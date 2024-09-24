# Local Variables
# ===============
#
# Pass custom values to the `make` cli as:
# > make start pg_name=foobar
#
pg_name?=test-db
pg_password?=postgres
pg_data?=.docker-data
filename?=query-editor

start:
	@echo "Starting Project..."
	@mkdir -p $(CURDIR)/$(pg_data)
	@docker-compose up -d
	@docker-compose logs -f

start-hasura:
	@docker-compose up -d hasura-engine
	@docker-compose logs -f hasura-engine

stop:
	@echo "Stopping Project..."
	@docker-compose down

logs:
	clear
	@echo "Attaching to Postgres logs..."
	@docker-compose logs -f

psql:
	@echo "Connecting to the database ("quit" to exit) ..."
	@docker exec -it $(pg_name) psql -U postgres postgres

query-editor:
	@echo "Executing query-editor ..."
	@docker exec -i $(pg_name) psql -U postgres postgres < ./query-editor.sql

seed:
	@docker exec -i $(pg_name) psql -U postgres postgres < ./seed.sql

clean:
	@docker exec -i $(pg_name) psql -U postgres postgres < ./clean.sql

exec-file:
	@echo "Executing file ..."
	@docker exec -i $(pg_name) psql -U postgres postgres < ./$(filename).sql

live-query: 
	@chmod +x monitor-changes.sh
	./monitor-changes.sh

%: 
	@$(MAKE) exec-file filename=$@

curr_dir:
	@echo $(shell pwd)