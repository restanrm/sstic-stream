.PHONY: build run

target=restanrm/sstic-stream


build:
	docker build -t ${target} .

run:
	docker run --rm -it -p 80:80 -p 1935:1935 --name sstic-stream ${target}
