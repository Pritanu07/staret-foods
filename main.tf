## Provider AWS

provider "aws" {
  region = "ap-southeast-1"
}

## Create VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "awsvpc"
  cidr = "172.31.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1c"]
  #private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["172.31.32.0/20", "172.31.0.0/20"]

  /*   enable_nat_gateway = true
  enable_vpn_gateway = true */

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

## ECS Module

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "priya-ecs2-cluster"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    priya-ecs2-task = { #td name
      cpu    = 512
      memory = 1024

      # Container definition(s)
      container_definitions = {

        priya-ecs2-task = { #container name
          essential = true
          image     = "public.ecr.aws/docker/library/httpd:latest"
          port_mappings = [
            {
              name          = "ecs-sample"
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
          readonly_root_filesystem = false

        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      subnet_ids                         = ["subnet-bea677f6", "subnet-29ed7170"]
      security_group_rules = {
        ingress_all = {
          type        = "ingress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          description = "Allow all"
          cidr_blocks = ["0.0.0.0/0"]
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }

}


##Test TF Workflow with EC2 2

 resource "aws_instance" "priya-ec2" {
  ami = "ami-0464f90f5928bccb8"
  instance_type = "t2.micro"
  tags = {
    Name = "priya-ec2"
  }
}  
 