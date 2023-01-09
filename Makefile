build:
	raco exe -o ./dst/bar main.rkt
.PHONY: build

clean:
	@rm -f ./dst/bar
.PHONY: clean
