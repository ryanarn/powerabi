; Global variable which holds the information about attribute selection for a particular abi style sheet.
(define *attributes* '(("ATR-LINUX" . #t)
                      ("ATR-EABI" . #f)
                      ("ATR-EABI-EXTENDED" . #f)
                      ("ATR-VECTOR" . #t)
                      ("ATR-SPE" . #t)
                      ("ATR-VLE" . #f)
                      ("ATR-CXX" . #t)
                      ("ATR-CLASSIC-FLOAT" . #t)
                      ("ATR-SOFT-FLOAT" . #t)
                      ("ATR-LONG-DOUBLE-IBM" . #t)
                      ("ATR-LONG-DOUBLE-IS-DOUBLE" . #t)
                      ("ATR-DFP" . #t)
                      ("ATR-BSS-PLT" . #t)
                      ("ATR-SECURE-PLT" . #t)
                      ("ATR-TLS" . #t)
                      ("ATR-PASS-COMPLEX-AS-STRUCT" . #f)
                      ("ATR-PASS-COMPLEX-IN-GPRS" . #t)
                      ))

; Anything not in this list defaults to #t which helps catch erroneous attribute tags.
(define *wrapit* '(("ATR-LINUX" . #f)
                   ("ATR-EABI" . #f) ; This covers !ATR-EABI
                   ))

