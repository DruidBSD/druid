/* vim: ts=4
 */

#include "sysinstall.h"
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <machine/console.h>

struct keymapInfo {
    const char *name;
    const struct keymap *map;
};

#include "keymap.h"

/*
 * keymap.h is being automatically generated by the Makefile.  It
 * contains definitions for all desired keymaps.  Note that since we
 * don't support font loading nor screen mapping during installation,
 * we simply don't care for any other keys than the ASCII subset.
 *
 * Therefore, if no keymap with the exact name has been found in the
 * first pass, we make a second pass over the table looking just for
 * the language name only.
 */

/*
 * Return values:
 *
 *  0: OK
 * -1: no appropriate keymap found
 * -2: error installing map (other than ENXIO which means we're not on syscons)
 */

int
loadKeymap(const char *lang)
{
    int passno, err;
    char *llang;
    size_t l;
    struct keymapInfo *kip;

    llang = strdup(lang);
    if (llang == NULL)
	abort();

    for (passno = 0; passno < 2; passno++)
    {
	if (passno > 0) 
	{
	    /* make the match more fuzzy */
	    l = strspn(llang, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789");
	    llang[l] = '\0';
	}

	l = strlen(llang);

	for (kip = keymapInfos; kip->name; kip++)
	    if (strncmp(kip->name, llang, l) == 0)
	    {
		/* Yep, got it! */
		err = ioctl(0, PIO_KEYMAP, kip->map);
		free(llang);
		return (err == -1 && errno != ENOTTY)? -2: 0;
	    }
    }
    free(llang);
    return -1;
}
