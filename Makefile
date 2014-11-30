
NPM   = npm
GRUNT = ./node_modules/grunt-cli/bin/grunt

all: build

bootstrap:
	@if [ ! -x $(GRUNT) ]; then $(NPM) install; fi

build: bootstrap
	@$(GRUNT)

clean: bootstrap
	@$(GRUNT) clean:clean

distclean: bootstrap
	@$(GRUNT) clean:clean clean:distclean

update-package-json: bootstrap
	$(NPM) install npm-check-updates
	./node_modules/npm-check-updates/bin/npm-check-updates -u

