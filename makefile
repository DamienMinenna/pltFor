**SHELL	= /bin/sh
MAKE	= make

FC= gfortran 

FCFLAGS= -O3

MAIN = example.f90

compil_options = pltFor.f90

PATH_LIBPYTHON = /PLEASE_FIND_THE_PATH_TO_THIS_FILE/libpython3.7m.dylib

DIR= -L./lib -lpltFor-0.2 $(PATH_LIBPYTHON)

all : $(MAIN)  
	$(FC) $(FCFLAGS) $(DIR) $(compil_options) $(MAIN)

plotFortran.o	: pltFor.f90
	$(FC) $(FCFLAGS) $(DIR) -c pltFor.f90 -o pltFor.o

.PHONY: clean

clean:
	rm -f *.o *.mod
