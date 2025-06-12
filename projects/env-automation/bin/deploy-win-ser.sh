#!/usr/bin/env bash
# This script deploys the Windows server environment for the project.
set -e

# ========== CONFIGURATION ==========
STACK_NAME="env-automation-win-ser"
REGION="us-west-2"
TEMPLATE_FILE="window-ec2-server.yml"
MY_IP="$(curl -s http://checkip.amazonaws.com)/32"

# ========== DEPLOYMENT ==========
echo "Deploying CloudFormation stack: $STACK_NAME in region: $REGION"
echo "Using my IP: $MY_IP"
aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --template-file "$TEMPLATE_FILE" \
  --parameter-overrides MyIP="$MY_IP" \
  --capabilities CAPABILITY_IAM 

  # ========== CHECK STACK STATUS ==========
  if [ $? -eq 0 ]; then
    echo "Stack deployment successful. Retrieving stack outputs..."
    aws cloudformation describe-stacks --stack-name "$STACK_NAME" \
      --stack-name "$STACK_NAME" \
      --region "$REGION" \
      --query "Stacks[0].Outputs" \
      --output table
    else
      echo "Stack deployment failed. Please check the AWS console for details."
      exit 1
  fi
# ========== POST DEPLOYMENT ==========
echo "Deployment completed. You can now access your Windows server."
