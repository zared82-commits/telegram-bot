APP := kbot
REGISTRY := ghcr.io
OWNER := zared82
IMAGE := $(REGISTRY)/$(OWNER)/$(APP)

VERSION := v1.0.0
SHA := $(shell git rev-parse --short HEAD)
OS := linux
ARCH := amd64

TAG := $(VERSION)-$(SHA)-$(OS)-$(ARCH)

.PHONY: test image push print

test:
	cd telegram-bot && go test ./...

image:
	docker build -t $(IMAGE):$(TAG) .

push:
	docker push $(IMAGE):$(TAG)

print:
	@echo $(IMAGE):$(TAG)
