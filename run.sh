#!/bin/bash

path=$1
file=$(basename $path)

if aws s3 cp $1 $file ; then
  chmod +x $file

  _output=`./$file $ARGS 2>&1`;_status=$?
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
