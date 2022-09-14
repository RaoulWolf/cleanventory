#' @title Read-In and Clean the Substances in Preparations in Nordic Countries
#'   inventory
#' @description This function reads-in and automatically cleans the Substances
#'   in Preparations in Nordic Countries inventory.
#' @param path (Character) The path to the TSV file.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#'   reasonably converted? Defaults to \code{FALSE}.
#' @details This function reads-in and automatically cleans the Substances in
#'   Preparations in Nordic Countries inventory.
#'
#'   The file needs to be manually downloaded from the following URL:
#'   http://www.spin2000.net/spinmyphp/
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @examples \dontrun{
#' path <- "spin.tsv"
#'
#' spin <- read_xn_spin(path)
#' }
#' @importFrom utils read.delim
#' @export
read_xn_spin <- function(path, clean_non_ascii = FALSE) {

  if (!is.logical(clean_non_ascii) || is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  spin <- utils::read.delim(file = path, na.strings = "")
  colnames(spin) <- c("cas_no", "substances")

  spin <- transform(
    spin,
    cas_no = ifelse(
      test = .check_cas(cas_no),
      yes = cas_no,
      no = NA_character_
    )
  )

  if (clean_non_ascii) {
    spin <- transform(spin, substances = .clean_non_ascii(substances))
  }

  spin

}
