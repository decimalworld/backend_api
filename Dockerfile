FROM ruby:2.5

RUN mkdir /backend
WORKDIR /backend

COPY Gemfile* /backend/
RUN bundle install
COPY ./ /backend/