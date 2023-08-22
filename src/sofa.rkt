#lang racket/base

(require "data.rkt")

(for-each (lambda (b)
            ;; TODO: use plot?
            '())
          (filter
            ;; prints only `is_focused` entries by default
            (lambda (b) (status-is_focused (book-status b)))
            (read-data (build-path (current-directory) "data"))))
