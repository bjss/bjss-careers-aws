const { DynamoDBClient, ScanCommand } = require("@aws-sdk/client-dynamodb");
const client = new DynamoDBClient({ region: process.env.REGION });
const { unmarshall } = require("@aws-sdk/util-dynamodb");

exports.handler = async (event) => {
  console.log(JSON.stringify(event));
  try {
    const command = new ScanCommand({
      TableName: process.env.CATALOGUE_TABLE_NAME,
      AttributesToGet: [
        "image_name",
        "size",
        "url_source",
        "url_100",
        "url_200",
        "url_400",
      ],
      Select: "SPECIFIC_ATTRIBUTES",
    });

    const output = await client.send(command);
    const result = output.Items.map((item) => unmarshall(item));
    console.log(JSON.stringify(result));
    console.log(`All records read from the catalogue successfully`);
    return {
      statusCode: 200,
      body: JSON.stringify(result),
    };
  } catch (err) {
    return {
      statusCode: 500,
      body: `Failed to get records from catalogue :: ${err}`,
    };
  }
};
