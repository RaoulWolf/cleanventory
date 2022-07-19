#' @title Read-In and Clean the US EPA TSCA Data Set
#' @description This function reads-in and automatically cleans the US EPA
#'   TSCA data set.
#' @param path (Character) The path to the extracted CSV file.
#' @details The function reads-in and cleans the US EPA TSCA data set into flat
#'   format.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with version 2022-02.
#' @examples \dontrun{
#' download.file(
#'   url = paste0(
#'     "https://www.epa.gov/system/files/other-files/2022-03/",
#'     "csv-non-cbi-tsca-inventory-022022.zip"
#'     ),
#'   destfile = "csv-non-cbi-tsca-inventory-022022.zip"
#' )
#'
#' unzip(zipfile = "csv-non-cbi-tsca-inventory-022022.zip")
#'
#' file_name <- list.files()
#'
#' path <- file_name[grepl(pattern = "TSCA", file_name)]
#'
#' tsca <- read_us_tsca(path)
#' }
#' @importFrom utils read.csv
#' @export
read_us_tsca <- function(path) {

  tsca <- utils::read.csv(
    file = path,
    na.strings = c(""),
    stringsAsFactors = FALSE
  )

  colnames(tsca) <- c(
    "id", "cas_rn", "cas_reg_no", "uid", "exp", "chem_name", "def", "uvcb",
    "flag", "activity"
  )

  tsca

}
