FROM alpine:latest

RUN apk update && \
    apk add openjdk21

RUN wget https://github.com/opentripplanner/OpenTripPlanner/releases/download/v2.7.0/otp-shaded-2.7.0.jar -O otp.jar

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add --no-cache s5cmd

COPY . .

RUN chmod +x tasks.sh

CMD ./tasks.sh
