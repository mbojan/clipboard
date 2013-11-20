\name{cb}
\alias{cb}
\alias{cb.data.frame}
\alias{cb.default}
\alias{cb.matrix}
\alias{cb.table}
\title{Exporting R objects to clipboard}
\usage{
  cb(object, ...)

  \method{cb}{matrix} (object,
    useNames = getOption("clipboard.useNames", TRUE), ...)

  \method{cb}{data.frame} (object, ...)

  \method{cb}{table} (object, ...)

  \method{cb}{default} (object, ...)
}
\arguments{
  \item{object}{object to be processed}

  \item{useNames}{logical, whether to use dimension names}

  \item{...}{other arguments to/from other methods}
}
\value{
  The converted object is put to clipboard and returned
  invisibly.
}
\description{
  This function exports R objects into the system clipboard
  in a format that is easy to paste it into Office-like
  programs (MSWord etc.).  Currently, methods for vectors,
  matrices, tables and data frames are implemented. For
  other objects the function tries to coerce its argument
  to a matrix first.
}
\details{
  An object is converted to a tab-separated table first.
  Details of the conversion depend on the class, see below.
  Such converted object is written into the system
  clipboard. A message stating the size of the exported
  table is printed into the console. Content of the
  clipboard can then be pasted in to MS Word or MS Excel,
  or any other application.

  For making tables in MSWord, LibreOffice, or alike you
  will have to first create an empty table with appropriate
  number of rows and columns. To aid you in this, when
  \code{cb} is called an informative message about the
  dimensionality of the exported table is printed. As a
  next step you have to select the whole table in MS Word,
  preferably via menus: Table|Select|Table. Then paste the
  content of the clipboard.

  In MS Excel and alike you are not required to select the
  appropriate area of the spreadsheet. It is sufficient to
  put the cursor (cell selector) in the upper-left corner
  of the to-be-table.

  If \code{useNames} is \code{TRUE} then the object is
  expanded to contain row and column names. The first cell
  in the first row contain dimension names
  (\code{names(dimnames(object))}) separated with a
  backslash.

  Writing to clipboard is performed using
  \code{\link{write_cb}}.

  If \code{object} is a matrix, the content is pasted into
  a single string in which columns are separated with tabs
  and rows with newline characters. Depending on the value
  of \code{useNames} row and column names are added as
  initial row and column to the result. If \code{object}'s
  dimnames have names defined, they are put in the first
  cell of the first row.

  If \code{object} is a data frame it is converted to a
  matrix processed as such. If the data frame contains
  factors, they are converted to chacracter strings first.

  If \code{object} is a table it is converted to matrix.
  Tables with more than two dimensions are not supported.
  One-dimensional tables are exported horizontally.

  For all other types of \code{object}'s not covered above,
  \code{cb} tries to convert them to a matrix and process
  it as such.
}
\seealso{
  \code{\link{write_cb}}, section Clipboard of
  \code{?file}, package \pkg{xtable} for exporting R
  objects to LaTeX or HTML.
}

