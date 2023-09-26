CONTAINER_NAME=larmic-golang-starter-example
IMAGE_NAME=larmic/golang-starter-example
IMAGE_TAG=latest

# external url that will be called by /api/external
EXTERNAL_URL=https://catfact.ninja/fact

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Build 🏗️———————————————————————————————————————————————————————————————————————————————————————————————————
docker-build: ## Builds docker image including automated tests
	@echo "Remove docker image if already exists"
	docker rmi -f ${IMAGE_NAME}:${IMAGE_TAG}
	@echo "Build go docker image"
	DOCKER_BUILDKIT=1 docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
	@echo "Prune intermediate images"
	docker image prune --filter label=stage=intermediate -f

## —— Run application 🏃🏽————————————————————————————————————————————————————————————————————————————————————————
docker-run: ## Runs docker container
	@echo "Run docker container"
	docker run -d -p 8080:8080 --rm -e EXTERNAL_URL=${EXTERNAL_URL} --name ${CONTAINER_NAME} ${IMAGE_NAME}
	docker logs -f ${CONTAINER_NAME}

docker-stop: ## Stops running docker container
	@echo "Stop docker container"
	docker stop ${CONTAINER_NAME}
