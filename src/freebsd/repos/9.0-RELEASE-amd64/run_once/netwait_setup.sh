#!/bin/sh
# -*- tab-width:  4 -*- ;; Emacs
# vi: set tabstop=4     :: Vi/ViM

# If running as xarchInstall, only use binaries in `/stand'
[ "$xarchInstall" ] && export PATH=/stand
############################################################ CONFIGURATION

# Indicate that we want color output
ANSI_COLOR=YES

# Pathnames
RC_CONF=/etc/rc.conf

############################################################ FUNCTIONS

# Include standard functions
. /dist/druid/etc/sh.subr

############################################################ MAIN SOURCE

task_begin "Configuring netwait..."
eval_spin << END_SPIN

# Introduce a delay if configured
[ "$HUMAN_DELAY" ] && sleep $HUMAN_DELAY

# Enable netwait at boot-time
cat >> $RC_CONF << EOF
netwait_enable="YES"
EOF

# XXX keep the below work-around which accounts for a bug in sh(1) XXX
cat >> /dev/null << EOF
EOF

END_SPIN
task_end $?

################################################################################
# END
################################################################################
#
# $Header: /cvsroot/druidbsd/druidbsd/druid/src/freebsd/repos/9.0-RELEASE-amd64/run_once/netwait_setup.sh,v 1.1 2012/01/28 07:01:33 devinteske Exp $
#
# $Copyright: 2006-2012 Devin Teske. All rights reserved. $
#
# $Log: netwait_setup.sh,v $
# Revision 1.1  2012/01/28 07:01:33  devinteske
# Commit initial public beta release (beta 56)
#
#
################################################################################