\name{cb}
\alias{cb}
\title{Exporting R objects to clipboard}
\usage{
  cb(object, ...)
}
\arguments{
  \item{object}{object to processed, currently matrix, data
  frame or table are supported directly. Other objects are
  coerced to matrix.}

  \item{useNames}{logical, whether to use dimension names}

  \item{\dots}{other arguments to methods}
}
\value{
  The converted object is put to clipboard and returned
  invisibly.
}
\description{
  This function exports R objects into Windows clipboard in
  a format that makes the further work in MS Office easier.
  Current methods cover matrices and data frames.
}
\details{
  There are currently three methods: for matrices, tables,
  and data frames. Data frames and tables are converted to
  matrices. \code{tcb} is an alias for \code{cbd}.

  For any other objects the function tries to coerce its
  argument to matrix.

  If \code{useNames} is \code{TRUE} then the object is
  expanded to contain row and column names. The first cell
  in the first row contain dimension names separated with a
  backslash.

  This function converts the object to a tab-separated
  table and puts it in the Windows clipboard. The content
  can then be pasted in to MS Word or MS Excel. For making
  tables in MS Word you will have to first create an empty
  table with appropriate number of rows and columns. To aid
  you in this after the \code{cb} is called it displays an
  informative message about the dimensionality of the
  exported table. As a next step you have to select the
  whole table in MS Word, preferably via menus:
  Table|Select|Table.  Then paste in the content of the
  clipboard.

  In MS Excel you are not required to select the
  appropriate area of the spread sheet. It is sufficient to
  put the cursor (cell selector) in the upper-left corner
  of the to-be-table.
}
\note{
  This function will work only on MS Windows distributions
  of R
}
\seealso{
  \code{writeClipboard} and package \pkg{xtable}
}

