FROM openjdk:8-jdk-alpine

ENV SBT_VERSION 1.5.5
ENV SCALA_VERSION 2.13.6

WORKDIR /app

COPY . /app

RUN apk add --no-cache bash && \
    mkdir -p /sbt/conf && \
    wget https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz && \
    tar -xzf sbt-$SBT_VERSION.tgz && \
    rm sbt-$SBT_VERSION.tgz && \
    echo "-Dsbt.color=always" >> /sbt/conf/sbtconfig.txt && \
    echo "-Dsbt.supershell=false" >> /sbt/conf/sbtconfig.txt && \
    echo "-Dsbt.log.noformat=true" >> /sbt/conf/sbtconfig.txt && \
    echo "-Dsbt.global.base=/sbt" >> /sbt/conf/sbtconfig.txt && \
    ln -s /sbt/bin/sbt /usr/local/bin/sbt

ENV PATH="/usr/local/bin:${PATH}"

CMD ["sbt", "run"]