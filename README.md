# APM-Instrumented Development Lambda Function

**Please read `deploy.sh` before execution no make sure that this sample does not conflict with any existing functions.**

### Setup

- [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI.
- [Setup](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) your credentials.
- [Clone](https://github.com/elastic/apm-aws-lambda) the repository containing the code of the Elastic APM Extension for AWS Lambda.
- Create an empty Lambda function with the name of your choice in AWS.
- [Set](https://www.elastic.co/guide/en/apm/guide/current/aws-lambda-extension.html#aws-lambda-configure-env) the environment variables required by the extension.
- In `deploy.sh`, set the following environment variables:
```
EXTENSION_PATH=<Path to extension codebase>
LAMBDA_NAME=<Your lambda function name>
AWS_REGION=<AWS Region>
EXTENSION_NAME=<The name you wish to give to the extension layer>
```
- Run the script :
```
./deploy.sh
```

### Usage

The script :
- Installs the dependencies featured in `requirements.txt`
- Packages the Lambda function and its dependencies into a .zip file
- Updates the Lambda function using the previously created deployment package
- Builds the extension and packages it into a .zip
- Publishes the extension as a layer

After executing the script, the last manual action is to either attach your newly uploaded layer to the lambda function to manually bump the version of the layer used by the Lambda function.
