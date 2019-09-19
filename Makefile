docker-image:
	docker build -t ainfosec-shim .

shim: docker-image
	mkdir -p ./build
	docker run -v $(shell pwd):/build ainfosec-shim

clean:
	rm -rf ./boot 
	rm -rf ./usr

.PHONY: all
all: shim

