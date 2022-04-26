#' @title Read-In and Clean the Japanese NITE Chemical Management GHS
#'   Classification Results
#' @description This function reads-in and automatically cleans the Japanese
#'   NITE Chemical Management GHS Classification results.
#' @param path (Character) The path to the XLSX file.
#' @param version (Character) Should the "atp" version information be included?
#'   Defaults to \code{NULL}.
#' @details This function reads-in and automatically cleans the Japanese NITE
#'   Chemical Management GHS Classification results.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with the March 2022 version; GHS classifications ommitted.
#' @examples \dontrun{
#' download.file(
#'   url = "https://www.nite.go.jp/chem/english/ghs/files/list_all_e.xlsx",
#'   destfile = "list_all_e.xlsx"
#' )
#'
#' path <- "list_all_e"
#'
#' nite <- read_nite(path)
#' }
#' @importFrom openxlsx read.xlsx
#' @export
read_nite <- function(path, version = NULL) {

  nite <- openxlsx::read.xlsx(
    xlsxFile = path,
    cols = 1:4,
    na.strings = c("-", "", " ", " -")
  )

  colnames(nite) <- c("cas", "substance_name", "id", "fy")

  if (!is.null(version)) {
    nite <- transform(nite, version = version)
  }

  nite

}
