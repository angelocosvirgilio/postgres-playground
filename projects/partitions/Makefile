# Local Variables
# ===============
#
# Pass custom values to the `make` cli as:
# > make start pg_name=foobar
#

include ../../Makefile
# curr_project?=projects/pushid
# base_dir?=../..

# filename=script

clean: filename=clean

create-range: filename=create-range
populate-range: filename=populate-range
read-range: filename=read-range

create-list: filename=create-list
populate-list: filename=populate-list
read-list: filename=read-list

create-hash: filename=create-hash
populate-hash: filename=populate-hash
read-hash: filename=read-hash

multilevel: filename=multilevel
clean create-range populate-range read-range create-list populate-list read-list create-hash populate-hash read-hash multilevel: exec-file

