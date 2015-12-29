# docker-s3-runner
Executes script from s3 path and notify via sns

## Running

	`docker run -d \
               -e ARGS='<param1 param2 param3>' \
               -e ARN='<topic arn sns>' \
               -e ID='<id>' \
               -e S3_LOG_BUCKET='<bucket name>'
               dpatriot/docker-s3-runner s3://s3-path`
