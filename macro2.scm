#lang scheme
; macro.scm  UNFINISHED
; Glenn G. Chappell
; 2026-03-30
;
; For CS 331 Spring 2026
; Code from Mar 30 - Scheme: Macros II


(display "This file contains sample code from March 30, 2026,\n")
(display "for the topic \"Scheme: Macros\".\n")
(display "It will execute, but it is not intended to do anything\n")
(display "useful. See the source.\n")


; ***** Multiple-Pattern Macros *****


; CODE COMING SOON


; ***** Keywords in Macros *****


; CODE COMING SOON


; ***** EXTRA: Symbolic Differentiation Macros *****


; Raise a to the b power: (expt a b)

; Try:
;   (expt 2 3)

; qderiv
; Macro. Differentiate, with respect to the given variable, a given
; expression. Returns the code for the derivative, quoted.
; Example:
;   (qderiv x (* x (sin x)))
(define-syntax qderiv
  (syntax-rules (+ - * / sqrt log exp expt sin cos tan asin acos atan)
    [(qderiv var (+ a))
     (list '+ (qderiv var a))
     ]
    [(qderiv var (+ a b))
     (list '+ (qderiv var a) (qderiv var b))
     ]
    [(qderiv var (- a))
     (list '- (qderiv var a))
     ]
    [(qderiv var (- a b))
     (list '- (qderiv var a) (qderiv var b))
     ]
    [(qderiv var (* a b))
     (list '+ (list '* 'a (qderiv var b)) (list '* 'b (qderiv var a)))
     ]
    [(qderiv var (/ a))
     (list '- (list '/ (qderiv var a) (list '* 'a 'a)))
     ]
    [(qderiv var (/ a b))
     (list '/ (list '- (list '* 'b (qderiv var a))
                    (list '* 'a (qderiv var b)))
           (list '* 'b 'b))
     ]
    [(qderiv var (sqrt a))
     (list '/ (qderiv var a) (list '* 2 (list 'sqrt 'a)))
     ]
    [(qderiv var (log a))
     (list '/ (qderiv var a) 'a)
     ]
    [(qderiv var (exp a))
     (list '* (list 'exp 'a) (qderiv var a))
     ]
    [(qderiv var (expt a b))
     (list '+ (list '* '(* (expt a b) (log a)) (qderiv var b))
           (list '* '(* b (expt a (- b 1))) (qderiv var a)))
     ]
    [(qderiv var (sin a))
     (list '* (list 'cos 'a) (qderiv var a))
     ]
    [(qderiv var (cos a))
     (list '- (list '* (list 'sin 'a) (qderiv var a)))
     ]
    [(qderiv var (tan a))
     (list '/ (qderiv var a) (list '* (list 'cos 'a) (list 'cos 'a)))
     ]
    [(qderiv var (asin a))
     (list '/ (qderiv var a) (list 'sqrt (list '- 1 (list '* 'a 'a))))
     ]
    [(qderiv var (acos a))
     (list '- (list '/ (qderiv var a)
                    (list 'sqrt (list '- 1 (list '* 'a 'a)))))
     ]
    [(qderiv var (atan a))
     (list '/ (qderiv var a) (list '+ 1 (list '* 'a 'a)))
     ]
    [(qderiv var var2)
     (cond
       [(and (symbol? 'var1) (symbol? 'var2) (symbol=? 'var 'var2)) 1]
       [(number? 'var2) 0]
       [else (error "qderiv: cannot handle expression")]
       )
     ]
    )
  )

; Try:
;   (qderiv x (* x x))
;   (qderiv x (expt x 3))
;   (qderiv x (expt 2 x))
;   (qderiv x (* (sin x) (cos x)))


; deriv
; Macro. Differentiate, with respect to the given variable, a given
; expression. Returns the code for the derivative, unquoted.
; Example:
;   (define (g x) (deriv x (* x (sin x))))
(define-syntax deriv
  (syntax-rules (+ - * / sqrt log exp expt sin cos tan asin acos atan)
    [(deriv var (+ a))
     (+ (deriv var a))
     ]
    [(deriv var (+ a b))
     (+ (deriv var a) (deriv var b))
     ]
    [(deriv var (- a))
     (- (deriv var a))
     ]
    [(deriv var (- a b))
     (- (deriv var a) (deriv var b))
     ]
    [(deriv var (* a b))
     (+ (* a (deriv var b)) (* b (deriv var a)))
     ]
    [(deriv var (/ a))
     (- (/ (deriv var a) (* a a)))
     ]
    [(deriv var (/ a b))
     (/ (- (* b (deriv var a))
           (* a (deriv var b)))
        (* b b))
     ]
    [(deriv var (sqrt a))
     (/ (deriv var a) (* 2 (sqrt a)))
     ]
    [(deriv var (log a))
     (/ (deriv var a) a)
     ]
    [(deriv var (exp a))
     (* (exp a) (deriv var a))
     ]
    [(deriv var (expt a b))
     (+ (* (* (expt a b) (log a)) (deriv var b))
        (* (* b (expt a (- b 1))) (deriv var a)))
     ]
    [(deriv var (sin a))
     (* (cos a) (deriv var a))
     ]
    [(deriv var (cos a))
     (- (* (sin a) (deriv var a)))
     ]
    [(deriv var (tan a))
     (/ (deriv var a) (* (cos a) (cos a)))
     ]
    [(deriv var (asin a))
     (/ (deriv var a) (sqrt (- 1 (* a a))))
     ]
    [(deriv var (acos a))
     (- (/ (deriv var a) (sqrt (- 1 (* a a)))))
     ]
    [(deriv var (atan a))
     (/ (deriv var a) (+ 1 (* a a)))
     ]
    [(deriv var var2)
     (cond
       [(and (symbol? 'var) (symbol? 'var2) (symbol=? 'var 'var2)) 1]
       [(number? 'var2) 0]
       [else (error "deriv: cannot handle expression")]
       )
     ]
    )
  )

; Try:
;   (define (g x) (deriv x (* x x)))
;   (g 5)

