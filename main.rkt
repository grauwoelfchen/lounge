#lang racket

(require racket/pretty)
(require toml)

#|
;; calendar view? any idea?
(require racket/date)
(printf "~s\n"
        (date->string (seconds->date (current-seconds))))
|#

(struct an-update (read_up_to updated) #:transparent)
(struct book (title isbn total_page_numbers update) #:transparent)

;; creates a book. this takes a hasheq object represents book entry.
;; a book struct like looks like:
;;   (book
;;     "title" "isbn" total_page_numbers
;;     (an-update read_up_to #<datetime updated_at>))
(define (create-book br)
  (book (hash-ref br 'title)
        (hash-ref br 'isbn)
        (hash-ref br 'total_page_numbers)
        (if (hash-has-key? br 'updates)
          (let ([lu (first (hash-ref br 'updates))])
            (an-update (hash-ref lu 'read_up_to)
                       (hash-ref lu 'updated_at)))
          empty)))

;; reads files in the data directory and generates a list contains all books
(define (read-data path)
  ;; returns readable file or not
  (define (user-readable? f)
    (member 'read (file-or-directory-permissions f)))

  (for/list ([f (in-directory path user-readable?)])
    ;; parse-toml creates a hasheq object
    (let* ([ht (parse-toml (port->string (open-input-file f) #:close? #t))]
           [br (hash-ref ht 'book)])
      (create-book br))))

;; TODO: create progress `bar`s
(for-each pretty-print (read-data "./data"))
