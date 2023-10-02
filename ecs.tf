resource "aws_ecs_cluster" "cluster" {
  name = "${var.name}-cluster-${var.environment}"
  tags = var.tags
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.ecs_task_definition_name
  tags                     = var.tags
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
  container_definitions = jsonencode([{
   name        = "${var.name}-container-${var.environment}"
   image       = docker_image.ai-app-image.name
   essential   = true
   portMappings = [{
     protocol      = "tcp"
     containerPort = var.container_port
     hostPort      = var.container_port
   }]
   }])
}