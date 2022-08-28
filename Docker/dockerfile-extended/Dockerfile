FROM ubuntu:16.04

ARG UID=1000

RUN apt-get update
RUN apt-get install nano
RUN useradd -ms /home/user -u $UID stepik

ENV EDITOR=nano
USER $UID
WORKDIR /home/stepik
VOLUME /home/stepik
ENTRYPOINT ["bash", "-c", "nano"]
