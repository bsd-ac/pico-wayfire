VERSION ?=	9999

DESTDIR ?=

PREFIX ?=	/usr
BINDIR ?=	$(PREFIX)/bin
LIBDIR ?= 	$(PREFIX)/lib
LIBEXECDIR ?=	$(PREFIX)/libexec/pico-de
DATADIR ?=	$(PREFIX)/share/pico-de

INSTALL ?=	install
CP ?=		cp -a

SUBDIRS ?=	mako nwg-launchers oguri pico-icons swappy \
		terminator waybar wayfire

.PHONY: all install install-data install-dirs install-libexec \
	install-pc install-setup

install: install-libexec install-data install-dirs install-pc install-setup

install-dirs:
	$(INSTALL) -d $(DESTDIR)$(BINDIR)
	$(INSTALL) -d $(DESTDIR)$(LIBDIR)/pkgconfig
	$(INSTALL) -d $(DESTDIR)$(LIBEXECDIR)
	$(INSTALL) -d $(DESTDIR)$(DATADIR)

install-data: install-dirs
	$(CP) $(SUBDIRS) default_wallpaper $(DESTDIR)$(DATADIR)

install-pc: install-dirs
	sed -e "s/@PREFIX@/$(PREFIX)/" \
	    -e "s/@BINDIR@/$(BINDIR)/" \
	    -e "s/@LIBDIR@/$(LIBDIR)/" \
	    -e "s/@LIBEXECDIR@/$(LIBEXECDIR)/" \
	    -e "s/@DATADIR@/$(DATADIR)/" \
	    -e "s/@VERSION@/$(VERSION)/" \
	    pico-de.pc.in > pico-de.pc
	$(INSTALL) -m644 pico-de.pc -t $(DESTDIR)$(LIBDIR)/pkgconfig

install-setup: install-dirs
	$(INSTALL) -m755 pico-de-setup -t $(DESTDIR)$(BINDIR)

install-libexec: install-dirs
	$(INSTALL) -m755 scripts/* -t $(DESTDIR)$(LIBEXEC)