#!/bin/bash

help_output()
{
	cat <<EOF
  Invocation:

	`basename $0` [--wrapper] [--draft] [--linux] [--eabi] [--unified] [--tagid]

  Options:

	Note: None of the following options are mutually exclusive.

	--wrapper)
		This directive tells the stylesheet engine to include the attribute
		tags in the generated output.  This is useful during writing and
		reviewing of the document.  This applies to all further options
		selected.

	--draft)
		This directive tells the stylesheet engine to include 'DRAFT' on page
		and titles and other important areas of the document.  This applies to
		all further options selected.

	--linux)
		This directive tells the stylesheet engine to assemble the Linux
		ABI document.

	--eabi)
		This directive tells the stylesheet engine to assemble the Embedded
		ABI document.

	--unified)
		This directive tells the stylesheet engine to assemble the Embedded
		ABI and Linux ABI into a single unified document.

	--tagid)
		This directive tells the stylesheet engine to append SGML id elements
		to the header names (sections, titles, tables, etc.).  This is used
		during document creation and editing to create easy reference points.

	e.g.
		./`basename $0` --linux --wrapper --unified

	results in the generation of:
		2008-09-03-Unified-PPC-elf32abi.pdf
		2008-09-03-Linux-PPC-elf32abi.pdf
EOF
}

if [ $# -eq 0 ]; then
	help_output;
	exit 0;
fi

for switch in "$@"; do
	case $switch in
		--h*|-h*)
			help_output
			exit 0;
			;;
		--wrapper|-wrapper)
			wrapper="yes"
			;;
		--draft|-draft)
			draft="yes"
			;;
		--linux|-linux|--linuxabi|-linuxabi)
			linux="yes"
			;;
		--eabi|-eabi)
			eabi="yes"
			;;
		--unified|-unified|--unifiedabi|-unifiedabi)
			unified="yes"
			;;
		--tag*|-tag*)
			tagid="yes"
			;;
	esac
done

if test ! -e colordef.dsl; then
	wget "http://www.cranesoftwrights.com/resources/color/colordef.dsl" -O colordef.dsl
fi

#DATE=`date +%Y-%m-%d`
VERSION=`grep "entity specversion" PPC-elf32abi.sgml | awk -F' ' '{print $3}' |  sed 's/\"\([0-9]*.[0-9]*\)\">/\1/'`

if test ! -z "$unified"; then
	echo jw -b pdf PPC-elf32abi.sgml -d 'abi.dsl#print' --nochunks  -i UNIFIED${draft:+ -i DRAFT}${wrapper:+ -i WRAPPER}${tagid:+ -i TAGID}
	jw -b pdf PPC-elf32abi.sgml -d 'abi.dsl#print' --nochunks  -i UNIFIED${draft:+ -i DRAFT}${wrapper:+ -i WRAPPER}${tagid:+ -i TAGID}
	if test -e "PPC-elf32abi.pdf"; then
		mv PPC-elf32abi.pdf ${DATE:${DATE}-}${draft:+Draft-}Power-Arch-32-bit-ABI-supp-${VERSION}-Unified.pdf
	fi
fi

if test ! -z "$linux"; then
	jw -b pdf PPC-elf32abi.sgml -d 'abi.dsl#print' --nochunks -i LINUX${draft:+ -i DRAFT}${wrapper:+ -i WRAPPER}${tagid:+ -i TAGID}
	if test -e "PPC-elf32abi.pdf"; then
		mv PPC-elf32abi.pdf ${DATE:${DATE}-}${draft:+Draft-}Power-Arch-32-bit-ABI-supp-${VERSION}-Linux.pdf
	fi
fi

if test ! -z "$eabi"; then
	jw -b pdf PPC-elf32abi.sgml -d 'abi.dsl#print' --nochunks -i EABI${draft:+ -i DRAFT}${wrapper:+ -i WRAPPER}${tagid:+ -i TAGID}
	if test -e "PPC-elf32abi.pdf"; then
		mv PPC-elf32abi.pdf ${DATE:${DATE}-}${draft:+Draft-}Power-Arch-32-bit-ABI-supp-${VERSION}-Embedded.pdf
	fi
fi
