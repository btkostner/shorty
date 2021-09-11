.PHONY: $(MAKECMDGOALS)

setup:
	docker-compose down
	docker-compose rm
	docker-compose build
	docker-compose run shorty mix setup

server:
	docker-compose up

lint:
	docker-compose run shorty mix format
	docker-compose run shorty mix credo
	docker-compose run shorty mix dialyzer

test:
	docker-compose run shorty mix test
