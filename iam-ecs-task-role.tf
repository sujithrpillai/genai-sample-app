resource "aws_iam_role" "ecs_task_role" {
  name = "${var.name}-ecsTaskRole"
  tags = var.tags
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
 
resource "aws_iam_policy" "bedrock" {
  name        = "${var.name}-task-policy-bedrock"
  description = "Policy that allows access to Bedrock"
  tags = var.tags
 policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": [
                "bedrock:*"
           ],
           "Resource": "*"
       }
   ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "ecs-task-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.bedrock.arn
}