
run: build
	docker-compose down
	docker-compose up -d

.PHONY: build
build:
	/home/skela/code/publish/.build/release/publish-cli generate
	docker build -f Dockerfile -t skela/blog:latest .

