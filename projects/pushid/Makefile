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

concat-files:
	@cat test.sql test2.sql > $(filename).sql

exec-script: exec-file

exec-scripts: concat-files exec-script
	@rm $(filename).sql