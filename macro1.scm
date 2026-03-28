#lang scheme
; macro1.scm
; Glenn G. Chappell
; 2026-03-27
;
; For CS 331 Spring 2026
; Code from Mar 27 - Scheme: Macros I


(display "This file contains sample code from March 27, 2026,\n")
(display "for the topic \"Scheme: Macros I\".\n")
(display "It will execute, but it is not intended to do anything\n")
(display "useful. See the source.\n")


; ***** Single-Pattern Macros *****


; Create pattern-based macro with a single pattern using
; define-syntax-rule. USAGE:
;   (define-syntax-rule (PATTERN) TRANSFORMED_CODE)

; my-quote
; Macro. Just like quote.
(define-syntax-rule
  (my-quote x)  ; pattern
  'x            ; transformed code
  )

; Try:
;   (my-quote (+ 1 2))

; quote-two
; Macro that takes two arguments and returns a list containing them
; unevaluated.
; Example:
;   (quote-two (+ 1 2) (+ 2 3))
; gives
;   ((+ 1 2) (+ 2 3))
(define-syntax-rule
  (quote-two x y)  ; pattern
  '(x y)           ; transformed code
  )

; Try:
;   (quote-two (+ 1 2) (+ 2 3))

; qlist
; Macro that takes any number of arguments and returns a list containing
; them unevaluated.
; Example:
;   (qlist (+ 1 2) 7 (+ 2 3))
; gives
;   ((+ 1 2) 7 (+ 2 3))
(define-syntax-rule
  (qlist . args)  ; pattern
  'args           ; transformed code
  )

; Try:
;   (qlist (+ 1 2) 7 (+ 2 3))
;   (list (+ 1 2) 7 (+ 2 3))

; swap
; Macro that takes a 2-item list and returns the list with the items
; reversed, then evaluates it.
; Example:
;   (swap ("Hello\n" display))
; will output "Hello\n".
(define-syntax-rule
  (swap (a b))  ; pattern
  (b a)         ; transformed code
  )

; Try:
;   (swap ("Hello\n" display))

; to-prod
; Macro that converts anything to a product. Given a nonempty list,
; replaces the first item with *, and evaluates the result.
; Example:
;   (to-prod (+ 4 5))
; gives
;   20
(define-syntax-rule
  (to-prod (_ . args))  ; pattern
  (* . args)            ; transformed code
  )

; Try:
;   (to-prod (+ 1 2 3 4))
;   (to-prod (list 7 8 9))
;   (define a 100)
;   (define b 5)
;   (to-prod (/ (+ a 2) (- b)))
; Note that the last 3 lines above do the computation from reflect.scm.

; def-two
; Macro that defines two symbols, setting values equal to given
; expressions.
; Example:
;   (def-two a 1 b (+ 2 3))
; defines a to be 1 and b to be 5.
(define-syntax-rule
  (def-two s1 e1 s2 e2)  ; pattern
  (begin                 ; transformed code
    (define s1 e1)
    (define s2 e2)
    )
  )

; Try:
;   (def-two a (+ 1 2) b (+ 2 3))
;   a
;   b

; for-loop1
; Macro. For-loop. Given start, end values. Loop body is 1-parameter
; procedure, which is called with each value from start to end,
; incrementing by 1.
(define-syntax-rule (for-loop1 (start end) proc)
  (let loop (
             [loop-counter start]
             )
    (cond
      [(loop-counter . <= . end)  ; Item between dots becomes 1st list
                                  ; item. This is syntactic sugar for
                                  ; infix operators.
       (begin
         (proc loop-counter)
         (loop (loop-counter . + . 1))
         )
       ])
    )
  )

; Try:
;   (for-loop1 (3 7) (lambda (i) (begin (display i) (newline))))

; for-loop2
; Macro. For-loop. Given loop-counter variable, start value, end value.
; Loop body is a non-empty sequence of expressions. These are evaluated,
; in order, with loop-counter set to each value from start to end,
; incrementing by 1.
(define-syntax-rule (for-loop2 (var start end) . body)
  (let loop (
             [loop-counter start]
             )
    (cond
      [(loop-counter . <= . end)
       (begin
         (let ([var loop-counter]) (begin . body))
         (loop (loop-counter . + . 1))
         )
       ])
    )
  )

; Try:
;   (for-loop2 (i 3 (+ 2 5)) (display i) (newline))

