# Mattermost's focalboard in docker

## About

Packages Mattermost's [focalboard](https://www.focalboard.com/) server for the current docker platform (e.g. raspberry pi) in a docker container.

### Why

I wanted to try [focalboard](https://www.focalboard.com/) on my raspberry pi, but no ARM builds where available at that time.

### How

Compiles the source release of focalboard and combines it with the non-platform specific files from the binary release.

## Build

Plase edit the `config.json` and change the default settings (e.g. secrets).

### Docker

```
docker build -t focalboard .
docker run -it -p 8000:8000 focalboard
```

Open a browser to http://localhost:8000 to start

### Docker-Compose

Docker-Compose provides the option to automate the build and run step, or even include some of the steps from the [personal server setup](https://www.focalboard.com/download/personal-edition/ubuntu/).


To start the server run

```
docker-compose up
``` 

This will automatically build the focalboard image and start it with the http port mapping.

## CREDITS and THANK YOU's

- [smallest secured golang docker image](https://github.com/chemidy/smallest-secured-golang-docker-image)
- [Mattermost](https://github.com/mattermost/focalboard)
