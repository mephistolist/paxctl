# paxctl
Converted paxctl to work on BSD.

1. - What it is

This is paxctl for BSD environments. This software can control PaX flags on a per binary basis. PaX is an intrusion prevention system that provides the best protection mechanisms against memory corruption bugs. Some applications are not compatible with certain features (due to design or bad engineering) and therefore they have to be exempted from certain enforcements. It is also possible to use PaX in soft mode where none of the protection mechanisms are active by default - here paxctl can be used to turn them on for selected programs (e.g., network daemons, programs that process network data such as mail clients, web browsers, etc).

PaX and paxctl work on ELF executables, both of the standard ET_EXEC and the newer ET_DYN kind (older PaX releases referred to the latter as ET_DYN executables, these days they are called Position Independent Executables or PIEs for short).

2. - Installation

Simply issue 'make' then 'make install'. If the defaults do not suit your needs, change them in the Makefile.

3. - References
     
PaX - http://pax.grsecurity.net
Paxctl-on-BSD - https://github.com/mephistolist/paxctl-on-BSD

4. - Usage

Considerning you have a binary named 'hello' you can run the following to enable seeing what flags are set:
```
paxctl -c ./hello
```
After which we can view that nothing is currently set on this new binary:
```
paxctl -v ./hello
PaX control v0.9
Copyright 2004,2005,2006,2007,2009,2010,2011,2012,2014 PaX Team <pageexec@freemail.hu>

- PaX flags: -------x-e-- [./hello]
	RANDEXEC is disabled
	EMUTRAMP is disabled
```
The following sets all possible flags:
```
paxctl -PEMRXS ./hello
```
After which we can confirm are now set:
```
paxctl -v ./hello
PaX control v0.9
Copyright 2004,2005,2006,2007,2009,2010,2011,2012,2014 PaX Team <pageexec@freemail.hu>

- PaX flags: P-S-M-X-E-R- [./hello]
	PAGEEXEC is enabled
	SEGMEXEC is enabled
	MPROTECT is enabled
	RANDEXEC is enabled
	EMUTRAMP is enabled
	RANDMMAP is enabled
```
A description of all options can be used with -h:
```
paxctl -h
PaX control v0.9
Copyright 2004,2005,2006,2007,2009,2010,2011,2012,2014 PaX Team <pageexec@freemail.hu>

usage: paxctl <options> <files>

options:
	-p: disable PAGEEXEC		-P: enable PAGEEXEC
	-e: disable EMUTRAMP		-E: enable EMUTRAMP
	-m: disable MPROTECT		-M: enable MPROTECT
	-r: disable RANDMMAP		-R: enable RANDMMAP
	-x: disable RANDEXEC		-X: enable RANDEXEC
	-s: disable SEGMEXEC		-S: enable SEGMEXEC

	-v: view flags			-z: restore default flags
	-q: suppress error messages	-Q: report flags in short format
	-c: convert PT_GNU_STACK into PT_PAX_FLAGS (see manpage!)
	-C: create PT_PAX_FLAGS (see manpage!)
```
