#!/usr/bin/env bash

# ========== CONFIGURATION ==========
REGION="us-west-2"
KEY_FILE="./Net-Bootcamp-Window-server-KeyPair.pem"  # Update path if needed

# ========== GET LATEST RUNNING WINDOWS INSTANCE ==========
echo "🔍 Searching for a running Windows instance..."

INSTANCE_ID=$(aws ec2 describe-instances \
  --region "$REGION" \
  --filters "Name=platform,Values=windows" "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].[InstanceId,LaunchTime]" \
  --output text | sort -k2 -r | head -n1 | awk '{print $1}')

if [[ -z "$INSTANCE_ID" ]]; then
  echo "❌ No running Windows EC2 instance found."
  exit 1
fi

echo "🆔 Found Windows EC2 Instance ID: $INSTANCE_ID"

# ========== GET PUBLIC IP ==========
echo "🌐 Fetching Public IP..."
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-id "$INSTANCE_ID" \
  --region "$REGION" \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

if [[ "$PUBLIC_IP" == "None" || -z "$PUBLIC_IP" ]]; then
  echo "❌ Failed to retrieve public IP. Is the instance in a public subnet?"
  exit 1
fi

echo "🌍 Public IP Address: $PUBLIC_IP"

# ========== GET WINDOWS PASSWORD ==========
echo "🔐 Retrieving Administrator password..."
PASSWORD=$(aws ec2 get-password-data \
  --instance-id "$INSTANCE_ID" \
  --priv-launch-key "$KEY_FILE" \
  --region "$REGION" \
  --query PasswordData \
  --output text)

if [[ -z "$PASSWORD" ]]; then
  echo "❌ Password not available yet. Wait a few minutes after launch or verify the key file is correct."
  exit 1
fi

# ========== DISPLAY RDP INFO ==========
echo -e "\n✅ Use the following credentials in Microsoft Remote Desktop:\n"
echo "🖥️  Host: $PUBLIC_IP"
echo "👤  Username: Administrator"
echo "🔑  Password: $PASSWORD"
