#lang br/quicklang
(provide + *)

(define-macro (stackerizer-mb EXPR)
	#'(#%module-begin
		(for-each displayln (reverse (flatten EXPR)))))
(provide (rename-out [stackerizer-mb #%module-begin]))

; Showing that `ARG ...` allows us to repeat the same pattern for each matched
; pattern by separating how `ARG` and `...` are used.
(define-macro (define-ops OP ...)
	#'(begin
		(define-macro-cases OP
			[(OP FIRST) #'FIRST]
			[(OP FIRST NEXT (... ...))
				#'(list 'OP FIRST (OP NEXT (... ...)))])
		...))
(define-ops + *)

; This is how we'd do this as a single macro which generates one op at a time
;
; (define-macro (define-op OP)
; 	#'(define-macro-cases OP
; 		[(OP FIRST) #'FIRST]
; 		[(OP FIRST NEXT (... ...))
; 			#'(list 'OP FIRST (OP NEXT (... ...)))]))

; (define-op +)
; (define-op *)