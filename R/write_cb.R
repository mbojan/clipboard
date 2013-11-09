write_cb <- function(x, ...)
{
  switch( Sys.info()["Sysname"],
         Linux = write_cb_linux(x, ...),
         Windows = write_cb_windows(x, ...),
         Darwin = write_cb_darwin(x, ...),
         stop("unknown operating system: ", Sys.info()["Sysname"])
         )
}



write_cb_windows <- function(x, ...)
{
  # TODO should we use file connection or 'writeClipboard' function?
  p <- file("clipboard", "w")
  writeLines(x, con=p)
}


write_cb_linux <- function(x, ...)
{
  stopifnot(has_xclip())
  p <- pipe("xclip -i -selection clipboard", "w")
  writeLines(x, con=p)
}


# Check if 'xclip' is available
has_xclip <- function()
{
  ver <- try( system("xclip -version", intern=TRUE) )
  if( inherits(ver, "try-error") || !grepl("xclip", ver) )
  {
    warning("'xclip' is not available")
    invisible(FALSE)
  } else
  {
    invisible(TRUE)
  }
}


write_cb_darwin <- function(x, ...)
{
  p <- pipe("pbcopy", "w")
  writeLines(x, con=p)
}
