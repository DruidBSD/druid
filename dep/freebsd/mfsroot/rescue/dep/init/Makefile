# -*- tab-width:  4 -*- ;; Emacs
# vi: set tabstop=4     :: Vi/ViM
############################################### Compiler 

# do not change anything in this section

CC           = cc
PROG         = init

LDFLAGS      = -O -pipe -g -static
INCLUDE      = -I.
CFLAGS       = -Wall -O -pipe $(INCLUDE)

SHELL        = /bin/sh
RM           = /bin/rm
STRIP        = /usr/bin/strip

############################################### Custom

# Objects to compile in this folder on `make all'
OBJS   = main.o

############################################### Rules

# no need to change anything below

noargs: all

all: $(PROG)

.o:
	$(CC) $(CFLAGS) $(<)

$(PROG): $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $(PROG)
	$(STRIP) -s $(PROG)

clean:
	$(RM) -f *.o
	$(RM) -f *.core

distclean: clean
	$(RM) -f $(PROG)

################################################################################
# END
################################################################################
#
# $Header: /cvsroot/druidbsd/druidbsd/druid/dep/freebsd/mfsroot/rescue/dep/init/Makefile,v 1.1 2012/01/28 06:59:34 devinteske Exp $
#
# $Copyright: 2006-2012 Devin Teske. All rights reserved. $
#
# $Log: Makefile,v $
# Revision 1.1  2012/01/28 06:59:34  devinteske
# Commit initial public beta release (beta 56)
#
#
################################################################################
