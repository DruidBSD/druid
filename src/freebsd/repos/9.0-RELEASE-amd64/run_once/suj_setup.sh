#!/bin/sh
# -*- tab-width:  4 -*- ;; Emacs
# vi: set tabstop=4     :: Vi/ViM

# If running as xarchInstall, only use binaries in `/stand'
[ "$xarchInstall" ] && export PATH=/stand
############################################################ CONFIGURATION

# Indicate that we want color output
ANSI_COLOR=YES

# Standard Pathnames
POST_INSTALL_SH1=/etc/rc.d/suj_enable
POST_INSTALL_SH2=/usr/local/etc/rc.d/suj_enable_cleanup.sh

############################################################ FUNCTIONS

# Include standard functions
. /dist/druid/etc/sh.subr

############################################################ MAIN SOURCE

task_begin "Enabling Soft-Updates Journaling..."
eval_spin << END_SPIN

#
# Create a mini boot-script to enable SoftUpdates Journaling
#
mkdir -p ${POST_INSTALL_SH1%/*}
cat > $POST_INSTALL_SH1 << EOF
#!/bin/sh
#
# PROVIDE: ${POST_INSTALL_SH1##*/}
# BEFORE: fsck
# KEYWORD: nojail
#
echo tunefs -j enable /var
     tunefs -j enable /var
echo tunefs -j enable /usr
     tunefs -j enable /usr
EOF

#
# Make it executable
#
chmod +x $POST_INSTALL_SH1

#
# Create another mini boot-script to delete first boot-script
#
mkdir -p ${POST_INSTALL_SH2%/*}
cat > $POST_INSTALL_SH2 << EOF
#!/bin/sh
rm -f $POST_INSTALL_SH1
rm -f $POST_INSTALL_SH2
EOF

#
# Make it executable
#
chmod +x $POST_INSTALL_SH2

# XXX keep the below work-around which accounts for a bug in sh(1) XXX
cat >> /dev/null << EOF
EOF

END_SPIN
task_end $?

################################################################################
# END
################################################################################
#
# $Header: /cvsroot/druidbsd/druidbsd/druid/src/freebsd/repos/9.0-RELEASE-amd64/run_once/suj_setup.sh,v 1.1 2012/01/28 07:01:34 devinteske Exp $
#
# $Copyright: 2006-2011 Devin Teske. All rights reserved. $
#
# $Log: suj_setup.sh,v $
# Revision 1.1  2012/01/28 07:01:34  devinteske
# Commit initial public beta release (beta 56)
#
#
################################################################################
