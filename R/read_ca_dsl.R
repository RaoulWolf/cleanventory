#' @title Read-In and Clean the Canada Domestic Substance List
#' @description This function reads-in and automatically cleans the Canada
#'   Domestic Substance List.
#' @param path (Character) The path to the .xlsx file.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#'   reasonably converted? Defaults to \code{FALSE}.
#' @details The .xlsx file has to be manually downloaded from the
#'   following website:
#'
#'   * https://pollution-waste.canada.ca/substances-search/Substance?lang=en
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @examples \dontrun{
#' path <- "Domestic Substances List (DSL).xlsx"
#'
#' dsl <- read_ca_dsl(path)
#' }
#' @importFrom openxlsx read.xlsx
#' @export
read_ca_dsl <- function(path, clean_non_ascii = FALSE) {

  if (!is.logical(clean_non_ascii) || is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  pre_dsl <- openxlsx::read.xlsx(path, cols = c(2, 4, 6:7), detectDates = TRUE)

  colnames(pre_dsl) <- c(
    "substance_identifier", "substance_name", "recent_publications",
    "date_published"
  )

  dsl <- transform(
    pre_dsl,
    substance_identifier = trimws(substance_identifier),
    substance_name = trimws(substance_name),
    recent_publications = trimws(recent_publications),
    date_published = as.Date(
      as.POSIXct(
        date_published, tz = "Canada/Central", tryFormats = "%Y-%m-%d"
      ),
      tz = "Canada/Central"
    )
  )

  if (clean_non_ascii) {
    dsl <- transform(
      dsl,
      substance_identifier = .clean_non_ascii(substance_identifier),
      substance_name = .clean_non_ascii(substance_name)
    )
  }

  dsl

}
