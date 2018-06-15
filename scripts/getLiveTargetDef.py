import boto3
import sys


ecsClient = boto3.client('ecs')
prev_image_tag = sys.argv[1]
acc_id = sys.argv[2]
image_arn = '{}.dkr.ecr.us-east-1.amazonaws.com/ecs-demo:{}'.format(acc_id,prev_image_tag)
for x in ecsClient.list_task_definitions()['taskDefinitionArns']:
	y = ecsClient.describe_task_definition(taskDefinition=x)
	if y['taskDefinition']['containerDefinitions'][0]['image'] != image_arn:
		ans = y['taskDefinition']['taskDefinitionArn'].split('/')[1].split(':')[0]
		print ans
