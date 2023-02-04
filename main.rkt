#lang racket/base

(require racket/pretty)

(require "data.rkt")

;; TODO: create progress `bar`s
;; prints all reading list data
(for-each pretty-print (read-data "./data"))
