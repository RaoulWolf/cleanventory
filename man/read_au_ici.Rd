% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_au_ici.R
\name{read_au_ici}
\alias{read_au_ici}
\title{Read-In and Clean the Australia Industrial Chemicals Inventory}
\usage{
read_au_ici(path, clean_non_ascii = FALSE)
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
  Industrial Chemicals Inventory.
}
\details{
This function reads-in and automatically cleans the Australia
  Industrial Chemicals Inventory.
}
\note{
Tested with the 10 February 2022 version.
}
\examples{
\dontrun{
download.file(
  url = paste(
    "https://www.industrialchemicals.gov.au/sites/default/files/2022-03",
    paste(
      "Full\%20list\%20of\%20chemicals\%20on\%20the\%20Inventory\%20",
      "\%2010\%20February\%202022.XLSX",
      sep = "-"
    ),
  sep = "/"
  ),
  destfile = paste(
    "Full list of chemicals on the Inventory",
    "10 February 2022.xlsx",
    sep = " - "
  )
)

path <- "Full list of chemicals on the Inventory - 10 February 2022.xlsx"

ici <- read_au_ici(path)
}
}
\author{
Raoul Wolf (\url{https://github.com/RaoulWolf/})
}
