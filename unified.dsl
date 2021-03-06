; Global variable which holds the information about attribute selection for a particular abi style sheet.
(define *attributes* '(("ATR-LINUX" . #t)
                      ("ATR-EABI" . #t)
                      ("ATR-EABI-EXTENDED" . #t)
                      ("ATR-VECTOR" . #t)
                      ("ATR-SPE" . #t)
                      ("ATR-VLE" . #t)
                      ("ATR-CLASSIC-FLOAT" . #t)
                      ("ATR-SOFT-FLOAT" . #t)
                      ("ATR-LONG-DOUBLE-IBM" . #t)
                      ("ATR-LONG-DOUBLE-IS-DOUBLE" . #t)
                      ("ATR-DFP" . #t)
                      ("ATR-BSS-PLT" . #t)
                      ("ATR-SECURE-PLT" . #t)
                      ("ATR-PASS-COMPLEX-AS-STRUCT" . #t)
                      ("ATR-PASS-COMPLEX-IN-GPRS" . #t)
                      ))

; don't need to define *wrapit* because they're all true.
;(define *wrapit* '(("ATR-LINUX" . #t)
;                   ("ATR-EABI" . #t)
;                   ("ATR-EABI-EXTENDED" . #t)
;                   ("ATR-VECTOR" . #t)
;                   ("ATR-SPE" . #t)
;                   ("ATR-VLE" . #t)
;                   ("ATR-CLASSIC-FLOAT" . #t)
;                   ("ATR-SOFT-FLOAT" . #t)
;                   ("ATR-LONG-DOUBLE-IBM" . #t)
;                   ("ATR-LONG-DOUBLE-IS-DOUBLE" . #t)
;                   ("ATR-DFP" . #t)
;                   ("ATR-BSS-PLT" . #t)
;                   ("ATR-SECURE-PLT" . #t)
;                   ("ATR-PASS-COMPLEX-AS-STRUCT" . #t)
;                   ("ATR-PASS-COMPLEX-IN-GPRS" . #t)
;                   ))
