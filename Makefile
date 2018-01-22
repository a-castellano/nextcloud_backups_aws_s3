# $Id$

PROG=nexcloud_backups_aws_s3

TEST_DIR=$(PWD)/tests

all: test

test:
	@echo "executing $(PROG) unit tests"
	@echo "- variables"
	( $(TEST_DIR)/01-variables )
	@echo "- usage"
	( $(TEST_DIR)/02-usage )
	@echo "- config files"
	( $(TEST_DIR)/03-configfiles )
	@echo "- unset variables"
	( $(TEST_DIR)/04-unsetvariables )
	@echo "- check required software"
	( $(TEST_DIR)/05-checkrequiredsoftware )
