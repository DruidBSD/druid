PROG=	menu
MAN=

BINDIR=/repos/vicor-fbs/bin
NO_SHARED=YES
NOSHARED=YES

SRCS=	dmenu.c globals.c keymap.c main.c menus.c makedevs.c misc.c \
	msg.c system.c install.c termcap.c variable.c keymap.h

CFLAGS+= -I/usr/src/gnu/lib/libdialog -I.
CFLAGS+= -Wall
.if ${MACHINE} == "pc98"
CFLAGS+= -DPC98
.endif

DPADD=	${LIBDIALOG} ${LIBNCURSES}
LDADD=	-ldialog -lncurses

CLEANFILES=	makedevs.c rtermcap
CLEANFILES+=	keymap.tmp keymap.h

makedevs.c:	Makefile rtermcap
	echo '#include <sys/types.h>' > makedevs.c
	./rtermcap ansi | \
		file2c 'const char termcap_ansi[] = {' ',0};' \
		>> makedevs.c
	./rtermcap cons25w | \
		file2c 'const char termcap_cons25w[] = {' ',0};' \
		>> makedevs.c
	./rtermcap cons25 | \
		file2c 'const char termcap_cons25[] = {' ',0};' \
		>> makedevs.c
	./rtermcap cons25-m | \
		file2c 'const char termcap_cons25_m[] = {' ',0};' \
		>> makedevs.c
	./rtermcap cons25r | \
		file2c 'const char termcap_cons25r[] = {' ',0};' \
		>> makedevs.c
	./rtermcap cons25r-m | \
		file2c 'const char termcap_cons25r_m[] = {' ',0};' \
		>> makedevs.c
	./rtermcap cons25l1 | \
		file2c 'const char termcap_cons25l1[] = {' ',0};' \
		>> makedevs.c
	./rtermcap cons25l1-m | \
		file2c 'const char termcap_cons25l1_m[] = {' ',0};' \
		>> makedevs.c
	./rtermcap vt100 | \
		file2c 'const char termcap_vt100[] = {' ',0};' \
		>> makedevs.c
	./rtermcap xterm | \
		file2c 'const char termcap_xterm[] = {' ',0};' \
		>> makedevs.c

build-tools:	rtermcap

rtermcap:	rtermcap.c
	${CC} -o ${.TARGET} ${.ALLSRC} -ltermcap

.if ${MACHINE} == "pc98"
KEYMAPS= jp.pc98 jp.pc98.iso
.else
KEYMAPS= be.iso bg.bds.ctrlcaps bg.phonetic.ctrlcaps br275.cp850 br275.iso \
	cs.latin2.qwertz danish.cp865 danish.iso estonian.iso \
	estonian.iso15 estonian.cp850 finnish.cp850 finnish.iso fr.iso \
	fr.iso.acc german.cp850 german.iso hr.iso hu.iso2.101keys \
	hu.iso2.102keys it.iso icelandic.iso icelandic.iso.acc jp.106 \
	lat-amer norwegian.iso pt.iso pt.iso.acc ru.koi8-r si.iso spanish.iso \
	spanish.iso.acc swedish.cp850 swedish.iso swissfrench.cp850 \
	swissfrench.iso swissgerman.cp850 swissgerman.iso swissgerman.iso.acc \
	ua.koi8-u ua.koi8-u.shift.alt uk.cp850 uk.iso us.dvorak us.emacs \
	us.iso us.pc-ctrl us.unix
.endif

keymap.h:
	rm -f keymap.tmp
	for map in ${KEYMAPS} ; do \
		KEYMAP_PATH=${.CURDIR}/../../share/syscons/keymaps \
			kbdcontrol -L $$map | \
			sed -e '/^static accentmap_t/,$$d' >> keymap.tmp ; \
	done
	echo "static struct keymapInfo keymapInfos[] = {" >> keymap.tmp
	for map in ${KEYMAPS} ; do \
		echo -n '	{ "'$$map'", ' >> keymap.tmp ; \
		echo "&keymap_$$map }," | tr '[-.]' '_' >> keymap.tmp ; \
	done
	( echo "	{ 0 }"; echo "};" ; echo "" ) >> keymap.tmp
	mv keymap.tmp keymap.h

beforeinstall:
	@if [ ! -d ${BINDIR}/ ]; then \
		mkdir -p ${BINDIR}; \
	fi

.include <bsd.prog.mk>
