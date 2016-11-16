# clipboard: R package making copy-pasting easy


[![Build Status](https://travis-ci.org/mbojan/clipboard.png?branch=master)](https://travis-ci.org/mbojan/clipboard)
[![Build Status](https://ci.appveyor.com/api/projects/status/yac98fafds7i65ci?svg=true)](https://ci.appveyor.com/project/mbojan/clipboardalluvial)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/clipboard?color=2ED968)](http://cranlogs.r-pkg.org/)
[![cran version](http://www.r-pkg.org/badges/version/clipboard)](https://cran.r-project.org/package=clipboard)


Package "clipboard" provide a portable way of interacting with system
clipboard. You can write content into a clipboard to be able to paste it into
some other application. For completeness, there are also functions for getting
content from the clipboard into R.  The primary motivation for writing this
package was to be able to quickly copy a content of a R object, typically a
matrix or a data frame, to be able to paste it into a table in an Office
program (e.g. MSWord, LibreOffice Writer, Excel, Calc, and alike).



## Dependencies

Functions in package "clipboard" try to use existing facilities, i.e.
connections, for writing into system clipboard as documented on
`help(connections)`. So far, functions for that purposes are available only on
some systems. For example, function `writeClipboard` is available only on
Windows. In package "clipboard" the type of the operating system is detected
and appropriate method for writing and reading into the clipboard is
automatically selected. In some cases the package has to rely on external
tools. They are mentioned below.

Linux: `xclip`




## Installation

Use package "devtools" and `install_github`:

```r
library(devtools)
install_github("mbojan/clipboard")
```


## Details

The main function is `cb` writes a textual representation of a single R object
into clipboard. The function is generic. Currently implemented methods cover
vectors, matrices, data frames, and tables. Users can write their own methods.
Additionally, functions `write_cb` and `read_cb` provide a low-level interface.

The package is developed on Github at https://github.com/mbojan/clipboard. Please
use Github facilities for submitting bugs (issues).
