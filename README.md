## Tech Stack

- Ruby 3.1.2
- Rails 7.0.3
- Redis 4.8
- PostgreSQL 14.5
- Sidekiq 6.5

## Instalation

```
# Clone repository:
$ git clone https://github.com/danyflorczak/Monte_Cinema.git

# Install required gems:
$ bundle install

# Create database with basic seeds:
$ rails db:create
$ rails db:migrate
$ rails db:seed

# compile assets
$ rails assets:precompile

# Run server
$ rails server

# Run Cron Jobs:
$ sidekiq 

# Run Tests:
$ rspec
```


