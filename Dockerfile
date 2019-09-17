FROM ubuntu:xenial

ADD requirements.txt requirements.txt
ADD setup.sh setup.sh
RUN apt-get -y update 
RUN apt-get install -y vim git python3 python3-pip python3-venv
RUN chmod +x setup.sh
CMD ./setup.sh