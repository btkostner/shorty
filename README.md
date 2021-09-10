<div align="center">
  <br>
  <img src="./priv/static/favicon-192.png" alt="Shorty URL Shortener" width="192" height="192">

  <h1>Shorty</h1>
  <h2>A simple URL Shortener</h2>
  <br>
</div>

<p align="center">
  <a href="https://github.com/btkostner/shorty/commits/master">
    <img src="https://img.shields.io/github/last-commit/btkostner/shorty.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub last commit">
  </a>

  <a href="https://github.com/btkostner/shorty/issues">
    <img src="https://img.shields.io/github/issues-raw/btkostner/shorty.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub issues">
  </a>

  <a href="https://github.com/btkostner/shorty/pulls">
    <img src="https://img.shields.io/github/issues-pr-raw/btkostner/shorty.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub pull requests">
  </a>  
</p>

<p align="center">
  <a href="#about">About</a> •
  <a href="#features">Features</a> •
  <a href="#running">Running</a> •
  <a href="#development">Development</a> •
  <a href="#faq">FAQ</a>
</p>

## About

Shorty is a dead simple URL shortener written in Elixir. It uses [hashids](https://hashids.org/) to create unique hashes based on the PostgreSQL auto increment pkey. This project was made to be dead simple and easily readable, with an easy path to scaling due to it's only dependency being PostgreSQL.

## Features

- A simple interface for adding URLs
- Exact same URLs get the exact same hashes
- A single PostgreSQL dependency
- No JavaScript required (though it does add some nice helper features)
- Easy to deploy docker image

## Running

For running this project, we have published a production ready docker image available at `ghcr.io/btkostner/shorty:latest`. Because every deployment platform is different, we will not cover how to deploy shorty to any specific platform, but we can give a quick run down on how to run it locally. For configuration, you can view the [environmental variables section](#Environmental-Variables).

### Docker

To start out, you will need these dependencies installed and usable.

  1. [Docker](https://docs.docker.com/get-docker/)
  2. A [PostgreSQL](https://www.postgresql.org/download/) instance with a _database already created_.
  3. A domain with SSL enabled. The docker image does not include SSL termination, but will include an `https://` on all full URLs it generates.

Next up, you will need to pull the docker image with:

```sh
docker pull ghcr.io/btkostner/shorty:latest
```

Once that is done, you will need to set three (or more) configuration variables.

  1. The `DATABASE_URL` to connect to postgreSQL.
  2. The `HOST` variable to create full URLs.
  3. The `SECRET_KEY_BASE` which needs to be 64 character random string.

The easiest way is to create a `.env` file that looks something like this:

```txt
DATABASE_URL=
HOST=
SECRET_KEY_BASE=
```

For more information can be found in the section below.

Then you will want to migrate your database with this command:

```sh
docker run --rm --network host --env-file .env -it ghcr.io/btkostner/shorty:latest eval Shorty.Release.migrate
```

And then finally, you can run the web server on port `8080` with:

```sh
docker run --rm --network host --env-file .env -it ghcr.io/btkostner/shorty:latest
```

### Environmental Variables

- `DATABASE_URL` - A full PostgreSQL connection URL. It should be in the form of `ecto://username:password@hostname/database`.

- `HASH_ID_SALT` - A random salt used in creating the short URL hash. Changing this after you have already inserted URLs into the database will result in all old hashes being incorrect.

- `HOST` - The domain people will access Shorty from. This is used to create full length URLs shown to users.

- `POOL_SIZE` - The amount of connections to pool for the database. Defaults to `10`.

- `SECRET_KEY_BASE` - Secret key for hashing web server cookies. This should be a 64 character random string generated with strong entropy.

## Developing

For developing, a local `docker-compose.yml` file and a `Makefile` has been included for convenience.

Firstly, you will need `docker` and `docker-compose` installed. Both have [excellent guides online for installing](https://docs.docker.com/compose/install/).

Next, simply run `make setup` to build the docker images needed for development. Any time you make changes to a dependency, you will need to re-run this command.

Next, you can run `make server` to start the development server. Most code should hot reload and be available without having to restart the server.

And lastly, to run tests, do `make test`. This will make sure the basic unit tests pass. More extensive testing, linting, and formatting will be ran when a PR is created.

## FAQ

### URL validation is really lax.

Yes. Yes it is. I could add more validation, ensure the URL is properly encoded on entry. Make sure there are no spaces or weird backslash stuff. It really doesn't matter though. Phoenix will encode the URL correctly when we redirect, so I left validation to the built in URI module. I could roll my own logic here, but I'm sure the people who have wrote the URI module know much more about the official spec, edge cases, and "the correct way of doing things" more than I do. Plus, the easy of entry adds to usability and UX.

### Why PostgreSQL as a data store?

It's the simplest data store to get up and running, has plenty of features (unique index on a text field with no character limit), and is used by _lots_ of large companies. This means any sort of scaling issue you run into has been blogged about before, any tool that you can think of has already been made, and just generally is a solid base to work on. It just works :tm: without a problem, which is exactly what you want from a database.

### The UI looks familiar.

Good eye. I used tailwind CSS for the styling, and used some tailwind UI templates for pages. They were adjusted to fit the project a bit more, but overall, it has a very stock tailwind feel to it.

### Are you going to add XXX feature?

Probably not. I consider the current state of Shorty pretty feature complete. Luckily, it's pretty easy to fork and add your own features to (like an admin interface.)
