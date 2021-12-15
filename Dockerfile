FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y default-libmysqlclient-dev
RUN mkdir /chat

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

EXPOSE 3000