#' Portable read/write access to system clipboard
#'
#' These functions aim at providing portable way of reading and writing to
#' system clipboard. The primary motivation was to smooth the process of
#' copy-pasting computation results from R to Office programs (MSWord,
#' LibreOffice, etc.).
#'
#' Interaction with system clipboard is very much system-dependent. The
#' particular method used depends on the type of the operating system, which is
#' queried from \code{Sys.info()["sysname"]}.
#' 
#' @param x object to be written, it is coerced to character
#' @param ... other arguments passed to/from other methods, including \code{condesc}
#' with connection description. See Details.
#'
#' @return
#' For \code{write_cb} it is \code{NULL}.
#'
#' For \code{read_cb}, it is a character vector with lines of content of the
#' clipboard.
#'
#' @references
#' Program \code{xclip} \url{http://sourceforge.net/projects/xclip}
#'
#' @seealso
#' Section "Clipboard" of \code{help(connection)}.





#' @details
#' \code{write_cb} expects a single argument which is written into the
#' clipboard after being converted to character. Writing is performed via a
#' connection description of which can be specified with \code{condesc} or the
#' \code{clipboard.write} option.  Defaults are system-specific, see below.
#'
#' On Windows writing to clipboard is performed via \code{file} connection.
#' Default description is \code{clipboard}.
#'
#' On Unix-like systems a small program \code{xclip} has to be installed, see
#' References below. Writing is performed via a \code{pipe} with description
#' \code{xclip -i -selection clipboard}.  By default we are using X selection
#' \code{clipboard}. Alternatives are \code{XA_PRIMARY} or \code{XA_SECONDARY}.
#' Consult further documentation of \code{xclip}.
#'
#' On MacOS writing is performed via \code{pipe} using \code{pbcopy} description
#' by default.
#' @export
#' @rdname write_cb
write_cb <- function(x, ...)
{
  x <- as.character(x)
  switch( Sys.info()["sysname"],
         Linux = write_cb_linux(x, ...),
         Windows = write_cb_windows(x, ...),
         Darwin = write_cb_darwin(x, ...),
         stop("unknown operating system: ", Sys.info()["Sysname"])
         )
}

#' @details
#' \code{read_cb} can be called without any arguments. Reading is performed via
#' a connection description of which can be specified with \code{condesc} or
#' \code{clipboard.read} option.  Defaults are system specific, see below.
#'
#' Reading Windows clipboard uses \code{file} connection with description \code{clipboard}.
#'
#' Reading clipboard on Linux is performed via a \code{pipe} and \code{xclip} program.
#'
#' Reading clipboard on MacOS uses \code{pipe} with description \code{pbcopy}.
#' @export
#' @rdname write_cb
read_cb <- function(...)
{
  switch( Sys.info()["sysname"],
         Linux = read_cb_linux(...),
         Windows = read_cb_windows(...),
         Darwin = read_cb_darwin(...),
         stop("unknown operating system: ", Sys.info()["Sysname"])
         )
}



#============================================================================


# Check if 'xclip' is available
has_xclip <- function()
{
  ver <- try( system("xclip -version 2>&1", intern=TRUE) )
  if( inherits(ver, "try-error") || !grepl("xclip", ver) )
  {
    warning("'xclip' is not available")
    return(FALSE)
  } else
  {
    return(TRUE)
  }
}


#============================================================================ 
# Writing to clipboard
#============================================================================ 


write_cb_windows <- function(x, condesc=getOption("clipboard.write", "clipboard"), ...)
{
  p <- file(condesc, "w")
  on.exit(close(p))
  writeLines(x, con=p)
}


write_cb_linux <- function(x, condesc=getOption("clipboard.write", "xclip -i -selection clipboard"), ...)
{
  stopifnot(has_xclip())
  p <- pipe(condesc, "w")
  on.exit(close(p))
  writeLines(x, con=p)
}




write_cb_darwin <- function(x, condesc=getOption("clipboard.write", "pbcopy"), ...)
{
  p <- pipe(condesc, "w")
  on.exit(close(p))
  writeLines(x, con=p)
}



#============================================================================ 
# Reading from clipboard
#============================================================================ 


read_cb_windows <- function(condesc=getOption("clipboard.read", "clipboard"), ...)
{
  p <- file(condesc, "r")
  on.exit(close(p))
  readLines(con=p)
}

read_cb_linux <- function( condesc = getOption("clipboard.read", "xclip -o -selection clipboard"), ...)
{
  stopifnot(has_xclip())
  p <- pipe(condesc, "r")
  on.exit(close(p))
  readLines(con=p)
}

read_cb_darwin <- function(condesc=getOption("clipboard.read", "pbcopy"))
{
  p <- pipe(condesc, "r")
  on.exit(close(p))
  readLines(con=p)
}
