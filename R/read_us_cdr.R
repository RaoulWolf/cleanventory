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

  if (grepl("2016", path)) {

    if (grepl("National Aggregate Production Volume", path)) {

      cdr <- utils::read.csv(
        file = path,
        colClasses = c(rep(NA, times = 2), rep("NULL", times = 4))
      )

      colnames(cdr) <- c("chemical_id_number", "stripped_chemical_id_number")

    } else if (grepl("Manufacturing Information", path)) {

      cdr <- utils::read.csv(
        file = path,
        colClasses = c(rep(NA, times = 5), rep("NULL", times = 36))
      )

      colnames(cdr) <- c(
        "consolidated_id", "chemical_id_number",
        "stripped_chemical_id_number", "chemical_name", "activity"
      )

    } else {

      cdr <- utils::read.csv(
        file = path,
        colClasses = c(rep(NA, times = 5), rep("NULL", times = 43))
      )

      colnames(cdr) <- c(
        "p_cdr_submissions_consolidated_id", "chemical_id_number",
        "stripped_chemical_id_number", "chemical_name", "activity"
      )

    }

    cdr <- transform(
      cdr,
      chemical_id_number = ifelse(
        test = !grepl("-", chemical_id_number),
        yes = sapply(
          chemical_id_number,
          FUN = function(x) {
            cas_1 <- substr(x, start = 1, stop = nchar(x) - 3)
            cas_2 <- substr(x, start = nchar(x) - 2, stop = nchar(x) - 1)
            cas_3 <- substring(text = x, first = nchar(x))
            cas <- paste(cas_1, cas_2, cas_3, sep = "-")
            return(cas)
          }
        ),
        no = chemical_id_number
      )
    )

    cdr <- transform(
      cdr,
      chemical_id_number = ifelse(
        test = !.check_cas(chemical_id_number),
        yes = NA_character_,
        no = chemical_id_number
      )
    )

  }

  if (grepl("2020", path)) {

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
        colClasses = c(
          rep(NA, times = 5),
          rep(
            "NULL",
            times = ifelse(
              test = grepl("Manufacturing-Import Information", path),
              yes = 59,
              no = 72
            )
          )
        )
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

  }

  cdr

}
