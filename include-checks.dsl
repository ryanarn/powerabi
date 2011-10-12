(define (doc-include? attribute)
  (let* ((included (assoc attribute *attributes*)))
    (if (equal? included '#f)
      #f
      (cdr included))))

; moved to abi.dsl because it's used by wrapper.dsl as well.
;(define (valid-token? token)

; Check if the CONDITION="ATR-*" attribute is marked #t
; These variables must be defined in the VARIABLEDEFS .dsl files.
(define (include-attribute? attrib)
	(if (string=? "!" (substring attrib 0 1))
		(not (doc-include? (substring attrib 1 (string-length attrib)))) ; Evaluate !ATR-*
		(doc-include? attrib))) ; Evaluate ATR-

; This function will recursively invoke itself.
(define (process-attributes attrib-list)
	(if (null? attrib-list) ;optimization
		#f ; Recursive exit condition.
		(let* ((attrib (car attrib-list))
		       (include (include-attribute? attrib))
		       (len (length attrib-list)))
		  (if (equal? len '1)
			include ; return 'include' if there's only an attribute and no token.
				(let * ((tok (car (cdr attrib-list)))) ;this may not be set if attrib-list has 1 or fewer elements.
					(if (equal? (valid-token? tok) '#f)
						#f ; not a valid token type so just bail out in error (e.g.  "ATR-LINUX ATR-EABI")
						(if (and
								(or
									(equal? tok "||" )
									(equal? tok "|" ))
								(or
									(equal? include '#t)
								(equal? (process-attributes (cdr(cdr attrib-list))) '#t)))
							#t
							(if (and
										(or
											(equal? tok "&&")
											(equal? tok "&"))
										(and
											(equal? include '#t)
											(equal? (process-attributes (cdr(cdr attrib-list))) '#t)))
								#t
								#f))))))))

; Parse the attribute list for attributes and tokens.
; At this time we don't support arbitrary grouping,
;  i.e. CONDITION="(ATR1 && (ATR2 || ATR3))" is not supported.
; All evaluation is evaluated as grouped right to left because
; this was easy to implement,
;   e.g. CONDITION="ATR1 && ATR2 || ATR3" == (ATR1 && (ATR2 || ATR3))
;   e.g. CONDITION="ATR1 || ATR2 && ATR3" == (ATR1 || (ATR2 && ATR3))
(define (include-attributes? nd)
	(let * ((attribs (attribute-string "CONDITION" nd)))
		(if (equal? attribs '#f)
		    #t ;There are no CONDITION attributes so it's included by default
		    (if (list? attribs)
			(process-attributes attribs) ;If it is a list simply process.
			(let* ((attrib-list (split attribs))); if not a list make it one,
				(process-attributes attrib-list)); and then process.
		    )
		)
	)
)

; This basically recurses through a node and its parents looking to see if any of the parents are conditionally excluded.
; This is important when determining whether to include information in the "table of figures".  We don't want to include
; links for elements that have been excluded.
(define (parents-include-attributes? nd)
	(if (include-attributes? nd)
	    (if (node-list=? nd (sgml-root-element))
                #t
	        (parents-include-attributes? (parent nd))
	    )
	    #f
	)
)
