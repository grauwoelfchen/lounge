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

```zsh
# make sure if you configure the local path in .autoenv (see .autoenv.sample)
% cd /path/to/lounge
# print progress bars
% bar
The Curious Incident of the Dog in the Night-Time:
Reading [=============================================-----] 242/268 90.3%

Learning go:
Reading [===========================================-------] 291/340 85.59%

Rust in Action:
Reading [===-----------------------------------------------] 23/417 5.52%
...
```


## License

`BSD-3-Clause`

```txt
Lounge
Copyright (c) 2023 Yasuhiro Яша Asaka
```
