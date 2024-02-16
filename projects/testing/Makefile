# Local Variables
# ===============
#
# Pass custom values to the `make` cli as:
# > make start pg_name=foobar
#
include ../../Makefile

pg_name=test-db
pg_password?=postgres
pgtap_version?=v0.0.0
project?=default
case?=*

clean: filename=clean
clean: exec-file

start-tests: clean seed test

build-test-container:
	clear
	@echo "Building pgtap container ..."
	@docker build -t pgtap ./pgtap

test: build-test-container run

run:
	clear	
	@echo "Running Unit Tests ..."
	@docker run --rm \
		--network=postgres-playground_default \
		--name pgtap \
		--link $(pg_name) \
		-v $(CURDIR)/tests/$(project)/:/$(project) \
		pgtap \
			-h test-db -u postgres -w postgres -d postgres -t '/$(project)/$(case).sql'
