#!/bin/bash
#NEWLINE=$'\n'

aws s3 cp $1 s3.sh
chmod +x s3.sh

export output=$(./s3.sh $ARGS)
export status=$?
export id=$ID

#message="{\"id\":\""$ID"\", \"status\":\""$status"\", \"output\":\""$output"\"}"

message=`python <<END
import sys, os, json

data = {}
data['id'] = os.environ['id']
data['status'] = os.environ['status']
data['output'] = os.environ['output']
json_data = json.dumps(data)

print json.dumps(data)

END`

export AWS_DEFAULT_REGION=us-east-1
aws sns publish --topic-arn "$ARN" --subject "Task: $ID" --message "$message"
