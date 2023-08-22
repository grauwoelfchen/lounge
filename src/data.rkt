#lang racket/base

(require racket/list)
(require racket/port)

(require toml)

#|
;; calendar view? any idea?
(require racket/date)
(printf "~s\n"
        (date->string (seconds->date (current-seconds))))
|#
(struct read-range (begin end) #:transparent)

(struct an-update-seq (read_up_to updated_at) #:transparent)
(struct an-update-rnd (read_range updated_at) #:transparent)

(struct book (title isbn edition total_page_numbers format
  reading_approach status update) #:transparent)
(struct approach (number_of_times order) #:transparent)
(struct status (is_focused is_finished) #:transparent)

;; creates a book with default values for optional fields. this takes a hasheq
;; object represents book entry.
;;
;; a book struct (with "sequential" reading_approach.order) looks like:
;;   (book
;;     "title" "isbn" edition total_page_numbers "format"
;;     (reading-approach number_of_times "order")
;;     (status #<boolean is_focused> #<boolean is_finished>)
;;     (an-update-seq read_up_to #<datetime updated_at>))
(define (create-book b)
  (let* ([ra (if (hash-has-key? b 'reading_approach)
             (let ([ap (hash-ref b 'reading_approach)])
               (approach
                 (hash-ref ap 'number_of_times)
                 (hash-ref ap 'order)))
             (approach 1 "sequential"))]
         [st (if (hash-has-key? b 'status)
               (let ([st (hash-ref b 'status)])
                 (status
                   (hash-ref st 'is_focused)
                   (hash-ref st 'is_finished)))
               (status #f #f))]
         [ed (if (hash-has-key? b 'edition)
               (hash-ref b 'edition)
               0)]
         [ft (if (hash-has-key? b 'format)
               (hash-ref b 'format)
               "print")]
         [up (if (hash-has-key? b 'updates)
               ;; get only the latest update
               (let ([lu (first (hash-ref b 'updates))])
                 (if (equal? (approach-order ra) "sequential")
                   (an-update-seq (hash-ref lu 'read_up_to)
                                  (hash-ref lu 'updated_at))
                 (let ([rr (hash-ref lu 'read_range)])
                   (an-update-rnd (read-range
                                    (hash-ref rr 'begin)
                                    (hash-ref rr 'end))
                                (hash-ref lu 'updated_at)))))
               empty)])
    (book (hash-ref b 'title)
          (hash-ref b 'isbn)
          ed ;; edition
          (hash-ref b 'total_page_numbers)
          ft ;; format
          ra ;; [book.reading_approach]
          st ;; [book.status]
          up)))

;; reads files in the data directory and generates a list contains all books
(define (read-data path)
  ;; returns readable file or not
  (define (user-readable? f)
    (member 'read (file-or-directory-permissions f)))

  (for/list ([f (in-directory path user-readable?)])
    ;; parse-toml creates a hasheq object
    (let* ([ht (parse-toml (port->string (open-input-file f) #:close? #t))]
           [b (hash-ref ht 'book)])
      (create-book b))))

(provide (struct-out an-update-seq)
         (struct-out an-update-rnd)
         (struct-out read-range)
         (struct-out book)
         (struct-out approach)
         (struct-out status))
(provide create-book
         read-data)
