.PHONY: $(MAKECMDGOALS)

setup:
	docker-compose down
	docker-compose rm
	docker-compose build
	docker-compose run shorty mix setup

server:
	docker-compose up

test:
	docker-compose run shorty mix test
