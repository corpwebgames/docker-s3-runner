FROM dpatriot/docker-awscli-java8
MAINTAINER Shago Vyacheslav <v.shago@corpwebgames.com>

ADD run.sh /opt

# Define working directory.
WORKDIR /opt

ENTRYPOINT ["./run.sh"]

CMD [""]
