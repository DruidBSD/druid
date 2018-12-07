#!/bin/sh
# -*- tab-width:  4 -*- ;; Emacs
# vi: set tabstop=4     :: Vi/ViM

# If running as xarchInstall, only use binaries in `/stand'
[ "$xarchInstall" ] && export PATH=/stand
############################################################ CONFIGURATION

# Indicate that we want color output
ANSI_COLOR=YES

############################################################ FUNCTIONS

# Include standard functions
. /dist/druid/etc/sh.subr

############################################################ MAIN SOURCE

task_begin "Performing cleanup routines..."
eval_spin << END_SPIN

# Introduce a delay if configured
[ "$HUMAN_DELAY" ] && sleep $HUMAN_DELAY

sleep 1 # placeholder

END_SPIN
task_end $?

################################################################################
# END
################################################################################
#
# $Header: /cvsroot/druidbsd/druidbsd/druid/src/freebsd/repos/9.0-RELEASE-amd64/run_once/cleanup.sh,v 1.1 2012/01/28 07:01:33 devinteske Exp $
#
# $Copyright: 2006-2012 Devin Teske. All rights reserved. $
#
# $Log: cleanup.sh,v $
# Revision 1.1  2012/01/28 07:01:33  devinteske
# Commit initial public beta release (beta 56)
#
#
################################################################################
