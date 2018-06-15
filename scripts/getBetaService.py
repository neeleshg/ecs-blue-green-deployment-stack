import boto3
import sys


ecsClient = boto3.client('ecs')
task_def = sys.argv[1]
clusterName = 'ecs-demo-cluster'
#print(ecsClient.list_clusters())
for x in ecsClient.list_services(cluster=clusterName)['serviceArns']:
	y = ecsClient.describe_services(cluster=clusterName,services=[x])['services'][0]['taskDefinition'].split("/")[1].split(":")[0]
	if y == task_def:
		print ecsClient.describe_services(cluster=clusterName,services=[x])['services'][0]['serviceName']
