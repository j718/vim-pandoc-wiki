FROM node:12.6-buster-slim

RUN apt-get update && apt-get install git -y
RUN apt-get install vim -y
