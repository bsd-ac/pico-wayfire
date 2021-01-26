VERSION ?=	9999

DESTDIR ?=

PREFIX ?=	/usr
BINDIR ?=	$(PREFIX)/bin
DATADIR ?=	$(PREFIX)/share/pico-wayfire
MANDIR ?=	$(PREFIX)/share/man/man1

INSTALL ?=	install
CP ?=		cp -a

SUBDIRS ?=	gtk mako nwg-launchers pico-icons swappy \
		terminator waybar wayfire

.PHONY:	all clean install

all: pico-wayfire-setup

pico-wayfire-setup: pico-wayfire-setup.in
	sed -e "s:@DATADIR@:$(DATADIR):" \
	    -e "s:@VERSION@:$(VERSION):" \
	    pico-wayfire-setup.in > pico-wayfire-setup

install: all
	$(INSTALL) -d $(DESTDIR)$(BINDIR)
	$(INSTALL) -d $(DESTDIR)$(DATADIR)
	$(INSTALL) -d $(DESTDIR)$(MANDIR)
	$(CP) $(SUBDIRS) wallpaper.jpeg $(DESTDIR)$(DATADIR)
	$(INSTALL) -m644 man1/pico-wayfire.1 $(DESTDIR)$(MANDIR)
	ln -sf pico-wayfire.1 $(DESTDIR)$(MANDIR)/pico-wayfire-setup.1
	$(INSTALL) -m755 pico-wayfire-setup -t $(DESTDIR)$(BINDIR)

clean:
	rm -f pico-wayfire-setup
