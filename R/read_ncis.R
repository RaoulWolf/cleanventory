#' @title Read-In and Clean the South Korean National Chemical Information
#'   System Data Set
#' @description This function reads-in and automatically cleans the South
#'   Korean National Chemical Information System (NCIS) data set.
#' @param path (Character) The path to the XLSX file.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#' reasonably converted? Defaults to \code{FALSE}.
#' @param date (Logical) Should the date of the XLSX file be included?
#'   Defaults to \code{TRUE}.
#' @details The function reads-in and cleans the South Korean National Chemical
#'   Information System (NCIS) data set into long flat format.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with an XLSX retrieved on 3 May 2022.
#' @examples \dontrun{
#' path <- "Chemical+Search_20220503055738.xlsx"
#'
#' ncis <- read_ncis(path)
#' }
#' @importFrom openxlsx read.xlsx
#' @export
read_ncis <- function(path, clean_non_ascii = FALSE, date = TRUE) {

  if (!is.logical(clean_non_ascii) | is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  if (!is.logical(date) | is.na(date)) {
    date <- TRUE
  }

  ncis_1 <- openxlsx::read.xlsx(
    xlsxFile = path,
    sheet = 1,
    startRow = 2,
    cols = 1:3,
    na.strings = c("", " ", "\n")
  )

  names(ncis_1) <- c("cas_no", "chemical_name", "ke_no")

  ncis_2 <- openxlsx::read.xlsx(
    xlsxFile = path,
    sheet = 2,
    colNames = FALSE,
    cols = 1:3,
    na.strings = c("", " ", "\n")
  )

  names(ncis_2) <- c("cas_no", "chemical_name", "ke_no")

  ncis <- rbind(ncis_1, ncis_2)

  if (clean_non_ascii) {
    ncis <- transform(
      ncis,
      cas_no = .clean_non_ascii(cas_no),
      chemical_name = .clean_non_ascii(chemical_name)
    )
  }

  ncis <- transform(
    ncis,
    id = paste(
      as.integer(factor(cas_no)),
      as.integer(factor(chemical_name)),
      as.integer(factor(ke_no)),
      sep = "_"
    )
  )

  ncis_split <- split(ncis, ~ id)

  ncis_agg <- do.call(
    what = "rbind",
    args = c(
      lapply(
        ncis_split,
        FUN = function(x) {
          tbs <- grepl(pattern = ",|&", x$cas_no)
          if (tbs) {
            rnew <- trimws(unlist(strsplit(x$cas_no, split = ",|&")))
            res <- data.frame(
              cas_no = rnew,
              chemical_name = x$chemical_name,
              ke_no = x$ke_no,
              id = x$id,
              stringsAsFactors = FALSE
            )
            return(res)
          } else {
            return(x)
          }
        }
      ),
      make.row.names = FALSE
    )
  )

  ncis_agg <- subset(ncis_agg, select = -c(id))

  ncis_agg <- transform(
    ncis_agg,
    cas_no = ifelse(
      test = cas_no == "200098-00-0" & chemical_name == "Parathion-methyl",
      yes = "298-00-0",
      no = ifelse(
        test = cas_no == "76-02-2" & chemical_name == "Chloropicrin",
        yes = "76-06-2",
        no = cas_no
      )
    )
  )

  if (date) {

    path_split <- unlist(strsplit(path, split = "/"))

    file_name <- path_split[grepl(pattern = ".xlsx", path_split)]

    file_date <- gsub(pattern = "[^[:digit:]]", replacement = "", file_name)
    file_date <- substr(file_date, start = 1, stop = 8)
    file_date <- as.POSIXct(file_date, tz = "Asia/Seoul", format = "%Y%m%d")

    ncis_agg <- transform(ncis_agg, date = file_date)

  }

  ncis_agg

}
