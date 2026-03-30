FROM ruby:2.7.8

ENV APP_HOME=/app \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development:test \
    RAILS_ENV=production \
    RACK_ENV=production

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libpq-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock .ruby-version ./

RUN gem install bundler -v 2.2.33 && \
    bundle _2.2.33_ config set without 'development test' && \
    bundle _2.2.33_ install

COPY . .

EXPOSE 3000

CMD ["bash", "-lc", "bundle exec rake db:migrate && bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000} -e production"]
