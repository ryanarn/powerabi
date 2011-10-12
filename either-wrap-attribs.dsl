; uses *wrapit* as defined in the individual fooabi.dsl files.
(define (wrap-include? attrib)
  (let ((included (assoc attrib *wrapit*)))
    (if (equal? included '#f) ; If we can't find an ("ATR-*" . #value) pair assume return "attrib".  This will help find errors.
      attrib
      (if (equal? (cdr included) '#f)
        #f
        attrib))))

(define (wrap-it? attrib)
	(if (string=? "!" (substring attrib 0 1))
		(let* ((wrap (wrap-include? (substring attrib 1 (string-length attrib))))) ; Evaluate !ATR-*
		  (if (equal? wrap '#f)
		    #f
		    (string-append "!" wrap)))
		(wrap-include? attrib))) ; Evaluate ATR-

