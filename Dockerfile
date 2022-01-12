FROM ruby:2.3-slim

RUN apt-get update -y && apt-get install -y git

WORKDIR /app
ADD . .
RUN bundle install
