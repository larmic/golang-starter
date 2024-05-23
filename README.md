# golang-starter

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Go build](https://github.com/larmic/golang-starter/actions/workflows/go-build.yml/badge.svg)](https://github.com/larmic/golang-starter/actions/workflows/go-build.yml)
[![Docker build and push](https://github.com/larmic/golang-starter/actions/workflows/docker-build-and-push.yml/badge.svg)](https://github.com/larmic/golang-starter/actions/workflows/docker-build-and-push.yml)
[![Docker hub image](https://img.shields.io/docker/image-size/larmic/golang-starter-example?label=dockerhub)](https://hub.docker.com/repository/docker/larmic/golang-starter-example)
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/larmic/golang-starter-example)

## Overview
This serves as a straightforward example illustrating how [Go](https://go.dev/), [Docker](https://www.docker.com/), 
[Docker Hub](https://hub.docker.com/) and [GitHub Actions](https://github.com/features/actions) can work seamlessly together. 
The ultimate goal is to achieve fully automated creation of a compact Docker image and its versioned 
transfer to Docker Hub.

## open TODOs
there are still some open TODOs
* system view as image?  
* structure oriented on https://github.com/golang-standards/project-layout  
* how to fork (github credentials, ...)  
* example requests  

## Used technologies
* [Go programming language](https://go.dev/)
* [Gin Web Framework](https://github.com/gin-gonic/gin) features a martini-like API with performance that is very fast
* [Docker](https://www.docker.com/) as application container
* [Docker Hub](https://hub.docker.com/) as container registry
* [GitHub Actions](https://github.com/features/actions) to automate CD/CD workflows (build docker application, push to registry,...)
* [Renovate](renovate.json) for automatic dependency updates 

## Requirements
* [Local Go installation](https://go.dev/doc/install) to build and run application without using docker for local debugging
* [Local Docker installation](https://docs.docker.com/engine/install/) to build docker container from local machine
* [Docker Hub account](https://hub.docker.com/signup) for automatically container upload to registry
* [Installed Renovate GitHub App](https://github.com/apps/renovate) to support automatically dependency updates

## In-depth explanation

### How to use this example

TODO

* Fork
* GitHub Credentials (for docker hub)
* Renovate
* change image name in GitHub actions

### Dockerfile

The [Dockerfile](Dockerfile) outlines a two-stage process to build a Go application.

In the first phase, it creates a so-called "Builder" container based on a predefined Golang image. All of the files that
comprise the Go project are copied into this container. Following that, all necessary dependencies are downloaded, tests
are run, and finally the application is compiled. Special attention is paid to adjusting the build to cater to different
hardware and operating system configurations.

In the second phase, a minimal executable Docker image is produced. The compiled application from the "Builder"
container is copied into a new Docker image, its base being an empty ('scratch') image, alongside associated
certificates. The entry point for the container is set to be the compiled application.

The resultant Docker image contains only the bare necessities to run the Go application and is therefore particularly
small and efficient. It demonstrates the multilayered nature of Docker and how well-thought-out Dockerfiles can
contribute to making containerization as efficient as possible.

### Pipeline

[GitHub Actions](https://github.com/features/actions) is used to automate two workflows:

1. [go-build.yml](.github/workflows/go-build.yml) 
   is using a plain [Go](https://go.dev/) workflow to build and test this application in a fast way.
2. [docker-build-and-push.yml](.gitignore/workflows/docker-build-and-push.yml)
   is responsible for building the [Docker](https://www.docker.com/) image and pushing it to [Docker Hub](https://hub.docker.com/).
   Repository secrets _DOCKER_USERNAME_ and _DOCKER_PASSWORD_ are required as documented in Part [How to use this example](#how-to-use-this-example).

TODO version replacement

### Where are the unit tests?

This is a simple illustration that shows the interaction between [Go](https://go.dev/), [Docker](https://www.docker.com/), [Docker Hub](https://hub.docker.com/) and 
[GitHub Actions](https://github.com/features/actions). Although the Dockerfile contains a phase that executes the 
(non-existent) tests, tests were omitted for the demo due to time constraints.