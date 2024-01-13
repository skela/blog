
run: build
	docker-compose down
	docker-compose up -d

.PHONY: build
build: blog serve

.PHONY: blog
blog:
	/home/skela/code/publish/.build/release/publish-cli generate
	python inject.py
	docker build --build-arg SRC_PATH=.dev -f Dockerfile -t skela/blog:latest .

.PHONY: serve
serve:
	docker build -f serve/Dockerfile -t skela/blog-serve:latest serve

.PHONY: watch
watch:
	sh watch.sh

