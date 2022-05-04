#' @title Read-In and Clean the ECHA EC Data Set
#' @description This function reads-in and automatically cleans the ECHA EC
#'   data set.
#' @param path (Character) The path to the CSV file.
#' @param clean_non_ascii (Logical) Should non-ASCII characters (Greek
#'   letters, the plus-minus sign, etc.) be cleaned? Defaults to \code{FALSE}.
#' @param version (Logical) Should the "version" information (i.e., the date
#'   of creation) be included? Defaults to \code{FALSE}.
#' @details The function reads-in and cleans the ECHA EC data set into long
#'   flat format.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with the "version" of 2022-01-11.
#' @examples \dontrun{
#' download.file(
#'   url = paste0(
#'     "https://echa.europa.eu/documents/10162/17222/ec_inventory_en.csv/",
#'     "326d9adb-27ed-5460-a2da-4f651b81e4b3"
#'     ),
#'   destfile = "ec_inventory_en.csv"
#' )
#'
#' path <- "ec_inventory_en.csv"
#'
#' ec <- read_ec(path)
#' }
#' @importFrom utils read.csv
#' @export
read_ec <- function(path, clean_non_ascii = FALSE, version = FALSE) {

  if (!is.logical(clean_non_ascii) || is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  ec <- utils::read.csv(
    file = path,
    na.strings = c("", "-"),
    stringsAsFactors = FALSE
  )

  colnames(ec) <- c(
    "id", "ec_name", "ec_no", "cas_no", "molecular_formula", "description",
    "infocard_url", "echa_name"
  )

  if (clean_non_ascii) {
    ec <- transform(
      ec,
      ec_name = .clean_non_ascii(ec_name),
      description = .clean_non_ascii(description),
      echa_name = .clean_non_ascii(echa_name))
  }

  if (!is.logical(version) || is.na(version)) {
    version <- FALSE
  }

  if (version) {
    ec <- transform(ec, version = paste("Unknown,", Sys.Date()))
  }

  ec

}
