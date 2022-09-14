#' @title Read-In and Clean the United States Chemical Data Reporting Inventory
#' @description This function reads-in and automatically cleans the United
#'   States Chemical Data Reporting inventory.
#' @param path (Character) The path to the CSV file.
#' @details The function reads-in and cleans the United States Chemical Data
#'   Reporting inventory.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @examples \dontrun{
#' path <- "2020 CDR Consumer and Commercial Use.csv"
#'
#' cdr <- read_us_cdr(path)
#' }
#' @importFrom utils read.csv
#' @export
read_us_cdr <- function(path) {

  if (grepl("Nationally Aggregated Production Volumes", path)) {

    cdr <- utils::read.csv(
      file = path,
      colClasses = c(rep(NA, times = 4), rep("NULL", times = 4))
    )

    colnames(cdr) <- c(
      "chemical_name", "chemical_id", "chemical_id_wo_dashes",
      "chemical_id_type"
    )

  } else {

    cdr <- utils::read.csv(
      file = path,
      colClasses = c(rep(NA, times = 5), rep("NULL", times = 72))
    )

    colnames(cdr) <- c(
      "chemical_report_id", "chemical_name", "chemical_id",
      "chemical_id_wo_dashes", "chemical_id_type"
    )

  }

  cdr <- transform(
    cdr,
    chemical_id = ifelse(
      test = chemical_id_type == "CASRN" & !grepl("-", chemical_id),
      yes = sapply(
        chemical_id,
        FUN = function(x) {
          cas_1 <- substr(x, start = 1, stop = nchar(x) - 3)
          cas_2 <- substr(x, start = nchar(x) - 2, stop = nchar(x) - 1)
          cas_3 <- substring(text = x, first = nchar(x))
          cas <- paste(cas_1, cas_2, cas_3, sep = "-")
          return(cas)
        }
      ),
      no = chemical_id
    )
  )

  cdr <- transform(
    cdr,
    chemical_id = ifelse(
      test = chemical_id_type == "CASRN" & !.check_cas(chemical_id),
      yes = NA_character_,
      no = chemical_id
    )
  )

  cdr

}
