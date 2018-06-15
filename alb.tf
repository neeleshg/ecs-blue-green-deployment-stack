resource "aws_lb" "ecs-demo-alb" {
  name = "ecs-demo-alb"

  idle_timeout = 400
  subnets = ["${aws_subnet.main-public-1.id}","${aws_subnet.main-public-2.id}"]
  security_groups = ["${aws_security_group.ecs-demo-elb-securitygroup.id}"]
  tags {
    Name = "ecs-demo-alb"
  }
}

resource "aws_lb_target_group" "targetgroup1" {
  name = "targetgroup1"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.main.id}"
  deregistration_delay = 60
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 3
    timeout = 10
    path = "/"
    interval = 15
  }
}
resource "aws_lb_target_group" "targetgroup2" {
  name = "targetgroup2"
  port = 8080
  protocol = "HTTP"
  deregistration_delay = 60
  vpc_id = "${aws_vpc.main.id}"
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 3
    timeout = 10
    path = "/"
    interval = 15
  }
}

resource "aws_lb_listener" "listern1" {
  load_balancer_arn = "${aws_lb.ecs-demo-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.targetgroup1.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "lb_listener_rule1" {
  listener_arn = "${aws_lb_listener.listern1.arn}"
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.targetgroup1.arn}"
  }
  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}


resource "aws_lb_listener" "listern2" {
  load_balancer_arn = "${aws_lb.ecs-demo-alb.arn}"
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.targetgroup2.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "lb_listener_rule2" {
  listener_arn = "${aws_lb_listener.listern2.arn}"
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.targetgroup2.arn}"
  }
  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}

