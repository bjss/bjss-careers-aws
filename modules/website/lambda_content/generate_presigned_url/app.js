const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");
const s3 = new S3Client({ region: process.env.REGION });

exports.handler = async (event) => {
  console.log(event);

  // Create an S3 client
  const bucketName = process.env.S3_BUCKET_NAME;
  const objectKey = `images/${event.queryStringParameters.filename}`;
  const expirationTime = 3600; // seconds from now
  const contentType = "image/jpeg";

  // Create a GetObjectCommand for the S3 object you want to generate a pre-signed URL for
  const putObjectCommand = new PutObjectCommand({
    Bucket: bucketName,
    Key: objectKey,
    ContentType: contentType,
  });

  try {
    const url = await getSignedUrl(s3, putObjectCommand, {
      expiresIn: expirationTime,
    });
    return {
      statusCode: 200,
      body: url,
    };
  } catch (err) {
    console.log(err);
    return {
      statusCode: 500,
      body: "Error generating pre-signed URL",
    };
  }
};
