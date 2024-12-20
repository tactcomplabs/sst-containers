docker: docker_build docker_run
docker_build:
	docker build -t sst_14_1 .

docker_run:
	docker run -it --rm \
             -v `pwd`:/scratch \
             --user $(id -u):$(id -g) \
             sst_14_1 /bin/bash 
