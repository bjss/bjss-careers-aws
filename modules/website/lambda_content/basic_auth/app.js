const { SSMClient, GetParameterCommand } = require('@aws-sdk/client-ssm');

const unauthorizedResponse = () => ({
  status: '401',
  statusDescription: 'Unauthorized',
  body: 'You are not authorized to enter',
  headers: {
    'www-authenticate': [{ key: 'WWW-Authenticate', value: 'Basic realm="Enter credentials to log in"' }],
  },
});

exports.handler = async (event) => {
  try {
    const { request } = event.Records[0].cf;
    const { headers } = request;

    if (! headers.authorization) {
      console.log(`No authorization header`)
      return unauthorizedResponse();
    }

    // Extract username and password from Authorization header
    let receivedUsername, receivedPassword
    try {
      const encodedCredentials = headers.authorization[0].value.split(' ')[1];
      const decodedCredentials = Buffer.from(encodedCredentials, 'base64').toString();
      [receivedUsername, receivedPassword] = decodedCredentials.split(':');
    } catch (err) {
      throw new Error(`Failed to determine username and password from browser :: ${err}`);
    }

    // Find corresponding password parameter from SSM
    let ssmPassword;
    try {
      const client = new SSMClient({ region: process.env.REGION });
      const input = {
        Name: `/auth/${receivedUsername}`,
        WithDecryption: true
      }
      const command = new GetParameterCommand(input);
      const ssmResponse = await client.send(command);
      ssmPassword = ssmResponse.Parameter.Value;
    } catch (err) {
      throw new Error(`Failed to read auth details for ${receivedUsername} from SSM`);
    }

    // Check if received username and password match valid credentials
    if (receivedPassword === ssmPassword) {
      console.log(`User ${receivedUsername} Authorised`);
      return request;
    } else {
      console.log(`User ${receivedUsername} Unauthorised`);
      return unauthorizedResponse();
    }
  } catch (err) {
    console.log(`Failed to authenticate user :: ${err}`);
    return unauthorizedResponse();
  }
};
