[
  {
    "essential": true,
    "memory": 256,
    "name": "neelesh-demo",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:${TAG}",
    "portMappings": [
        {
            "containerPort": 80,
            "hostPort": 0
        }
    ]
  }
]

