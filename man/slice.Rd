% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slice.R
\name{slice}
\alias{slice}
\alias{slice_head}
\alias{slice_tail}
\alias{slice_min}
\alias{slice_max}
\alias{slice_sample}
\title{Subset rows by position}
\usage{
slice(.data, ...)

slice_head(.data, ..., n, prop)

slice_tail(.data, ..., n, prop)

slice_min(.data, order_by, ..., n, prop, with_ties = TRUE)

slice_max(.data, order_by, ..., n, prop, with_ties = TRUE)

slice_sample(.data, ..., n, prop, weight_by = NULL, replace = FALSE)
}
\arguments{
\item{.data}{A \code{data.frame}.}

\item{...}{For \code{slice()}: integer row values.

Provide either positive values to keep, or negative values to drop. The values provided must be either all positive
or negative. Indices beyond the number of rows in the input are silently ignored.}

\item{n, prop}{Provide either \code{n}, the number of rows, or \code{prop}, the proportion of rows to select. If neither are
supplied, \code{n = 1} will be used.

If \code{n} is greater than the number of rows in the group (or \code{prop > 1}), the result will be silently truncated to the
group size. If the \code{prop}ortion of a group size is not an integer, it is rounded down.}

\item{order_by}{The variable to order by.}

\item{with_ties}{\code{logical(1)}. Should ties be kept together? The default, \code{TRUE}, may return more rows than you
request. Use \code{FALSE} to ignore ties, and return the first \code{n} rows.}

\item{weight_by}{Sampling weights. This must evaluate to a vector of non-negative numbers the same length as the
input. Weights are automatically standardised to sum to 1.}

\item{replace}{\code{logical(1)}. Should sampling be performed with (\code{TRUE}) or without (\code{FALSE}, the default)
replacement.}
}
\value{
An object of the same type as \code{.data}. The output has the following properties:
\itemize{
\item Each row may appear 0, 1, or many times in the output.
\item Columns are not modified.
\item Groups are not modified.
\item Data frame attributes are preserved.
}
}
\description{
Subset rows by their original position in the \code{data.frame}. Grouped \code{data.frame}s use the position within each group.
}
\examples{
slice(mtcars, c(1, 2, 3))
mtcars \%>\% slice(1:3)

# Similar to head(mtcars, 1)
mtcars \%>\% slice(1L)

# Similar to tail(mtcars, 1):
mtcars \%>\% slice(n())
mtcars \%>\% slice(5:n())
# Rows can be dropped with negative indices:
slice(mtcars, -(1:4))

# First and last rows based on existing order
mtcars \%>\% slice_head(n = 5)
mtcars \%>\% slice_tail(n = 5)

# Grouped operations:
mtcars \%>\% group_by(am, cyl, gear) \%>\% slice_head(n = 2)

}
