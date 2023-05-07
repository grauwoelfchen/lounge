#lang racket/base

(require racket/pretty)

(require "data.rkt")

;; TODO: create progress `bar`s
;; ~~prints all reading list data~~ returns only `is_focused` for now
(for-each pretty-print
          (filter
            (lambda (d) (status-is_focused (book-status d)))
            (read-data "./data")))
