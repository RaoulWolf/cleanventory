% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_my_cims.R
\name{read_my_cims}
\alias{read_my_cims}
\title{Read-In and Clean the Malaysia Chemical Information Management System
  Inventory}
\usage{
read_my_cims(path, clean_non_ascii = FALSE)
}
\arguments{
\item{path}{(Character) The path to the CSV file.}

\item{clean_non_ascii}{(Logical) Should the non-ASCII characters be
reasonably converted? Defaults to \code{FALSE}.}
}
\value{
Returns a data frame.
}
\description{
This function reads-in and automatically cleans the Malaysia
  Chemical Information Management System (CIMS) inventory.
}
\details{
The function reads-in and cleans the United States Chemical Data
  Reporting inventory.
}
\examples{
\dontrun{
path <- "cims.csv"

cims <- read_my_cims(path)
}
}
\author{
Raoul Wolf (\url{https://github.com/RaoulWolf/})
}
