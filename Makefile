ROOT_PASSWD?=rooting
IMAGE?=workstation
VERSION?=

docker-clean:
	@echo "Remove all non running containers"
	docker rm $$(docker ps -q -f status=exited)
	@echo "Delete all untagged/dangling (<none>) images"
	docker rmi --force $$(docker image ls -q --filter dangling=true)
	# docker rmi `docker images -q -f dangling=true`

clean-containers:
	docker stop $$(docker ps -aq)
	docker rm $$(docker ps -aq)

# Example to clean all images
# make clean IMAGE=workstation
clean:
	docker rmi $$(docker images --filter=reference="davidban77/netautomator:${IMAGE}*" -q)

# Example to create an specific version
# make build IMAGE=workstation VERSION=-1.0.0 ROOT_PASSWD=rooting
build:
	cd docker/${IMAGE}/ && \
		docker build --build-arg root_passwd=${ROOT_PASSWD} -t davidban77/netautomator:${IMAGE}${VERSION} . && \
		cd ../../

# Example to push an specific version
# make push IMAGE=workstation VERSION=-1.0.0
push:
	docker push davidban77/netautomator:${IMAGE}${VERSION}
