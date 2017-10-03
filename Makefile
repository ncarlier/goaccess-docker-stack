.SILENT :

# Include common Make tasks
root_dir:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
makefiles:=$(root_dir)/makefiles
include $(makefiles)/help.Makefile
include $(makefiles)/compose.Makefile

## Deploy containers to Docker host
deploy: compose-build compose-up
.PHONY: deploy

## Un-deploy containers from Docker host
undeploy: compose-down
.PHONY: undeploy

## Get deployed service(s) status
status: compose-status
.PHONY: status

## Get deployed service(s) logs
logs: compose-logs
.PHONY: logs

## Generate report
report:
	$(MAKE) compose-start service=goaccess
.PHONY: report
