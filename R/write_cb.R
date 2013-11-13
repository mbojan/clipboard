#============================================================================ 
# Writing to clipboard


# Generic interface for writing to clipboard dispatching to other functions
# based on the type of the system based on Sys.info()
write_cb <- function(x, ...)
{
  switch( Sys.info()["Sysname"],
         Linux = write_cb_linux(x, ...),
         Windows = write_cb_windows(x, ...),
         Darwin = write_cb_darwin(x, ...),
         stop("unknown operating system: ", Sys.info()["Sysname"])
         )
}



# On Windows
write_cb_windows <- function(x, condesc=getOption("clipboard.write"), ...)
{
  if(is.null(condesc)) condesc <- "clipboard"
  p <- file(condesc, "w")
  writeLines(x, con=p)
  close(p)
}


# On Unix-like systems use 'xclip'
write_cb_linux <- function(x, condesc=getOption("clipboard.write"), ...)
{
  if(is.null(condesc)) condesc <- "xclip -i -selection clipboard"
  stopifnot(has_xclip())
  p <- pipe(condesc, "w")
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


# On MacOS
write_cb_darwin <- function(x, condesc=getOption("clipboard.write"), ...)
{
  if(is.null(condesc)) condesc <- "pbcopy"
  p <- pipe(condesc, "w")
  writeLines(x, con=p)
}





#============================================================================ 
# Reading from clipboard
#============================================================================ 




# Generic interface for reading to clipboard dispatching to other functions
# based on the type of the system based on Sys.info()
read_cb <- function(x, ...)
{
  switch( Sys.info()["Sysname"],
         Linux = read_cb_linux(x, ...),
         Windows = read_cb_windows(x, ...),
         Darwin = read_cb_darwin(x, ...),
         stop("unknown operating system: ", Sys.info()["Sysname"])
         )
}

# Reading Windows clipboard
read_cb_windows <- function(x, condesc=getOption("clipboard.read"), ...)
{
  if(is.null(condesc)) condesc <- "clipboard"
  p <- file(condesc, "r")
  on.exit(close(p))
  readLines(x, con=p)
}
