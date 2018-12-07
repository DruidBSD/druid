#!/bin/sh
#
# $Header: /cvsroot/druidbsd/druidbsd/druid/src/freebsd/repos/9.0-RELEASE/local/install.sh,v 1.1 2012/01/28 07:00:05 devinteske Exp $
#

if [ "`id -u`" != "0" ]; then
	echo "Sorry, this must be done as root."
	exit 1
fi
cat local.?? | tar --unlink -xpzf - -C ${DESTDIR:-/}
exit 0
