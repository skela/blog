
run: build
	docker-compose down
	docker-compose up -d

.PHONY: build
build:
	/home/skela/code/publish/.build/release/publish-cli generate
	docker build -f Dockerfile -t skela/blog:latest .

push_docker:
	docker push skela/blog:latest

push_digital_ocean:
	docker tag skela/blog:latest registry.digitalocean.com/skela/blog
	docker push registry.digitalocean.com/skela/blog
