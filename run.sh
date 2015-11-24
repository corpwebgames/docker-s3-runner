#!/bin/bash

aws s3 cp $1 s3.sh
./s3.sh
