#!/bin/sh
# -*- tab-width:  4 -*- ;; Emacs
# vi: set tabstop=4     :: Vi/ViM
############################################################ COPYRIGHT
#
# (c)2011. Devin Teske. All Rights Reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
############################################################ GLOBALS

#
# Global exit status variables
#
SUCCESS=0
FAILURE=1

#
# Program name
#
progname="${0##*/}"

#
# OS Glue
#
UNAME_S=$( uname -s )

############################################################ FUNCTIONS

# have $anything
#
# A wrapper to the `type' built-in. Returns true if argument is a valid shell
# built-in, keyword, or externally-tracked binary, otherwise false.
#
have()
{
	type "$@" > /dev/null 2>&1
}

# fprintf $fd $fmt [ $opts ... ]
#
# Like printf, except allows you to print to a specific file-descriptor. Useful
# for printing to stderr (fd=2) or some other known file-descriptor.
#
fprintf()
{
	local fd=$1
	[ $# -gt 1 ] || return $FAILURE
	shift 1
	printf "$@" >&$fd
}

# eprintf $fmt [ $opts ... ]
#
# Print a message to stderr (fd=2).
#
eprintf()
{
	fprintf 2 "$@"
}

# die [ $fmt [ $opts ... ]]
#
# Optionally print a message to stderr before exiting with failure status.
#
die()
{
	local fmt="$1"
	[ $# -gt 0 ] && shift 1
	[  "$fmt"  ] && eprintf "$fmt\n" "$@"

	exit $FAILURE
}

# usage
#
# Prints a short syntax statement and exits.
#
usage()
{
	local argfmt1="\t%s\n" argfmt2="\t\t%s\n"
	local optfmt="\t%-6s%s\n"
	local exfmt="\t%s\n"

	eprintf "Usage: %s [OPTIONS] mount_point\n" "$progname"

	eprintf "ARGUMENTS:\n"
	eprintf "$argfmt1" "mount_point"
	eprintf "$argfmt2" \
	        "Directory to unmount (e.g., \`/mnt'). [Required]"
	eprintf "\n"

	eprintf "OPTIONS:\n"
	eprintf "$optfmt" "-h" \
	        "Print this message to stderr and exit."
	eprintf "\n"

	eprintf "EXAMPLE:\n"
	eprintf "$exfmt" \
	        "./$progname /mnt"
	eprintf "\n"

	die
}

# eval2 $cmd ...
#
# Print a command to stdout before executing it.
#
eval2()
{
	echo "$*"
	eval "$@"
}

############################################################ MAIN SOURCE

[ $# -eq 1 ] || usage

MOUNTDIR="$1"

#
# Perform sanity checks
#
[ -e "$MOUNTDIR" ] || die "%s:%s: No such file or directory." \
	"$progname" "$MOUNTDIR"
[ -d "$MOUNTDIR" ] || die "%s:%s: Not a directory." \
	"$progname" "$MOUNTDIR"

echo "Un-Mounting Directory: $MOUNTDIR"
echo ""
case "$UNAME_S" in
FreeBSD)
	cmd=
	if have mdconfig; then
		cmd="mdconfig -d -u 99"
	elif have vnconfig; then
		cmd="vnconfig -u vn99c"
	fi

	n=
	[ "$cmd" ] && n=1

	printf "Command$n: "
	eval2 umount "$MOUNTDIR" || die

	if [ "$cmd" ]; then
		n=$(( $n + 1 ))
		printf "Command$n: "
		eval2 $cmd || die
	fi
	;;
*)
	printf "Command: "
	eval2 umount "$MOUNTDIR" || die
esac
echo "done."

################################################################################
# END
################################################################################
#
# $Header: /cvsroot/druidbsd/druidbsd/druid/src/tools/umount_iso.sh,v 1.2 2012/07/06 01:15:25 devinteske Exp $
#
# $Copyright: 2006-2012 Devin Teske. All rights reserved. $
#
# $Log: umount_iso.sh,v $
# Revision 1.2  2012/07/06 01:15:25  devinteske
# Fix copyright and remove old log entries.
#
# Revision 1.1  2012/01/28 07:01:43  devinteske
# Commit initial public beta release (beta 56)
#
#
################################################################################
