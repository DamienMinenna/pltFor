!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!
!!    Module pltFor
!!
!!    Function interfaces to plot fortran arrays with python
!!
!!    Author: Damien Minenna
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
MODULE pltFor
  USE, intrinsic :: iso_c_binding
  USE, intrinsic :: iso_fortran_env
  IMPLICIT NONE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  INTERFACE
    SUBROUTINE pltfor_plot(x_c, y_c, size_xy, str_title, str_xlabel, &
                        str_ylabel, str_file, len_title, len_xlabel, &
                        len_ylabel, len_file) BIND (c)

        USE, intrinsic :: iso_c_binding

        INTEGER(c_int) :: size_xy
        INTEGER(c_int) :: len_title 
        INTEGER(c_int) :: len_file 
        INTEGER(c_int) :: len_xlabel
        INTEGER(c_int) :: len_ylabel

        REAL(c_double) :: x_c(size_xy)
        REAL(c_double) :: y_c(size_xy)
        CHARACTER(KIND=c_char), DIMENSION(len_title) :: str_title
        CHARACTER(KIND=c_char), DIMENSION(len_xlabel) :: str_xlabel
        CHARACTER(KIND=c_char), DIMENSION(len_ylabel) :: str_ylabel
        CHARACTER(KIND=c_char), DIMENSION(len_file) :: str_file

    END SUBROUTINE pltfor_plot
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE pltfor_plot_adv(x_c, y_c, size_xy, str_color, str_marker, &
        str_linestyle, n_linewidth, n_markersize, str_title, str_xlabel, &
        str_ylabel, str_file, len_color, len_marker, len_linestyle, &
        len_title, len_file, len_xlabel, len_ylabel) BIND (c)

        USE, intrinsic :: iso_c_binding

        INTEGER(c_int) :: size_xy
        INTEGER(c_int) :: len_color
        INTEGER(c_int) :: len_marker 
        INTEGER(c_int) :: len_linestyle

        INTEGER(c_int) :: len_title 
        INTEGER(c_int) :: len_file 
        INTEGER(c_int) :: len_xlabel
        INTEGER(c_int) :: len_ylabel

        REAL(c_double) :: x_c(size_xy)
        REAL(c_double) :: y_c(size_xy)
        CHARACTER(KIND=c_char), DIMENSION(len_color) :: str_color
        CHARACTER(KIND=c_char), DIMENSION(len_marker) :: str_marker
        CHARACTER(KIND=c_char), DIMENSION(len_linestyle) :: str_linestyle
        REAL(c_double) :: n_linewidth
        REAL(c_double) :: n_markersize
        CHARACTER(KIND=c_char), DIMENSION(len_title) :: str_title
        CHARACTER(KIND=c_char), DIMENSION(len_xlabel) :: str_xlabel
        CHARACTER(KIND=c_char), DIMENSION(len_ylabel) :: str_ylabel
        CHARACTER(KIND=c_char), DIMENSION(len_file) :: str_file

    END SUBROUTINE pltfor_plot_adv
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE pltfor_multiplot(x_c, y_c, size_xy, num_plot, str_color, &
        str_marker, str_linestyle, n_linewidth, n_markersize, str_title, &
        str_xlabel, str_ylabel, str_file, len_color, len_marker, &
        len_linestyle, len_title, len_file, len_xlabel, len_ylabel) BIND (c)

        USE, intrinsic :: iso_c_binding

        INTEGER(c_int) :: size_xy
        INTEGER(c_int) :: num_plot 
        INTEGER(c_int) :: len_color
        INTEGER(c_int) :: len_marker 
        INTEGER(c_int) :: len_linestyle

        INTEGER(c_int) :: len_title 
        INTEGER(c_int) :: len_file 
        INTEGER(c_int) :: len_xlabel
        INTEGER(c_int) :: len_ylabel

        REAL(c_double) :: x_c(size_xy, num_plot)
        REAL(c_double) :: y_c(size_xy, num_plot)
        CHARACTER(KIND=c_char), DIMENSION(len_color) :: str_color
        CHARACTER(KIND=c_char), DIMENSION(len_marker) :: str_marker
        CHARACTER(KIND=c_char), DIMENSION(len_linestyle) :: str_linestyle
        REAL(c_double) :: n_linewidth(num_plot)
        REAL(c_double) :: n_markersize(num_plot)
        CHARACTER(KIND=c_char), DIMENSION(len_title) :: str_title
        CHARACTER(KIND=c_char), DIMENSION(len_xlabel) :: str_xlabel
        CHARACTER(KIND=c_char), DIMENSION(len_ylabel) :: str_ylabel
        CHARACTER(KIND=c_char), DIMENSION(len_file) :: str_file

    END SUBROUTINE pltfor_multiplot
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE pltfor_scatter_full(x_c, y_c, s_c, c_c, size_xy, n_alpha, &
                str_cmap, str_marker, str_title, str_xlabel, str_ylabel, &
                str_cmaplabel, str_file, len_cmap, len_marker, len_cmaplabel, &
                len_title, len_file, len_xlabel, len_ylabel) BIND (c)

        USE, intrinsic :: iso_c_binding

        INTEGER(c_int) :: size_xy
        INTEGER(c_int) :: len_cmap
        INTEGER(c_int) :: len_marker 
        INTEGER(c_int) :: len_cmaplabel

        INTEGER(c_int) :: len_title 
        INTEGER(c_int) :: len_file 
        INTEGER(c_int) :: len_xlabel
        INTEGER(c_int) :: len_ylabel

        REAL(c_double) :: x_c(size_xy)
        REAL(c_double) :: y_c(size_xy)
        REAL(c_double) :: s_c(size_xy)
        REAL(c_double) :: c_c(size_xy)
        REAL(c_double) :: n_alpha
        CHARACTER(KIND=c_char), DIMENSION(len_cmap) :: str_cmap
        CHARACTER(KIND=c_char), DIMENSION(len_marker) :: str_marker
        CHARACTER(KIND=c_char), DIMENSION(len_title) :: str_title
        CHARACTER(KIND=c_char), DIMENSION(len_xlabel) :: str_xlabel
        CHARACTER(KIND=c_char), DIMENSION(len_ylabel) :: str_ylabel
        CHARACTER(KIND=c_char), DIMENSION(len_cmaplabel) :: str_cmaplabel
        CHARACTER(KIND=c_char), DIMENSION(len_file) :: str_file

    END SUBROUTINE pltfor_scatter_full
  END INTERFACE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
CONTAINS
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE plt_plot(x, y, str_title, str_xlabel, str_ylabel, str_file)
    !! Quick plot plt.plot(x,y)

        USE, intrinsic :: iso_c_binding
        USE, intrinsic :: iso_fortran_env
        IMPLICIT NONE

        REAL(real64), DIMENSION(:), INTENT(IN) :: x
        REAL(real64), DIMENSION(:), INTENT(IN) :: y

        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_title
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_file
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_xlabel
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_ylabel

        REAL(c_double), DIMENSION(SIZE(x)) :: x_c
        REAL(c_double), DIMENSION(SIZE(y)) :: y_c
        INTEGER(c_int) :: size_xy 
        INTEGER(c_int) :: len_title 
        INTEGER(c_int) :: len_file 
        INTEGER(c_int) :: len_xlabel
        INTEGER(c_int) :: len_ylabel


        IF (SIZE(x) .NE. SIZE(y))then
            PRINT*, 'WARNING: array sizes not equal in plt_plot!'
        ELSE
            x_c(:) = x(:)
            y_c(:) = y(:)
            size_xy = SIZE(x)
            len_title = LEN(str_title)
            len_file = LEN(str_file)
            len_xlabel = LEN(str_xlabel)
            len_ylabel = LEN(str_ylabel)

            CALL pltfor_plot(x_c, y_c, size_xy, str_title, str_xlabel, &
                          str_ylabel, str_file, len_title, len_xlabel, &
                          len_ylabel, len_file)

        END IF
    END SUBROUTINE plt_plot
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE plt_plot_adv(x, y, str_color, str_marker, str_linestyle, &
        linewidth, markersize, str_title, str_xlabel, str_ylabel, str_file)
    !! Advanced plot plt.plot(x,y)

        USE, intrinsic :: iso_c_binding
        USE, intrinsic :: iso_fortran_env
        IMPLICIT NONE

        REAL(real64), DIMENSION(:), INTENT(IN) :: x
        REAL(real64), DIMENSION(:), INTENT(IN) :: y 
        REAL(real64), INTENT(IN) :: linewidth 
        REAL(real64), INTENT(IN) :: markersize 

        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_color
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_marker
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_linestyle
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_title
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_file
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_xlabel
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_ylabel

        REAL(c_double), DIMENSION(SIZE(x)) :: x_c
        REAL(c_double), DIMENSION(SIZE(y)) :: y_c
        INTEGER(c_int) :: size_xy 
        REAL(c_double) :: n_linewidth 
        REAL(c_double) :: n_markersize 
        INTEGER(c_int) :: len_color
        INTEGER(c_int) :: len_marker 
        INTEGER(c_int) :: len_linestyle

        INTEGER(c_int) :: len_title 
        INTEGER(c_int) :: len_file 
        INTEGER(c_int) :: len_xlabel
        INTEGER(c_int) :: len_ylabel

        IF (SIZE(x) .NE. SIZE(y))then
            PRINT*, 'WARNING: array sizes not equal in plt_plot_adv!'
        ELSE
            x_c(:) = x(:)
            y_c(:) = y(:)
            size_xy = SIZE(x)
            n_linewidth = linewidth
            n_markersize = markersize
            len_color = LEN(str_color)
            len_marker = LEN(str_marker)
            len_linestyle = LEN(str_linestyle)
            len_title = LEN(str_title)
            len_file = LEN(str_file)
            len_xlabel = LEN(str_xlabel)
            len_ylabel = LEN(str_ylabel)

            CALL pltfor_plot_adv(x_c, y_c, size_xy, str_color, str_marker, &
              str_linestyle, n_linewidth, n_markersize, str_title, str_xlabel, &
              str_ylabel, str_file, len_color, len_marker, len_linestyle, &
              len_title, len_file, len_xlabel, len_ylabel)

        END IF
    END SUBROUTINE plt_plot_adv
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE plt_multiplot(x, y, str_color, str_marker, str_linestyle, &
        linewidth, markersize, str_title, str_xlabel, str_ylabel, str_file)
    !! Advanced plot plt.plot(x,y)

        USE, intrinsic :: iso_c_binding
        USE, intrinsic :: iso_fortran_env
        IMPLICIT NONE
        INTEGER(int32) :: shapeOfx(2)
        INTEGER(int32) :: shapeOfy(2)

        REAL(real64), DIMENSION(:,:), INTENT(IN) :: x
        REAL(real64), DIMENSION(:,:), INTENT(IN) :: y 
        REAL(real64), DIMENSION(SIZE(x(1,:))), INTENT(IN) :: linewidth 
        REAL(real64), DIMENSION(SIZE(x(1,:))), INTENT(IN) :: markersize 

        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_color
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_marker
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_linestyle

        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_title
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_file
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_xlabel
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_ylabel

        REAL(c_double), DIMENSION(SIZE(x(:,1)), SIZE(x(1,:))) :: x_c
        REAL(c_double), DIMENSION(SIZE(y(:,1)), SIZE(y(1,:))) :: y_c
        INTEGER(c_int) :: size_xy 
        INTEGER(c_int) :: num_plot 
        REAL(c_double), DIMENSION(SIZE(x(1,:))) :: n_linewidth 
        REAL(c_double), DIMENSION(SIZE(x(1,:))) :: n_markersize 
        INTEGER(c_int) :: len_color
        INTEGER(c_int) :: len_marker 
        INTEGER(c_int) :: len_linestyle

        INTEGER(c_int) :: len_title 
        INTEGER(c_int) :: len_file 
        INTEGER(c_int) :: len_xlabel
        INTEGER(c_int) :: len_ylabel


        shapeOfx = SHAPE(x)
        shapeOfy = SHAPE(y)
        IF ((shapeOfx(1) .NE. shapeOfy(1)) .OR. (shapeOfx(2) .NE. shapeOfy(2)))then
            PRINT*, 'WARNING: array sizes not equal in plt_multiplot_adv!'
        ELSE

            x_c(:,:) = x(:,:)
            y_c(:,:) = y(:,:)
            size_xy = SIZE(x(:,1))
            num_plot = SIZE(x(1,:))

            n_linewidth(:) = linewidth(:)
            n_markersize(:) = markersize(:)

            len_color = LEN(str_color)
            len_marker = LEN(str_marker)
            len_linestyle = LEN(str_linestyle)
            len_title = LEN(str_title)
            len_file = LEN(str_file)
            len_xlabel = LEN(str_xlabel)
            len_ylabel = LEN(str_ylabel)

            CALL pltfor_multiplot(x_c, y_c, size_xy, num_plot, str_color, str_marker, &
              str_linestyle, n_linewidth, n_markersize, str_title, str_xlabel, &
              str_ylabel, str_file, len_color, len_marker, len_linestyle, &
              len_title, len_file, len_xlabel, len_ylabel)

        END IF
    END SUBROUTINE plt_multiplot
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE plt_scatter_full(x, y, s, c, alpha, str_cmap, str_marker, &
                str_title, str_xlabel, str_ylabel, str_cmaplabel, str_file)
    !! Advanced plot plt.plot(x,y)

        USE, intrinsic :: iso_c_binding
        USE, intrinsic :: iso_fortran_env
        IMPLICIT NONE

        REAL(real64), DIMENSION(:), INTENT(IN) :: x
        REAL(real64), DIMENSION(:), INTENT(IN) :: y 
        REAL(real64), DIMENSION(:), INTENT(IN) :: s
        REAL(real64), DIMENSION(:), INTENT(IN) :: c 
        REAL(real64), INTENT(IN) :: alpha 

        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_cmap
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_marker

        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_title
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_file
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_xlabel
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_ylabel
        CHARACTER(KIND=c_char, len=*), INTENT(IN) :: str_cmaplabel

        REAL(c_double), DIMENSION(SIZE(x)) :: x_c
        REAL(c_double), DIMENSION(SIZE(y)) :: y_c
        REAL(c_double), DIMENSION(SIZE(x)) :: s_c
        REAL(c_double), DIMENSION(SIZE(y)) :: c_c
        INTEGER(c_int) :: size_xy 
        REAL(c_double) :: n_alpha 
        INTEGER(c_int) :: len_cmap
        INTEGER(c_int) :: len_marker 
        INTEGER(c_int) :: len_cmaplabel
        INTEGER(c_int) :: len_title 
        INTEGER(c_int) :: len_file 
        INTEGER(c_int) :: len_xlabel
        INTEGER(c_int) :: len_ylabel


        IF (SIZE(x) .NE. SIZE(y))then
            PRINT*, 'WARNING: array sizes not equal in plt_scatter_full!'
        ELSE
            x_c(:) = x(:)
            y_c(:) = y(:)
            s_c(:) = s(:)
            c_c(:) = c(:)
            size_xy = SIZE(x)
            n_alpha = alpha
            len_cmap = LEN(str_cmap)
            len_marker = LEN(str_marker)
            len_cmaplabel = LEN(str_cmaplabel)
            len_title = LEN(str_title)
            len_file = LEN(str_file)
            len_xlabel = LEN(str_xlabel)
            len_ylabel = LEN(str_ylabel)

            CALL pltfor_scatter_full(x_c, y_c, s_c, c_c, size_xy, n_alpha, &
                  str_cmap, str_marker, str_title, str_xlabel, str_ylabel, &
                  str_cmaplabel, str_file, len_cmap, len_marker, &
                  len_cmaplabel, len_title, len_file, len_xlabel, len_ylabel)

        END IF
    END SUBROUTINE plt_scatter_full
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
END MODULE pltFor
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
