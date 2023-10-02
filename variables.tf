variable "region" {
  default     = "<<Replace with your AWS Region"
  description = "AWS region for resources deployment"
  type        = string
}
variable "vpc_id" {
  default     = "Replace with the VPC ID"
  description = "VPC ID"
  type        = string
}
variable "private_subnet_id" {
  default     = ["Replace with the Subnet in which the Fargate should run"]
  description = "Private Subnet ID"
}
variable "name" {
  default     = "ai-app"
  description = "AI App Name"
  type        = string
}
variable "environment" {
  default     = "dev"
  description = "AI App Environment Name"
  type        = string
}
variable "container_port" {
  default     = "80"
  description = "Container Port"
  type        = number
}
variable "tags" {
  default = {
    ProjectName = "Replace with the Project Name tag if you wish to keep"
    ResourceName  = "Replace with the Email address tag if you wish to keep"
  }
  description = "Default tags for all resources"
  type        = map(string)
}
variable "ecs_task_definition_name" {
    type = string
    default = "ai-app-task"
    description = "Task definition name"
}
