#' @title Read-In and Clean the ECHA EC Inventory Data Set
#' @description This function reads-in and automatically cleans the ECHA EC
#'   data set.
#' @param path (Character) The path to the CSV file.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#' reasonably converted? Defaults to \code{FALSE}.
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
#' eci <- read_eu_eci(path)
#' }
#' @importFrom utils read.csv
#' @export
read_eu_eci <- function(path, clean_non_ascii = FALSE) {

  if (!is.logical(clean_non_ascii) || is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  eci <- utils::read.csv(
    file = path,
    na.strings = c("", "-"),
    stringsAsFactors = FALSE
  )

  colnames(eci) <- c(
    "id", "ec_name", "ec_no", "cas_no", "molecular_formula", "description",
    "infocard_url", "echa_name"
  )

  eci <- transform(
    eci,
    cas_no = sapply(
      cas_no,
      FUN = function(x) {
        if (grepl(pattern = "/", x)) {
          cas_split <- unlist(strsplit(x, split = "/"))
          cas_new <- paste(
            cas_split[3], cas_split[2], as.integer(cas_split[1]), sep = "-"
          )
          return(cas_new)
        } else {
          return(x)
        }
      }
    )
  )

  if (clean_non_ascii) {
    eci <- transform(
      eci,
      eci_name = .clean_non_ascii(ec_name),
      description = .clean_non_ascii(description),
      echa_name = .clean_non_ascii(echa_name))
  }

  eci

}
