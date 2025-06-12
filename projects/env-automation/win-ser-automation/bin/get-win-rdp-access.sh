#!/usr/bin/env bash
# This script retrieves the public IP and admin password for a Windows EC2 instance.

set -e

# === CONFIGURATION ===
INSTANCE_ID="i-01df32c4059954629"
REGION="us-west-2"
KEY_FILE="./Net-Bootcamp-Window-server-KeyPair.pem"

# === VALIDATION ===
if [ ! -f "$KEY_FILE" ]; then
  echo "❌ Private key file not found: $KEY_FILE"
  exit 1
fi

chmod 400 "$KEY_FILE"

# === STEP 1: Get Public IP ===
echo "🌐 Fetching Public IP for Instance: $INSTANCE_ID"
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --region "$REGION" \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

echo "✅ Public IP Address: $PUBLIC_IP"

# === STEP 2: Get Administrator Password ===
echo "🔐 Retrieving Administrator password..."
PASSWORD_JSON=$(aws ec2 get-password-data \
  --instance-id "$INSTANCE_ID" \
  --priv-launch-key "$KEY_FILE" \
  --region "$REGION")

PASSWORD=$(echo "$PASSWORD_JSON" | jq -r '.PasswordData')

if [ -z "$PASSWORD" ]; then
  echo "⏳ Password not yet available. Wait a few minutes and try again."
  exit 1
fi

# === STEP 3: Display RDP Access Info ===
echo ""
echo "🖥️  Connect to your Windows instance:"
echo "--------------------------------------"
echo "RDP IP Address : $PUBLIC_IP"
echo "Username       : Administrator"
echo "Password       : $PASSWORD"
echo "--------------------------------------"
echo "📢 Open Remote Desktop (mstsc) and connect to the public IP."
