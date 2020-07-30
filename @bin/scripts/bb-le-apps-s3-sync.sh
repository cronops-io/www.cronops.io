#!/usr/bin/env bash

#
# GLOBAL ARGS & VARIABLES
#
APP_ENVIRONMENT=$1
PROJECT_SHORT_NAME="co"

# STAGE VARIABLES
#
if [[ ${APP_ENVIRONMENT} == "dev" ]]; then   # dev.aws.cronops.io
    AWS_ENVIRONMENT="apps-${APP_ENVIRONMENT}stg"
    AWS_CLOUDFRONT_DIST_ID="E3XXXXXXXXXXX"

elif [[ ${APP_ENVIRONMENT} == "prd" ]]; then # prd.aws.cronops.io
    AWS_ENVIRONMENT="apps-${APP_ENVIRONMENT}"
    AWS_CLOUDFRONT_DIST_ID="EI2XXXXXXXXXX"
else
    echo "---"
    echo "${APP_ENVIRONMENT} NOT a valid Environment Stage"
    echo "---"
    exit 1
fi

#
# Deployment: AWS S3 PutObject + CF cache invalidation
#
AWS_BUCKET_NAME="${PROJECT_SHORT_NAME}-${AWS_ENVIRONMENT}-frontend-${APP_ENVIRONMENT}-awscronopsio-origin"
AWS_IAM_PROFILE="${PROJECT_SHORT_NAME}-dev-deploymaster"

echo "Deploying ${APP_ENVIRONMENT}.aws.cronops.io to AWS S3 Bucket: ${AWS_BUCKET_NAME}"
aws s3 sync ./dist/ s3://${AWS_BUCKET_NAME} \
--profile ${AWS_IAM_PROFILE}
echo "---"

echo "Invalidating ${APP_ENVIRONMENT}.aws.cronops.io AWS CF Cache ${AWS_CLOUDFRONT_DIST_ID}"
aws cloudfront create-invalidation \
--distribution-id ${AWS_CLOUDFRONT_DIST_ID} \
--paths "/*" \
--profile ${AWS_IAM_PROFILE}
echo "---"

echo "SUCCESSFULLY DEPLOYED to ${APP_ENVIRONMENT}"

exit 0
