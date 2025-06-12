#!/usr/bin/env bash
# This script deploys the Windows server environment for the project.
set -e

# ========== CONFIGURATION ==========
STACK_NAME="env-automation-win-ser"
REGION="us-west-2"
TEMPLATE_FILE="window-ec2-server.yml"
MY_IP="$(curl -s http://checkip.amazonaws.com)/32"

# === PARAMETER VALUES ===
VPC_CIDR="10.200.123.0/24"
PUBLIC_SUBNET_CIDR="10.200.123.0/25"
PRIVATE_SUBNET_CIDR="10.200.123.128/25"
AVAILABILITY_ZONE="us-west-2a"

# ========== DEPLOYMENT ==========
echo "🚀 Deploying CloudFormation stack: $STACK_NAME in region: $REGION"
echo "🌍 Using Public IP for RDP/SSH: $MY_IP"

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --template-file "$TEMPLATE_FILE" \
  --parameter-overrides \
    VpcCidr="$VPC_CIDR" \
    PublicSubnetCidr="$PUBLIC_SUBNET_CIDR" \
    PrivateSubnetCidr="$PRIVATE_SUBNET_CIDR" \
    AvailabilityZone="$AVAILABILITY_ZONE" \
    MyIP="$MY_IP" \
  --capabilities CAPABILITY_IAM \
  --no-fail-on-empty-changeset

# ========== CHECK STACK STATUS ==========
if [ $? -eq 0 ]; then
  echo "✅ Stack deployment successful. Retrieving stack outputs..."
  aws cloudformation describe-stacks \
    --stack-name "$STACK_NAME" \
    --region "$REGION" \
    --query "Stacks[0].Outputs" \
    --output table
else
  echo "❌ Stack deployment failed. Please check the AWS console for details."
  exit 1
fi

# ========== POST DEPLOYMENT ==========
echo "✅ Deployment completed. Your Windows server environment is now live."
echo "🔗 You can connect to your Windows server using RDP with the following command:"
