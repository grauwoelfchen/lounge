#lang racket

(require racket/pretty)
(require toml)

#|
;; calendar view? any idea?
(require racket/date)
(printf "~s\n"
        (date->string (seconds->date (current-seconds))))
|#

;; reads files in the data directory and generates a list contains all books
(define (read-data path)
  ;; returns readable file or not
  (define (user-readable? f)
    (member 'read (file-or-directory-permissions f)))

  (for/list ([f (in-directory path user-readable?)])
    ;; hasheq
    (let* ([ht (parse-toml (port->string (open-input-file f) #:close? #t))]
           [book (hash-ref ht 'book)])
      ;; format:
      ;;   '("title" "isbn" total_page_numbers
      ;;     (read_up_to #<datetime updated_at>))
      (list
        (hash-ref book 'title)
        (hash-ref book 'isbn)
        (hash-ref book 'total_page_numbers)
        (if (hash-has-key? book 'updates)
          (list
            (hash-ref (first (hash-ref book 'updates)) 'read_up_to)
            (hash-ref (first (hash-ref book 'updates)) 'updated_at))
          '())))))

;; TODO: create progress `bar`s
(for-each pretty-print (read-data "./data"))
