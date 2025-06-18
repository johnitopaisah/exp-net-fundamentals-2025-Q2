#!/usr/bin/env bash

# ================= CONFIGURATION =================
STACK_NAME="env-automation-multi-os"
REGION="us-west-2"
TEMPLATE_FILE="dynamic-os-template.yml"
MY_IP="$(curl -s http://checkip.amazonaws.com)/32"

# === PARAMETER VALUES ===
VPC_CIDR="10.200.123.0/24"
PUBLIC_SUBNET_CIDR="10.200.123.0/25"
PRIVATE_SUBNET_CIDR="10.200.123.128/25"
AVAILABILITY_ZONE="us-west-2a"
KEY_PAIR_NAME="Net-Bootcamp-Win-ubu-rhel-server-KeyPair"
OPERATING_SYSTEM="Windows"  # Change to Ubuntu or RedHat as needed

# ================= DEPLOYMENT =================
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
    KeyPairName="$KEY_PAIR_NAME" \
    OperatingSystem="$OPERATING_SYSTEM" \
  --capabilities CAPABILITY_IAM \
  --no-fail-on-empty-changeset

# ================= CHECK OUTPUTS =================
if [ $? -eq 0 ]; then
  echo "✅ Stack deployment successful. Retrieving outputs..."
  aws cloudformation describe-stacks \
    --stack-name "$STACK_NAME" \
    --region "$REGION" \
    --query "Stacks[0].Outputs" \
    --output table
else
  echo "❌ Stack deployment failed. Check the AWS console for error details."
  exit 1
fi

# ================= POST-INSTRUCTIONS =================
echo "📌 To connect, retrieve instance ID, public IP, and access credentials as required."
echo "📝 For Windows, use get-password-data with the .pem key."
echo "🔑 For Ubuntu/RedHat, use: ssh -i path/to/key.pem ec2-user@<PublicIP>"
