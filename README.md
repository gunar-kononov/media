# README

Server:

> bundle install

> RAILS_ENV=production DATABASE_URL=postgres://user:pass@host/db bin/rails db:setup

> RAILS_ENV=production DATABASE_URL=postgres://user:pass@host/db SECRET_KEY_BASE=secret bin/rails s

Tests:

> RAILS_ENV=test bin/rails db:create

> RAILS_ENV=test bin/rails db:schema:load

> RAILS_ENV=test bin/rspec
