USER_NAME := ublin

.PHONY: all build push clean

all: build push

build: build-comment build-ui build-post build-prometheus

push: push-comment push-ui push-post push-prometheus

clean:
	@echo "Stopping and removing all containers..."
	@docker stop $(shell docker ps -aq) || true
	@docker rm $(shell docker ps -aq) || true
	@echo "Removing all images..."
	@docker rmi -f $(shell docker images -aq) || true

build-comment:
	@cd ../src/comment && \
	docker build -t $(USER_NAME)/comment .

build-ui:
	@cd ../src/ui && \
	docker build -t $(USER_NAME)/ui .

build-post:
	@cd ../src/post-py && \
	docker build -t $(USER_NAME)/post .

build-prometheus:
	@cd ../monitoring/prometheus && \
	docker build -t $(USER_NAME)/prometheus .

push-comment:
	@docker push $(USER_NAME)/comment

push-ui:
	@docker push $(USER_NAME)/ui

push-post:
	@docker push $(USER_NAME)/post

push-prometheus:
	@docker push $(USER_NAME)/prometheus
