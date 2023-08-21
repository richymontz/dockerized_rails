
# Dockerized Rails App

In this open REST API we are able to post a long url from a website and get a short encrypted version of this url, also we can consume endpoints in order to put the short url and be redirected to the website.

## Setup
create volumes for postgresql and redis first

    docker volume create --name dockerized-rails-postgres
    docker volume create --name dockerized-rails-redis

After create them, you should run:

    docker compose up --build -d

When containers are running, is necessary initialize the database in development, you should to run the following commands first:

    docker compose run dockerized_rails rake db:reset
    docker compose run dockerized_rails rake db:migrate

For test environment you should run this command:

    docker compose run dockerized_rails rake db:test:prepare

Now the application is ready!

## Endpoints

This table describe the available endpoints:

| Routes | Parameter |
|--|--|
| `GET/`  | `8ffdefb` Short URL in the route |
| `GET /web_sites` | `title: Google` |
| `POST /create_url` | `{ url: 'http://www.google.com' }` |

## Shortener code

    Digest::MD5.hexdigest(long_url)[0..6]
