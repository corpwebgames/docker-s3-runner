#!/bin/bash

export AWS_DEFAULT_REGION=us-east-1
export id=$ID
export category=$CATEGORY

send(){
export output=$1
export status=$2

message=`python <<END
import sys, os, json

data = {}
data['id'] = os.environ['id']
data['category'] = os.environ['category']
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

  if [ "$KEYSTORE_PATH" ]; then
    if aws s3 cp $KEYSTORE_PATH . ; then
      export KEYSTORE_KEY=$(basename $KEYSTORE_PATH)
    fi
    if [ -z "$KEYSTORE_SECRET" ]; then
      export KEYSTORE_SECRET=changeit
    fi
  fi
  if [ "$INTERPRETER" ]; then 
    $INTERPRETER $file $ARGS 2>&1 | tee $file-$ID.out;
  else
    ./$file $ARGS 2>&1 | tee $file-$ID.out;
  fi
  
  _status=${PIPESTATUS[0]}
  _output=`cat $file-$ID.out | head -c65535`
  #send "$_output" "$_status"

  times=$(date +"%H%M")
  if [ "$S3_LOG_BUCKET" ]; then aws s3 cp $file-$ID.out s3://$S3_LOG_BUCKET/docker/$CATEGORY/$file-$ID-$times.out; fi

  exit $_status

else
  #send "File $1 not found" "255"
  exit 255
fi
