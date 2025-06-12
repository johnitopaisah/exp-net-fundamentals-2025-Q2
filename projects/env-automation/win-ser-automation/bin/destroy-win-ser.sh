#!/usr/bin/env bash
# This script deletes the Windows server CloudFormation stack and all associated resources.
set -e

# ========== CONFIGURATION ==========
STACK_NAME="env-automation-win-ser"
REGION="us-west-2"

# ========== DELETE STACK ==========
echo "🗑️ Deleting CloudFormation stack: $STACK_NAME in region: $REGION"
aws cloudformation delete-stack \
  --stack-name "$STACK_NAME" \
  --region "$REGION"

echo "⏳ Waiting for stack deletion to complete..."
aws cloudformation wait stack-delete-complete \
  --stack-name "$STACK_NAME" \
  --region "$REGION"

echo "✅ Stack $STACK_NAME has been successfully deleted."
# ========== POST DELETION ==========
echo "Your Windows server environment has been removed. If you need to deploy it again, please run the deployment script."
