#!/bin/bash

export AWS_DEFAULT_REGION=us-east-1
export id=$ID

send(){
export output=$1
export status=$2

message=`python <<END
import sys, os, json

data = {}
data['id'] = os.environ['id']
data['status'] = os.environ['status']
data['output'] = os.environ['output']
json_data = json.dumps(data)

print json.dumps(data)

END`

aws sns publish --topic-arn "$ARN" --subject "Task: $ID" --message "$message"
}


path=$1
file=$(basename $path)

if aws s3 cp $1 $file ; then
  chmod +x $file

  send "" "Running"
  _output=`./$file $ARGS 2>&1`;_status=$?
  send $_output $_status
else
  send "File $1 not found" "255"
fi
