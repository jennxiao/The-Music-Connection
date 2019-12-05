FROM travisci/ubuntu-ruby:16.04

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# postgresql gem dependency
RUN apt-get install zlib1g-dev
RUN apt-get install -y libpq-dev
# sqlite3 gem dependency
RUN apt-get install -y libsqlite3-dev
RUN apt-get install dos2unix

WORKDIR /
RUN mkdir /The-Music-Connection
WORKDIR /The-Music-Connection
COPY Gemfile /The-Music-Connection/Gemfile
COPY Gemfile.lock /The-Music-Connection/Gemfile.lock
RUN gem install bundler --version 1.17.3
RUN gem uninstall bundler --version 2.0.2
RUN bundle _1.17.3_ install
COPY . /The-Music-Connection

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN dos2unix /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

WORKDIR /The-Music-Connection
CMD ["rails", "server", "-b", "0.0.0.0"]
