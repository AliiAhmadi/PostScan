.DEFAULT_GOAL := run

.PHONY: run
run:
	@chmod +x main.sh ./lib/* ./cves/* config.sh
	@./main.sh
