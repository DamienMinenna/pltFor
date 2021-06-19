# pltFor

**pltFor** (reads "plot for") is a Fortran-Python interface library to plot figures directly in Fortran. Here an example:

```fortran
program plot_cosx

  use, intrinsic :: iso_fortran_env
  use pltFor ! load pltFor module
  implicit none
  real(real64), dimension(6) :: x = (/ 1., 2., 3., 4., 5., 6. /)
  
  call plt_plot(x, cos(x), 'Title', 'xlabel', 'ylabel', 'plot.jpg')

end program plot_cosx
```

* Advantages:
  * Easy to use, easy to install.
  * Open source and modifiable.
  * Do not require to write output files to be read by external languages.
  * Do not generate external files, aside the wanted figures.
  * Performed during the Fortran execution.
  * The same approach can be used to run Python script modifying the Fortran variables (the memory is shared between Fortran and Python).

* Drawbacks:
  * Do not save the variables. Therefore, to re-plot the figures, we need to run again the Fortran code.
  * Exotic plot options, such as advanced multiplot or adding annotations, are not taken into account.

**How it work?** The plot functions are written within a Python3 Matplotlib script. With the Python package CFFI, our script is used to generate a shared library with a C-style binding interface. Finally, the library is linked to the Fortran code with a classical C-Fortran interface.

***

## User guide

A more complete user guide will be available soon. 


### Available subroutines

#### Quick plot
x and y must be 1D array in double precision (you can force the conversion with *real(x,8)*). 
```Fortran
call plt_plot(x, y, 'Title', 'xlabel', 'ylabel', 'plot.jpg')
```

#### Advanced plot
x and y must be 1D array in double precision (you can force the conversion with *real(x,8)*). 
```Fortran
call plt_plot_adv(x, & ! Argument x (1D array float64)
                  y, & ! Argument y (1D array float64)
                  'steelblue', & ! color. Ex: b g r c m y k w grey, brown, ivory, teal, royalblue, orchid
                  'P', & ! marker. Ex: None . , o v ^ < > 1 2 3 4 8 s p P * h H + x X D d | _ 
                  'dashdot', & ! linestyle. Ex: solid dotted dashed dashdot
                  3.d0, & ! linewidth (float64)
                  12.d0, & ! markersize (float64)
                  'Title', & ! title. Leave '' for none
                  'xlabel', & ! xlabel. Leave '' for none
                  'ylabel', & ! ylabel. Leave '' for none
                  'plot.jpg') ! filename to save. MUST end with a valid format (.png, .pdf, ...)
```

#### Advanced multiplot
x and y must be 2D array in double precision organized as x(n, m) with n the number of point for a given plot and m the plot index. x and y must be the same size.
```Fortran
call plt_multiplot(mat_X(:,0:3), & ! Argument x (2D array float64 organized as (data, plot)). All the plots must have the same size
                   mat_Y(:,0:3), & ! Argument y (2D array float64 organized as (data, plot)). All the plots must have the same size
                   'steelblue; coral; lime', & ! color. Use ; as separator. Ex: b g r c m y k w grey, brown, ivory, teal, royalblue, orchid
                   '^; ,; d', & ! marker. Use ; as separator. Ex: None . , o v ^ < > 1 2 3 4 8 s p P * h H + x X D d | _ 
                   'dashdot; solid; dashed', & ! linestyle. Use ; as separator. Ex: solid dotted dashed dashdot
                   (/ 3.d0, 1.d0, 2.d0 /), & ! linewidth (float64)
                   (/ 12.d0, 15.d0, 5.d0 /), & ! markersize (float64)
                   'Title: plt_multiplot', & ! title. Leave '' for none
                   'xlabel', & ! xlabel. Leave '' for none
                   'ylabel', & ! ylabel. Leave '' for none
                   'Figs/plt_multiplot.jpg') ! filename to save. MUST end with a valid format (.png, .pdf, ...)
```


#### Scatter
x, y, s and c must be 1D array in double precision (you can force the conversion with *real(x,8)*). 
```Fortran
call plt_scatter_full(x, & ! Argument x (1D array float64)
                      y, & ! Argument y (1D array float64)
                      s, & ! Argument surface area (1D array float64)
                      c, & ! Argument color (1D array float64)
                      1.d0, & ! alpha (float64) between 0 (transparent) and 1 (opaque).
                      'hsv', & ! cmap. Ex: viridis, plasma, inferno, magma, cividis, PuRd, YlGn, spring, hot, tab20c, ...
                      'H', & ! marker. Ex: None . , o v ^ < > 1 2 3 4 8 s p P * h H + x X D d | _ 
                      'Title', & ! title. Leave '' for none
                      'xlabel', & ! xlabel. Leave '' for none
                      'ylabel', & ! ylabel. Leave '' for none
                      'cmaplabel', & ! cmaplabel. Leave '' for none
                      'plot.jpg') ! filename to save. MUST end with a valid format (.png, .pdf, ...)
```

***

## Installation

Go to the folder *lib* and run the `INSTALL` file or execute
```python
python3 pltFor_builder.py
```

This will create a shared library called `libpltFor-0.2.so` (or .dylib for MacOS). (Tips: you can move this file).

Then, add the `pltFor.f90` module to your code folder. The module must be refered in your fortran code as
```fortran
use pltFor
```
Finally, when compiling the module, you must add the path of `libpltFor-0.2.so` (generated above) and the path of `libpython3.7m.so` (for python3.7). This last library should be in the main python directory. (Tips: The path can appear during the execution of `pltFor_builder.py`).
```shell
gfortran path/libpltFor-0.2.so path/libpython3.7m.so -c pltFor.f90 -o pltFor.o
```

## Installation example

An example is provided with the `example.f90` program. To compile it, you can use the `makefile` file. Modify the Python path **PATH_LIBPYTHON** that include `libpython3.7m.so`. 
Then execute it and run the code
```shell
make
./a.out
```

***

### Installation errors

* If the message `error while loading shared libraries` occurs, you must find the `path` to this library and execute:
  ```shell
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path
  export LD_LIBRARY_PATH
  ```

* For MacOS user, if the message `dyld: Library not loaded: * Reason: image not found` occurs, you must find the `path` to this library and execute:
  ```shell
  DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/path
  export DYLD_LIBRARY_PATH
  ```

* If the message `distutils.errors.LinkError: command 'x86_64-apple-darwin13.4.0-clang' failed with exit status 254` occurs, execute:
  ```shell
  export CC=/usr/bin/clang
  export CXX=/usr/bin/clang++
  ```

* For MacOS users, if the message `library not found for -lSystem`occurs, execute
  ```shell
  sudo xcode-select --install
  ````
  then add `-L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem` to the compilation statement

* Anaconda user of MacOS Big Sur, please update Anaconda
  ```shell
  conda update --all   
  ```

***

## Notes

**pltFor** is still in developpment. It is planned to improve the installation and to dedicate its proper folder in usr/lib. 

The library builder is inspired from a [Noah Brenowitz's post](https://www.noahbrenowitz.com/post/calling-fortran-from-python/)


## Contributing

Pull requests on the git project are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
