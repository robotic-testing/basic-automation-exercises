FROM ruby:3.0.4-alpine

ENV BUNDLER_VERSION 2.2.21

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN apk add build-base

RUN echo 'gem: --no-rdoc --no-ri' >> "/root/.gemrc" \
    && gem install bundler -v $BUNDLER_VERSION \
    && bundle config deployment 'true' \
    && bundle config without development:test \
    && bundle install --jobs 4 --retry 2

ADD . /app

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
