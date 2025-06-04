#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# === STACK CONFIGURATION ===
STACK_NAME="NetBootVPC"
REGION="us-west-2"
TEMPLATE_FILE="template.yml"

# === PARAMETER VALUES ===
VPC_CIDR="10.200.123.0/24"
PUBLIC_SUBNET_CIDR="10.200.123.0/25"
PRIVATE_SUBNET_CIDR="10.200.123.128/25"
AVAILABILITY_ZONE="us-west-2a"

# === Print a status message ===
echo "🚀 Deploying CloudFormation stack: $STACK_NAME in region $REGION"

# === DEPLOY THE CLOUDFORMATION STACK ===
aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE" \
  --region "$REGION" \
  --capabilities CAPABILITY_IAM \
  --parameter-overrides \
    VpcCidr="$VPC_CIDR" \
    PublicSubnetCidr="$PUBLIC_SUBNET_CIDR" \
    PrivateSubnetCidr="$PRIVATE_SUBNET_CIDR" \
    AvailabilityZone="$AVAILABILITY_ZONE"

# === WAIT FOR STACK CREATION TO COMPLETE ===
echo "⏳ Waiting for stack creation to complete..."
aws cloudformation wait stack-create-complete \
  --stack-name "$STACK_NAME" \
  --region "$REGION"

# === DISPLAY STACK OUTPUTS ===
echo "✅ Stack $STACK_NAME deployed successfully in region $REGION."
echo "📦 Fetching stack outputs..."
aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --query "Stacks[0].Outputs" \
  --output table

# === FINAL MESSAGE ===
echo "✅ Deployment complete. You can now use the resources created by the stack."
# End of script
