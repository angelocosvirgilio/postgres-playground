# Local Variables
# ===============
#
# Pass custom values to the `make` cli as:
# > make start pg_name=foobar
#
pg_name?=test-db
pg_password?=postgres
pg_version?=13.2
pg_data?=.docker-data

start:
	@echo "Starting Project..."
	@mkdir -p $(CURDIR)/$(pg_data)
	@docker-compose up -d
	@docker-compose logs -f

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

seed:
	@docker exec -i $(pg_name) psql -U postgres postgres < ./seed.sql
