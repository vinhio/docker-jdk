all: build version run

build:
	docker build -t vinhio/jdk:11-alpine .

version:
	docker run -ti vinhio/jdk:11-alpine java -version

run:
	docker run -ti -u java vinhio/jdk:11-alpine bash

