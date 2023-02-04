#lang racket/base

(require gregor)
(require rackunit "../data.rkt")

;; testing for the data module
(define data-tests
  (test-suite
    "Test for data.rkt"

    (test-case
      "An update struct has expected transparent fields"
      (let ([an-event (an-update 9 (datetime 2023 02 05 06 15 51))])
        (check-equal?
          (an-update-read_up_to an-event) 9
          "read_up-to should be accessible")
        (check-equal?
          (an-update-updated_at an-event) (datetime 2023 02 05 06 15 51)
          "updated_at should be accessible")
        an-event))

    (test-case
      "A book struct has expected transparent fields"
      (let ([a-book (book "title" "978-0-0-0000-0000-0" 349 '())])
        (check-equal?
          (book-title a-book) "title"
          "title should be accessible")
        (check-equal?
          (book-isbn a-book) "978-0-0-0000-0000-0"
          "isbn should be accessible")
        (check-equal?
          (book-total_page_numbers a-book) 349
          "total_page_numbers should be accessible")
        (check-equal?
          (book-update a-book) '()
          "update should be accessible")
        a-book))

    ;; TODO create-book
    ;; TODO read-data
  ))

(provide data-tests)
