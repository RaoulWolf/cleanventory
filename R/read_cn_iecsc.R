#' @title Read-In and Clean the Chinese Inventory of Existing Chemical
#'   Substances and Chemicals
#' @description This function reads-in and automatically cleans the Chinese
#'   Inventory of Existing Chemical Substances and Chemicals data set.
#' @param path (Character) The path to the PDF file.
#' @details The function reads-in and cleans the Chinese Inventory of Existing
#'   Chemical Substances and Chemicals data set into long flat format.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with the 2013 PDF.
#' @examples \dontrun{
#' path <- "2013.pdf"
#'
#' cn_iecsc <- read_cn_iecsc(path)
#' }
#' @importFrom pdftools pdf_data
#' @export
read_cn_iecsc <- function(path) {

  pre_iecsc <- suppressMessages(pdftools::pdf_data(path))

  iecsc_raw <- do.call(
    what = "c",
    args = lapply(
      pre_iecsc,
      FUN = function(x) {
        res <- subset(x, subset = .check_cas(trimws(text)))
        if (nrow(res) == 0L) {
          return(NULL)
        } else {
          return(res$text)
        }
      }
    )
  )

  iecsc <- data.frame(
    "cas_number" = unique(iecsc_raw),
    stringsAsFactors = FALSE
  )

  iecsc

}
