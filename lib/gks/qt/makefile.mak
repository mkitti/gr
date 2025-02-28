UNAME := $(shell uname)
TMP_QMAKE ?= $(shell which qmake 2>/dev/null || which qmake6 2>/dev/null || which qmake-qt5 2>/dev/null || which qmake-qt4 2>/dev/null || echo '')
ifneq ($(QT4_QMAKE),)
ifneq ($(QT4_QMAKE),false)
  TMP_QMAKE := $(QT4_QMAKE)
endif
endif
ifneq ($(QT5_QMAKE),)
ifneq ($(QT5_QMAKE),false)
  TMP_QMAKE := $(QT5_QMAKE)
endif
endif
ifneq ($(QT6_QMAKE),)
ifneq ($(QT6_QMAKE),false)
  TMP_QMAKE := $(QT6_QMAKE)
endif
endif
QMAKE ?= $(TMP_QMAKE)

QMakefile:
	@if [ "$(QMAKE)" != "" ]; then $(QMAKE) -o QMakefile; fi

default: QMakefile
	@if [ "$(QMAKE)" != "" ]; then $(MAKE) -f QMakefile; fi

install: default
ifeq ($(UNAME), Darwin)
	@if [ ! -d $(DESTDIR)$(GRDIR)/Applications ]; then \
	mkdir -m 755 $(DESTDIR)$(GRDIR)/Applications; fi
	@ditto gksqt.app \
	$(DESTDIR)$(GRDIR)/Applications/gksqt.app
else
	cp -p gksqt $(DESTDIR)$(GRDIR)/bin
endif

clean:
	@if [ -f QMakefile ]; then make -f QMakefile distclean; \
	rm -f QMakefile; fi
	@if [ -f Makefile ]; then make distclean; fi

.PHONY: default install clean
