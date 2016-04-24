FROM ubuntu:precise

RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev swig python-dev curl git -y

ADD . /project

WORKDIR /project

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*