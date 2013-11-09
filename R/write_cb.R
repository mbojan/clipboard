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
  # TODO xclip needed
  p <- pipe("xclip -i -selection clipboard", "w")
  writeLines(x, con=p)
}


write_cb_darwin <- function(x, ...)
{
  p <- pipe("pbcopy", "w")
  writeLines(x, con=p)
}
