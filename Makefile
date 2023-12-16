CC:=cc
CFLAGS:=-march=native -O2 -Wcast-qual -Wbad-function-cast -Wshadow -Wwrite-strings -Wnested-externs -Winline -Wredundant-decls -Waggregate-return -Wformat=2 -Wpointer-arith -Wconversion -Wmissing-declarations -Wmissing-prototypes -w -fPIC --std=c17 -pipe
LDFLAGS=-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now
DESTDIR:=/usr/local
MANDIR:=/usr/share/man/man1
INSTALL:=install
PROG:=paxctl
RM:=rm

all:
	$(CC) $(CFLAGS) -c $(PROG).c
	$(CC) $(CFLAGS) $(PROG).o -o $(PROG)

install: $(PROG)
	$(INSTALL) -d -o 0 -g 0 -m 755 $(DESTDIR)/sbin
	$(INSTALL) -o 0 -g 0 -m 555 $(PROG) $(DESTDIR)/sbin/$(PROG)
	$(INSTALL) -o 0 -g 0 -m 444 $(PROG).1 $(MANDIR)/$(PROG).1

clean:
	$(RM) -f $(PROG) $(PROG).o core
