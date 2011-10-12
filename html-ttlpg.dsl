; This seems like overkill just to wrap the book title in DRAFTTEXT but it's
; the only way to do it right now because the 'element title' rule already
; processed the title element by the time it called process-children with the
; title-mode mode.
(mode book-titlepage-recto-mode
  (element abbrev
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element abstract
    (make element gi: "DIV"
	  ($semiformal-object$)))

  (element (abstract title) (empty-sosofo))

  (element address 
    (make element gi: "DIV"
	  attributes: (list (list "CLASS" (gi)))
	  (with-mode titlepage-address-mode 
	    ($linespecific-display$ %indent-address-lines% %number-address-lines%))))

  (element affiliation
    (make element gi: "DIV"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)))

  (element artpagenums
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element author
    (let ((author-name  (author-string))
	  (author-affil (select-elements (children (current-node)) 
					 (normalize "affiliation"))))
      (make sequence      
	(make element gi: "H3"
	      attributes: (list (list "CLASS" (gi)))
	      (make sequence
		(make element gi: "A"
		      attributes: (list (list "NAME" (element-id)))
		      (empty-sosofo))
		(literal author-name)))
	(process-node-list author-affil))))

  (element authorblurb
    (make element gi: "DIV"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)))

  (element authorgroup
    (process-children))

  (element authorinitials
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element bibliomisc (process-children))
  (element bibliomset (process-children))

  (element collab
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element confgroup
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element contractnum
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element contractsponsor
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element contrib
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element copyright
    (titlepage-recto-copyright))

  (element (copyright year)
    (make sequence
      (process-children)
      (if (not (last-sibling? (current-node)))
	  (literal ", ")
	  (empty-sosofo))))

  (element (copyright holder)
    (make sequence
      (process-children)
      (if (not (last-sibling? (current-node)))
	  (literal ", ")
	  (empty-sosofo))))

  (element corpauthor
    (make element gi: "H3"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)))

  (element corpname
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element date
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element edition
    (make element gi: "P"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make entity-ref name: "nbsp")
	  (literal (gentext-element-name-space (gi (current-node))))))

  (element editor
    (let ((editor-name (author-string)))
      (make sequence
	(if (first-sibling?) 
	    (make element gi: "H4"
		  attributes: (list (list "CLASS" "EDITEDBY"))
		  (literal (gentext-edited-by)))
	    (empty-sosofo))
	(make element gi: "H3"
	      attributes: (list (list "CLASS" (gi)))
	      (literal editor-name)))))

  (element firstname
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element graphic
    (let* ((nd (current-node))
	   (fileref (attribute-string (normalize "fileref") nd))
	   (entattr (attribute-string (normalize "entityref") nd))
	   (entityref (if entattr
			  (entity-system-id entattr)
			  #f))
	   (format  (attribute-string (normalize "format")))
	   (align   (attribute-string (normalize "align")))
	   (attr    (append 
		     (if align 
			 (list (list "ALIGN" align)) 
			 '())
		     (if entityref
			 (list (list "SRC" (graphic-file entityref)))
			 (list (list "SRC" (graphic-file fileref))))
		     (list (list "ALT" ""))
		     )))
      (if (or fileref entityref) 
	  (make empty-element gi: "IMG"
		attributes: attr)
	  (empty-sosofo))))

  (element honorific
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element isbn
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element issn
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element itermset (empty-sosofo))

  (element invpartnumber
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element issuenum
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element jobtitle
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element keywordset (empty-sosofo))

  (element legalnotice 
    (titlepage-recto-legalnotice))
  
  (element (legalnotice title) (empty-sosofo))

  (element lineage
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))
  
  (element modespec (empty-sosofo))

  (element orgdiv
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element orgname
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element othercredit
    (let ((author-name  (author-string))
	  (author-affil (select-elements (children (current-node)) 
					 (normalize "affiliation"))))
      (make sequence
	(make element gi: "H3"
	      attributes: (list (list "CLASS" (gi)))
	      (make sequence
		(make element gi: "A"
		      attributes: (list (list "NAME" (element-id)))
		      (empty-sosofo))
		(literal author-name)))
	(process-node-list author-affil))))

  (element othername
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element pagenums
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))
  
  (element printhistory
    (make element gi: "DIV"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)))

  (element productname
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element productnumber
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element pubdate
    (make element gi: "P"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element publisher
    (make element gi: "P"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)))

  (element publishername
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element pubsnumber
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element releaseinfo
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element revhistory
    (make element gi: "DIV"
	  attributes: (list (list "CLASS" (gi)))
	  (make element gi: "TABLE"
		attributes: (list
			     (list "WIDTH" ($table-width$))
			     (list "BORDER" "0"))
		(make sequence
		  (make element gi: "TR"
			(make element gi: "TH"
			      attributes: '(("ALIGN" "LEFT") 
					    ("VALIGN" "TOP")
					    ("COLSPAN" "3"))
			      (make element gi: "B"
				    (literal (gentext-element-name 
					      (gi (current-node)))))))
		  (process-children)))))

  (element (revhistory revision)
    (let ((revnumber (select-elements (descendants (current-node)) 
				      (normalize "revnumber")))
	  (revdate   (select-elements (descendants (current-node)) 
				      (normalize "date")))
	  (revauthor (select-elements (descendants (current-node)) 
				      (normalize "authorinitials")))
	  (revremark (select-elements (descendants (current-node)) 
				      (normalize "revremark"))))
      (make sequence
      (make element gi: "TR"
	(make element gi: "TD"
	      attributes: (list
			   (list "ALIGN" "LEFT"))
	      (if (not (node-list-empty? revnumber))
		  (make sequence
		    (literal (gentext-element-name-space 
			      (gi (current-node))))
		    (process-node-list revnumber))
		  (empty-sosofo)))
	(make element gi: "TD"
	      attributes: (list
			   (list "ALIGN" "LEFT"))
	      (if (not (node-list-empty? revdate))
		  (process-node-list revdate)
		  (empty-sosofo)))
	(make element gi: "TD"
	      attributes: (list
			   (list "ALIGN" "LEFT"))
	      (if (not (node-list-empty? revauthor))
		  (make sequence
		    (literal (gentext-revised-by))
		    (process-node-list revauthor))
		  (empty-sosofo))))
	(make element gi: "TR"
	    (make element gi: "TD"
		  attributes: (list
			       (list "ALIGN" "LEFT")
			       (list "COLSPAN" "3"))
		  (if (not (node-list-empty? revremark))
		      (process-node-list revremark)
		      (empty-sosofo)))))))

  (element (revision revnumber) (process-children-trim))
  (element (revision date) (process-children-trim))
  (element (revision authorinitials) (process-children-trim))
  (element (revision revremark) (process-children-trim))

  (element seriesvolnums
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element shortaffil
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))
  
  (element subjectset (empty-sosofo))

  (element subtitle 
    (make element gi: "H2"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children-trim)))

  (element surname
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))

  (element title 
    (make element gi: "H1"
	  attributes: (list (list "CLASS" (gi)))
	  (make element gi: "A"
		attributes: (list (list "NAME" (element-id)))
      (make sequence
      <![%DRAFT;[(literal "&DRAFTTEXT")]]>
		 (with-mode title-mode
		   (process-children-trim))))))

  (element (formalpara title) ($runinhead$))

  (element titleabbrev (empty-sosofo))
  
  (element volumenum
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" (gi)))
	  (process-children)
	  (make empty-element gi: "BR")))
)

