import json
import boto3
import sys

elbclient = boto3.client('elbv2')
elbName='neelesh-alb'
elbresponse = elbclient.describe_load_balancers(Names=[elbName])
listners = elbclient.describe_listeners(LoadBalancerArn=elbresponse['LoadBalancers'][0]['LoadBalancerArn'])
for x in listners['Listeners']:
        if (x['Port'] == 80):
        	livelistenerarn = x['ListenerArn']
        if (x['Port'] == 8080):
        	betalistenerarn = x['ListenerArn']

livetgresponse = elbclient.describe_rules(ListenerArn=livelistenerarn)


for x in livetgresponse['Rules']:
	
		if x['Priority'] == '1':
			livetargetgroup = x['Actions'][0]['TargetGroupArn']
			liverulearn = x['RuleArn']

betatgresponse = elbclient.describe_rules(ListenerArn=betalistenerarn)
for x in betatgresponse['Rules']:
        if x['Priority'] == '1':
            betatargetgroup = x['Actions'][0]['TargetGroupArn']
            betarulearn = x['RuleArn']



modifyOnBeta = elbclient.modify_rule(
    RuleArn=betarulearn,
    Actions=[
        {
            'Type': 'forward',
            'TargetGroupArn': livetargetgroup
        }
    ]
)



modifyOnLive = elbclient.modify_rule(
    RuleArn=liverulearn,
    Actions=[
        {
            'Type': 'forward',
            'TargetGroupArn': betatargetgroup
        }
    ]
)

print 'Swapped'
