<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [

<!ENTITY html-ss PUBLIC "-//Norman Walsh//DOCUMENT DocBook HTML Stylesheet//EN" CDATA dsssl>
<!ENTITY print-ss PUBLIC "-//Norman Walsh//DOCUMENT DocBook Print Stylesheet//EN" CDATA dsssl>

<!ENTITY % UNIFIED "INCLUDE">
<!ENTITY % EABI "IGNORE">
<!ENTITY % LINUX "IGNORE">
<!ENTITY % WRAPPER "IGNORE">
<!ENTITY % TAGID "IGNORE">
<!ENTITY % DRAFT "IGNORE">

<![%EABI;[
<!ENTITY % UNIFIED "IGNORE">
<!ENTITY VARIABLEDEFS SYSTEM "eabi.dsl">
<!ENTITY INCLUDECHECKS SYSTEM "include-checks.dsl">
<!ENTITY ABITEXT "Embedded">
]]>

<![%LINUX;[
<!ENTITY % UNIFIED "IGNORE">
<!ENTITY VARIABLEDEFS SYSTEM "linuxabi.dsl">
<!ENTITY INCLUDECHECKS SYSTEM "include-checks.dsl">
<!ENTITY ABITEXT "Server">
]]>

<![%UNIFIED;[
<!ENTITY % LINUX "IGNORE">
<!ENTITY % EABI "IGNORE">
<!ENTITY VARIABLEDEFS SYSTEM "unified.dsl">
<!ENTITY INCLUDECHECKS SYSTEM "dont-include-checks.dsl">
]]>

<![%TAGID;[<!ENTITY TAGIDDEF SYSTEM "tagid.dsl">]]>

<![%WRAPPER;[
  <!ENTITY WRAPPERDEF SYSTEM "wrapper.dsl">
  <![%LINUX;[
		<!ENTITY WRAPITDEF SYSTEM "either-wrap-attribs.dsl">
  ]]>
  <![%EABI;[
		<!ENTITY WRAPITDEF SYSTEM "either-wrap-attribs.dsl">
  ]]>
  <![%UNIFIED;[
		<!ENTITY WRAPITDEF SYSTEM "unified-wrap-attribs.dsl">
  ]]>

]]>

<!ENTITY TAGIDDEF SYSTEM "tagid-stub.dsl">
<!ENTITY WRAPPERDEF SYSTEM "wrapper-stub.dsl">
<!ENTITY WRAPITDEF SYSTEM "wrapit-stub.dsl">
<!ENTITY COLORDEF SYSTEM "colordef.dsl">
<!ENTITY PRINTTTLPAGE SYSTEM "print-ttlpg.dsl">
<!ENTITY HTMLTTLPAGE SYSTEM "html-ttlpg.dsl">
<!ENTITY ABICOMMON SYSTEM "abicommon.dsl">
<!ENTITY DRAFTTEXT "DRAFT: ">
<!ENTITY ABITEXT "Unified">
]>

<style-sheet>
<style-specification id="html" use="html-stylesheet">
<style-specification-body>

; Pull in the ABI particular attribute definitions which effect
; paragraph inclusion/exclusion.
&VARIABLEDEFS;

; Pull in the functions which check the INCLUDE/IGNORE status of the ABI attribute
; variables defined in VARIABLEDEFS
&INCLUDECHECKS;

; Pull in overrides of common functions that are shared between html and print
&ABICOMMON;

; Pull in the html title-page mode overloads.  They're very long and the
; modifications were miniscule.
&HTMLTTLPAGE;

; Pull in the colors
&COLORDEF;

; Necessary to conditionally include/exclude phrase elements from the book
; title.  Oddly enough the head-title-mode isn't used for chapters titles.
(mode head-title-mode
  ;; TITLE in an HTML HEAD
 (element (title) ; Put DRAFTTEXT on the HTML HEAD TITLE if available.
   (make sequence
    <![%DRAFT;[(literal "&DRAFTTEXT")]]>
    (process-children)))

 (element (phrase) ; Necessary to conditionaly include phrase elements
    (conditional-sequence (current-node))
 )
 (element graphic (empty-sosofo))
 (element inlinegraphic (empty-sosofo))
)

; This affects the Chapter titles.
(mode title-mode
  (element title
   (make sequence
    <![%DRAFT;[(literal "&DRAFTTEXT")]]>
    (process-children)))
)

; This affects the navigation banner usage of the title
;; +-----------------------------------------+
;; |               nav-banner                |
;; +------------+---------------+------------|
;; |  prevlink  |  nav-context  |  nextlink  |
;; +-----------------------------------------+
;(mode title-sosofo-mode
;  (element title
;   (make sequence
;    <![%DRAFT;[(literal "&DRAFTTEXT")]]>
;    (process-children-trim)))
;
;  (element citetitle
;    (process-children-trim))
;
;  (element refname
;    (process-children-trim))
;
;  (element refentrytitle
;    (process-children-trim)))

; Create an element if it has a CONDITION attribute only if
; that attribute is marked INCLUDE in the VARIABLEDEFS file.
(define (conditional-element nd elem)
	(if (include-attributes? (nd))
		(make element gi: elem (process-children))
		(empty-sosofo)))

(element listitem
 (conditional-element (current-node) "LI")
)

(element para
 (conditional-element (current-node) "P")
)

; Sometimes a varlistentry is excluded entirely based upon a CONDITION
; attribute.
(element varlistentry
	(if (include-attributes? (current-node))
		(let ((terms    (select-elements (children (current-node)) (normalize "term")))
			(listitem (select-elements (children (current-node)) (normalize "listitem"))))
				(make sequence
					(make element gi: "DT"
						(if (attribute-string (normalize "id"))
							(make sequence
								(make element gi: "A"
									attributes: (list (list "NAME" (attribute-string (normalize "id"))))
									(empty-sosofo))
								(process-node-list terms))
							(process-node-list terms)))
					(process-node-list listitem)))
		(empty-sosofo)))

; This deviates from the original in that it includes/excludes based on a
; CONDITION attribute.  It also prepends a ", " if the node isn't the first
; one rather than the original version which appended a ", " if the node isn't
; the last, which isn't correct when the last node is excluded based on
; CONDITION.
(element (varlistentry term)
	(if (include-attributes? (current-node))
		(make sequence
			(if (not (first-sibling?))
				(literal ", ")
				(literal ""))
			(process-children-trim))
		(empty-sosofo)))

</style-specification-body>
</style-specification>

<style-specification id="print" use="print-stylesheet">
<style-specification-body>

; Pull in the ABI particular attribute definitions which effect
; paragraph inclusion/exclusion.
&VARIABLEDEFS;

; Pull in the functions which check the INCLUDE/IGNORE status of the ABI attribute
; variables defined in VARIABLEDEFS
&INCLUDECHECKS;

; Pull in the conditional $wrapper$ definition.
&WRAPPERDEF;
&WRAPITDEF;

; Pull in the conditional tagid definition.
&TAGIDDEF;

; Pull in overrides of common functions that are shared between html and print
&ABICOMMON;

; Pull in the print title-page mode overloads.  They're very long and the
; modifications were miniscule.
&PRINTTTLPAGE;

; Pull in the colors
&COLORDEF;

; This affects the Chapter titles in the table-of-contents
(mode title-mode
  (element title
   (make sequence
    <![%DRAFT;[(literal "&DRAFTTEXT")]]>
    (process-children)))
)

; This affects the actual Chapter titles.
(mode component-title-mode
 (element title
  (make sequence
    <![%DRAFT;[(literal "&DRAFTTEXT")]]>
   (process-children))))

;(mode title-sosofo-mode
;  (element title
;   (make sequence
;    <![%DRAFT;[(literal "&DRAFTTEXT")]]>
;    (process-children-trim)))
;
;  (element citetitle
;    (process-children-trim))
;
;  (element refname
;    (process-children-trim))
;
;  (element refentrytitle
;    (process-children-trim)))

; Create an element if it has a CONDITION attribute only if
; that attribute is marked INCLUDE in the VARIABLEDEFS file.
(define (conditional-element nd)
	(if (include-attributes? (nd))
		($CONDITION-wrapper$ (make paragraph (process-children)))
		(empty-sosofo)))

(element para
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($paragraph$))
		(empty-sosofo)))

(define ($admonition$)
  (if %admon-graphics%
      ($graphical-admonition$)
      (make display-group
	;;space-before: %block-sep%
	;space-before: 0pt
	;space-before: (* %block-sep% 4)
	;;space-after: %block-sep%
	space-before: %block-sep%
	space-after: %block-sep%
	;space-after: 0pt
	start-indent: (if %admon-graphics%
			  (inherited-start-indent)
			  (+ (inherited-start-indent) (* (ILSTEP) 2)))
	end-indent: (inherited-end-indent)
	font-size: (- %bf-size% 1pt)
	font-weight: 'medium
	font-posture: 'upright
	font-family-name: %admon-font-family%
	line-spacing: (* (- %bf-size% 1pt) %line-spacing-factor%)
	(process-children))))


;; Add the end-indent
(define ($list$)
   (make display-group
     start-indent: (if (INBLOCK?)
		       (inherited-start-indent)
		       (+ %block-start-indent% (inherited-start-indent)))
     end-indent: (inherited-end-indent)
     space-after:  (if (INLIST?) %para-sep% %block-sep%)))

; Added to set end-indent: (inherited-end-indent)
(define (generic-list-item indent-step line-field)
  (let* ((itemcontent (children (current-node)))
         (first-child (node-list-first itemcontent))
         (spacing (inherited-attribute-string (normalize "spacing"))))
    (make display-group
      space-before: 0pt
      space-after: 0pt
      start-indent: (+ (inherited-start-indent) indent-step)
      end-indent: (inherited-end-indent)
;	(make rule
;	  orientation: 'horizontal
;	  line-thickness: %object-rule-thickness%
;	  display-alignment: 'center
;	  space-after: 0pt
;	  space-before: 0pt
;	  keep-with-next?: #t)
      (make paragraph
        use: (cond
              ((equal? (gi first-child) (normalize "programlisting"))
               verbatim-style)
              ((equal? (gi first-child) (normalize "screen"))
               verbatim-style)
              ((equal? (gi first-child) (normalize "synopsis"))
               verbatim-style)
              ((equal? (gi first-child) (normalize "literallayout"))
               linespecific-style)
              ((equal? (gi first-child) (normalize "address"))
               linespecific-style)
              (else
               nop-style))
        space-before: (if (equal? (normalize "compact") spacing)
                          0pt
                          %para-sep%)
        first-line-start-indent: (- indent-step)
        end-indent: (inherited-end-indent)
;	(make rule
;	  orientation: 'horizontal
;	  line-thickness: %object-rule-thickness%
;	  display-alignment: 'center
;	  space-after: 0pt
;	  space-before: 0pt
;	  keep-with-next?: #t)
        (make sequence
          line-field)
	(with-mode listitem-content-mode
	  (process-node-list first-child)))
      (process-node-list (node-list-rest itemcontent)))))


(element variablelist
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ (process-variablelist (current-node)))
		(empty-sosofo)))

; This has been moved from the non-modal (element variablelist) so
; that we can do conditional selection there and call this in two cases.
(define (process-variablelist nd)
;(element variablelist
  (let* ((termlength (if (attribute-string (normalize "termlength"))
			 (string->number 
			  (attribute-string (normalize "termlength")))
			 %default-variablelist-termlength%))
	 (maxlen     (if (> termlength %default-variablelist-termlength%)
			    termlength
			    %default-variablelist-termlength%))
	 (too-long?  (variablelist-term-too-long? termlength)))
    (make display-group
      start-indent: (if (INBLOCK?)
			(inherited-start-indent)
			(+ %block-start-indent% (inherited-start-indent)))
      space-before: (if (INLIST?) %para-sep% %block-sep%)
      space-after:  (if (INLIST?) %para-sep% %block-sep%)

      (if (and (or (and termlength (not too-long?))
		   %always-format-variablelist-as-table%)
	       (or %may-format-variablelist-as-table%
		   %always-format-variablelist-as-table%))
	  (make table
	    space-before: (if (INLIST?) %para-sep% %block-sep%)
	    space-after:  (if (INLIST?) %para-sep% %block-sep%)
	    start-indent: (if (INBLOCK?)
			      (inherited-start-indent)
			      (+ %block-start-indent% 
				 (inherited-start-indent)))

;; Calculate the width of the column containing the terms...
;;
;; maxlen       in        (inherited-font-size)     72pt
;;        x ---------- x ----------------------- x ------ = width
;;           12 chars              10pt              in
;;
	    (make table-column
	      column-number: 1
	      width: (* (* (/ maxlen 12) (/ (inherited-font-size) 10pt)) 72pt))
	    (with-mode variablelist-table
	      (process-children)))
	  (process-children)))))



; This has been moved from the non-modal (element (itemizedlist listitem)) so
; that we can do conditional selection there and call this in two cases.
(define (process-listitem nd)
  (let ((ilevel (length (hierarchical-number-recursive (normalize "itemizedlist"))))
	(override (inherited-attribute-string (normalize "override")))
	(mark (inherited-attribute-string (normalize "mark"))))
    (generic-list-item
     (ILSTEP)
     (if (or (and override
		  (equal? (normalize override) (normalize "none")))
	     (and (not override)
		  (equal? (normalize mark) (normalize "none"))))
	 (make line-field
	   font-size: (BULLTREAT BULLSIZE ilevel override mark)
	   position-point-shift: (BULLTREAT BULLSHIFT ilevel override mark)
	   field-width: (ILSTEP)
	   (literal "\no-break-space;"))
	 (make line-field
	   font-size: (BULLTREAT BULLSIZE ilevel override mark)
	   position-point-shift: (BULLTREAT BULLSHIFT ilevel override mark)
	   field-width: (ILSTEP)
	   (literal (BULLTREAT BULLSTR ilevel override mark)))))))

; Only list the items conditionally included.  The original contents of this
; function were moved to process-listitem.
(element (itemizedlist listitem)
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ (process-listitem (current-node)))
		(empty-sosofo)))

(element itemizedlist
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ ($list$))
		(empty-sosofo)))

; Sometimes a varlistentry is excluded entirely based upon a CONDITION
; attribute.
(element varlistentry
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ (process-children))
		(empty-sosofo)))

; This deviates from the original in that it includes/excludes based on a
; CONDITION attribute.  It also prepends a ", " if the node isn't the first
; one rather than the original version which appended a ", " if the node isn't
; the last, which isn't correct when the last node is excluded based on
; CONDITION.
(element (varlistentry term)
	(if (include-attributes? (current-node))
		($CONDITION-wrapper$ (make paragraph
			space-before: (if (first-sibling?)
									%block-sep%
									0pt)
			keep-with-next?: #t
			first-line-start-indent: 0pt
			start-indent: (inherited-start-indent)
			(process-children)))
		(empty-sosofo)))

; Updated the authorgroup space-after to adjust the space between the book
; title and the author group in order to fit all authors on the first page.
(define (book-titlepage-before node side)
  (if (equal? side 'recto)
      (cond
       ((equal? (gi node) (normalize "corpauthor"))
	(make paragraph
	  space-after: (* (HSIZE 5) %head-after-factor% 8)
	  (literal "\no-break-space;")))
       ((equal? (gi node) (normalize "authorgroup"))
	(if (have-sibling? (normalize "corpauthor") node)
	    (empty-sosofo)
	    (make paragraph
	      ;space-after: (* (HSIZE 5) %head-after-factor% 2)
	      space-after: 0pt
	      (literal "\no-break-space;"))))
       ((equal? (gi node) (normalize "author"))
	(if (or (have-sibling? (normalize "corpauthor") node) 
	        (have-sibling? (normalize "authorgroup") node))
	    (empty-sosofo)
	    (make paragraph
	      space-after: (* (HSIZE 5) %head-after-factor% 8)
	      (literal "\no-break-space;"))))
       (else (empty-sosofo)))
      (empty-sosofo)))

(element informaltable
  (let ((attrib (attribute-string "CONDITION" (current-node))))
   (if (include-attributes? (current-node))
         ($CONDITION-wrapper$ (with-mode mutual-exclusion-table-mode ($informal-object$ %informaltable-rules% %informaltable-rules%))  )
	 (empty-sosofo))))

(mode mutual-exclusion-table-mode
 (element (thead)
   ($mutual-exclusion-table-body$ (current-node)))
 (element (tbody)
   ($mutual-exclusion-table-body$ (current-node)))
   )


(define (INCONDITION?)
  (inherited-attribute-string "CONDITION" (current-node)))

(define ($informal-object$ #!optional (rule-before? #f) (rule-after? #f))
  (make display-group
    start-indent: (+ %block-start-indent% (inherited-start-indent))
    space-before: (if (INLIST?) %block-sep%
		    (if (INCONDITION?) 0pt (/ %block-sep% 8)))
    space-after: (if (INLIST?) %block-sep%
		    (if (INCONDITION?) 0pt (/ %block-sep% 8)))

    keep-with-previous?: #f
    keep: 'page
    (if rule-before?
	(make rule
	  orientation: 'horizontal
	  line-thickness: %object-rule-thickness%
	  display-alignment: 'center
	  space-after: (/ %block-sep% 2)
          ;keep-with-previous?: #f
	  keep-with-next?: #t)
	(empty-sosofo))
    (process-children)
    (if rule-after?
	(make rule
	  orientation: 'horizontal
	  line-thickness: %object-rule-thickness%
	  display-alignment: 'center
	  space-before: (/ %block-sep% 2)
	  keep-with-previous?: #t)
	(empty-sosofo))))

; It's stupid that the following three defines are necessary just to override
; the 'bolding' of the thead cell.
(define ($mutual-exclusion-table-body$ body)
  (let* ((tgroup (ancestor (normalize "tgroup") body))
	 (cols   (string->number (attribute-string (normalize "cols") tgroup)))
	 (blabel (cond 
		   ((equal? (gi body) (normalize "thead")) 'thead)
		   ((equal? (gi body) (normalize "tbody")) 'tbody)
		   ((equal? (gi body) (normalize "tfoot")) 'tfoot))))
    (make sequence
      label: blabel
      (let loop ((rows (select-elements (children body) (normalize "row")))
		 (overhang (constant-list 0 cols)))
	(if (node-list-empty? rows)
	    (empty-sosofo)
	    (make sequence
	      ($mutual-exclusion-process-row$ (node-list-first rows) overhang)
	      (loop (node-list-rest rows)
		    (update-overhang (node-list-first rows) overhang))))))))

(define ($mutual-exclusion-process-row$ row overhang)
  (let* ((tgroup           (ancestor (normalize "tgroup") row))
	 (maxcol           (string->number (attribute-string 
					    (normalize "cols") tgroup)))
	 (lastentry        (node-list-last (node-list-filter-out-pis 
					    (children row))))
	 (table            (parent tgroup)))
    ;; there's no point calculating the row or colsep here, each cell
    ;; specifies it which overrides anything we might say here...
    (make table-row
      (let loop ((cells (node-list-filter-out-pis (children row)))
		 (prevcell (empty-node-list)))
	(if (node-list-empty? cells)
	    (empty-sosofo)
	    (make sequence
	      ($mutual-exclusion-process-cell$ (node-list-first cells) prevcell row overhang)
	      (loop (node-list-rest cells) (node-list-first cells)))))
      
      ;; add any necessary empty cells to the end of the row
      (let loop ((colnum (+ (cell-column-number lastentry overhang)
			    (hspan lastentry))))
	(if (> colnum maxcol)
	    (empty-sosofo)
	    (make sequence
	      ($process-empty-cell$ colnum row)
	      (loop (+ colnum 1))))))))

(define ($mutual-exclusion-process-cell$ entry preventry row overhang)
  (let* ((colnum    (cell-column-number entry overhang))
	 (lastcellcolumn (if (node-list-empty? preventry)
			     0
			     (- (+ (cell-column-number preventry overhang)
				   (hspan preventry))
				1)))
	 (lastcolnum (if (> lastcellcolumn 0)
			 (overhang-skip overhang lastcellcolumn)
			 0))
	 (font-name (if (have-ancestor? (normalize "thead") entry)
			%title-font-family%
			%body-font-family%))
	 (weight    (if (have-ancestor? (normalize "thead") entry)
			'normal
			'normal))
	 (adjust-size    (if (have-ancestor? (normalize "thead") entry)
         (/ %smaller-size-factor% 1.2)
         1))
	 (fontcolor color-black)
	 (align     (cell-align entry colnum)))

    (make sequence
      ;; This is a little bit complicated.  We want to output empty cells
      ;; to skip over missing data.  We start count at the column number
      ;; arrived at by adding 1 to the column number of the previous entry
      ;; and skipping over any MOREROWS overhanging entrys.  Then for each
      ;; iteration, we add 1 and skip over any overhanging entrys.
      (let loop ((count (overhang-skip overhang (+ lastcolnum 1))))
	(if (>= count colnum)
	    (empty-sosofo)
	    (make sequence
	      ($process-empty-cell$ count row)
	      (loop (overhang-skip overhang (+ count 1))))))

      ;; Now we've output empty cells for any missing entries, so we 
      ;; are ready to output the cell for this entry...
      (make table-cell 
	column-number: colnum
	n-columns-spanned: (hspan entry)
	n-rows-spanned: (vspan entry)

	cell-row-alignment: (cell-valign entry colnum)

	cell-after-column-border: (if (cell-colsep entry colnum)
				      calc-table-cell-after-column-border
				      #f)

	cell-after-row-border: (if (cell-rowsep entry colnum)
				   (if (last-sibling? (parent entry))
				       calc-table-head-body-border
				       calc-table-cell-after-row-border)
				   #f)

	cell-before-row-margin: %cals-cell-before-row-margin%
	cell-after-row-margin: %cals-cell-after-row-margin%
	cell-before-column-margin: %cals-cell-before-column-margin%
	cell-after-column-margin: %cals-cell-after-column-margin%

	;; If there is some additional indentation (because we're in a list,
	;; for example) make sure that gets passed along, but don't add
	;; the normal body-start-indent.
	start-indent: (+ (- (inherited-start-indent) %body-start-indent%)
			 %cals-cell-content-start-indent%)
	end-indent: %cals-cell-content-end-indent%
	(if (equal? (gi entry) (normalize "entrytbl"))
	    (make paragraph 
	      (literal "ENTRYTBL not supported."))
	    (make paragraph
	      font-family-name: font-name
	      font-weight: weight
         font-size: (* (inherited-font-size) adjust-size )
         color: fontcolor
	      quadding: align
	      (process-node-list (children entry))))))))


(mode abi-diff-thead-mode
 (element (thead)
   ($abi-diff-process-table-body$ (current-node)))
 (element (tbody)
   ($abi-diff-process-table-body$ (current-node)))
   )

; It's stupid that the following three defines are necessary just to override
; the 'bolding' of the thead cell.
(define ($abi-diff-process-table-body$ body)
  (let* ((tgroup (ancestor (normalize "tgroup") body))
	 (cols   (string->number (attribute-string (normalize "cols") tgroup)))
	 (blabel (cond 
		   ((equal? (gi body) (normalize "thead")) 'thead)
		   ((equal? (gi body) (normalize "tbody")) 'tbody)
		   ((equal? (gi body) (normalize "tfoot")) 'tfoot))))
    (make sequence
      label: blabel
      (let loop ((rows (select-elements (children body) (normalize "row")))
		 (overhang (constant-list 0 cols)))
	(if (node-list-empty? rows)
	    (empty-sosofo)
	    (make sequence
	      ($abi-diff-process-row$ (node-list-first rows) overhang)
	      (loop (node-list-rest rows)
		    (update-overhang (node-list-first rows) overhang))))))))

(define ($abi-diff-process-row$ row overhang)
  (let* ((tgroup           (ancestor (normalize "tgroup") row))
	 (maxcol           (string->number (attribute-string 
					    (normalize "cols") tgroup)))
	 (lastentry        (node-list-last (node-list-filter-out-pis 
					    (children row))))
	 (table            (parent tgroup)))
    ;; there's no point calculating the row or colsep here, each cell
    ;; specifies it which overrides anything we might say here...
    (make table-row
      (let loop ((cells (node-list-filter-out-pis (children row)))
		 (prevcell (empty-node-list)))
	(if (node-list-empty? cells)
	    (empty-sosofo)
	    (make sequence
	      ($abi-diff-process-cell$ (node-list-first cells) prevcell row overhang)
	      (loop (node-list-rest cells) (node-list-first cells)))))
      
      ;; add any necessary empty cells to the end of the row
      (let loop ((colnum (+ (cell-column-number lastentry overhang)
			    (hspan lastentry))))
	(if (> colnum maxcol)
	    (empty-sosofo)
	    (make sequence
	      ($process-empty-cell$ colnum row)
	      (loop (+ colnum 1))))))))

(define ($abi-diff-process-cell$ entry preventry row overhang)
  (let* ((colnum    (cell-column-number entry overhang))
	 (lastcellcolumn (if (node-list-empty? preventry)
			     0
			     (- (+ (cell-column-number preventry overhang)
				   (hspan preventry))
				1)))
	 (lastcolnum (if (> lastcellcolumn 0)
			 (overhang-skip overhang lastcellcolumn)
			 0))
	 (font-name (if (have-ancestor? (normalize "thead") entry)
			%title-font-family%
			%body-font-family%))
	 (weight    (if (have-ancestor? (normalize "thead") entry)
			'normal
			'medium))
	 (adjust-size    (if (have-ancestor? (normalize "thead") entry)
         (/ %smaller-size-factor% 1.5)
         1))
	 (fontcolor    (if (have-ancestor? (normalize "thead") entry)
         color-medslateblue
         color-purple))
	 (align     (cell-align entry colnum)))

    (make sequence
      ;; This is a little bit complicated.  We want to output empty cells
      ;; to skip over missing data.  We start count at the column number
      ;; arrived at by adding 1 to the column number of the previous entry
      ;; and skipping over any MOREROWS overhanging entrys.  Then for each
      ;; iteration, we add 1 and skip over any overhanging entrys.
      (let loop ((count (overhang-skip overhang (+ lastcolnum 1))))
	(if (>= count colnum)
	    (empty-sosofo)
	    (make sequence
	      ($process-empty-cell$ count row)
	      (loop (overhang-skip overhang (+ count 1))))))

      ;; Now we've output empty cells for any missing entries, so we 
      ;; are ready to output the cell for this entry...
      (make table-cell 
	column-number: colnum
	n-columns-spanned: (hspan entry)
	n-rows-spanned: (vspan entry)

	cell-row-alignment: (cell-valign entry colnum)

	cell-after-column-border: (if (cell-colsep entry colnum)
				      calc-table-cell-after-column-border
				      #f)

	cell-after-row-border: (if (cell-rowsep entry colnum)
				   (if (last-sibling? (parent entry))
				       calc-table-head-body-border
				       calc-table-cell-after-row-border)
				   #f)

	cell-before-row-margin: %cals-cell-before-row-margin%
	cell-after-row-margin: %cals-cell-after-row-margin%
	cell-before-column-margin: %cals-cell-before-column-margin%
	cell-after-column-margin: %cals-cell-after-column-margin%

	;; If there is some additional indentation (because we're in a list,
	;; for example) make sure that gets passed along, but don't add
	;; the normal body-start-indent.
	start-indent: (+ (- (inherited-start-indent) %body-start-indent%)
			 %cals-cell-content-start-indent%)
	end-indent: %cals-cell-content-end-indent%
	(if (equal? (gi entry) (normalize "entrytbl"))
	    (make paragraph 
	      (literal "ENTRYTBL not supported."))
	    (make paragraph
	      font-family-name: font-name
	      font-weight: weight
         font-size: (* (inherited-font-size) adjust-size )
         color: fontcolor
	      quadding: align
	      (process-node-list (children entry))))))))

; Extended to support ("italicstrong" "italicbold" "boldstrong" "bolditalic") and "strikethrough"
(element emphasis
  (if (attribute-string (normalize "role"))
      (cond
        ((or (equal? (attribute-string (normalize "role")) "strong")
             (equal? (attribute-string (normalize "role")) "bold"))
            ($bold-seq$))
        ((or (equal? (attribute-string (normalize "role")) "italicstrong")
             (equal? (attribute-string (normalize "role")) "italicbold")
             (equal? (attribute-string (normalize "role")) "boldstrong")
             
            ($bold-italic-seq$))
        ((equal? (attribute-string (normalize "role")) "strikethrough")
            ($score-seq$ 'through))
        (else
          ($italic-seq$)))
      ($italic-seq$)))

;(define (conditional-element nd elem)
; (let * ((attrib (attribute-string "CONDITION" nd)))
;	(if (or
;			(equal? attrib '#f)
;			(include-attributes? attrib))

;
;(element figure
;	(if (include-attributes? (current-node))
;	  ;; FIXME: this is a bit crude...
;	  (let* ((mediaobj (select-elements (children (current-node))
;	            (normalize "mediaobject")))
;	   (imageobj (select-elements (children mediaobj)
;	            (normalize "imageobject")))
;	   (image    (select-elements (children imageobj)
;	            (normalize "imagedata")))
;	   (graphic  (select-elements (children (current-node))
;	            (normalize "graphic")))
;	   (align    (if (node-list-empty? image)
;	           (if (node-list-empty? graphic)
;	         #f
;	         (attribute-string (normalize "align")
;	               (node-list-first graphic)))
;	           (attribute-string (normalize "align") (node-list-first image))))
;	   (dalign  (cond ((equal? align (normalize "center"))
;	       'center)
;	      ((equal? align (normalize "right"))
;	       'end)
;	      (else
;	       'start))))
;	    (if align
;	  (make display-group
;	    quadding: dalign
;	    ($formal-object$ %figure-rules% %figure-rules%))
;	  ($formal-object$ %figure-rules% %figure-rules%)))
;		(empty-sosofo)))
;

;; Overridden to provide CONDITION-wrapper and TAGID
(element table 
  (if (include-attributes? (current-node))
    ($CONDITION-wrapper$
      ;; can't be a "formal-object" because it requires special handling for
      ;; the PGWIDE attribute
      (let* ((nsep   (gentext-label-title-sep (gi)))
	  (pgwide (attribute-string (normalize "pgwide")))
	  (indent (lambda () (if (not (equal? pgwide "1"))
	         		(+ %block-start-indent% 
	         		   (inherited-start-indent))
	         		%cals-pgwide-start-indent%)))
	  (rule-before? %table-rules%)
	  (rule-after? %table-rules%)
	  (title-sosofo (make paragraph
	         	 font-weight: %table-title-font-weight%
	         	 space-before: (if (object-title-after)
	         			   %para-sep%
	         			   0pt)
	         	 space-after: (if (object-title-after)
	         			  0pt
	         			  %para-sep%)
	         	 start-indent: (indent)
	         	  keep-with-next?: #t
	         	  (literal (gentext-element-name (current-node)))
	         	  (if (string=? (element-label) "")
	         	      (literal nsep)
	         	      (literal " " (element-label) nsep))
	         	  (element-title-sosofo)
                          ($TAGID$ (current-node))))
	   (table-sosofo (make display-group
	         	  font-weight: 'bold
	         	  space-before: 0pt
	         	  space-after: 0pt
	         	  start-indent: (indent)
			  keep: 'page ; This keeps the section title with the table
	         	  (process-children)))
	   (table (make display-group
	            start-indent: (+ %block-start-indent%
	         		    (inherited-start-indent))
	            space-before: %block-sep%
	            space-after:  (/ %para-sep% 3)
		    ;keep: #t
	            (if rule-before?
	                (make rule
	         	 orientation: 'horizontal
	         	 line-thickness: %object-rule-thickness%
	         	 display-alignment: 'center
	         	 space-after: (/ %block-sep% 2)
	         	 keep-with-next?: #t)
	                (empty-sosofo))
	            (if (object-title-after)
	                (make sequence
	         	 table-sosofo
	         	 title-sosofo)
	                (make sequence
	         	 title-sosofo
	         	 table-sosofo))
	            (if rule-after?
	                (make rule
	         	 orientation: 'horizontal
	         	 line-thickness: %object-rule-thickness%
	         	 display-alignment: 'center
	         	 space-before: (/ %block-sep% 2)
	         	 keep-with-previous?: #t)
	                (empty-sosofo)))))
      (if (and (equal? (print-backend) 'tex)
	       formal-object-float
	       (float-object (current-node)))
	  (make page-float
	    table)
	  table))
	) ;;$CONDITION-wrapper
	(empty-sosofo)))

;; Override this to add $TAGID$ on the title bar.
(mode formal-object-title-mode
  (element title
    (let* ((object (parent (current-node)))
	   (nsep   (gentext-label-title-sep (gi object))))
      (make paragraph
	font-weight: %formal-object-title-font-weight%
	space-before: (if (object-title-after (parent (current-node)))
			  %para-sep%
			  0pt)
	space-after: (if (object-title-after (parent (current-node)))
			 0pt
			 %para-sep%)
	start-indent: (+ %block-start-indent% (inherited-start-indent))
	keep-with-next?: (not (object-title-after (parent (current-node))))
	(if (member (gi object) (named-formal-objects))
	    (make sequence
	      (literal (gentext-element-name object))
	      (if (string=? (element-label object) "")
		  (literal nsep)
		  (literal " " (element-label object) nsep))
	      )
	    (empty-sosofo))
	(process-children)
	($TAGID$ (parent (current-node)) )))))

;; Override this to add $TAGID$ on the title bar.
(define ($section-title$)
  (let* ((sect (current-node))
	 (info (info-element))
	 (exp-children (if (node-list-empty? info)
			   (empty-node-list)
			   (expand-children (children info) 
					    (list (normalize "bookbiblio") 
						  (normalize "bibliomisc")
						  (normalize "biblioset")))))
	 (parent-titles (select-elements (children sect) (normalize "title")))
	 (info-titles   (select-elements exp-children (normalize "title")))
	 (titles        (if (node-list-empty? parent-titles)
			    info-titles
			    parent-titles))
	 (subtitles     (select-elements exp-children (normalize "subtitle")))
	 (renderas (inherited-attribute-string (normalize "renderas") sect))
	 ;; the apparent section level
	 (hlevel
	  ;; if not real section level, then get the apparent level
	  ;; from "renderas"
	  (if renderas
	      (section-level-by-gi #f (normalize renderas))
	      ;; else use the real level
	      (SECTLEVEL)))
	 (hs (HSIZE (- 5 hlevel))))
    (make sequence
      (make paragraph
	font-family-name: %title-font-family%
	font-weight:  (if (< hlevel 5) 'bold 'medium)
	font-posture: (if (< hlevel 5) 'upright 'italic)
	font-size: hs
	line-spacing: (* hs %line-spacing-factor%)
	space-before: (* hs %head-before-factor%)
	space-after: (if (node-list-empty? subtitles)
			 (* hs %head-after-factor%)
			 0pt)
	start-indent: (if (or (>= hlevel 3)
			      (member (gi) (list (normalize "refsynopsisdiv") 
						 (normalize "refsect1") 
						 (normalize "refsect2") 
						 (normalize "refsect3"))))
			  %body-start-indent%
			  0pt)
	first-line-start-indent: 0pt
	quadding: %section-title-quadding%
	keep-with-next?: #t
	heading-level: (if %generate-heading-level% hlevel 0)
	;; SimpleSects are never AUTO numbered...they aren't hierarchical
	(if (string=? (element-label (current-node)) "")
	    (empty-sosofo)
	    (literal (element-label (current-node)) 
		     (gentext-label-title-sep (gi sect))))
	(element-title-sosofo (current-node))
	($TAGID$ (current-node))
      )
      (with-mode section-title-mode
	(process-node-list subtitles))
      ($proc-section-info$ info))))



(element sidebar
  (make display-group
    space-before: %block-sep%
    (make box
      ;display?: #t
      ;break-after: 'page
      box-type: 'border
      line-thickness: 1pt
      start-indent: (- (inherited-start-indent) 20pt)
      end-indent: (inherited-end-indent)
      (if (node-list-empty? (select-elements (children (current-node))
                                             (normalize "title")))
          (make display-group
            start-indent: 2pt
            end-indent: 2pt
            space-before: %block-sep%
            space-after: %block-sep%
            (process-children))
          (make display-group
            start-indent: 2pt
            end-indent: 2pt
            space-before: 0pt
            space-after: %block-sep%
            (make sequence
              (let* ((object (current-node))
                     (title  (select-elements (children object)
                                              (normalize "title")))
                     (nsep   (gentext-label-title-sep (gi object))))
                (make paragraph
                  font-weight: 'bold
                  space-before: %block-sep%
                  space-after: %para-sep%
                  keep-with-next?: #t
                  (literal (gentext-element-name object))
                  (if (string=? (element-label object) "")
                      (literal nsep)
                      (literal " " (element-label object) nsep))
                  (process-node-list (children title))))
              (process-children))))))
)


;;;;

;; This is used by the wrapper and attribute inclusion functions to determine what are valid tokens in attribute tags.
(define (valid-token? token)
	(if (or
				(equal? token "&&")
				(equal? token "&")
				(equal? token "||")
				(equal? token "|"))
		#t
		#f))

;; Make this smaller so that it condenses the document a bit.
(define %block-sep%
 %para-sep%)

;; Customize this so that it doesn't print conditional attribute sections in the TOC which don't pass the inclusion test.
;; Build a TOC starting at nd reaching down depth levels.
;; The optional arguments are used on recursive calls to build-toc
;; and shouldn't be set by the initial caller...
;;
(define (build-toc nd depth #!optional (first? #t) (level 1))
  (let* ((toclist (toc-list-filter
                   (node-list-filter-by-gi (children nd)
                                           (append (division-element-list)
                                                   (component-element-list)
                                                   (section-element-list))))))
        (if (or (<= depth 0)
                (node-list-empty? toclist))
            (empty-sosofo)
            (make sequence
              (toc-title first?)
              (let loop ((nl toclist))
                (if (node-list-empty? nl)
                    (empty-sosofo)
	            (if (include-attributes? (node-list-first nl))
                        (sosofo-append
                          ($toc-entry$ (node-list-first nl) level)
                          (build-toc (node-list-first nl) (- depth 1) #f (+ level 1))
                          (loop (node-list-rest nl)))
			(loop (node-list-rest nl)))
))))))

; We can't generate the list of tables because a table could be embedded in a conditional section which doesn't pass the inclusion test and it'd be to hard to determine if any ancestor didn't pass.
(define ($generate-book-lot-list$)
  ;; REFENTRY generate-book-lot-list
  ;; PURP Which Lists of Titles should be produced for Books?
  ;; DESC               
  ;; This parameter should be a list (possibly empty) of the elements
  ;; for which Lists of Titles should be produced for each 'Book'.
  ;;                
  ;; It is meaningless to put elements that do not have titles in this
  ;; list.  If elements with optional titles are placed in this list, only
  ;; the instances of those elements that do have titles will appear in
  ;; the LOT.
  ;;
  ;; /DESC
  ;; AUTHOR N/A
  ;; /REFENTRY
(list (normalize "figure") (normalize "table")))

;; Build a LOT starting at nd for all the lotgi's it contains.
;; The optional arguments are used on recursive calls to build-toc
;; and shouldn't be set by the initial caller...
;;
(define (build-lot nd lotgi #!optional (first? #t))
  (let* ((lotlist (select-elements (descendants nd)
                                   (normalize lotgi))))
    (if (node-list-empty? lotlist)
        (empty-sosofo)
        (make sequence
          (lot-title first? lotgi)
          (let loop ((nl lotlist))
            (if (node-list-empty? nl)
                (empty-sosofo)
		(if (parents-include-attributes? (node-list-first nl))
                    (make sequence
                      (if (string=? (gi (node-list-first nl)) lotgi)
                          ($lot-entry$ (node-list-first nl))
                          (empty-sosofo))
                      (build-lot (node-list-first nl) lotgi #f)
                      (loop (node-list-rest nl)))
		    (loop (node-list-rest nl)))
))))))


;; We have to override the entire book element to fix a bug in the LOT looping.
(element book
  (let* ((bookinfo  (select-elements (children (current-node))
                                     (normalize "bookinfo")))
         (dedication (select-elements (children (current-node))
                                      (normalize "dedication")))
         (nl        (titlepage-info-elements (current-node) bookinfo)))
    (make sequence
      (if %generate-book-titlepage%
          (make simple-page-sequence
            page-n-columns: %titlepage-n-columns%
            input-whitespace-treatment: 'collapse
            use: default-text-style
            (book-titlepage nl 'recto)
            (make display-group
              break-before: 'page
              (book-titlepage nl 'verso)))
          (empty-sosofo))

      (if (node-list-empty? dedication)
          (empty-sosofo)
          (with-mode dedication-page-mode
            (process-node-list dedication)))

      (if (not (generate-toc-in-front))
          (process-children)
          (empty-sosofo))

      (if %generate-book-toc%
          (make simple-page-sequence
            page-n-columns: %page-n-columns%
            page-number-format: ($page-number-format$ (normalize "toc"))
            use: default-text-style
            left-header:   ($left-header$ (normalize "toc"))
            center-header: ($center-header$ (normalize "toc"))
            right-header:  ($right-header$ (normalize "toc"))
            left-footer:   ($left-footer$ (normalize "toc"))
            center-footer: ($center-footer$ (normalize "toc"))
            right-footer:  ($right-footer$ (normalize "toc"))
            input-whitespace-treatment: 'collapse
            (build-toc (current-node)
                       (toc-depth (current-node))))
          (empty-sosofo))

      (let loop ((gilist ($generate-book-lot-list$)))
        (if (null? gilist)
            (empty-sosofo)
            (if (not (node-list-empty?
                      (select-elements (descendants (current-node))
                                       (car gilist))))
                (make simple-page-sequence
                  page-n-columns: %page-n-columns%
                  page-number-format: ($page-number-format$ (normalize "lot"))
                  use: default-text-style
                  left-header:   ($left-header$ (normalize "lot"))
                  center-header: ($center-header$ (normalize "lot"))
                  right-header:  ($right-header$ (normalize "lot"))
                  left-footer:   ($left-footer$ (normalize "lot"))
                  center-footer: ($center-footer$ (normalize "lot"))
                  right-footer:  ($right-footer$ (normalize "lot"))
                  input-whitespace-treatment: 'collapse
                  (build-lot (current-node) (car gilist))
                  (loop (cdr gilist)))
                (loop (cdr gilist)))))

      (if (generate-toc-in-front)
          (process-children)
          (empty-sosofo)))))

; Overridden to add table-part-omit-middle-header to table-part
(element tgroup
  (let ((frame-attribute (if (inherited-attribute-string (normalize "frame"))
                             (inherited-attribute-string (normalize "frame"))
                             ($cals-frame-default$))))
    (make table
      ;; These values are used for the outer edges (well, the top, bottom
      ;; and left edges for sure; I think the right edge actually comes
      ;; from the cells in the last column
      before-row-border:  (if (cond
                               ((equal? frame-attribute (normalize "all")) #t)
                               ((equal? frame-attribute (normalize "sides")) #f)
                               ((equal? frame-attribute (normalize "top")) #t)
                               ((equal? frame-attribute (normalize "bottom")) #f)
                               ((equal? frame-attribute (normalize "topbot")) #t)
                               ((equal? frame-attribute (normalize "none")) #f)
                               (else #f))
                              calc-table-before-row-border
                              #f)
      after-row-border:   (if (cond
                               ((equal? frame-attribute (normalize "all")) #t)
                               ((equal? frame-attribute (normalize "sides")) #f)
                               ((equal? frame-attribute (normalize "top")) #f)
                               ((equal? frame-attribute (normalize "bottom")) #t)
                               ((equal? frame-attribute (normalize "topbot")) #t)
                               ((equal? frame-attribute (normalize "none")) #f)
                               (else #f))
                              calc-table-after-row-border
                              #f)
      before-column-border: (if (cond
                                 ((equal? frame-attribute (normalize "all")) #t)
                                 ((equal? frame-attribute (normalize "sides")) #t)
                                 ((equal? frame-attribute (normalize "top")) #f)
                                 ((equal? frame-attribute (normalize "bottom")) #f)
                                 ((equal? frame-attribute (normalize "topbot")) #f)
                                 ((equal? frame-attribute (normalize "none")) #f)
                                 (else #f))
                                calc-table-before-column-border
                                #f)
      after-column-border:  (if (cond
                                 ((equal? frame-attribute (normalize "all")) #t)
                                 ((equal? frame-attribute (normalize "sides")) #t)
                                 ((equal? frame-attribute (normalize "top")) #f)
                                 ((equal? frame-attribute (normalize "bottom")) #f)
                                 ((equal? frame-attribute (normalize "topbot")) #f)
                                 ((equal? frame-attribute (normalize "none")) #f)
                                 (else #f))
                                calc-table-after-column-border
                                #f)
      display-alignment: %cals-display-align%
      (make table-part
        table-part-omit-middle-header?: #t
        table-part-omit-middle-footer?: #t
        content-map: '((thead header)
                       (tbody #f)
                       (tfoot footer))
        ($process-colspecs$ (current-node))
        (process-children)
        (make-table-endnotes)))))

; Override so that we don't have big para-sep in space-after if the para is in a note.
(define ($paragraph$)
  (if (or (equal? (print-backend) 'tex)
          (equal? (print-backend) #f))
      ;; avoid using country: characteristic because of a JadeTeX bug...
      (make paragraph
        first-line-start-indent: (if (is-first-para)
                                     %para-indent-firstpara%
                                     %para-indent%)
        space-before: %para-sep%
	; If the paragraph is in a list or the child of a note element don't space-after
        space-after: (if (or (INLIST?)
			     (match-element? '(note) (parent (current-node))))
                         0pt
			 ; If the paragraph has a last child and it is a table, then don't space-after.
			 (let *((lastchild (node-list-last (children (current-node)))))
			       (if (and (not (node-list-empty? lastchild))
				        (match-element? '(table) lastchild))
				   0pt
				   %para-sep%)
			     ))
        quadding: %default-quadding%
        hyphenate?: %hyphenation%
        language: (dsssl-language-code)
        (process-children-trim))
      (make paragraph
        first-line-start-indent: (if (is-first-para)
                                     %para-indent-firstpara%
                                     %para-indent%)
        space-before: %para-sep%
        space-after: (if (INLIST?)
                         0pt
                         %para-sep%)
        quadding: %default-quadding%
        hyphenate?: %hyphenation%
        language: (dsssl-language-code)
        country: (dsssl-country-code)
        (process-children-trim))))

; Override in order to keep: 'page
(define ($verbatim-display$ indent line-numbers?)
  (let* ((width-in-chars (if (attribute-string (normalize "width"))
                             (string->number (attribute-string (normalize "width")))
                             %verbatim-default-width%))
         (fsize (lambda () (if (or (attribute-string (normalize "width"))
                                   (not %verbatim-size-factor%))
                               (/ (/ (- %text-width% (inherited-start-indent))
                                     width-in-chars)
                                  0.7)
                               (* (inherited-font-size)
                                  %verbatim-size-factor%))))
         (vspace-before (if (INBLOCK?)
                            0pt
                            (if (INLIST?)
                                %para-sep%
                                %block-sep%)))
         (vspace-after (if (INBLOCK?)
                           0pt
                           (if (INLIST?)
                               0pt
                               %block-sep%))))
    (make paragraph
      use: verbatim-style
      keep-with-previous?: #t
      keep-with-next?: #t
      keep: 'page
      space-before: (if (and (string=? (gi (parent)) (normalize "entry"))
                             (absolute-first-sibling?))
                        0pt
                        vspace-before)
      space-after:  (if (and (string=? (gi (parent)) (normalize "entry"))
                             (absolute-last-sibling?))
                        0pt
                        vspace-after)
      font-size: (fsize)
      line-spacing: (* (fsize) %line-spacing-factor%)
      start-indent: (if (INBLOCK?)
                        (inherited-start-indent)
                        (+ %block-start-indent% (inherited-start-indent)))
      (if (or indent line-numbers?)
          ($linespecific-line-by-line$ indent line-numbers?)
          (process-children)))))

</style-specification-body>
</style-specification>

<external-specification id="html-stylesheet" document="html-ss">
<external-specification id="print-stylesheet" document="print-ss">
</style-sheet>
