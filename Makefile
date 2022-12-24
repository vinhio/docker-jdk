VERSION ?= 'latest'

build:
	docker build --no-cache -t vinhio/jdk:17-alpine .

run:
	docker run -ti -u java vinhio/jdk:17-alpine bash

version:
	#make version VERSION="latest"
	docker tag vinhio/jdk:17-alpine vinhio/jdk:$(VERSION)

push:
	#make push VERSION="latest"
	docker push vinhio/jdk:$(VERSION)
