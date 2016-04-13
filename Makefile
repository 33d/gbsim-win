# My directory; see http://stackoverflow.com/q/322936
TOP := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
STAGE ?= $(TOP)/stage

LIBELF_SRC := $(wildcard $(TOP)/libelf-*)
LIBPTHREADS_W32_SRC := $(wildcard $(TOP)/pthreads-w32-*)

LIBELF_A := $(STAGE)/lib/libelf.a
LIBPTHREAD_W32_A := $(STAGE)/lib/libpthreadGC1.a
LIBSDL2_A := $(STAGE)/lib/libSDL2.a

export STAGE V

gbsim: $(LIBELF_A)  $(LIBSDL2_A)
	$(MAKE) -C gbsim -f Makefile.mingw build-gbsim

$(LIBSDL2_A): $(STAGE)
	cp -r $(TOP)/SDL2-2.0.3/i686-w64-mingw32/* $(STAGE)
	# see http://stackoverflow.com/a/22600114
	cp $(TOP)/SDL_platform.h.fix $(STAGE)/include/SDL2/SDL_platform.h

$(LIBELF_A): $(STAGE)
	cd $(LIBELF_SRC) ; ./configure --prefix=$(STAGE)
	$(MAKE) -C $(LIBELF_SRC) install

$(STAGE):
	mkdir -p $(STAGE)

clean:
	$(MAKE) -C $(LIBELF_SRC) clean
	$(MAKE) -C gbsim -f Makefile.mingw clean
	-rm -Rf $(STAGE)

.PHONY: gbsim clean
