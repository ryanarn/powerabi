(mode book-titlepage-recto-mode
  (element abbrev
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element abstract
    (make display-group
      use: book-titlepage-recto-style
      quadding: 'start
      ($semiformal-object$)))

  (element (abstract title) (empty-sosofo))

  (element (abstract para)
    (make paragraph
      use: book-titlepage-recto-style
      quadding: 'start
      (process-children)))

  (element address 
    (make display-group
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (with-mode titlepage-address-mode 
	($linespecific-display$ %indent-address-lines% %number-address-lines%))))

  (element affiliation
    (make display-group
      use: book-titlepage-recto-style
      (process-children)))

  (element artpagenums
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element author
    (let ((author-name  (author-string))
	  (author-affil (select-elements (children (current-node)) 
					 (normalize "affiliation"))))
      (make sequence      
	(make paragraph
	  use: book-titlepage-recto-style
	  font-size: (HSIZE 1)
	  line-spacing: (* (HSIZE 1) %line-spacing-factor%)
	  space-before: (* (HSIZE 1) %head-before-factor%)
	  quadding: %division-title-quadding%
	  keep-with-next?: #t
	  (literal author-name))
	(process-node-list author-affil))))

  (element authorblurb
    (make display-group
      use: book-titlepage-recto-style
      quadding: 'start
      (process-children)))

  (element (authorblurb para)
    (make paragraph
      use: book-titlepage-recto-style
      quadding: 'start
      (process-children)))

  (element authorgroup
    (make display-group
      (process-children)))

  (element authorinitials
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element bibliomisc (process-children))

  (element bibliomset (process-children))

  (element collab
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element confgroup
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element contractnum
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element contractsponsor
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element contrib
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element copyright
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      space-before: (* (HSIZE 2) %head-before-factor%)
      (literal (gentext-element-name (current-node)))
      (literal "\no-break-space;")
      (literal (dingbat "copyright"))
      (literal "\no-break-space;")
      (process-children)))

  (element (copyright year)
    (make sequence
      (process-children)
      (if (not (last-sibling? (current-node)))
	  (literal ", ")
	  (literal " "))))

  (element (copyright holder) ($charseq$))

  (element corpauthor
    (make sequence
      (make paragraph
	use: book-titlepage-recto-style
	font-size: (HSIZE 3)
	line-spacing: (* (HSIZE 3) %line-spacing-factor%)
	space-before: (* (HSIZE 2) %head-before-factor%)
	quadding: %division-title-quadding%
	keep-with-next?: #t
	(process-children))
      ;; This paragraph is a hack to get the spacing right.
      ;; Authors always have an affiliation paragraph below them, even if
      ;; it's empty, so corpauthors need one too.
      (make paragraph
	use: book-titlepage-recto-style
	font-size: (HSIZE 1)
	line-spacing: (* (HSIZE 1) %line-spacing-factor%)
	space-after: (* (HSIZE 2) %head-after-factor% 4)
	quadding: %division-title-quadding%
	keep-with-next?: #t
	(literal "\no-break-space;"))))

  (element corpname
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element date
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element edition
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)
      (literal "\no-break-space;")
      (literal (gentext-element-name-space (gi (current-node))))))

  (element editor
    (let ((editor-name (author-string)))
      (make sequence      
	(if (first-sibling?) 
	    (make paragraph
	      use: book-titlepage-recto-style
	      font-size: (HSIZE 1)
	      line-spacing: (* (HSIZE 1) %line-spacing-factor%)
	      space-before: (* (HSIZE 2) %head-before-factor% 6)
	      quadding: %division-title-quadding%
	      keep-with-next?: #t
	      (literal (gentext-edited-by)))
	    (empty-sosofo))
	(make paragraph
	  use: book-titlepage-recto-style
	  font-size: (HSIZE 3)
	  line-spacing: (* (HSIZE 3) %line-spacing-factor%)
	  space-after: (* (HSIZE 2) %head-after-factor% 4)
	  quadding: %division-title-quadding%
	  keep-with-next?: #t
	  (literal editor-name)))))

  (element firstname
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element graphic
    (let* ((nd (current-node))
	   (fileref (attribute-string "fileref" nd))
	   (entityref (attribute-string "entityref" nd))
	   (format (attribute-string "format" nd))
	   (align (attribute-string "align" nd)))
      (if (or fileref entityref) 
	  (make external-graphic
	    notation-system-id: (if format format "")
	    entity-system-id: (if fileref 
				  (graphic-file fileref)
				  (if entityref 
				      (entity-generated-system-id entityref)
				      ""))
	    display?: #t
	    display-alignment: 'center)
	  (empty-sosofo))))

  (element honorific
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element isbn
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element issn
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element itermset (empty-sosofo))

  (element invpartnumber
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element issuenum
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element jobtitle
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element keywordset
    (make paragraph
      quadding: 'start
      (make sequence
	font-weight: 'bold
	(literal "Keywords: "))
      (process-children)))

  (element (keyword)
    (make sequence
      (process-children)
      (if (not (last-sibling?))
	  (literal ", ")
	  (literal ""))))

  (element legalnotice
    (make display-group
      use: book-titlepage-recto-style
      ($semiformal-object$)))

  (element (legalnotice title) (empty-sosofo))

  (element (legalnotice para)
    (make paragraph
      use: book-titlepage-recto-style
      quadding: 'start
      line-spacing: (* 0.8 (inherited-line-spacing))
      font-size: (* 0.8 (inherited-font-size))
      (process-children)))

  (element lineage
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element modespec (empty-sosofo))

  (element orgdiv
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element orgname
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element othercredit
    (let ((author-name  (author-string))
	  (author-affil (select-elements (children (current-node)) 
					 (normalize "affiliation"))))
      (make sequence      
	(make paragraph
	  use: book-titlepage-recto-style
	  font-size: (HSIZE 3)
	  line-spacing: (* (HSIZE 3) %line-spacing-factor%)
	  space-before: (* (HSIZE 2) %head-before-factor%)
	  quadding: %division-title-quadding%
	  keep-with-next?: #t
	  (literal author-name))
	(process-node-list author-affil))))

  (element othername
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element pagenums
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element printhistory
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element productname
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element productnumber
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element pubdate
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element publisher
    (make display-group
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element publishername
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element pubsnumber
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element releaseinfo
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element revhistory
    (make sequence
      (make paragraph
	use: book-titlepage-recto-style
	space-before: (* (HSIZE 3) %head-before-factor%)
	space-after: (/ (* (HSIZE 1) %head-before-factor%) 2)
	(literal (gentext-element-name (current-node))))
      (make table
	before-row-border: #f
	(process-children))))
  
  (element (revhistory revision)
    (let ((revnumber (select-elements (descendants (current-node)) 
				      (normalize "revnumber")))
	  (revdate   (select-elements (descendants (current-node)) 
				      (normalize "date")))
	  (revauthor (select-elements (descendants (current-node))
				      (normalize "authorinitials")))
	  (revremark (select-elements (descendants (current-node))
				      (normalize "revremark")))
	  (revdescription (select-elements (descendants (current-node))
				      (normalize "revdescription"))))
      (make sequence
	(make table-row
	  (make table-cell
	    column-number: 1
	    n-columns-spanned: 1
	    n-rows-spanned: 1
	    start-indent: 0pt
	    (if (not (node-list-empty? revnumber))
		(make paragraph
		  use: book-titlepage-recto-style
		  font-size: %bf-size%
		  font-weight: 'medium
		  (literal (gentext-element-name-space (current-node)))
		  (process-node-list revnumber))
		(empty-sosofo)))
	  (make table-cell
	    column-number: 2
	    n-columns-spanned: 1
	    n-rows-spanned: 1
	    start-indent: 0pt
	    cell-before-column-margin: (if (equal? (print-backend) 'tex)
					   6pt
					   0pt)
	    (if (not (node-list-empty? revdate))
		(make paragraph
		  use: book-titlepage-recto-style
		  font-size: %bf-size%
		  font-weight: 'medium
		  (process-node-list revdate))
		(empty-sosofo)))
	  (make table-cell
	    column-number: 3
	    n-columns-spanned: 1
	    n-rows-spanned: 1
	    start-indent: 0pt
	    cell-before-column-margin: (if (equal? (print-backend) 'tex)
					   6pt
					   0pt)
	    (if (not (node-list-empty? revauthor))
		(make paragraph
		  use: book-titlepage-recto-style
		  font-size: %bf-size%
		  font-weight: 'medium
		  (literal (gentext-revised-by))
		  (process-node-list revauthor))
		(empty-sosofo))))
	(make table-row
	  cell-after-row-border: #f
	  (make table-cell
	    column-number: 1
	    n-columns-spanned: 3
	    n-rows-spanned: 1
	    start-indent: 0pt
	    (cond ((not (node-list-empty? revremark))
		   (make paragraph
		     use: book-titlepage-recto-style
		     font-size: %bf-size%
		     font-weight: 'medium
		     space-after: (if (last-sibling?) 
				      0pt
				      (/ %block-sep% 2))
		     (process-node-list revremark)))
		  ((not (node-list-empty? revdescription))
		   (make sequence
		     use: book-titlepage-recto-style
		     font-size: %bf-size%
		     font-weight: 'medium
		     (process-node-list revremark)))
		  (else (empty-sosofo))))))))
  
  (element (revision revnumber) (process-children-trim))
  (element (revision date) (process-children-trim))
  (element (revision authorinitials) (process-children-trim))
  (element (revision revremark) (process-children-trim))
  (element (revision revdescription) (process-children))

  (element seriesvolnums
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element shortaffil
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  (element subjectset (empty-sosofo))

  (element subtitle 
    (make paragraph
      use: book-titlepage-recto-style
      font-size: (HSIZE 4)
      line-spacing: (* (HSIZE 4) %line-spacing-factor%)
      space-before: (* (HSIZE 4) %head-before-factor%)
      quadding: %division-subtitle-quadding%
      keep-with-next?: #t
      (process-children-trim)))

  (element surname
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))

  ; This is the front page of the document.
  (element title 
     (make sequence
  
       (make paragraph
           use: book-titlepage-recto-style
           font-size: (HSIZE 5)
           line-spacing: (* (HSIZE 5) %line-spacing-factor%)
           space-before: (* (HSIZE 5) %head-before-factor%)
           quadding: %division-title-quadding%
           keep-with-next?: #t
           heading-level: (if %generate-heading-level% 1 0)
           (make sequence
               <![%DRAFT;[(literal "&DRAFTTEXT")]]>
               (with-mode title-mode
	    (process-children-trim))))
         (make external-graphic
       	   display?: #t
       	   scale: 0.25
           display-alignment: 'center
       	   ;entity-system-id: "graphics/p_source_c.jpg"
       	   entity-system-id: "graphics/Power.png"
           display-alignment: 'start
       	)

  ))

  (element formalpara ($para-container$))
  (element (formalpara title) ($runinhead$))
  (element (formalpara para) (make sequence (process-children)))

  (element titleabbrev (empty-sosofo))

  (element volumenum
    (make paragraph
      use: book-titlepage-recto-style
      quadding: %division-title-quadding%
      (process-children)))
)

(mode book-titlepage-verso-mode
  (element abbrev
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element abstract ($semiformal-object$))

  (element (abstract title) (empty-sosofo))

  (element address 
    (make display-group
      use: book-titlepage-verso-style
      (with-mode titlepage-address-mode 
	($linespecific-display$ %indent-address-lines% %number-address-lines%))))

  (element affiliation
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element artpagenums
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element author
    ;; Print the author name.  Handle the case where there's no AUTHORGROUP
    (let ((in-group (have-ancestor? (normalize "authorgroup") (current-node))))
      (if (not in-group)
	  (make paragraph
	    ;; Hack to get the spacing right below the author name line...
	    ;space-after: (* %bf-size% %line-spacing-factor%)
	    space-after: (* (/ %bf-size% 4) %line-spacing-factor%)
	    (make sequence
	      (literal (gentext-by))
	      (literal "\no-break-space;")
	      (literal (author-list-string))))
	  (make sequence 
	    (literal (author-list-string))))))  

  (element authorblurb
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element authorgroup
    (let* ((editors (select-elements (children (current-node)) (normalize "editor"))))
      (make paragraph
	space-after: (* %bf-size% %line-spacing-factor%)
	(make sequence
	  (if (node-list-empty? editors)
	      (literal (gentext-by))
	      (literal (gentext-edited-by)))
	  (literal "\no-break-space;")
	  (process-children-trim)))))

  (element authorinitials
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element bibliomisc (process-children))

  (element bibliomset (process-children))

  (element collab
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element confgroup
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element contractnum
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element contractsponsor
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element contrib
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element copyright
    (make paragraph
      use: book-titlepage-verso-style
      (literal (gentext-element-name (current-node)))
      (literal "\no-break-space;")
      (literal (dingbat "copyright"))
      (literal "\no-break-space;")
      (process-children)))

  (element (copyright year)
    (make sequence
      (process-children)
      (if (not (last-sibling? (current-node)))
	  (literal ", ")
	  (literal " "))))

  (element (copyright holder) ($charseq$))

  (element corpauthor
    ;; note: book-titlepage-corpauthor takes care of wrapping multiple
    ;; corpauthors
    (make sequence
      (if (first-sibling?)
	  (if (equal? (gi (parent (current-node))) (normalize "authorgroup"))
	      (empty-sosofo)
	      (literal (gentext-by) " "))
	  (literal ", "))
      (process-children)))

  (element corpname
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element date
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element edition
    (make paragraph
      (process-children)
      (literal "\no-break-space;")
      (literal (gentext-element-name-space (gi (current-node))))))

  (element editor
    ;; Print the editor name.
    (let ((in-group (have-ancestor? (normalize "authorgroup") (current-node))))
      (if (or #f (not in-group)) ; nevermind, always put out the Edited by
	  (make paragraph
	    ;; Hack to get the spacing right below the author name line...
	    space-after: (* %bf-size% %line-spacing-factor%)
	    (make sequence
	      (literal (gentext-edited-by))
	      (literal "\no-break-space;")
	      (literal (author-string))))
	  (make sequence
	    (literal (author-list-string))))))

  (element firstname
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element graphic
    (let* ((nd (current-node))
	   (fileref (attribute-string "fileref" nd))
	   (entityref (attribute-string "entityref" nd))
	   (format (attribute-string "format" nd))
	   (align (attribute-string "align" nd)))
      (if (or fileref entityref) 
	  (make external-graphic
	    notation-system-id: (if format format "")
	    entity-system-id: (if fileref 
				  (graphic-file fileref)
				  (if entityref 
				      (entity-generated-system-id entityref)
				      ""))
	    display?: #t
	    display-alignment: 'start)
	  (empty-sosofo))))

  (element honorific
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element isbn
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element issn
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element itermset (empty-sosofo))

  (element invpartnumber
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element issuenum
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element jobtitle
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element keywordset
    (make paragraph
      quadding: 'start
      (make sequence
	font-weight: 'bold
	(literal "Keywords: "))
      (process-children)))

  (element (keyword)
    (make sequence
      (process-children)
      (if (not (last-sibling?))
	  (literal ", ")
	  (literal ""))))

  (element legalnotice
    (make display-group
      use: book-titlepage-verso-style
      ($semiformal-object$)))

  (element (legalnotice title) (empty-sosofo))

  (element (legalnotice para) 
    (make paragraph
      use: book-titlepage-verso-style
      font-size: (* (inherited-font-size) 0.8)
      (process-children-trim)))

  (element lineage
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element modespec (empty-sosofo))

  (element orgdiv
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element orgname
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element othercredit
    ;; Print the author name.  Handle the case where there's no AUTHORGROUP
    (let ((in-group (have-ancestor? (normalize "authorgroup") (current-node))))
      (if (not in-group)
	  (make paragraph
	    ;; Hack to get the spacing right below the author name line...
	    space-after: (* %bf-size% %line-spacing-factor% )
	    (make sequence
	      (literal (gentext-by))
	      (literal "\no-break-space;")
	      (literal (author-list-string))))
	  (make sequence 
	    (literal (author-list-string))))))  

  (element othername
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element pagenums
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element printhistory
    (make display-group
      use: book-titlepage-verso-style
      (process-children)))

  (element productname
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element productnumber
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element pubdate
    (make paragraph
      (literal (gentext-element-name-space (gi (current-node))))
      (process-children)))

  (element publisher
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element publishername
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element pubsnumber
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element releaseinfo
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element revhistory
    (make sequence
      (make paragraph
	use: book-titlepage-verso-style
	space-before: (* (HSIZE 3) %head-before-factor%)
	space-after: (/ (* (HSIZE 1) %head-before-factor%) 2)
	(literal (gentext-element-name (current-node))))
      (make table
	before-row-border: #f
	(process-children))))
  
  (element (revhistory revision)
    (let ((revnumber (select-elements (descendants (current-node)) 
				      (normalize "revnumber")))
	  (revdate   (select-elements (descendants (current-node)) 
				      (normalize "date")))
	  (revauthor (select-elements (descendants (current-node))
				      (normalize "authorinitials")))
	  (revremark (select-elements (descendants (current-node))
				      (normalize "revremark")))
	  (revdescription (select-elements (descendants (current-node))
				      (normalize "revdescription"))))
      (make sequence
	(make table-row
	  (make table-cell
	    column-number: 1
	    n-columns-spanned: 1
	    n-rows-spanned: 1
	    start-indent: 0pt
	    (if (not (node-list-empty? revnumber))
		(make paragraph
		  use: book-titlepage-verso-style
		  font-size: %bf-size%
		  font-weight: 'medium
		  (literal (gentext-element-name-space (current-node)))
		  (process-node-list revnumber))
		(empty-sosofo)))
	  (make table-cell
	    column-number: 2
	    n-columns-spanned: 1
	    n-rows-spanned: 1
	    start-indent: 0pt
	    cell-before-column-margin: (if (equal? (print-backend) 'tex)
					   6pt
					   0pt)
	    (if (not (node-list-empty? revdate))
		(make paragraph
		  use: book-titlepage-verso-style
		  font-size: %bf-size%
		  font-weight: 'medium
		  (process-node-list revdate))
		(empty-sosofo)))
	  (make table-cell
	    column-number: 3
	    n-columns-spanned: 1
	    n-rows-spanned: 1
	    start-indent: 0pt
	    cell-before-column-margin: (if (equal? (print-backend) 'tex)
					   6pt
					   0pt)
	    (if (not (node-list-empty? revauthor))
		(make paragraph
		  use: book-titlepage-verso-style
		  font-size: %bf-size%
		  font-weight: 'medium
		  (literal (gentext-revised-by))
		  (process-node-list revauthor))
		(empty-sosofo))))
	(make table-row
	  cell-after-row-border: #f
	  (make table-cell
	    column-number: 1
	    n-columns-spanned: 3
	    n-rows-spanned: 1
	    start-indent: 0pt
	    (cond ((not (node-list-empty? revremark))
		   (make paragraph
		     use: book-titlepage-verso-style
		     font-size: %bf-size%
		     font-weight: 'medium
		     space-after: (if (last-sibling?) 
				      0pt
				      (/ %block-sep% 2))
		     (process-node-list revremark)))
		  ((not (node-list-empty? revdescription))
		   (make sequence
		     use: book-titlepage-verso-style
		     font-size: %bf-size%
		     font-weight: 'medium
		     (process-node-list revdescription)))
		(else (empty-sosofo)))))))) 
  
  (element (revision revnumber) (process-children-trim))
  (element (revision date) (process-children-trim))
  (element (revision authorinitials) (process-children-trim))
  (element (revision revremark) (process-children-trim))
  (element (revision revdescription) (process-children))

  (element seriesvolnums
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element shortaffil
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element subjectset (empty-sosofo))

  (element subtitle
    (make sequence
      font-family-name: %title-font-family%
      font-weight: 'bold
      (literal (if (first-sibling?) ": " "; "))
      (process-children)))

  (element surname
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))

  (element title
    (make sequence
      font-family-name: %title-font-family%
      font-weight: 'bold
      (with-mode title-mode
       (make sequence
      <![%DRAFT;[(literal "&DRAFTTEXT")]]>
	(process-children)))))

  (element formalpara ($para-container$))
  (element (formalpara title) ($runinhead$))
  (element (formalpara para) (make sequence (process-children)))

  (element titleabbrev (empty-sosofo))

  (element volumenum
    (make paragraph
      use: book-titlepage-verso-style
      (process-children)))
)

