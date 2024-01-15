# Local Variables
# ===============
#
# Pass custom values to the `make` cli as:
# > make start pg_name=foobar
#

include ../../Makefile
# curr_project?=projects/pushid
# base_dir?=../..

clean: filename=clean
clean: exec-file


loaddata: filename=loaddata
analyze: filename=analyze
deletetuples: filename=deletetuples
runvacuum: filename=runvacuum
loaddata analyze deletetuples runvacuum: seed exec-file


