; This function will recursively invoke itself and generate a wrapper string based upon whether specific wrapper attributes are to be displayed or not.
(define (parse-condition-string attrib-list)
  (if (null? attrib-list) ;optimization
    #f ; empty attrib-list
    (let* ((attrib (car attrib-list)) ; Pull the next attribute token.
	  (wrap   (wrap-it? attrib)) ; Do we need to wrap wrap it?
	  (len    (length attrib-list))) ; Was that the last word in the list?
      ;(if (equal? len '1) ; If there's only one attribute we don't need to process further.
      (if (<= len '2) ; If there's only one attribute (perhaps followed by a token) we don't need to process further.
	wrap ; return the result of wrap-it?
	; Otherwise we have to process a ATR-* 'token' ATR-* string.  So the next item should be a logical operator token.
	(let * ((tok (car (cdr attrib-list))))
	  ; If the token is invalid just return wrap.  We don't care if the rest of the string is invalid.
          (if (equal? (valid-token? tok) '#f)
	    wrap ; this may or may not be '#f
	    ; Otherwise we need to call parse-wrapper again and cat 'wrap + tok + parse-wrapper'
	    (let* ((subwrap (parse-condition-string (cdr(cdr attrib-list)))))
	      ; If 'wrap' is #f then we shouldn't include it or 'tok' in the return string.
	      (if (equal? wrap '#f)
		subwrap
		(if (equal? subwrap '#f) ; If subwrap is '#f then don't include it in the return string, or the preceeding token.
		  (string-append wrap)
		  (string-append wrap (string-append " " (string-append tok (string-append " " subwrap)))))))))))))

; This either returns the string to display in the wrapper text, e.g. "ATR-FOO && ATR-BAR" or it returns #f.
; It gets a bit complicated but it'll only display sections of the attribute string that it's supposed to, e.g. if ATR-LINUX isn't supposed to be displayed but
; there is an attribute string "ATR-TLS && ATR-LINUX" this function will return "ATR-TLS" only.
(define (display-wrapper? attribs)
  ;Attrib is something like "ATR-CLASSIC-FLOAT && ATR-LINUX"
  (if (equal? attribs '#f)
    '#f ; If there isn't a CONDITION attribute string simply bail early.
    ; Otherwise we need to determine whether to display a wrapper based upon the individual attributes that make up the attribute string.
    (if (list? attribs) ; We need it in list form.
      (parse-condition-string attribs) ;If it is a list simply process.
      (let* ((attrib-list (split attribs))); if not a list make it one,
      	(parse-condition-string attrib-list)); and then process.
    )))

(define ($CONDITION-wrapper$ object)
  (let * ((wrapper (display-wrapper? (attribute-string "CONDITION" (current-node)))))
	 (if (equal? wrapper '#f)
		object; Don't wrap it if there's no CONDITION variable or if the specific attribute isn't supposed to be wrapped.
		; Otherwise we wrap it with top and bottom lines, or a box.
		(if (or ; Use a 'rule' for the following rather than a 'box'
				(match-element? '(sect1) (current-node))
				(match-element? '(sect2) (current-node))
				(match-element? '(sect3) (current-node)))
;;				(match-element? '(sect4) (current-node)))
			(make display-group
				(make display-group
					keep: #t
				(make rule
					start-indent: (if (match-element? '(sect1) (current-node)) 0pt (inherited-start-indent))
					orientation: 'horizontal
					;line-thickness: %object-rule-thickness%
					line-thickness: 3pt
					length: (if (match-element? '(sect1) (current-node)) %text-width% (- %text-width% (inherited-start-indent) ))
					space-before: 5pt
					space-after: 4pt
					keep-with-next?: #t
					keep: #t
				)
				(make paragraph
					font-weight: 'bold
					space-before: 0pt
					space-after: 0pt
					quadding: 'center
					keep-with-previous?: #t
					keep-with-next?: #t
				(literal wrapper)))
				object
				(make display-group
					keep: #t
				(make paragraph
							font-weight: 'bold
							space-before: 0pt
							space-after: 0pt
							quadding: 'center
							keep-with-next?: #t
							(literal wrapper))

				(make rule
					start-indent: (if (match-element? '(sect1) (current-node)) 0pt (inherited-start-indent))
					orientation: 'horizontal
					;line-thickness: %object-rule-thickness%
					line-thickness: 3pt
					space-before: 1pt
					space-after: 5pt
					length: (if (match-element? '(sect1) (current-node)) %text-width% (- %text-width% (inherited-start-indent) ))
					keep-with-previous?: #t
				))
				
			)
			; non-sect
			(make display-group
				;keep: #t
				;keep: 'page
				;(make sequence
				space-after: %block-sep%
				(make rule
					start-indent: (inherited-start-indent)
					orientation: 'horizontal
					;line-thickness: %object-rule-thickness%
					line-thickness: 2pt
					length: (- %text-width% (inherited-start-indent))
					space-before: 5pt
					space-after: 4pt
					keep-with-next?: #t
					;keep: #t
					;keep: 'page
				)
				(make paragraph
					font-weight: 'bold
					space-before: 0pt
					space-after: 0pt
					quadding: 'center
					keep-with-previous?: #t
					keep-with-next?: #t
				(literal wrapper))
				object
				(make rule
					start-indent: (inherited-start-indent)
					orientation: 'horizontal
					;line-thickness: %object-rule-thickness%
					line-thickness: 2pt
					space-before: (if (INLIST?) 2pt 0pt)
					space-after: 5pt
					length: (- %text-width% (inherited-start-indent))
					keep-with-previous?: #t
					;keep: #t
					;keep: 'page
				)
				;)
			)
))))

; Commented out the brackets [ ] around phrase conditionals since we don't want them in
; the final generated documents at all.  Probably should have conditioned this on DRAFT.
(define ($phrase-CONDITION-wrapper$ object)
;  (let * ((wrapper (display-wrapper? (attribute-string "CONDITION" (current-node)))))
;	 (if (equal? wrapper '#f)
		object ; don't wrap it if there's no CONDITION variable
;		(make sequence
;			(make sequence
;				font-weight: 'bold
;				color: color-slategray4
;				(literal (string-append " " (string-append wrapper "["))))
;			object ; the phrase
;			(make sequence
;				font-weight: 'bold
;				color: color-slategray4
;				(literal "]" ))
;		)
;	))
)
