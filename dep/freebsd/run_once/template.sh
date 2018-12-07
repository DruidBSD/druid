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

task_begin "Some task..."
eval_spin << END_SPIN

# commands to be executed

END_SPIN
task_end $?

################################################################################
# END
################################################################################
#
# $Header: /cvsroot/druidbsd/druidbsd/druid/dep/freebsd/run_once/template.sh,v 1.1 2012/01/28 06:59:47 devinteske Exp $
#
# $Copyright: 2006-2012 Devin Teske. All rights reserved. $
#
# $Log: template.sh,v $
# Revision 1.1  2012/01/28 06:59:47  devinteske
# Commit initial public beta release (beta 56)
#
#
################################################################################
