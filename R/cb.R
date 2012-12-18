# copy object to windows clipboard

cb <- function(object, ...) UseMethod("cb")


cb.matrix <- function(object, useNames=TRUE)
{
	if( !useNames | is.null(dimnames(object)) ) {
	    m <- object
	}
	else {
	    nams <- dimnames(object)
	    dnames <- names(nams)
	    # make a sequence if dimension names are empty
	    if( is.null(nams[[1]]) ) nams[[1]] <- seq(1, dim(object)[1])
	    if( is.null(nams[[2]]) ) nams[[2]] <- seq(1, dim(object)[2])
	    m <- cbind(nams[[1]], object)
	    m <- rbind( c( paste(dnames, collapse="\\"), nams[[2]]), m)
	}
	rval <- apply( m, 1, paste, collapse="\t")
	rval <- paste(rval, collapse="\n")
	require(utils)
	writeClipboard(rval)
	cat("In clipboard:",
	    paste(dim(m), collapse=" x "),
	    "table\n")
	invisible(rval)
}


cb.data.frame <- function(object, useNames=TRUE)
{
	# convert factors two character
	isf <- sapply(object, is.factor)
	d <- object
	d[isf] <- lapply( d[isf], as.character )
	# process as character matrix
	toWord( as.matrix(d), useNames=useNames)
}


# for tables
cb.table <- function(object, useNames=TRUE)
{
    # only if table is one- or two-dimensional
    ndim <- length(dim(object))
    if( ndim > 2 )
	stop("'object' has ", ndim, " dimensions, only 1 or 2 supported")
    # horizontal table for one dimension
    if( ndim == 1 )
    {
	rval <- toWord( t(as.matrix(object)), useNames=useNames )
    } else
    {
	class(object) <- "matrix"
	rval <- toWord( object, useNames=useNames )
    }
    invisible(rval)
}


# Default method tries to coerce the object to matrix

cb.default <- function(object, useNames=TRUE)
{
    toWord( as.matrix(object), useNames=useNames )
}


# alias
# tcb <- function(object, ...) cb( object=object, ... )
