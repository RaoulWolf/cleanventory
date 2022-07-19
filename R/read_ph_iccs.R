#' @title Read-In and Clean the Philippines Inventory of Chemicals and Chemical
#'   Substances
#' @description This function reads-in and automatically cleans the Philippines
#'   Inventory of Chemicals and Chemical Substances.
#' @param path (Character) The path to the \code{iccs} PDF file. Not used
#'   for \code{emb20} or \code{emb21}.
#' @param clean_non_ascii (Logical) Should the non-ASCII characters be
#'   reasonably converted? Defaults to \code{FALSE}.
#' @details This function reads-in and automatically cleans the Philippines
#'   Inventory of Chemicals and Chemical Substances.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with the 2017 version.
#' @examples \dontrun{
#' download.file(
#'   url =
#'     "https://chemical.emb.gov.ph/wp-content/uploads/2020/07/PICCS.2017.pdf",
#'   destfile = "PICCS.2017.pdf"
#' )
#'
#' path <- "PICCS.2017.pdf"
#'
#' piccs <- read_ph_iccs(path)
#' }
#' @importFrom pdftools pdf_data
#' @importFrom utils tail
#' @export
read_ph_iccs <- function(path, clean_non_ascii = FALSE) {

  if (!is.logical(clean_non_ascii) || is.na(clean_non_ascii)) {
    clean_non_ascii <- FALSE
  }

  pre_iccs <- pdftools::pdf_data(path, font_info = TRUE)

    iccs_raw <- lapply(
      pre_iccs,
      FUN = function(x) {

        pre_res <- subset(
          x,
          subset = font_name != "ABCDEE+Calibri-Bold" & font_size >= 12
        )
        pre_res <- pre_res[order(pre_res$y), ]
        pre_res <- transform(
          pre_res,
          y_diff =
            pre_res$y - c(min(pre_res$y), pre_res$y[1:(nrow(pre_res) - 1L)])
        )
        pre_res <- transform(
          pre_res,
          y_diff_cat = ifelse(y_diff >= 15L, TRUE, FALSE)
        )
        pre_res <- transform(pre_res, y_diff_cat = 1L + cumsum(y_diff_cat))

        pre_res_split <- split(pre_res, ~ y_diff_cat)

        res <- do.call(
          what = "rbind",
          args = c(
            lapply(
              pre_res_split,
              FUN = function(y) {

                part_res <- data.frame(
                  cas_rn = ifelse(
                    test = is.null(y[y$x < 150L, ]$text),
                    yes = NA_character_,
                    no = y[y$x < 150L, ]$text
                  ),
                  chemical_name = paste(y[y$x > 150L, ]$text, collapse = " ")
                )

                return(part_res)

              }
            ),
            make.row.names = FALSE
          )
        )

        return(res)

      }
    )

    iccs <- do.call(what = "rbind", args = c(iccs_raw, make.row.names = FALSE))

    iccs <- transform(
      iccs,
      cas_rn = ifelse(
        test = cas_rn == "13152521-11-6" & chemical_name == "5H-cyclopenta[H]quinazoline, 6,7,8,9-tetrahydro-7,7,8,9,9-pentamethyl-",
        yes = "1315251-11-6",
        no = ifelse(
          test = cas_rn == "16442-16-2" & chemical_name == "Alanine, N,N, bis (carboxymethyl) trisodium salt",
          yes = "164462-16-2",
          no = ifelse(
            test = cas_rn == "5117" & chemical_name == "4-(1-oxo-2-propenyl)-morpholine",
            yes = "5117-12-4",
            no = cas_rn
          )
        )
      )
    )
    iccs <- unique(subset(iccs, subset = .check_cas(cas_rn)))
    row.names(iccs) <- NULL

    if (clean_non_ascii) {
      iccs <- transform(iccs, chemical_name = .clean_non_ascii(chemical_name))
    }

    iccs

}
