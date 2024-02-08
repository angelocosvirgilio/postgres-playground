# Local Variables
# ===============
#
# Pass custom values to the `make` cli as:
# > make start pg_name=foobar
#

include ../../Makefile
# curr_project?=projects/pushid
# base_dir?=../..

filename=script

#populate: filename=populate
#create-schema: filename=read-data
clean: filename=clean
populate: filename=pagila-data
research: filename=research
examples-functions: filename=examples-functions
examples-queries: filename=examples-queries
research: filename=research
clean populate research examples-functions examples-queries: exec-file


concat-files:
	@cat seed.sql pagila-schema.sql > $(filename).sql

create-schema: concat-files exec-file
	@rm $(filename).sql