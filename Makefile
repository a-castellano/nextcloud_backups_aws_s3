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
