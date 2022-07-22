#' @title Read-In and Clean the Japanese NITE Chemical Management GHS
#'   Classification Results
#' @description This function reads-in and automatically cleans the Japanese
#'   NITE Chemical Management GHS Classification results.
#' @param path (Character) The path to the XLSX file.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#'   reasonably converted? Defaults to \code{FALSE}.
#' @details This function reads-in and automatically cleans the Japanese NITE
#'   Chemical Management GHS Classification results.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with the March 2022 version; GHS classifications omitted.
#' @examples \dontrun{
#' download.file(
#'   url = "https://www.nite.go.jp/chem/english/ghs/files/list_all_e.xlsx",
#'   destfile = "list_all_e.xlsx"
#' )
#'
#' path <- "list_all_e"
#'
#' nite <- read_jp_nite(path)
#' }
#' @importFrom openxlsx read.xlsx
#' @export
read_jp_nite <- function(path, clean_non_ascii = FALSE) {

  if (!is.logical(clean_non_ascii) || is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  nite <- openxlsx::read.xlsx(
    xlsxFile = path,
    cols = 1:6,
    na.strings = c("-", "", " ", " -")
  )

  colnames(nite) <- c(
    "cas", "cas_without_hyphen", "substance_name", "id", "fy", "new_revise"
  )

  nite <- transform(
    nite,
    cas = ifelse(
      test = .check_cas(cas),
      yes = cas,
      no = NA_character_
    ),
    cas_without_hyphen = as.integer(cas_without_hyphen)
  )

  if (clean_non_ascii) {
    nite <- transform(
      nite,
      substance_name = .clean_non_ascii(substance_name),
      id = .clean_non_ascii(id)
    )
  }

  nite

}
