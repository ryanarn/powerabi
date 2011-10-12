(define ($TAGID$ nd) ;; Let the caller pass the 'node' to us since sometimes it's the parent
  (let * ((id-attrib (attribute-string (normalize "id") nd)))
	 (if (equal? id-attrib '#f)
		(empty-sosofo) ; don't output the id tag it if there's no [ID|id] element attribute
		(make sequence
			font-weight: 'bold
			color: color-slategray4
			(literal (string-append " [" (string-append (attribute-string (normalize "id") nd) "] "))))
		
)))
