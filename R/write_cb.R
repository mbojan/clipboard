#' Writing to system clipboard
#'
#' System-independent writing to clipboard for pasting elsewhere
#'
#' @param x character, lines of text to be written
#' @param ... other arguments passed to/from other methods
#'
#' @return nothing
#'
#' @export

write_cb <- function(x, ...)
{
  switch( Sys.info()["Sysname"],
         Linux = write_cb_linux(x, ...),
         Windows = write_cb_windows(x, ...),
         Darwin = write_cb_darwin(x, ...)
         )
}



write_cb_windows <- function(x, ...)
{
  # TODO use either file connection or 'writeClipboard' function
  p <- file("clipboard", "w")
  writeLines(x, con=p)
}


write_cb_linux <- function(x, ...)
{
  p <- pipe("xclip -i -selection clipboard", "w")
  writeLines(x, con=p)
}


write_cb_darwin <- function(x, ...)
{
  p <- pipe("pbcopy", "w")
  writeLines(x, con=p)
}
