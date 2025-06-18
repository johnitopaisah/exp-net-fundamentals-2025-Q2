#!/usr/bin/env bash

# Automatically detect the instance ID of the most recently launched EC2 instance with a known tag
INSTANCE_ID=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=Net-Bootcamp-Window-server-Instance" \
  --query "Reservations[-1].Instances[0].InstanceId" \
  --region us-west-2 \
  --output text)

# Get the public IP address of the instance
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --region us-west-2 \
  --output text)

# Determine the OS by checking the platform details
OS_PLATFORM=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].PlatformDetails" \
  --region us-west-2 \
  --output text)

# Choose username based on OS
if [[ "$OS_PLATFORM" == *"Windows"* ]]; then
  USERNAME="Administrator"
  echo "🔐 Getting password for Windows instance..."
  PASSWORD=$(aws ec2 get-password-data \
    --instance-id "$INSTANCE_ID" \
    --priv-launch-key ./Net-Bootcamp-Window-server-KeyPair.pem \
    --region us-west-2 \
    --query PasswordData \
    --output text)
else
  # Default to Ubuntu user
  USERNAME="ubuntu"
  PASSWORD="(use your .pem key)"
fi

echo ""
echo "💻  Instance ID: $INSTANCE_ID"
echo "💡  Detected OS: $OS_PLATFORM"
echo "🌍  Public IP: $PUBLIC_IP"
echo "👤  Username: $USERNAME"
echo "🔑  Password: $PASSWORD"
echo ""
echo "🔌  To connect:"
if [[ "$OS_PLATFORM" == *"Windows"* ]]; then
  echo "Use Microsoft Remote Desktop:"
  echo "  PC name: $PUBLIC_IP"
  echo "  Username: $USERNAME"
  echo "  Password: (above)"
else
  echo "Use SSH:"
  echo "  ssh -i ./Net-Bootcamp-Window-server-KeyPair.pem $USERNAME@$PUBLIC_IP"
fi
