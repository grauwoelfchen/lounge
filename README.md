# Lounge

## Requirements

* Racket

## Build

```zsh
# to build the `bar` CLI application
% make build
```

## Usage

```zsh
# make sure if you configure the local path in .autoenv (see .autoenv.sample)
% cd /path/to/lounge
% bar
(book
 "Command-Line Rust"
 "978-1-098-10943-1"
 361
 (update 59 #<datetime 2022-10-21T02:22:18>))
(book
 "Terraform: Up & Running"
 "978-1-492-04690-5"
 323
 (update 28 #<datetime 2023-01-18T19:13:27>))
(book
 "Learning go"
 "978-1-492-07721-3"
 340
 (update 92 #<datetime 2023-01-18T17:44:13>))
(book
 "Realm of Racket"
 "978-1-59327-491-7"
 283
 (update 34 #<datetime 2023-01-11T18:38:34>))
(book
 "Grokking Algorithms"
 "978-1-61729-223-1"
 233
 (update 23 #<datetime 2022-12-29T15:35:48>))
(book
 "Python Testing with pytest - Second Edition"
 "978-1-68050-860-4"
 240
 (update 240 #<datetime 2022-12-15T14:38:34>))
...
```
