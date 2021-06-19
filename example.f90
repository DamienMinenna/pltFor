!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!
!!    Program MAIN.f90
!!
!!    Test for pltFor
!!
!!    Author: Damien Minenna
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
program example_pltFor
  use, intrinsic :: iso_c_binding
  use, intrinsic :: iso_fortran_env, only: dp => real64, i32 => int32

  use pltFor ! Module pltFor

  implicit none
  
  real(dp), dimension(10) :: x
  real(dp), dimension(10) :: y

  real(dp), dimension(10) :: s
  real(dp), dimension(10) :: c

  real(dp), dimension(10,3) :: mat_X
  real(dp), dimension(10,3) :: mat_Y

  print *, 'Start example.f90'

  ! Arbitrary arrays
  x = (/ 1.d0, 2.d0, 3.d0, 4.d0, 5.d0, 6.d0, 7.d0, 8.d0, 9.d0, 10.d0 /)
  y = cos(x)

  s = 4.d0 * x**2
  c = x

  ! Quick plot
  call plt_plot(x, y, 'Title: plt_plot', 'xlabel', 'ylabel', 'Figs/plt_plot.jpg')

  ! Advanced plot
  call plt_plot_adv(x, & ! Argument x (1D array float64)
                    y, & ! Argument y (1D array float64)
                    'steelblue', & ! color. Ex: b g r c m y k w grey, brown, ivory, teal, royalblue, orchid
                    'P', & ! marker. Ex: None . , o v ^ < > 1 2 3 4 8 s p P * h H + x X D d | _ 
                    'dashdot', & ! linestyle. Ex: solid dotted dashed dashdot
                    3.d0, & ! linewidth (float64)
                    12.d0, & ! markersize (float64)
                    'Title: plt_plot_adv', & ! title. Leave '' for none
                    'xlabel', & ! xlabel. Leave '' for none
                    'ylabel', & ! ylabel. Leave '' for none
                    'Figs/plt_plot_adv.jpg') ! filename to save. MUST end with a valid format (.png, .pdf, ...)

  ! Arbitrary 2D arrays
  mat_X(:,1) = x
  mat_X(:,2) = x + 0.5d0
  mat_X(:,3) = x - 0.5d0

  mat_Y(:,1) = cos(x)
  mat_Y(:,2) = cos(mat_X(:,2))
  mat_Y(:,3) = sin(x)

  ! Advanced multiple plot
  call plt_multiplot(mat_X, & ! Argument x (2D array float64 organized as (data, plot)). All the plots must have the same size
                     mat_Y, & ! Argument y (2D array float64 organized as (data, plot)). All the plots must have the same size
                     'steelblue; coral; lime', & ! color. Use ; as separator. Ex: b g r c m y k w grey, brown, ivory, teal, royalblue, orchid
                     '^; ,; d', & ! marker. Use ; as separator. Ex: None . , o v ^ < > 1 2 3 4 8 s p P * h H + x X D d | _ 
                     'dashdot; solid; dashed', & ! linestyle. Use ; as separator. Ex: solid dotted dashed dashdot
                     (/ 3.d0, 1.d0, 2.d0 /), & ! linewidth (float64)
                     (/ 12.d0, 15.d0, 5.d0 /), & ! markersize (float64)
                     'Title: plt_multiplot', & ! title. Leave '' for none
                     'xlabel', & ! xlabel. Leave '' for none
                     'ylabel', & ! ylabel. Leave '' for none
                     'Figs/plt_multiplot.jpg') ! filename to save. MUST end with a valid format (.png, .pdf, ...)

  ! Scatter
  call plt_scatter_full(x, & ! Argument x (1D array float64)
                        y, & ! Argument y (1D array float64)
                        s, & ! Argument surface area (1D array float64)
                        c, & ! Argument color (1D array float64)
                        1.d0, & ! alpha (float64) between 0 (transparent) and 1 (opaque).
                        'hsv', & ! cmap. Ex: viridis, plasma, inferno, magma, cividis, PuRd, YlGn, spring, hot, tab20c, ...
                        'H', & ! marker. Ex: None . , o v ^ < > 1 2 3 4 8 s p P * h H + x X D d | _ 
                        'Title: plt_scatter_full', & ! title. Leave '' for none
                        'xlabel', & ! xlabel. Leave '' for none
                        'ylabel', & ! ylabel. Leave '' for none
                        'cmaplabel', & ! cmaplabel. Leave '' for none
                        'Figs/plt_scatter.jpg') ! filename to save. MUST end with a valid format (.png, .pdf, ...)

  print *, 'End example.f90'

end program example_pltFor
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
