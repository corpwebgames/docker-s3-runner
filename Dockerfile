FROM dpatriot/docker-awscli-java8
MAINTAINER Shago Vyacheslav <v.shago@corpwebgames.com>

ADD run.sh /data

# Define working directory.
WORKDIR /data

ENTRYPOINT ["./run.sh"]

CMD [""]
