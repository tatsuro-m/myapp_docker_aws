FROM ruby:2.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

#追加
RUN mkdir -p tmp/sockets

# Expose volumes to frontend
VOLUME /myapp/public
VOLUME /myapp/tmp


# 以下の部分をそのままにしておくと、rails sになると思うので、nginxを使うように一旦コメントアウトしておきますね。
## Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
#EXPOSE 3000
#
## Start the main process.
#CMD ["rails", "server", "-b", "0.0.0.0"]


# Start Server
# TODO: environment
CMD bundle exec puma