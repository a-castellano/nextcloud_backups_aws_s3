PROG=nextcloud_backups_aws_s3

TEST_DIR=$(PWD)/tests

all: test build

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
	@echo "- check connections"
	( $(TEST_DIR)/06-checkconnections )
	@echo "- check users"
	( $(TEST_DIR)/07-checkusers )
	@echo "- check database backup"
	( $(TEST_DIR)/08-databasebackup )

build:
	( cp -R lib clean_lib )
	( find clean_lib -type f -exec sed  -i '/^\#.*$$/d' {} \; )
	( find clean_lib -type f -exec sed  -i '/source .*$$/d' {} \; )
	( perl -pe 's/source lib\/(.*)$$/`cat clean_lib\/$$1`/e'  src/$(PROG) > $(PROG) )
	( chmod 755 $(PROG) )
	( rm -rf clean_lib )

clean:
	( rm -f $(PROG) )

install:
	( mv $(PROG) /usr/bin/$(PROG) )

uninstall:
	( rm /usr/bin/$(PROG) )
