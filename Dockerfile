FROM alpine:latest

RUN apk update && \
    apk add openjdk21

RUN wget https://github.com/opentripplanner/OpenTripPlanner/releases/download/v2.7.0/otp-shaded-2.7.0.jar -O otp.jar

RUN wget https://github.com/openstreetmap/osmosis/releases/download/0.49.2/osmosis-0.49.2.zip && \
    unzip osmosis-0.49.2.zip -d /opt && \
    mv /opt/osmosis-0.49.2 /opt/osmosis && \
    ln -s /opt/osmosis/bin/osmosis /usr/local/bin/osmosis

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache s5cmd

COPY . .

RUN chmod +x tasks.sh

CMD ./tasks.sh
