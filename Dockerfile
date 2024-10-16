FROM ruby:3.3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN bundle install

EXPOSE 9292

CMD [ "rackup", "-o", "0.0.0.0" ]
