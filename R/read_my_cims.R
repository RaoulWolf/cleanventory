#' @title Read-In and Clean the Malaysia Chemical Information Management System
#'   Inventory
#' @description This function reads-in and automatically cleans the Malaysia
#'   Chemical Information Management System (CIMS) inventory.
#' @param path (Character) The path to the CSV file.
#' @details The function reads-in and cleans the United States Chemical Data
#'   Reporting inventory.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @examples \dontrun{
#' path <- "cims.csv"
#'
#' cims <- read_my_cims(path)
#' }
#' @importFrom utils read.delim
#' @export
read_my_cims <- function(path, clean_non_ascii = FALSE) {

  cims <- utils::read.delim(
    file = path,
    na.strings = c("-", "Not Available", "None available"),
    colClasses = c(rep("character", times = 3), "NULL")
  )
  colnames(cims) <- c("cas_no", "chemical_name", "iupac_name")

  cims <- transform(cims, id = 1:nrow(cims))

  cims_split <- split(cims, f = ~ id)

  cims_clean <- lapply(
    cims_split,
    FUN = function(x) {
      if (.check_cas(x$cas_no)) {
        return(x)
      } else {
        cas_split <- unlist(strsplit(x$cas_no, split = "\\(|\\)"))
        cas_list <- unique(cas_split[.check_cas(cas_split)])

        if (length(cas_list) == 0L) {
          cas_list <- NA_character_
        }

        cas_df <- data.frame(
          cas_no = cas_list,
          chemical_name = x$chemical_name,
          iupac_name = x$iupac_name,
          id = x$id,
          stringsAsFactors = FALSE
        )

        return(cas_df)

      }
    }
  )

  cims <- do.call(what = "rbind", args = c(cims_clean, make.row.names = FALSE))

  cims <- subset(cims, select = -c(id))

  if (clean_non_ascii) {
    cims <- transform(
      cims,
      chemical_name = .clean_non_ascii(chemical_name),
      iupac_name = .clean_non_ascii(iupac_name)
    )
  }

  cims <- unique(cims)
  row.names(cims) <- NULL

  cims

}
