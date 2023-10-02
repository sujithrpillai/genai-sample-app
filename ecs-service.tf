resource "aws_ecs_service" "main" {
 name                               = "${var.name}-service-${var.environment}"
 tags                               = var.tags
 cluster                            = aws_ecs_cluster.cluster.id
 task_definition                    = aws_ecs_task_definition.main.arn
 desired_count                      = 1
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 100
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"
 
 network_configuration {
   security_groups  = [ aws_security_group.ecs_tasks.id ]
   subnets          = var.private_subnet_id
   assign_public_ip = true
 }
 
 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
}