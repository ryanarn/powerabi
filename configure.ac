#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

# Unfortunately we can't use PACKAGE_VERSION because the 32-bit and 64-bit
# documents will have different versions.
AC_INIT(powerabi, 0.0.0, rsa@us.ibm.com)
AC_CONFIG_SRCDIR([PPC-elf32abi.sgml])

PPC32_ABI_VERSION=1.1
PPC64_ABI_VERSION=0.9

bitness=
AC_ARG_WITH([bitness],
	    AS_HELP_STRING([--with-bitness],
			   [Use this option to indicate the bitness of the ABI you will be building.  The allowed options are '32' and '64'.  The default is to generate a 32-bit document.  @<:@Default=32@:>@.]),
	    [dnl
  case "$with_bitness" in
    64)
      bitness="$with_bitness"
      ;;
    32|*)
      bitness="32"
  esac
  
  AC_MSG_NOTICE([configuring ${bitness}-bit document])],
	    [bitness=32])
AC_SUBST(bitness)

version=
if test "$bitness" = "32"; then
	version=${PPC32_ABI_VERSION}
else
	version=${PPC64_ABI_VERSION}
fi
AC_MSG_NOTICE([${bitness}-bit document will be ABI version ${version}.])
AC_SUBST(version)

release_msg=
AC_ARG_WITH([release],
	    AS_HELP_STRING([--with-release],
			   [Include if you want to build a RELEASE version of the document.  It will not have 'DRAFT' on section titles.  The default is to have 'DRAFT' appear throughout the document.  @<:@Default=no@:>@.]),
	    [dnl
  case "$with_release" in
  yes)
    release="yes"
    release_msg="release"
    ;;
  no|*)
    release="no"
    release_msg="DRAFT"
    ;;
  esac],
	    [dnl
  release="no"
  release_msg="DRAFT"])

AC_MSG_NOTICE([configuring as a ${release_msg} document.])
AC_SUBST(release)

AC_ARG_WITH([attributes],
	    AS_HELP_STRING([--with-attributes],
			   [@<:@Default=yes@:>@.]),
	    [dnl
  case "$with_attributes" in
  no)
    attributes="no"
    ;;
  yes|*)
    attributes="yes"
    ;;
  esac],
	    [dnl
  attributes=yes])

AC_MSG_NOTICE([configuring document to be generated with attribute wrappers.])
AC_SUBST(attributes)

AC_ARG_WITH([tags],
	    AS_HELP_STRING([--with-tags],
			   [Display element ID tags for use during document revision/writing.@<:@Default=no@:>@.]),
	    [dnl
  case "$with_tags" in
  yes)
    tags="yes"
    AC_MSG_NOTICE([configuring document to be generated with element ID tags.])
    ;;
  no|*)
    tags="no"
    ;;
  esac],
	    [dnl
  tags=no])
AC_SUBST(tags)



publish=
AC_ARG_WITH([publish],
	    AS_HELP_STRING([--with-publish],
			  [Use this option to indicate that the document is to have the publish date marked.  The allowed options are 'yes' and 'no'.  The default is 'no', which will leave the publish date blank.]),
	    [dnl
  case "$with_publish" in
  yes)
    publish="yes"
    ;;
  no|*)
    publish="no"
    ;;
  esac],
	    [publish=no])

if test "$publish" = "no"; then
    AC_MSG_NOTICE([Excluding the publish date on the generated ABI documents.])
else
    AC_MSG_NOTICE([Including the publish date on the generated ABI documents.])
fi

AC_SUBST(publish)

linuxabi=""
AC_ARG_WITH([linux],
            AC_HELP_STRING([--with-linux],
                             [Generate the Linux ABI document.@<:@Default=no@:>@]),
	    [dnl
  case "$with_linux" in
  yes)
    linuxabi="linux"
    AC_MSG_NOTICE([Generating the Linux ABI document.])
    ;;
  no|*)
    linuxabi=""
    ;;
  esac],
	    [linuxabi=""])
AC_SUBST(linuxabi)

embeddedabi=""
AC_ARG_WITH([embedded],
            AC_HELP_STRING([--with-embedded],
                             [Generate the Embedded ABI document.@<:@Default=no@:>@]),
	    [dnl
  case "$with_embedded" in
  yes)
    embeddedabi="embedded"
    AC_MSG_NOTICE([Generating the Embedded ABI document.])
    ;;
  no|*)
    embeddedabi=""
    ;;
  esac],
	    [embeddedabi=""])
AC_SUBST(embeddedabi)

unifiedabi=
AC_ARG_WITH([unified],
            AC_HELP_STRING([--with-unified],
                             [Generate the Unified ABI document.@<:@Default=yes@:>@]),
	    [dnl
  case "$with_unified" in
  no)
    unifiedabi=
    ;;
  yes|*)
    unifiedabi="unified"
    ;;
  esac],
	    [unifiedabi="unified"])
AC_SUBST(unifiedabi)

if test "$unifiedabi" = "unified"; then
    AC_MSG_NOTICE([Generating the Unified ABI document.])
fi



AC_CONFIG_FILES([Makefile])

AC_OUTPUT
