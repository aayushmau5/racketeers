#lang racket
(define message "Meow!")
(define (say-hello name)
  (displayln (string-append message " " name "!")))

(say-hello "Aayush")
