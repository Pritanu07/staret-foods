data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["sandbox-vpc"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "priya-ecs2-cluster"   #Change

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    priya-ecs2-service = { #task def and service name -> #Change
      cpu    = 512
      memory = 1024

      # Container definition(s)
      container_definitions = {

        priya-ecs2-container = { #container name
          essential = true 
          image     = "public.ecr.aws/docker/library/httpd:latest"
          port_mappings = [
            {
              name          = "priya-ecs2-container"  #container name
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
          readonly_root_filesystem = false

        }
      }
      assign_public_ip = true
      deployment_minimum_healthy_percent = 100
      subnet_ids = flatten(data.aws_subnets.public.ids)
      security_group_ids  = ["sg-01adb0fa94b766534"]
    }
  }
}