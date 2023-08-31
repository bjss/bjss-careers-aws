const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocument } = require("@aws-sdk/lib-dynamodb");
const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const { SSMClient, GetParameterCommand } = require('@aws-sdk/client-ssm');

async function createCatalogueEntry(record) {
  try {
    const ddbClient = new DynamoDBClient({ region: process.env.REGION });
    const ddbDocClient = DynamoDBDocument.from(ddbClient);
    const params = {
      TableName: process.env.CATALOGUE_TABLE_NAME,
      Item: {
        image_name: record.s3.object.key.split("/")[1],
        source_ip: record.requestParameters.sourceIPAddress,
        timestamp: record.eventTime,
        size: record.s3.object.size,
        url_source: `https://${process.env.HOST_NAME}/${record.s3.object.key}`,
      },
      ConditionExpression: "attribute_not_exists(image_name)",
    };
    return ddbDocClient.put(params);
  } catch (err) {
    throw new Error(`Failed to create catalogue record :: ${err}`);
  }
}

async function getSystemCredsFromSsm() {
  try {
    const client = new SSMClient({ region: process.env.REGION });
    const input = {
      Name: `/auth/system`,
      WithDecryption: true
    }
    const command = new GetParameterCommand(input);
    const ssmResponse = await client.send(command);
    return `system:${ssmResponse.Parameter.Value}`;
  } catch (err) {
    throw new Error(`Failed to read system credentials from SSM`)
  }
}

async function getImageFromProxy(size, encodedImageUrl) {
  try {
    const imgProxyAddress = `http://imgproxy.${process.env.ENVIRONMENT}.private.techtest.bjsscareers.co.uk`;
    const imgProxyResizeUrl = `${imgProxyAddress}/sig/size:${size}/${encodedImageUrl}`;
    console.log(`attempting to resize image with url ${imgProxyResizeUrl}`);
    const response = await fetch(imgProxyResizeUrl);
    const blob = await response.blob();
    const arrayBuffer = await blob.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);
    return buffer;
  } catch (err) {
    throw new Error(`Failed to get image from image proxy :: ${err}`);
  }
}

async function putImageToS3(sourceKey, size, body) {
  try {
    const s3Client = new S3Client({ region: process.env.REGION });
    const targetKey = sourceKey
      .replace("images/", "resized/")
      .replace(".jpg", `-rx-${size}.jpg`);

    putObjectParams = {
      Bucket: process.env.S3_BUCKET_NAME,
      Key: targetKey,
      Body: body,
      ContentType: "image/jpeg",
    };

    console.log(
      `uploading ${putObjectParams.Key} to ${putObjectParams.Bucket}`
    );

    const putObjectCommand = new PutObjectCommand(putObjectParams);
    await s3Client.send(putObjectCommand);
    return targetKey;
  } catch (err) {
    throw new Error(`Failed to upload image to S3 :: ${err}`);
  }
}

async function updateCatalogueEntry(existingImageName, addField, addImageKey) {
  try {
    const ddbClient = new DynamoDBClient({ region: process.env.REGION });
    const ddbDocClient = DynamoDBDocument.from(ddbClient);
    const ddbUpdateParams = {
      TableName: process.env.CATALOGUE_TABLE_NAME,
      Key: { image_name: existingImageName },
      UpdateExpression: `set ${addField} = :newValue`,
      ExpressionAttributeValues: {
        ":newValue": `https://${process.env.HOST_NAME}/${addImageKey}`,
      },
      ReturnValues: "UPDATED_NEW",
    };

    console.log(`about to update dynamodb with these params`, ddbUpdateParams);
    return await ddbDocClient.update(ddbUpdateParams);
  } catch (err) {
    throw new Error(`Failed to update record in catalogue :: ${err}`);
  }
}

async function resizeImage(imageKey, resizeTo) {
  try {
    const encodedUrl = btoa(`https://${await getSystemCredsFromSsm()}@${process.env.HOST_NAME}/${imageKey}`);
    const newImage = await getImageFromProxy(resizeTo, encodedUrl);
    const resizedImageKey = await putImageToS3(imageKey, resizeTo, newImage);
    console.log(
      `imagekey ${imageKey} | resizeTo ${resizeTo} | resizedImageKey ${resizedImageKey}`
    );
    const updated = await updateCatalogueEntry(
      imageKey.split("/")[1],
      `url_${resizeTo}`,
      resizedImageKey
    );
  } catch (err) {
    throw new Error(`Failed to resize image ${imageKey} :: ${err}`);
  }
}

exports.handler = async (event) => {
  console.log(JSON.stringify(event));
  try {
    // add image record to catalog
    await Promise.all(
      event.Records.map((record) => createCatalogueEntry(record))
    );

    // resize image several times and update record in catalog
    await Promise.all([
      ...event.Records.map((record) =>
        resizeImage(record.s3.object.key, "100")
      ),
      ...event.Records.map((record) =>
        resizeImage(record.s3.object.key, "200")
      ),
      ...event.Records.map((record) =>
        resizeImage(record.s3.object.key, "400")
      ),
    ]);
    console.log(`Resized all images successfully`);
  } catch (err) {
    throw new Error(`Failed to resize image :: ${err}`);
  }
  return true;
};
