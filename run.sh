#!/bin/bash

if aws s3 cp $1 s3.sh ; then
  chmod +x s3.sh

  _output=`./s3.sh $ARGS 2>&1`;_status=$?
  export output=$_output
  export status=$_status
else
  export output="File $1 not found"
  export status="255"
fi

  export id=$ID


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
