#lang racket/base

(require racket/format)
(require racket/list)
(require racket/math)
(require racket/pretty)

(require "data.rkt")

(define bar-width 45)

(for-each (lambda (b)
            ;; skip "random" reading order books (for now)
            (if (and (equal? (approach-order (book-reading_approach b))
                             "sequential")
                     (not (empty? (book-update b))))
              (let* ([p (an-update-seq-read_up_to (book-update b))]
                     [v (* (/ p (book-total_page_numbers b)) 100)]
                     [s (exact-round (* (/ bar-width 100) v))])
                ;; prints a progress bar
                (displayln (format
                             "~a:\nReading [~a~a] ~a/~a ~a%\n"
                             (book-title b)
                             (make-string s #\=)
                             (make-string (- bar-width s) #\-)
                             p
                             (book-total_page_numbers b)
                             (~r v #:precision 2))))
              0))
          (filter
            ;; prints only `is_focused` entries by default
            (lambda (b) (status-is_focused (book-status b)))
            (read-data "./data")))
