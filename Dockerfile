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

RUN gem install bundler -v 1.17.3 && \
    bundle _1.17.3_ config set without 'development test' && \
    bundle _1.17.3_ install

COPY . .

RUN SECRET_KEY_BASE=dummy bundle _1.17.3_ exec rake assets:precompile

EXPOSE 3000

RUN printf '#!/usr/bin/env bash\nset -e\n\necho \"Starting Alpha Blog...\"\necho \"Running database migrations...\"\nbundle exec rake db:migrate --trace\necho \"Seeding demo content if needed...\"\nbundle exec rake db:seed\necho \"Starting Rails server on port ${PORT:-3000}...\"\nexec bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000} -e production\n' > /usr/local/bin/start-render && chmod +x /usr/local/bin/start-render

CMD ["/usr/local/bin/start-render"]
