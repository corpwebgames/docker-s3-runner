#!/bin/bash
NEWLINE=$'\n'

aws s3 cp $1 s3.sh
chmod +x s3.sh

output=$(./s3.sh $ARGS)
status=$?

export AWS_DEFAULT_REGION=us-east-1
aws sns publish --topic-arn "$ARN" --subject "Task: $ID" --message "Status: $status ${NEWLINE}${NEWLINE}Output: $output"
