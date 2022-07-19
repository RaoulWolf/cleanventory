#' @title Read-In and Clean the Japanese Chemical Substance Control Law
#'   Inventory
#' @description This function reads-in and automatically cleans the Japanese
#'   Chemical Substance Control Law inventory.
#' @param path (Character) The path to the TSV file.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#'   reasonably converted? Defaults to \code{FALSE}.
#' @details The three TSV files have to be manually downloaded from the
#'   following website:
#'
#'   * https://www.nite.go.jp/en/chem/chrip/chrip_search/sltLst
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @examples \dontrun{
#' path <- "Japan CSCL_ Existing Chemical Substances.tsv"
#'
#' cscl <- read_jp_cscl(path)
#' }
#' @importFrom utils read.delim
#' @export
read_jp_cscl <- function(path, clean_non_ascii = FALSE) {

  if (!is.logical(clean_non_ascii) || is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  cscl_raw <- utils::read.delim(
    file = path,
    sep = "\t",
    na.strings = c("", "-")
  )

  colnames(cscl_raw) <- c(
    "no", "chrip_id", "cas_rn", "cas_identity", "chemical_substance_name"
  )

  cscl <- transform(
    cscl_raw,
    cas_rn = ifelse(
      test = .check_cas(cas_rn),
      yes = cas_rn,
      no = NA_character_
    )
  )

  if (clean_non_ascii) {
    cscl <- transform(
      cscl,
      chemical_substance_name = .clean_non_ascii(chemical_substance_name)
    )
  }

  row.names(cscl) <- NULL

  cscl

}
