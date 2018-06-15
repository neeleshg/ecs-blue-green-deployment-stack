resource "aws_ecs_service" "ecs-demo-service1" {
  name = "ecs-demo-service1"
  cluster = "${aws_ecs_cluster.ecs-demo-cluster.id}"
  task_definition = "${aws_ecs_task_definition.ecs-demo-task-definition1.arn}"
  desired_count = 1
  iam_role = "${aws_iam_role.ecs-service-role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs-service-attach1"]

  load_balancer {
    target_group_arn = "${aws_lb_target_group.targetgroup1.arn}"
    container_name = "ecs-demo-demo"
    container_port = 80
  }
#  lifecycle { ignore_changes = ["task_definition"] }
}

resource "aws_ecs_service" "ecs-demo-service2" {
  name = "ecs-demo-service2"
  cluster = "${aws_ecs_cluster.ecs-demo-cluster.id}"
  task_definition = "${aws_ecs_task_definition.ecs-demo-task-definition2.arn}"
  desired_count = 1
  iam_role = "${aws_iam_role.ecs-service-role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs-service-attach1"]

  load_balancer {
    target_group_arn = "${aws_lb_target_group.targetgroup2.arn}"
    container_name = "ecs-demo-demo"
    container_port = 80
  }
#  lifecycle { ignore_changes = ["task_definition"] }
}

