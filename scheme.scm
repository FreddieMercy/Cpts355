;Created by Junhao Zhang "Freddie" ID# 11356533

;1. nth
(define (nth list index) (cond ((null? list) '()) ((eqv? index 0) (car list)) (#t (nth (cdr list) (- index 1)) ) ) )

;2. repl
(define (repl list index value) (cond ((null? list) '()) ((eqv? index 0) (cons value (cdr list))) (#t (cons (car list) (repl (cdr list) (- index 1) value)) ) ) )

;3. range
(define (range min max) (cond ((< min max) (cons min (range (+ min 1) max )) ) (#t '() )))

;4. merge2
(define (merge2 l1 l2) (cond ((null? l1) l2) ((null? l2) l1) (#t (if (> (car l1) (car l2)) (cons (car l2) (merge2 l1 (cdr l2))) (cons (car l1) (merge2 (cdr l1) l2))))))

;5 fold
(define (fold op list bad) (cond ((null? list) bad) (#t (op (car list) (fold op (cdr list) bad ) )) ))

;6 mergeN
(define (mergeN list) (fold merge2 list '()))

;7 unzip
(define (unzip1 li) (cond ((null? li) '())(#t ((lambda (x) (cons (car (car li)) x))(unzip1 (cdr li))))))
(define (unzip2 li) (cond ((null? li) '())(#t ((lambda (x) (cons (car (cdr (car li)))x))(unzip2 (cdr li))))))
(define (unzip li) (cond ((null? li) '()) (#t (list (unzip1 li) (unzip2 li) ))))



;Test cases:
(nth '(1 2 3 4) 1)
(repl '(1 2 3 4) 1 7)
(range 4 6)
(merge2 '(2 4 6) '(1 4 5))
(mergeN '((2 4 6) (1 4 5)))
(mergeN '((2 4 5) (1 4 6) (3 7 9)))
(unzip '((1 2) (3 4) (5 6)))
(unzip '())