docker-clean:
	@echo "Remove all non running containers"
	docker rm `docker ps -q -f status=exited`
	@echo "Delete all untagged/dangling (<none>) images"
	docker rmi --force $$(docker images -q dangling=true)
	# docker rmi `docker images -q -f dangling=true`

clean:
	docker rmi --force $$(docker images -q davidban77/netautomator | uniq)

clean-containers:
	docker stop $$(docker ps -aq)
	docker rm $$(docker ps -aq)

clean-latest:
	docker rmi davidban77/netautomator:latest -f

clean-workstation:
	docker rmi davidban77/netautomator:workstation -f

clean-ansible:
	docker rmi davidban77/netautomator:ansible -f

workstation: clean-workstation
	docker build -t davidban77/netautomator:workstation -f docker/workstation/Dockerfile .

ansible: clean-ansible
	docker build -t davidban77/netautomator:ansible -f docker/ansible/Dockerfile .
