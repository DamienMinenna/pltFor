import cffi

ffibuilder = cffi.FFI()

header  = """
extern void pltfor_plot (double *, double *, int *, char *, char *, char *, char *, int *, int *, int *, int *);
extern void pltfor_plot_adv (double *, double *, int *, char *, char *, char *, double *, double *, char *, char *, char *, char *, int *, int *, int *, int *, int *, int *, int *);
extern void pltfor_multiplot (double *, double *, int *, int *, char *, char *, char *, double *, double *, char *, char *, char *, char *, int *, int *, int *, int *, int *, int *, int *);
extern void pltfor_scatter_full (double *, double *, double *, double *, int *, double *, char *, char *, char *, char *, char *, char *, char *, int *, int *, int *, int *, int *, int *, int *);
"""

module = """
from plugin_pltFor import ffi
import numpy as np
import matplotlib.pyplot as plt

ctype2dtype = {}

for prefix in ('int', 'uint'):
    for log_bytes in range(4):
        ctype = '%s%d_t' % (prefix, 8 * (2**log_bytes))
        dtype = '%s%d' % (prefix[0], 2**log_bytes)
        ctype2dtype[ctype] = np.dtype(dtype)

ctype2dtype['float'] = np.dtype('f4')
ctype2dtype['double'] = np.dtype('f8')


def asarray(ffi, ptr, shape, **kwargs):
    length = np.prod(shape)
    T = ffi.getctype(ffi.typeof(ptr).item)

    if T not in ctype2dtype:
        raise RuntimeError("Cannot create an array for element type: %s" % T)

    a = np.frombuffer(ffi.buffer(ptr, length * ffi.sizeof(T)), ctype2dtype[T])\
          .reshape(shape, **kwargs)
    return a


@ffi.def_extern()
def pltfor_plot(a_ptr, b_ptr, ab_size, str_title, str_xlabel, str_ylabel, str_file, len_title, len_xlabel, len_ylabel, len_file):

    a = asarray(ffi, a_ptr, shape=(ab_size[0],))
    b = asarray(ffi, b_ptr, shape=(ab_size[0],))

    name_title = ffi.string(str_title).decode("utf-8")[0:len_title[0]]
    name_xlabel = ffi.string(str_xlabel).decode("utf-8")[0:len_xlabel[0]]
    name_ylabel = ffi.string(str_ylabel).decode("utf-8")[0:len_ylabel[0]]
    name_file = ffi.string(str_file).decode("utf-8")[0:len_file[0]]

    if name_file == '':
        name_file = 'plot.png'

    plt.figure()
    plt.plot(a[:], b[:], color='black', marker='o', linestyle='solid', linewidth=2, markersize=5)
    plt.grid()
    if name_title != '':
        plt.title(name_title)
    if name_xlabel != '':
        plt.xlabel(name_xlabel)
    if name_ylabel != '':
        plt.ylabel(name_ylabel)
    plt.tight_layout()
    plt.savefig(name_file)


@ffi.def_extern()
def pltfor_plot_adv(a_ptr, b_ptr, ab_size, str_color, str_marker, str_linestyle, n_linewidth, n_markersize, str_title, str_xlabel, str_ylabel, str_file, len_color, len_marker, len_linestyle, len_title, len_file, len_xlabel, len_ylabel):

    a = asarray(ffi, a_ptr, shape=(ab_size[0],))
    b = asarray(ffi, b_ptr, shape=(ab_size[0],))

    name_color = ffi.string(str_color).decode("utf-8")[0:len_color[0]]
    if name_color == '':
        name_color = 'black'
    name_marker= ffi.string(str_marker).decode("utf-8")[0:len_marker[0]]
    if name_marker == '':
        name_marker = 'o'
    name_linestyle = ffi.string(str_linestyle).decode("utf-8")[0:len_linestyle[0]]
    if name_linestyle == '':
        name_linestyle = 'solid'

    name_title = ffi.string(str_title).decode("utf-8")[0:len_title[0]]
    name_xlabel = ffi.string(str_xlabel).decode("utf-8")[0:len_xlabel[0]]
    name_ylabel = ffi.string(str_ylabel).decode("utf-8")[0:len_ylabel[0]]
    name_file = ffi.string(str_file).decode("utf-8")[0:len_file[0]]

    if name_file == '':
        name_file = 'plot.png'

    plt.figure()
    plt.plot(a[:], b[:], color=name_color, marker=name_marker, linestyle=name_linestyle, linewidth=n_linewidth[0], markersize=n_markersize[0])
    plt.grid()
    if name_title != '':
        plt.title(name_title)
    if name_xlabel != '':
        plt.xlabel(name_xlabel)
    if name_ylabel != '':
        plt.ylabel(name_ylabel)
    plt.tight_layout()
    plt.savefig(name_file)


@ffi.def_extern()
def pltfor_multiplot(a_ptr, b_ptr, ab_size, num_plot, str_color, str_marker, str_linestyle, n_linewidth, n_markersize, str_title, str_xlabel, str_ylabel, str_file, len_color, len_marker, len_linestyle, len_title, len_file, len_xlabel, len_ylabel):

    a = asarray(ffi, a_ptr, shape=(num_plot[0], ab_size[0]))
    b = asarray(ffi, b_ptr, shape=(num_plot[0], ab_size[0]))

    name_color = ffi.string(str_color).decode("utf-8")[0:len_color[0]]
    name_color = name_color.replace(' ','').split(';')
    if name_color == '':
        name_color = ['black'] * num_plot[0]
    for i in range(len(name_color)+1, num_plot[0]+1):
        name_color.append('black')

    name_marker= ffi.string(str_marker).decode("utf-8")[0:len_marker[0]]
    name_marker = name_marker.replace(' ','').split(';')
    if name_marker == '':
        name_marker = ['o'] * num_plot[0]
    for i in range(len(name_marker)+1, num_plot[0]+1):
        name_marker.append('o')

    name_linestyle = ffi.string(str_linestyle).decode("utf-8")[0:len_linestyle[0]]
    name_linestyle = name_linestyle.replace(' ','').split(';')
    if name_linestyle == '':
        name_linestyle = ['solid'] * num_plot[0]
    for i in range(len(name_linestyle)+1, num_plot[0]+1):
        name_linestyle.append('solid')

    name_title = ffi.string(str_title).decode("utf-8")[0:len_title[0]]
    name_xlabel = ffi.string(str_xlabel).decode("utf-8")[0:len_xlabel[0]]
    name_ylabel = ffi.string(str_ylabel).decode("utf-8")[0:len_ylabel[0]]
    name_file = ffi.string(str_file).decode("utf-8")[0:len_file[0]]

    if name_file == '':
        name_file = 'plot.png'

    plt.figure()
    for i in range(num_plot[0]):
        plt.plot(a[i,:], b[i,:], color=name_color[i], marker=name_marker[i], linestyle=name_linestyle[i], linewidth=n_linewidth[i], markersize=n_markersize[i])
    plt.grid()
    if name_title != '':
        plt.title(name_title)
    if name_xlabel != '':
        plt.xlabel(name_xlabel)
    if name_ylabel != '':
        plt.ylabel(name_ylabel)
    plt.tight_layout()
    plt.savefig(name_file)


@ffi.def_extern()
def pltfor_scatter_full(a_ptr, b_ptr, s_ptr, col_ptr, ab_size, n_alpha, str_cmap, str_marker, str_title, str_xlabel, str_ylabel, str_cmaplabel, str_file, len_cmap, len_marker, len_cmaplabel, len_title, len_file, len_xlabel, len_ylabel):


    a = asarray(ffi, a_ptr, shape=(ab_size[0],))
    b = asarray(ffi, b_ptr, shape=(ab_size[0],))
    sur = asarray(ffi, s_ptr, shape=(ab_size[0],))
    col = asarray(ffi, col_ptr, shape=(ab_size[0],))

    name_marker= ffi.string(str_marker).decode("utf-8")[0:len_marker[0]]
    if name_marker == '':
        name_marker = 'o'
    name_cmap= ffi.string(str_cmap).decode("utf-8")[0:len_cmap[0]]
    if name_cmap == '':
        name_cmap = 'viridis'

    name_title = ffi.string(str_title).decode("utf-8")[0:len_title[0]]
    name_xlabel = ffi.string(str_xlabel).decode("utf-8")[0:len_xlabel[0]]
    name_ylabel = ffi.string(str_ylabel).decode("utf-8")[0:len_ylabel[0]]
    name_cmaplabel = ffi.string(str_cmaplabel).decode("utf-8")[0:len_cmaplabel[0]]
    name_file = ffi.string(str_file).decode("utf-8")[0:len_file[0]]

    if name_file == '':
        name_file = 'plot.png'

    plt.figure()
    q = plt.scatter(a[:], b[:], s=sur[:], c=col[:], marker=name_marker, cmap=name_cmap)
    cbar = plt.colorbar(q)  
    if name_cmaplabel != '':
      cbar.set_label(name_cmaplabel)
    plt.grid()
    if name_title != '':
        plt.title(name_title)
    if name_xlabel != '':
        plt.xlabel(name_xlabel)
    if name_ylabel != '':
        plt.ylabel(name_ylabel)
    plt.tight_layout()
    plt.savefig(name_file)

"""

with open("plugin_pltFor_h.h", "w") as f:
    f.write(header)

ffibuilder.embedding_api(header)
ffibuilder.set_source("plugin_pltFor", r'''
    #include "plugin_pltFor_h.h"
''')

ffibuilder.embedding_init_code(module)
ffibuilder.compile(target="libpltFor-0.2.*", verbose=True)
