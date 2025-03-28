FROM ruby:3.4-slim

RUN apt-get update -qq && apt-get upgrade -qq
RUN apt-get install -qq --no-install-recommends \
	build-essential git libpq-dev libyaml-dev libffi-dev libvips pkg-config
RUN gem install foreman tailwindcss

WORKDIR /app

COPY . .

RUN bundle install

EXPOSE 3000

CMD ["./bin/dev"]
