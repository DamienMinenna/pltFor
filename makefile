**SHELL	= /bin/sh
MAKE	= make

FC= gfortran 

FCFLAGS= -O3

MAIN = example.f90

compil_options = pltFor.f90

PATH_LIBPYTHON = /Users/damien/opt/anaconda3/lib

DIR= -L./lib -lpltFor-0.2 $(PATH_LIBPYTHON)/libpython3.7m.dylib $(PATH_LIBPYTHON)/libc++.1.dylib -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem

all : $(MAIN)  
	$(FC) $(FCFLAGS) $(DIR) $(compil_options) $(MAIN)

plotFortran.o	: pltFor.f90
	$(FC) $(FCFLAGS) $(DIR) -c pltFor.f90 -o pltFor.o

.PHONY: clean

clean:
	rm -f *.o *.mod
