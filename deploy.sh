#!/bin/bash

# Variables
EXTENSION_PATH=../../apm-aws-lambda/apm-lambda-extension/ # Path to extension codebase
LAMBDA_NAME=lambda-sample-dev-$USER # Your lambda function name.
AWS_REGION=eu-central-1 # AWS Region
GOOS=linux
GOARCH=amd64
EXTENSION_NAME=extension-dev-$USER-$GOOS-$GOARCH

# Package Lambda function
pip install -r requirements.txt -t ./dependencies
rm -f deployment-package.zip
zip -qq -r deployment-package.zip .

# Update Lambda function. The function should be already created in the Web UI with the name LAMBDA_NAME
aws lambda update-function-code --function-name $LAMBDA_NAME --region $AWS_REGION --zip-file fileb://deployment-package.zip

# Prepare the extension package
cd $EXTENSION_PATH
rm -rf bin
GOOS=linux GOARCH=amd64 go build -o bin/extensions/extension-dev-$GOOS-$GOARCH main.go
(cd bin && zip -qq -r -D extension-dev-$GOOS-$GOARCH.zip .)

# Upload extension layer
aws lambda publish-layer-version --layer-name $EXTENSION_NAME --region $AWS_REGION --zip-file fileb://bin/extension-dev-$GOOS-$GOARCH.zip

# The layer version has to be set manually in the Lambda console
# You can find the number that was just generated at the end of the output of this script.

# Invoke Lambda function and visualize result
# cd -
# aws lambda invoke --function-name $LAMBDA_NAME --log-type Tail ../response.json | base64 -d
# cat ../response.json
