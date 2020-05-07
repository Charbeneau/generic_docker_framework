.PHONY: python-package help
.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([0-9a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

%:
    @:

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

docker-clean-unused: ## docker system prune --all --force --volumes
	docker system prune --all --force --volumes

docker-clean-all:  ## docker container stop $$(docker container ls --all --quiet) && docker system prune --all --force --volumes
	docker container stop $$(docker container ls --all --quiet) && docker system prune --all --force --volumes

build: ## Build the image and tag it generic
	docker build --tag generic .

jupyter: ## Start jupyter notebook server.
	docker run --publish 8888:8888 --volume $$(pwd)/notebooks:/workspace/notebooks --detach generic jupyter

hello_world: ## Run scripts/hello_world.py inside the 'generic' container.
	docker run --volume $$(pwd)/scripts:/workspace/scripts generic python /workspace/scripts/hello_world.py

stop: ## Stop the 'generic' container.
	docker container stop $$(docker ps -q --filter ancestor=generic)

shell:
	docker run --interactive --tty --volume $$(pwd)/scripts:/workspace/scripts generic /bin/sh
