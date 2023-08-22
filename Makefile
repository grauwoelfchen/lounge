# after pkg install, raco will setup
setup:
	@raco pkg install --pkgs --fail-fast
.PHONY: setup

test:
	@raco test --direct test/test.rkt
.PHONY: test

build:
	raco exe -o $(PWD)/dst/bar src/main.rkt
.PHONY: build

clean:
	@rm -f $(PWD)/dst/bar
.PHONY: clean
