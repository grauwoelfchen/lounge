#lang racket/base

(require gregor)
(require rackunit "../src/data.rkt")

;; testing for the data module
(define data-tests
  (test-suite
    "Test for data.rkt"

    ;; update with order = "sequential"
    (test-case
      "An update struct for seq has expected transparent fields"
      (let ([an-event (an-update-seq 9 (datetime 2023 02 05 06 15 51))])
        (check-equal?
          (an-update-seq-read_up_to an-event) 9
          "read_up-to should be accessible")
        (check-equal?
          (an-update-seq-updated_at an-event) (datetime 2023 02 05 06 15 51)
          "updated_at should be accessible")
        an-event))

    ;; update with order = "random"
    (test-case
      "An update struct for rnd has expected transparent fields"
      (let ([an-event (an-update-rnd (read-range 3 4)
                                     (datetime 2023 02 05 06 15 51))])
        (check-equal?
          (an-update-rnd-read_range an-event) (read-range 3 4)
          "read_range should be accessible")
        (check-equal?
          (an-update-rnd-updated_at an-event) (datetime 2023 02 05 06 15 51)
          "updated_at should be accessible")
        an-event))

    ;; reading_approach

    ;; status

    ;; book
    (test-case
      "A book struct has expected transparent fields"
      (let ([a-book (book
                      "title"
                      "978-0-0-0000-0000-0"
                      3
                      349
                      "print"
                      '()
                      '()
                      '()
                      )])
        (check-equal?
          (book-title a-book) "title"
          "title should be accessible")
        (check-equal?
          (book-isbn a-book) "978-0-0-0000-0000-0"
          "isbn should be accessible")
        (check-equal?
          (book-edition a-book) 3
          "edition should be accessible")
        (check-equal?
          (book-total_page_numbers a-book) 349
          "total_page_numbers should be accessible")
        (check-equal?
          (book-format a-book) "print"
          "print should be accessible")
        (check-equal?
          (book-reading_approach a-book) '()
          "reading_approach should be accessible")
        (check-equal?
          (book-status a-book) '()
          "status should be accessible")
        (check-equal?
          (book-update a-book) '()
          "update should be accessible")
        a-book))

    ;; TODO create-book
    ;; TODO read-data
  ))

(provide data-tests)
