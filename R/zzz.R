.onLoad <- function(libname, pkgname)
{
  if( Sys.info()["sysname"] == "Linux" )
  {
    if( !has_xclip() )
    {
      warning("it seems that xclip is not installed, package 'clipboard' may not work correctly")
    } else {
      message(has_xclip(TRUE), " found")
    }
  }
}
