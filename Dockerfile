FROM ruby:3.1.2-alpine3.16

ENV APP_ROOT /usr/src/myapp

RUN apk update && \
  apk add --no-cache \
  build-base \
  gcompat \
  git \
  mysql-dev \
  tzdata && \
  mkdir $APP_ROOT

WORKDIR $APP_ROOT

COPY Gemfile* $APP_ROOT/

RUN bundle install --jobs 4

COPY . $APP_ROOT
