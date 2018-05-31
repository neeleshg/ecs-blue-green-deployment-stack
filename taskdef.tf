data "template_file" "neelesh-task-definition-template" {
  template               = "${file("templates/app.json.tpl")}"
  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.neelesh-demo.repository_url}", "https://", "")}"
    TAG = "${var.image_tag}"
  }
}

resource "aws_ecs_task_definition" "neelesh-task-definition1" {
  family                = "neelesh-task-definition1"
  container_definitions = "${data.template_file.neelesh-task-definition-template.rendered}"
  cpu = 256
  memory = 256
}

resource "aws_ecs_task_definition" "neelesh-task-definition2" {
  family                = "neelesh-task-definition2"
  container_definitions = "${data.template_file.neelesh-task-definition-template.rendered}"
  cpu = 256
  memory = 256
}
