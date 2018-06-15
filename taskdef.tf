data "template_file" "ecs-demo-task-definition-template" {
  template               = "${file("templates/app.json.tpl")}"
  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.ecs-demo-repo.repository_url}", "https://", "")}"
    TAG = "${var.image_tag}"
  }
}

resource "aws_ecs_task_definition" "ecs-demo-task-definition1" {
  family                = "ecs-demo-task-definition1"
  container_definitions = "${data.template_file.ecs-demo-task-definition-template.rendered}"
  cpu = 256
  memory = 256
}

resource "aws_ecs_task_definition" "ecs-demo-task-definition2" {
  family                = "ecs-demo-task-definition2"
  container_definitions = "${data.template_file.ecs-demo-task-definition-template.rendered}"
  cpu = 256
  memory = 256
}
