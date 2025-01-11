run:
	docker run --env-file .env 'hh_app'

build: env_file
	docker build --tag 'hh_app' .

env_file:
ifeq (,$(wildcard .env))
	@echo "Creating .env file from .env-example..."
	cp .env-pub .env
endif

clean:
	docker stop $(shell docker ps -q --filter ancestor=hh_app ) 2>/dev/null || true
	docker rm $(shell docker ps -a -q --filter "ancestor=hh_app") 2>/dev/null || true

rebuild: clean build