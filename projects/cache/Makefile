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

populate: filename=populate
clean: filename=clean
01-03-explain: filename=01-03-explain
02-04-checkblocks: filename=02-04-checkblocks
05-insufficient_cache: filename=05-insufficient_cache
populate clean 01-03-explain 02-04-checkblocks 05-insufficient_cache: exec-file

