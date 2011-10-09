#!/usr/bin/clisp
;author: Cooler_
;contact: c00f3r@gmail.com 
;site: BugSec.com.br
;simple exemple to use lisp on math problems
;quadratic equation


(defun entrada ()
 (format t "~% Digite um número: ")
;função read para ler STDIN
 (
  let ((valor (read)))
; condição simples usando func numberp para verificar se
; a entrada é número então a função retorna o mesmo
; caso contrário função volta do inicio...
   (
    if (numberp valor)
     valor
    (entrada)
   )
 )
)

(defun sq (x) (* x x))

(defun baskara (a b c)
 (
  if(zerop a)
  (/(- c)b)
  (
   let((var(-(sq b)(* 4 a c))))
   (
    unless (minusp var)
    (
     let((discrt(sqrt var)))
      (format t "x1 = ~$ ~%" (/(-(- b)discrt)(* 2 a))) 
      (format t "x2 = ~$ ~%" (/(+(- b)discrt)(* 2 a)))
    ) 
   ) 
  ) 
 )
)

(format t "Programa formula de baskara~%de os valores para completar A,B e C~%")
(baskara (entrada) (entrada) (entrada) )

