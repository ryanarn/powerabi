;; Overrides of common functions shared between html and print

;; Are sections enumerated?
;; The number appears in their title, both in the table
;; of contents, and in the text.
(define %section-autolabel% 
  #t)

; Conditionally exclude an element and generate a sequence from those included.
(define (conditional-sequence nd)
	(if (include-attributes? nd)
     (process-children)
     ;($CONDITION-wrapper$ process-children)
     (empty-sosofo)
   ))

; Non modal version
(element phrase
  ($phrase-CONDITION-wrapper$ (conditional-sequence (current-node)))
)

; Function to prepend the DRAFTTEXT onto the string if it's defined.
(define (prepend-draft-string tok)
     <![%DRAFT;[(string-append "&DRAFTTEXT"]]>
     tok
     <![%DRAFT;[)]]>
)

(define (data-of node)
  ;; return the data characters of a node, except for the content of
  ;; indexterms which are suppressed.
  (let loop ((nl (children node)) (result ""))
    (if (node-list-empty? nl)
	result
	(if (equal? (node-property 'class-name (node-list-first nl)) 'element)
	    (if (or (equal? (gi (node-list-first nl)) (normalize "indexterm"))
							(equal? (gi (node-list-first nl)) (normalize "comment"))
							(equal? (gi (node-list-first nl)) (normalize "remark"))
							(equal? (include-attributes? (node-list-first nl)) '#t))
		(loop (node-list-rest nl) result)
		(loop (node-list-rest nl)
		      (string-append result (data-of (node-list-first nl)))))
	    (if (or (equal? (node-property 'class-name (node-list-first nl))
			    'data-char)
		    (equal? (node-property 'class-name (node-list-first nl))
			    'sdata))
		(loop (node-list-rest nl)
		      (string-append result (data (node-list-first nl))))
		(loop (node-list-rest nl) result))))))

(define (element-title-string nd)
  (let ((title (element-title nd)))
    (if (string? title)
	title
	(prepend-draft-string (data-of title)))))

(element note
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($admonition$))
		(empty-sosofo)))

(element programlisting
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($verbatim-display$
			%indent-programlisting-lines%
			(or %number-programlisting-lines%
				(equal? (attribute-string (normalize "linenumbering")) (normalize "numbered")))))
		(empty-sosofo)))

(element screen
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($verbatim-display$
			%indent-screen-lines%
			(or %number-screen-lines%
				(equal? (attribute-string (normalize "linenumbering")) (normalize "numbered")))))
		(empty-sosofo)))




(element figure
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ 		

(let* ((mediaobj (select-elements (children (current-node))
				    (normalize "mediaobject")))
	 (imageobj (select-elements (children mediaobj)
				    (normalize "imageobject")))
	 (image    (select-elements (children imageobj)
				    (normalize "imagedata")))
	 (graphic  (select-elements (children (current-node))
				    (normalize "graphic")))
	 (align    (if (node-list-empty? image)
		       (if (node-list-empty? graphic)
			   #f
			   (attribute-string (normalize "align")
					     (node-list-first graphic)))
		       (attribute-string (normalize "align") (node-list-first image))))
	 (dalign  (cond ((equal? align (normalize "center"))
			 'center)
			((equal? align (normalize "right"))
			 'end)
			(else
			 'start))))
    (if align
	(make display-group
	  quadding: dalign
	  ($formal-object$ %figure-rules% %figure-rules%))
	($formal-object$ %figure-rules% %figure-rules%)))


		)
		(empty-sosofo)))

(element sect1
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($section$))
		(empty-sosofo)))

(element sect2
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($section$))
		(empty-sosofo)))

(element sect3
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($section$))
		(empty-sosofo)))

(element sect4
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($section$))
		(empty-sosofo)))

(element sect5
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($section$))
		(empty-sosofo)))
