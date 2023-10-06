# after pkg install, raco will setup
setup:
	@raco pkg install --deps search-auto --skip-installed --fail-fast
.PHONY: setup

test:
	@raco test --quiet --direct test/test.rkt
.PHONY: test

build-bar:
	raco exe -o $(PWD)/dst/bar src/bar.rkt
.PHONY: build-bar

build-sofa:
	raco exe -o $(PWD)/dst/sofa src/sofa.rkt
.PHONY: build-sofa

build: build-bar build-sofa
.PHONY: build

clean:
	@raco pkg empty-trash
	@rm -fr $(PWD)/{,src/}compiled
	@rm -f $(PWD)/dst/bar
.PHONY: clean
