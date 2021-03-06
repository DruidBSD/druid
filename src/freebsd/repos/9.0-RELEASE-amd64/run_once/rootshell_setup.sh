#!/bin/sh
# -*- tab-width:  4 -*- ;; Emacs
# vi: set tabstop=4     :: Vi/ViM

# If running as xarchInstall, only use binaries in `/stand'
[ "$xarchInstall" ] && export PATH=/stand
############################################################ CONFIGURATION

# Indicate that we want color output
ANSI_COLOR=YES

shell=/usr/local/sbin/host-setup

############################################################ FUNCTIONS

# Include standard functions
. /dist/druid/etc/sh.subr

############################################################ MAIN SOURCE

task_begin "Setting root-login shell to \`$shell'..."
eval_spin << END_SPIN

# Introduce a delay if configured
[ "$HUMAN_DELAY" ] && sleep $HUMAN_DELAY

chmod go-wrx "$shell"
chsh -s "$shell" > /dev/null 2>&1

END_SPIN
task_end $?

################################################################################
# END
################################################################################
#
# $Header: /cvsroot/druidbsd/druidbsd/druid/src/freebsd/repos/9.0-RELEASE-amd64/run_once/rootshell_setup.sh,v 1.1 2012/01/28 07:01:33 devinteske Exp $
#
# $Copyright: 2006-2012 Devin Teske. All rights reserved. $
#
# $Log: rootshell_setup.sh,v $
# Revision 1.1  2012/01/28 07:01:33  devinteske
# Commit initial public beta release (beta 56)
#
#
################################################################################
