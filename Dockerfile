# ----------------------------------------------------------------------------------------------
# hackathon-starter Development Container
# Build command
# docker build -t nixhatter/hackathon-starter .
# Running the container
# Make sure to set the port to your specific web app
# docker run --name hackathon-starter -d -p 3000:3000 nixhatter/hackathon-starter
# ----------------------------------------------------------------------------------------------
FROM centos:latest
MAINTAINER Dillon Aykac <dillon@nixx.co>
LABEL Description="A container for hackathon starter" Vendor="NiXX" Version="1.0"

# Let's install all the dependencies
RUN yum -y update; yum clean all
RUN yum -y group install "Development Tools"
RUN yum -y install epel-release; yum clean all
RUN yum -y install git which inotify-tools


RUN yum install -y nodejs npm
#RUN npm install -g npm@latest
#RUN npm install -g n
#RUN n 0.12
RUN npm config set loglevel warn

# Setup the Volume
VOLUME ["/var/www"]

RUN mkdir /var/internal

RUN echo "inotifywait -r -m /var/www | while read" >> inotify.sh
RUN echo "do" >> inotify.sh
RUN echo "rsync -a /var/www/ /var/internal/" >> inotify.sh
RUN echo "done" >> inotify.sh

# Expose Ports
EXPOSE 3000

# Let's go go go
CMD sh inotify.sh & \
sleep 3 && \
rsync -a /var/www/ /var/internal/ && \
cd /var/internal && \
npm install && \
npm start
