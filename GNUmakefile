# vim: ft=make ts=8 sts=2 sw=2 noet

PREFIX         ?= /usr/local
BINDIR         ?= $(PREFIX)/bin
MANDIR         ?= $(PREFIX)/share/man
MAN1DIR        ?= $(MANDIR)/man1

CRAMCMD         = cram

GZIPCMD        ?= gzip
INSTALL_DATA   ?= install -m 644
INSTALL_DIR    ?= install -m 755 -d
INSTALL_SCRIPT ?= install -m 755
RST2HTML       ?= $(call first_in_path,rst2html.py rst2html)

SHELL           = $(call first_in_path,zsh)

name            = git-mailz

installed       = $(name).1.gz $(name)
artifacts       = $(installed) README.html PKGBUILD $(name).spec

sources         = $(name).zsh

revname         = $(shell git describe --always --first-parent)

ALL_INCLUSIVE  ?= 0

.DEFAULT_GOAL  := $(if $(subst 0,,$(ALL_INCLUSIVE)),all,most)

.PHONY: all
all: $(artifacts)

.PHONY: most
most: $(installed)

.PHONY: clean
clean:
	$(RM) $(artifacts)

.PHONY: check
check: $(.DEFAULT_GOAL)
	env -i CRAM="$(CRAM)" PATH="$$PATH:$$PWD/t:$$PWD" SHELL="$(SHELL)" $(CRAMCMD) --shell=tsh t

.PHONY: html
html: README.html

.PHONY: install
install: $(installed)
	$(INSTALL_DIR) $(DESTDIR)$(BINDIR)
	$(INSTALL_DIR) $(DESTDIR)$(MAN1DIR)
	$(INSTALL_SCRIPT) $(name) $(DESTDIR)$(BINDIR)/$(name)
	$(INSTALL_DATA) $(name).1.gz $(DESTDIR)$(MAN1DIR)/$(name).1.gz

.PHONY: tarball
tarball: .git
	git archive \
	  --format tar.gz \
	  --prefix $(name)-$(fix_version)/ \
	  --output $(name)-$(fix_version).tar.gz \
	  HEAD
%.gz: %
	$(GZIPCMD) -cn $< | tee $@ >/dev/null

%.1: m/%.1
	$(INSTALL_DATA) $< $@

%.html: %.rest
	$(RST2HTML) --strict $< $@

$(name): s/$(name).zsh
	$(INSTALL_SCRIPT) $< $@

$(name).spec: p/$(name).spec.in
	$(call subst_version,^Version:)

PKGBUILD: p/PKGBUILD.in
	$(call subst_version,^pkgver=)

define subst_version
	sed -e "/$(1)/s/__VERSION__/$(fix_version)/" \
	    $< | tee $@ >/dev/null
endef

fix_version = $(subst -,+,$(patsubst v%,%,$(revname)))

define first_in_path
$(or \
  $(firstword $(wildcard \
    $(foreach p,$(1),$(addsuffix /$(p),$(subst :, ,$(PATH)))) \
  )) \
, $(error Need one of: $(1)) \
)
endef

