FROM webgames/awscli-java8:1.3-jdk11

ADD run.sh /opt/
RUN chmod +x /opt/run.sh

# Define working directory.
WORKDIR /opt

ENTRYPOINT ["./run.sh"]

CMD [""]
