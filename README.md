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
* retry os.getEnv(...) i.e. when environment variable changed
* change context path (when overriding it using ingress controller, service returns 404)
* explain Pipeline, VERSION, open-api-3.yaml, dockerfile
* system view as image?  
* structure oriented on https://github.com/golang-standards/project-layout  
* how to fork (github credentials, ...)  
* example requests  
* write some tests? (disclaimer? this project should only demonstrate how github and docker integration is working together)

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