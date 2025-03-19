#!/bin/bash

################

#Description: Create and destroy VPC using AWS CLI
#- Create VPC
#- Create a public Subnet
#- teardown VPC

#verify if user has aws cli installed
#verify if AWS configure is done
#verify if user has created VPC with a particular name and if it exists, delete it, else create it

################

#variables
vpc_name="myAIpairscriptedVPC"
vpc_cidr_block="10.0.0.0/16"
subnet_cidr_block="10.0.3.0/24"
subnet_az="us-east-1a"
subnet_name="myAIPairScriptedSubnet"


#functions
create_vpc(){
  aws ec2 create-vpc --cidr-block $vpc_cidr_block --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=$vpc_name}]" | jq
}

create_subnet(){
  vpc_id=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=$vpc_name" --query "Vpcs[0].VpcId" --output text)
  aws ec2 create-subnet --vpc-id $vpc_id --cidr-block $subnet_cidr_block --availability-zone $subnet_az --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=$subnet_name}]" | jq
}

delete_vpc(){
  vpc_id=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=$vpc_name" --query "Vpcs[0].VpcId" --output text)
  aws ec2 delete-vpc --vpc-id $vpc_id
}

#main
create_vpc
create_subnet
#delete_vpc
```

