#' @title Read-In and Clean the New Zealand Inventory of Chemicals
#' @description This function reads-in and automatically cleans the New Zealand
#'   Inventory of Chemicals.
#' @param path (Character) The path to the XLSX file.
#' @param version (Logical) Should the version information be included?
#'   Defaults to \code{TRUE}.
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
#'   )
#'   destfile = "NZIOC_Full_Spreadsheet_December_2021.xlsx"
#' )
#'
#' path <- "NZIOC_Full_Spreadsheet_December_2021.xlsx"
#'
#' nite <- read_nzioc(path)
#' }
#' @importFrom openxlsx read.xlsx
#' @export
read_nzioc <- function(path, version = TRUE) {

  nzioc <- openxlsx::read.xlsx(xlsxFile = path, startRow = 2)

  names(nzioc) <- c(
    "cas_number", "cas_name", "approval", "restrictions_exclusions"
  )

  if (version) {
    version <- unlist(strsplit(path, split = "/"))
    version <- version[
      sapply(
        version,
        FUN = function(x) { grepl(pattern = ".xlsx", x) },
        USE.NAMES = FALSE
      )
    ]
    version <- unlist(strsplit(version, split = "\\."))[1]
    version <- rev(unlist(strsplit(version, split = "_")))
    version <- paste(version[2], version[1])
    nzioc <- transform(nzioc, version = version)
  }

  nzioc

}
