
run: build
	docker-compose down
	docker-compose up -d

.PHONY: build
build: blog serve

.PHONY: blog
blog:
	docker run -it -v .:/work -w /work hulex/publish-build:latest publish generate
	python inject.py
	docker build --build-arg SRC_PATH=.dev -f Dockerfile -t skela/blog:latest .

.PHONY: serve
serve:
	docker build -f serve/Dockerfile -t skela/blog-serve:latest serve

.PHONY: watch
watch:
	sh watch.sh

