#lang scheme
; check_scheme.scm
; Glenn G. Chappell
; 2026-02-10
;
; For CS 331 Spring 2026
; A Scheme Program to Run
; Used in Assignment 3, Exercise A


; Useful Functions

(define (a x y)
  (if (null? x)
      y
      (cons (car x) (a (cdr x) y)))
  )

(define (aa . xs)
  (if (null? xs)
      '()
      (a (car xs) (apply aa (cdr xs)))
      )
  )

(define (m d ns)
  (if (null? ns)
      '()
      (let ([n (+ d (car ns))])
        (cons (integer->char (+ 1 n)) (m n (cdr ns))))
      )
  )

(define (mm ns) (list->string (m 0 ns)))


; Mysterious Data

(define cds1 '(71 -7 15 0 -7))
(define cds2 '(5 -9 14 0 -51))
(define cds3 '(41 10 -51 33 -33))
(define cds4 '(55 -22 17 -5 -77))
(define cds5 '(80 5 -5 0 9))
(define cds6 '(-43))


; Mysterious Output

(display "Secret message #3:\n\n")
(display (mm (aa cds1 cds2 cds3 cds4 cds5 cds6)))
(newline)
(newline)

