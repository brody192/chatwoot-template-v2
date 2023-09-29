FROM chatwoot/chatwoot:v$3.1.1-ce

ARG FRONTEND_URL ACTIVE_STORAGE_SERVICE DATABASE_URL PGHOST PGPORT DEFAULT_LOCALE INSTALLATION_ENV NODE_ENV RAILS_ENV REDIS_URL SECRET_KEY_BASE

RUN apk add --no-cache multirun postgresql-client

CMD pg_isready -h $PGHOST -p $PGPORT && bundle exec rails db:chatwoot_prepare && bundle exec rails db:migrate && \
    multirun "bundle exec sidekiq -C config/sidekiq.yml" && "bundle exec rails s -b 0.0.0.0 -p $PORT"