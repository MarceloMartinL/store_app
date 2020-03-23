# Store_app PJ

Store API that manages stores, products and orders.

## Requirements

- Ruby 2.6.5
- Rails 5.2.4
- Docker
- Docker-compose

## How To Use

Create a .env file in the root folder and set the ENV variables:
```
# Database config

POSTGRES_USER=<YOUR DB USER>
POSTGRES_PASSWORD=<YOUR DB PASS>

```
The run the following commands to start the app:
```
$ docker-compose run web bundle install
$ docker-compose run web rails db:create
$ docker-compose run web rails db:migrate
$ docker-compose up --build
```

## Run tests

```
$ docker-compose run web rspec
```
## API Documentation

https://app.swaggerhub.com/apis-docs/marcelom/store_app/1.0.0
