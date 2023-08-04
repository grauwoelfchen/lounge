# Lounge


## Requirements

* Racket


## Build

```zsh
# to build the `bar` CLI application
% make build
```


## Test

```zsh
# use rackunit
% make test
```


## Usage

### Bar

Build the `bar` binary.

```zsh
# make sure if you configure the local path in .autoenv (see .autoenv.sample)
% cd /path/to/lounge
# print progress bars
% bar
His Dark Materials Northern Lights:
Reading [==-------------------------------------------] 18/397 4.53%

Learning go:
Reading [=======================================------] 291/340 85.59%

Rust in Action:
Reading [==-------------------------------------------] 23/417 5.52%

Programming Elm:
Reading [====-----------------------------------------] 25/270 9.26%
```

### Suit

A small shell script that finds the target file (ISBN code) with partial
letters input of a book title, and opens it via `$EDITOR`.

This requires the fuzzy finder `fzf`. See the `bin/suit`.

```zsh
# make sure if you configure the local path in .autoenv (see .autoenv.sample)
% cd /path/to/lounge
# prints a list of pairs like `(isbn, title)`, and gives it to `fzf`.
#
# e.g.
#
#   ...
#   (978-1-83855-833-5, Mastering Go)
# > (978-1-492-07721-3, Learing Go)
# 4/24 ───────────────────────────────────────────────────────────────────────
# > Go
% suit
```

The filtering part is equivalent with:

```zsh
% ls data/*.toml | \
xargs head -3 | \
awk '{
  if ($1 ~ /^title|^isbn/) {
    s=substr($0, index($0, $3));
    gsub("\"", "", s);
    print s;
  }
}' | \
awk '!(NR % 2) {
  print "("$0", "p")"
} {
  p = $0
}' | \
fzf
```


## License

`BSD-3-Clause`

```txt
Lounge
Copyright (c) 2023 Yasuhiro Яша Asaka
```
