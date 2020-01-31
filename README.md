# dockerizing-ruby
Dockerizing Ruby Tutorial

## Local setup

Prepare environment, for dev version you can use the example environment:

```bash
$ cp env-example .env
```

Start the server:

```bash
$ docker-compose up --build
```


Browse http://localhost:8020


## Production image

Prepare production environment, set you production values:

```bash
$ cp env-example .env
```bash


```bash
$ docker build --build-arg USER_ID=$(id -u)  --build-arg GROUP_ID=$(id -g) -t $DOCKER_USERNAME/dockerizing-ruby-drkiq:latest .
```bash




In addition to these two containers, you’ll need a Postgres and redis databases, and it’s reommended to put a load balancer in front of port 8010

Start drkiq:

```bash
$ docker run -it --env-file=.env -p 8010:8010 -v VOLUME_MAPS -t $DOCKER_USERNAME/dockerizing-ruby-drkiq:latest
```


Start sidekiq

```bash
$ docker run -it --env-file=.env -v VOLUME_MAPS -t $DOCKER_USERNAME/dockerizing-ruby-drkiq:latest bundle exec sidekiq
```

