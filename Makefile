# $Id$

PROG=nexcloud_backups_aws_s3

TEST_DIR=$(PWD)/tests

all: test

test:
	@echo "executing $(PROG) unit tests"
	( $(TEST_DIR)/run-test-suite )
