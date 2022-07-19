#' @title Read-In and Clean the New Zealand Inventory of Chemicals
#' @description This function reads-in and automatically cleans the New Zealand
#'   Inventory of Chemicals.
#' @param path (Character) The path to the XLSX file.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#'   reasonably converted? Defaults to \code{FALSE}.
#' @details This function reads-in and automatically cleans the New Zealand
#'   Inventory of Chemicals.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with the December 2021 version.
#' @examples \dontrun{
#' download.file(
#'   url = paste(
#'     "https://www.epa.govt.nz/assets/Uploads/Documents/Hazardous-Substances",
#'     "Guidance/NZIOC_Full_Spreadsheet_December_2021.xlsx",
#'     sep = "/"
#'   ),
#'   destfile = "NZIOC_Full_Spreadsheet_December_2021.xlsx"
#' )
#'
#' path <- "NZIOC_Full_Spreadsheet_December_2021.xlsx"
#'
#' ioc <- read_ioc(path)
#' }
#' @importFrom openxlsx read.xlsx
#' @export
read_nz_ioc <- function(path, clean_non_ascii = FALSE) {

  if (!is.logical(clean_non_ascii) || is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  ioc <- openxlsx::read.xlsx(xlsxFile = path, startRow = 2)

  names(ioc) <- c(
    "cas_number", "cas_name", "approval", "restrictions_exclusions"
  )

  ioc <- transform(
    ioc,
    cas_number = ifelse(
      test = .check_cas(cas_number),
      yes = cas_number,
      no = NA_character_
    )
  )

  if (clean_non_ascii) {
    ioc <- transform(ioc, cas_name = .clean_non_ascii(cas_name))
  }

  ioc

}
