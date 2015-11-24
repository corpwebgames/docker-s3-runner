FROM dpatriot/docker-awscli-java8
MAINTAINER Shago Vyacheslav <v.shago@corpwebgames.com>

# Define working directory.
WORKDIR /data

ADD run.sh /data

ENTRYPOINT ["./run.sh"]

CMD [""]
