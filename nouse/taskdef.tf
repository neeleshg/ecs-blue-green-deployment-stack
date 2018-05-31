data "template_file" "neelesh-task-definition-template" {
  template               = "${file("templates/app.json.tpl")}"
  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.neelesh-demo.repository_url}", "https://", "")}"
  }
}

resource "aws_ecs_task_definition" "neelesh-task-definition" {
  family                = "neelesh"
  container_definitions = "${data.template_file.neelesh-task-definition-template.rendered}"
}


resource "aws_ecs_service" "neelesh-service" {
  name = "neelesh-service"
  cluster = "${aws_ecs_cluster.neelesh-cluster.id}"
  task_definition = "${aws_ecs_task_definition.neelesh-task-definition.arn}"
  desired_count = 1
  iam_role = "${aws_iam_role.ecs-service-role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs-service-attach1"]

  load_balancer {
    elb_name = "${aws_lb.neelesh-alb.name}"
    container_name = "neelesh-demo"
    container_port = 80
  }
  lifecycle { ignore_changes = ["task_definition"] }
}

