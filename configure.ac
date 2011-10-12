#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

# Autoconf 2.59 required because recursively configured 'libdecnumber' library
# has a hard-coded 2.59 requirement and Libdfp doesn't really care, but can't
# control libdecnumber.
AC_INIT(powerabi, 0.0.1, rsa@us.ibm.com)
AC_CONFIG_SRCDIR([PPC-elf32abi.sgml])

with_release=
AC_ARG_WITH([release],
	    AS_HELP_STRING([--with-release],
			   [Include if you want to build a RELEASE version of the document.  It will not have 'DRAFT' on section titles.  The default is to have 'DRAFT' appear throughout the document.  @<:@Default=no@:>@.]),
	    [with_release=$withval],
	    [with_release=no])
AC_SUBST(with_release)

AC_ARG_ENABLE([docs],
              AC_HELP_STRING([--enable-docs@<:@=DOCS...@:>@],
                             [Generated documents DOC1,DOC2,DOC3 from list 'linux', 'eabi', 'unified' .@<:@Default=unified@:>@]),
                             , [enable_docs=unified])

