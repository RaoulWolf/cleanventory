#' @title Read-In and Clean the Australia Hazardous Chemical Information System
#'   (HCIS) Data Set
#' @description This function reads-in and automatically cleans the Australia
#'   Hazardous Chemical Information System (HCIS) data set.
#' @param path (Character) The path to the XLSX file.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#' reasonably converted? Defaults to \code{FALSE}.
#' @details The function reads-in and cleans the Australia Hazardous Chemical
#'   Information System (HCIS) data set into long flat format.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with an XLSX retrieved on 4 May 2022.
#' @examples \dontrun{
#' path <- "HCResults.xlsx"
#'
#' hcis <- read_hcis(path)
#' }
#' @importFrom openxlsx read.xlsx
#' @export
read_au_hcis <- function(path, clean_non_ascii = FALSE) {

  if (!is.logical(clean_non_ascii) | is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  hcis <- openxlsx::read.xlsx(xlsxFile = path, na.strings = c("", " "))

  names(hcis) <- c(
    "cas_no", "chemical_name", "hazard_category",
    "pictogram_codes_and_signal_words", "hazard_statement_codes",
    "hazard_statements", "cut_offs_specifications", "notes", "sources"
  )

  hcis <- transform(
    hcis,
    cas_no = trimws(cas_no),
    chemical_name = trimws(chemical_name)
  )

  if (clean_non_ascii) {
    hcis <- transform(
      hcis,
      chemical_name = .clean_non_ascii(chemical_name),
      hazard_category = .clean_non_ascii(hazard_category),
      cut_offs_specifications = .clean_non_ascii(cut_offs_specifications)
    )
  }

  hcis

}
