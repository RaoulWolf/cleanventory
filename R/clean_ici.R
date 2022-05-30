#' @title Read-In and Clean the Australia Industrial Chemicals Inventory
#' @description This function reads-in and automatically cleans the Australia
#'   Industrial Chemicals Inventory.
#' @param path (Character) The path to the XLSX file.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#'   reasonably converted? Defaults to \code{FALSE}.
#' @param version (Logical) Should the version information be included?
#'   Defaults to \code{TRUE}.
#' @details This function reads-in and automatically cleans the Australia
#'   Industrial Chemicals Inventory.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with the 10 February 2022 version.
#' @examples \dontrun{
#' download.file(
#'   url = paste(
#'     "https://www.industrialchemicals.gov.au/sites/default/files/2022-03",
#'     paste(
#'       "Full%20list%20of%20chemicals%20on%20the%20Inventory%20",
#'       "%2010%20February%202022.XLSX",
#'       sep = "-"
#'     ),
#'   sep = "/"
#'   ),
#'   destfile = paste(
#'     "Full list of chemicals on the Inventory",
#'     "10 February 2022.xlsx",
#'     sep = " - "
#'   )
#' )
#'
#' path <- "Full list of chemicals on the Inventory - 10 February 2022.xlsx"
#'
#' ici <- read_ici(path)
#' }
#' @importFrom openxlsx read.xlsx
#' @export
clean_ici <- function(path, clean_non_ascii = FALSE, version = TRUE) {

  if (!is.logical(clean_non_ascii) || is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  if (!is.logical(version) || is.na(version)) {
    version <- TRUE
  }

  ici <- openxlsx::read.xlsx(xlsxFile = path, startRow = 2, cols = 1:5)

  names(ici) <- c(
    "cr_no", "cas_no", "cas_name", "aicis_approved_chemical_name_aacn",
    "molecular_formula"
  )

  ici <- transform(
    ici,
    cr_no = as.integer(cr_no),
    cas_no = ifelse(
      test = cas_no == "Confidential",
      yes = NA_character_,
      no = cas_no
    )
  )

  if (clean_non_ascii) {

    ici <- transform(
      ici,
      cas_name = .clean_non_ascii(cas_name),
      molecular_formula = .clean_non_ascii(molecular_formula)
    )

  }

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
    version <- unlist(strsplit(version, split = " - "))[2]
    ici <- transform(ici, version = version)
  }

  ici

}
