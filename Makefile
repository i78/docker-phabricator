BUILDTIME=$(shell date +%s)

docker-image:	
	docker build --no-cache -t codecyclist/phabricator -t codecyclist/phabricator:${BUILDTIME} phabricator

reset-compose:
	docker-compose rm

clean:
	echo Removing docker images...
	docker rmi codecyclist/phabricator

destroy:
	echo Removing docker instances
	docker-compose rm 
	docker volume prune
