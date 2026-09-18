#!/bin/bash

# AWS Resource Checker
# Checks for running resources that might cost money

REGION="eu-west-2"
echo "======================================"
echo "AWS Resource Check - $(date)"
echo "Region: $REGION"
echo "======================================"

# Check EKS clusters
echo ""
echo "--- EKS Clusters ---"
CLUSTERS=$(aws eks list-clusters --region $REGION --query 'clusters' --output text)
if [ -z "$CLUSTERS" ]; then
    echo "✅ No clusters running"
else
    echo "⚠️  WARNING: Clusters found: $CLUSTERS"
fi

# Check EC2 instances
echo ""
echo "--- EC2 Instances ---"
INSTANCES=$(aws ec2 describe-instances \
    --region $REGION \
    --filters "Name=instance-state-name,Values=running" \
    --query 'Reservations[*].Instances[*].InstanceId' \
    --output text)
if [ -z "$INSTANCES" ]; then
    echo "✅ No instances running"
else
    echo "⚠️  WARNING: Running instances: $INSTANCES"
fi

# Check Load Balancers
echo ""
echo "--- Load Balancers ---"
LBS=$(aws elb describe-load-balancers \
    --region $REGION \
    --query 'LoadBalancerDescriptions[*].LoadBalancerName' \
    --output text)
if [ -z "$LBS" ]; then
    echo "✅ No load balancers"
else
    echo "⚠️  WARNING: Load balancers found: $LBS"
fi

# Check NAT Gateways
echo ""
echo "--- NAT Gateways ---"
NATS=$(aws ec2 describe-nat-gateways \
    --region $REGION \
    --filter "Name=state,Values=available" \
    --query 'NatGateways[*].NatGatewayId' \
    --output text)
if [ -z "$NATS" ]; then
    echo "✅ No NAT gateways"
else
    echo "⚠️  WARNING: NAT gateways found: $NATS"
fi

# Check RDS
echo ""
echo "--- RDS Databases ---"
DBS=$(aws rds describe-db-instances \
    --region $REGION \
    --query 'DBInstances[*].DBInstanceIdentifier' \
    --output text)
if [ -z "$DBS" ]; then
    echo "✅ No databases running"
else
    echo "⚠️  WARNING: Databases found: $DBS"
fi

echo ""
echo "======================================"
echo "Check complete!"
echo "======================================"
