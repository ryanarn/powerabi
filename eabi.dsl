; Global variable which holds the information about attribute selection for a particular abi style sheet.
(define *attributes* '(("ATR-LINUX" . #f)
                       ("ATR-EABI" . #t)
                       ("ATR-EABI-EXTENDED" . #t)
                       ("ATR-VECTOR" . #f)
                       ("ATR-VRSAVE-BOOL" . #f)
                       ("ATR-VRSAVE-MASK" . #f)
                       ("ATR-VECTOR-SCALAR" . #f)
                       ("ATR-SPE" . #t)
                       ("ATR-VLE" . #t)
                       ("ATR-CXX" . #f)
                       ("ATR-CLASSIC-FLOAT" . #t)
                       ("ATR-SOFT-FLOAT" . #t)
                       ("ATR-LONG-DOUBLE-IBM" . #f)
                       ("ATR-LONG-DOUBLE-IS-DOUBLE" . #t)
                       ("ATR-DFP" . #f)
                       ("ATR-BSS-PLT" . #t)
                       ("ATR-SECURE-PLT" . #f)
                       ("ATR-TLS" . #f)
                       ("ATR-PASS-COMPLEX-AS-STRUCT" . #t)
                       ("ATR-PASS-COMPLEX-IN-GPRS" . #t)
                       ))

; Anything not in this list defaults to #t which helps catch erroneous attribute tags.
(define *wrapit* '(("ATR-LINUX" . #f) ; This covers !ATR-LINUX
                   ("ATR-EABI" . #f)
                   ))

