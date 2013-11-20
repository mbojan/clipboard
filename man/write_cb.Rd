\name{write_cb}
\alias{read_cb}
\alias{write_cb}
\title{Portable read/write access to system clipboard}
\usage{
  write_cb(x, ...)

  read_cb(...)
}
\arguments{
  \item{x}{object to be written, it is coerced to
  character}

  \item{condesc}{connection description, defaults are
  system-specific, see Details

  \code{write_cb} expects a single argument which is
  written into the clipboard after being converted to
  character. Writing is performed via a connection
  description of which can be specified with \code{condesc}
  or the \code{clipboard.write} option.  Defaults are
  system-specific, see below.

  \code{read_cb} can be called without any arguments.
  Reading is performed via a connection description of
  which can be specified with \code{condesc} or
  \code{clipboard.read} option.  Defaults are system
  specific, see below.

  Interaction with system clipboard is very much
  system-dependent. The particular method used depends on
  the type of the operating system, which is queried from
  \code{Sys.info()["sysname"]}.}
}
\value{
  For \code{write_cb} it is \code{NULL}.

  For \code{read_cb}, it is a character vector with lines
  of content of the clipboard.
}
\description{
  These functions aim at providing portable way of reading
  and writing to system clipboard. The primary motivation
  was to smooth the process of copy-pasting computation
  results from R to Office programs (MSWord, LibreOffice,
  etc.).
}
\references{
  Program \code{xclip}
  \url{http://sourceforge.net/projects/xclip}
}

