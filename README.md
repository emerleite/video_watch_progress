# Video Watch Progress

Track video watch progress and return the point you've stopped. 

NOTE: This software it's almost production ready. It's an open source version of what I did for the last two years. There's few work to do. This first version was created to present at Elixir Conf US 2018. In a few weeks I'll release a full production ready with the improvements I have to finish. Take a look on ISSUES and see what's missing.

## Dependencies
  * Elixir 1.7
  * MySQL 5.7

```sh
$ docker run --name mysql-video -p 3306:3306 -e MYSQL_ALLOW_EMPTY_PASSWORD=true -d mysql:5.7
```

## Starting

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Demo

There is a demo at `demo/index.html` that works with this version.
