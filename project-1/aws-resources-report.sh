#!/bin/bash

############################
# Author: Harshwardhan
# Date: 22th-feb
#
#Version: V1
#
# this script will report the AWS resource usage
############################

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM

# list s3 bucket
echo “print list of s3 buckets”  >> resourceTracker
aws s3 ls  >> resourceTracker

# list EC2 instances
echo “print ec2 instances on account” >> resourceTracker
aws ec2 describe-instances --query 'Reservations[].Instances[?State.Name==`running`].InstanceId'  >> resourceTracker


# list lambda 
echo “print lambda fucntions” >> resourceTracker
aws lambda list-functions >> resourceTracker

# list iam users
echo “list iam users” >> resourceTracker
aws iam list-users >> resourceTracker
