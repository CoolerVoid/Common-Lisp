#!/usr/bin/clisp
;-----------------------------------------------------
; Autor: Antonio "Cooler_"
; Contato: c00f3r@gmail.com
; 
; Simple Dork Spider version 0.1 With Common Lisp
; example to install libs to wheel this code:
; apt-get install clisp cl-ppcre cl-usocket
; to use this folow example: 
; chmod +x code; touch vuln.txt; 
; ./code URLlist.txt string2search
;-----------------------------------------------------

; Bibliotecas usadas
(asdf:oos 'asdf:load-op :usocket)
(asdf:oos 'asdf:load-op :cl-ppcre)
; Pegamos entrada do arquivo e Dork
(setf nomefile (first ext:*args*))
(setf dork (second ext:*args*)) 
; Vendo se foi passado argumentos
(if(not nomefile) (format t "~%está faltando argumento do nomefile~%"))
(if(not dork) (format t "~%está faltando argumento do dork~%"))
; Abre lista
(let ((arquivo (open nomefile :if-does-not-exist nil))) 
 (when arquivo
  (loop for line = (read-line arquivo nil) while line do
; Peneiramos dados do link , para passar de acordo 
; com paradigmas do protocolo http
   (setf url (cl-ppcre:scan-to-strings "[^(http|https):\/\/](\\S+)[^\/]" line ))
   (setf site (cl-ppcre:scan-to-strings "(\\S[^\/]+)[^\/]" url))
   (setf index (cl-ppcre:scan-to-strings "\/(\\S+)" url))
; Construimos a socket
   (setq sock (usocket:socket-connect site 80))
   (format (usocket:socket-stream sock) 
    "~A~A~A~C~A~A~C~C~C" "GET " index " HTTP/1.1" #\Newline "Host: " site  #\Return #\Newline #\Newline)
; mostramos saída 
	(force-output (usocket:socket-stream sock))
	(do ((line                                                            
 	(read-line (usocket:socket-stream sock) nil)                       
 	 (read-line (usocket:socket-stream sock) nil)))                     
 	  ((not line))
; Se conter a dork na linha,será salvo o link em um TXT
  	  (setf vuln (cl-ppcre:scan-to-strings dork line)) 
  	   (if(STRING= vuln dork) 
   	   (with-open-file (stream "vuln.txt" :direction :output :if-exists :append )
    	   (format stream "~A~C" line #\newline)
   	     (format t "~%~%Encontrada Dork!!!~%vide arquivo vuln.txt~%~%")
    	     (close stream)(return 0))) 
    	      (format t "~A~%" line))
 ))
 (close arquivo))

