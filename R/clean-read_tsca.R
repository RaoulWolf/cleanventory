#' @title Read-In and Clean the US EPA TSCA Data Set
#' @description This function reads-in and automatically cleans the US EPA
#'   TSCA data set.
#' @param path (Character) The path to the extracted CSV file.
#' @param last_created (Logical) Should the "last created" information be
#'   extracted from the file name? Defaults to \code{TRUE}.
#' @details The function reads-in and cleans the US EPA TSCA data set into flat
#'   format.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with the "last created" version 2021-08.
#' @examples \dontrun{
#' zip_file <- download.file(
#'   url = paste0(
#'     "https://www.epa.gov/system/files/other-files/2021-08/",
#'     "csv-non-cbi-tsca-inventory-202108.zip"
#'     ),
#'   destfile = "csv-non-cbi-tsca-inventory-202108.zip"
#' )
#'
#' unzip(zipfile = zip_file)
#'
#' file_name <- list.files()
#'
#' path <- file_name[grepl(pattern = "TSCA", file_name)]
#'
#' tsca <- read_tsca(path)
#' }
#' @importFrom bit64 as.integer64
#' @importFrom utils read.csv
#' @export
read_tsca <- function(path, last_created = TRUE) {

  tsca <- utils::read.csv(
    file = path,
    na.strings = c(""),
    colClasses = c("UID" = "character", "EXP" = "integer"),
    stringsAsFactors = FALSE
  )

  colnames(tsca) <- c(
    "id", "cas_rn", "cas_reg_no", "uid", "exp", "chem_name", "def", "uvcb",
    "flag", "activity"
  )

  tsca <- transform(tsca, cas_reg_no = bit64::as.integer64(tsca$cas_reg_no))

  if (!is.logical(last_created) || is.na(last_created)) {

    last_created <- TRUE

  }

  if (last_created) {

    path_split <- unlist(strsplit(path, split = "/"))

    file_name <- path_split[grepl(pattern = ".csv", path_split)]

    file_date_split <- unlist(
      regmatches(
        file_name,
        m = gregexpr(pattern = "[[:digit:]]", text = file_name)
      )
    )

    file_year <- paste(file_date_split[1:4], collapse = "")

    file_month <- paste(file_date_split[5:6], collapse = "")

    last_created <- paste(file_year, file_month, sep = "-")

    tsca <- transform(tsca, last_created = last_created)

  }

  tsca

}
