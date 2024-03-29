% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_au_hcis.R
\name{read_au_hcis}
\alias{read_au_hcis}
\title{Read-In and Clean the Australia Hazardous Chemical Information System
  (HCIS) Data Set}
\usage{
read_au_hcis(path, clean_non_ascii = FALSE)
}
\arguments{
\item{path}{(Character) The path to the XLSX file.}

\item{clean_non_ascii}{(Logical) Should the non-ASCII characters be
reasonably converted? Defaults to \code{FALSE}.}
}
\value{
Returns a data frame.
}
\description{
This function reads-in and automatically cleans the Australia
  Hazardous Chemical Information System (HCIS) data set.
}
\details{
The function reads-in and cleans the Australia Hazardous Chemical
  Information System (HCIS) data set into long flat format.
}
\note{
Tested with an XLSX retrieved on 4 May 2022.
}
\examples{
\dontrun{
path <- "HCResults.xlsx"

hcis <- read_au_hcis(path)
}
}
\author{
Raoul Wolf (\url{https://github.com/RaoulWolf/})
}
