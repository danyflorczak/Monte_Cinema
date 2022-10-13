## Monte Cinema
Rubycamp Project :D

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

# Run server
$ rails server

# Run Cron Jobs:
$ sidekiq 

# Run Tests:
$ rspec
```
## Live App 
App is deployed on Heroku and you can find it here: </br>
https://monte-cinema-v1.herokuapp.com/ </br>
TESTS USERS: </br>
- login: test@manager.com, password: 'password'
- login: test@client.com, password: 'password'
</br>
App have few addons:
- Heroku Redis
- Sentry
- email sending ( in progress )
- generally speaking app is almost complete beside sending emails to user which is in progress


## Api Documentation
Link to Api documentation: </br>
https://documenter.getpostman.com/view/20280442/2s83zjt3y2#07a9a79e-32f7-4bb5-a21a-e9aa4dc7f505

## TO DO's

- [ ] Change api to be more flexible and secure
- [ ] Make emails work on heroku
- [ ] Write more tests 

