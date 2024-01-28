#!/bin/bash

docker compose up -d
sleep 30
docker exec -it gitlab-runner gitlab-runner register \
--url http://EXTERNAL_IP \
--non-interactive \
--locked=false \
--name DockerRunner \
--executor docker \
--docker-image alpine:latest \
--registration-token GITLAB_TOKEN \
--tag-list "linux,xenial,ubuntu,docker" \
--run-untagged
