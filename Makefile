REGISTRY ?= localhost:5000
IMAGES ?= $(shell find . -name '*Dockerfile' -print0 | xargs -0 -n1 dirname | cut -c 3- | sort)
TAG ?= $(shell git log -1 --pretty=format:%h)

.DEFAULT_GOAL := help

.PHONY: \
	help \
	list-tasks \
	list-images \
	remove \
	build \
	tag \
	tag-latest \
	push

help: ## print this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN { FS = ":.*?## " }; \
	{ printf "\033[36m%-15s\033[0m : %s\n", $$1, $$2 }'

list-tasks: ## list all available tasks
	@awk -F: '/^[a-z]/ {print $$1}' Makefile

list-targets: ## list all docker build targets
	@for image in $(IMAGES); do \
		echo $$image; \
	done

remove: ## remove all the images. For selected images: make remove -e IMAGES=image
	@for image in $(IMAGES); do \
		docker rmi $$image; \
	done

build: ## builds all the images. For selected images: make build -e IMAGES="image_a image_b"
	@for image in $(IMAGES); do \
		docker build --rm $(BUILD_ARGS) -t $$image -f $$image/*Dockerfile $$image; \
	done

tag: ## tag all the images. For selected image with desired tag: make tag -e IMAGES=image -e TAG=tag
	@for image in $(IMAGES); do \
		docker tag $$image $(REGISTRY)/$$image:$(TAG); \
	done

tag-latest: ## tag all the images with 'latest' tag. For selected images: make tag -e IMAGES=image
	@for image in $(IMAGES); do \
		docker tag $$image $(REGISTRY)/$$image:latest; \
	done

push: ## push all the images to the registry/ For selected images: make push -e REGISRTY=registry -e IMAGES=image
	@for image in $(IMAGES); do \
		docker push $(REGISTRY)/$$image:latest; \
	done
