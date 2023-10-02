resource "aws_ecr_repository" "ai-app" {
  name = "${var.name}-${var.environment}"
  tags = var.tags
  force_delete = true
}
resource "docker_image" "ai-app-image" {
  name = "${aws_ecr_repository.ai-app.repository_url}:latest"
  build {
    context    = "."
    dockerfile = "Dockerfile"
  }
}
resource "docker_registry_image" "ai-app-image" {
  name          = docker_image.ai-app-image.name
  keep_remotely = true
}