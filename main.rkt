#lang racket/gui

; top level window
(define frame (new frame% [label "Racketeers!"]
                   [width 400]
                   [height 400]))

(define msg (new message% [parent frame]
                 [label "Hello from racket gui!"]))

; (new button% [parent frame]
;      [label "Click me"]
;      [callback (lambda (button event)
;                  (begin
;                    (displayln button)
;                    (displayln event)
;                    (send msg set-label "Message changed!")))])

; Derive a new canvas (a drawing window) class to handle events
(define my-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
    (define/override (on-event event)
      (send msg set-label "Canvas mouse"))
    ; Define overriding method to handle keyboard events
    (define/override (on-char event)
      (displayln event)
      (send msg set-label "Canvas keyboard"))
    ; Call the superclass init, passing on all init args
    (super-new)))

(new canvas% [parent frame]
     [paint-callback
      (lambda (canvas dc)
        (send dc set-scale 3 3)
        (send dc set-text-foreground "blue")
        (send dc draw-text "Don't Panic!" 0 0))])


; Make a canvas that handles events in the frame
; (new my-canvas% [parent frame])

; (new button% [parent frame]
;      [label "Pause"]
;      [callback (lambda (button event) (sleep 5))])

(define panel (new horizontal-pane% [parent frame]))

(define count 0)
(define count-value (new message% [parent panel]
                         [label (number->string count)]))

(define (update-count value)
  (send count-value set-label (number->string value)))

(new button% [parent panel]
     [label "-"]
     [callback (λ (self event)
                 (set! count (sub1 count))
                 (displayln count)
                 (update-count count))])

(new button% [parent panel]
     [label "+"]
     [callback (λ (self event)
                 (set! count (add1 count))
                 (displayln count)
                 (update-count count))])


(define dialog (new dialog% [parent frame]
                    [label "Ok"]
                    [width 100]
                    [height 100]))

(send frame show #t)
(send dialog show #t)