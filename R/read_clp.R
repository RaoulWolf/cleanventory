#' @title Read-In and Clean the ECHA CLP Annex VI Data Set
#' @description This function reads-in and automatically cleans the ECHA CLP
#'   Annex VI data set.
#' @param path (Character) The path to the XLSX file.
#' @param atp (Logical) Should the "atp" version information be included?
#'   Defaults to \code{TRUE}.
#' @details The function reads-in and cleans the ECHA CLP Annex VI data set
#'   into long flat format.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with "atp" versions 9, 10, 13, 14, 15, and 17.
#' @examples \dontrun{
#' download.file(
#'   url = paste0(
#'     "https://echa.europa.eu/documents/10162/17218/",
#'     "annex_vi_clp_table_atp17_en.xlsx/",
#'     "4dcec79c-f277-ed68-5e1b-d435900dbe34?t=1638888918944"
#'   ),
#'   destfile = "annex_vi_clp_table_atp17_en.xlsx"
#' )
#'
#' path <- "annex_vi_clp_table_atp17_en.xlsx"
#'
#' clp <- read_clp(path)
#' }
#' @importFrom openxlsx read.xlsx
#' @export
read_clp <- function(path, atp = TRUE) {

  clp <- openxlsx::read.xlsx(
    xlsxFile = path,
    startRow = 7,
    colNames = FALSE,
    cols = 1:4,
    na.strings = "-"
  )

  colnames(clp) <- c(
    "index_no", "international_chemical_identification", "ec_no", "cas_no"
  )

  clp_split <- split(clp, clp$index_no)

  clp_res <- lapply(
    clp_split,
    FUN = function(x) {

      if (any(grepl(pattern = "\\[[[:digit:]]+\\]\n",
                    x$international_chemical_identification),
              grepl(pattern = "\\[[[:digit:]]+\\]\n", x$ec_no),
              grepl(pattern = "\\[[[:digit:]]+\\]\n", x$cas_no))) {

        international_chemical_identification_split <- unlist(
          strsplit(
            x$international_chemical_identification,
            split = "\\[[[:digit:]]+\\]\n"
          )
        )

        international_chemical_identification_index <- unlist(
          regmatches(
            x$international_chemical_identification,
            m = gregexpr(
              pattern = "\\[[[:digit:]]+\\]",
              text = x$international_chemical_identification
            )
          )
        )

        international_chemical_identification_index <- as.integer(
          unlist(
            regmatches(
              international_chemical_identification_index,
              m = gregexpr(
                pattern = "[[:digit:]]+",
                text = international_chemical_identification_index
              )
            )
          )
        )

        international_chemical_identification_split <- trimws(
          gsub(
            pattern = "\n",
            replacement = " ",
            international_chemical_identification_split
          )
        )

        international_chemical_identification_df <- data.frame(
          index = international_chemical_identification_index,
          international_chemical_identification =
            international_chemical_identification_split,
          stringsAsFactors = FALSE
        )

        ec_no_split <- unlist(
          strsplit(x$ec_no, split = "\\[[[:digit:]]+\\]\n")
        )

        ec_no_index <- unlist(
          regmatches(
            x$ec_no,
            m = gregexpr(pattern = "\\[[[:digit:]]+\\]", text = x$ec_no)
          )
        )

        ec_no_index <- as.integer(
          unlist(
            regmatches(
              ec_no_index,
              m = gregexpr(pattern = "[[:digit:]]+", text = ec_no_index)
            )
          )
        )

        if (length(ec_no_index) == 0L) {

          ec_no_index <- NA_integer_

        }

        ec_no_split <- trimws(
          gsub(pattern = "\n]", replacement = "", ec_no_split)
        )

        ec_no_split <- ifelse(
          test = nchar(ec_no_split) < 9L, yes = NA_character_, no = ec_no_split
        )

        ec_no_df <- data.frame(
          index = ec_no_index,
          ec_no = ec_no_split,
          stringsAsFactors = FALSE
        )

        cas_no_split <- unlist(
          strsplit(x$cas_no, split = "\\[[[:digit:]]+\\]\n")
        )

        cas_no_index <- unlist(
          regmatches(
            x$cas_no,
            m = gregexpr(pattern = "\\[[[:digit:]]+\\]", text = x$cas_no)
          )
        )

        cas_no_index <- as.integer(
          unlist(
            regmatches(
              cas_no_index,
              m = gregexpr(pattern = "[[:digit:]]+", text = cas_no_index)
            )
          )
        )

        if (length(cas_no_index) == 0L) {

          cas_no_index <- NA_integer_

        }

        cas_no_split <- trimws(
          gsub(pattern = "\n]", replacement = "", cas_no_split)
        )

        cas_no_df <- data.frame(
          index = cas_no_index,
          cas_no = cas_no_split,
          stringsAsFactors = FALSE
        )

        final_df <- data.frame(
          index = 1:max(
            international_chemical_identification_index,
            ec_no_index,
            cas_no_index,
            na.rm = TRUE
          ),
          index_no = x$index_no,
          stringsAsFactors = FALSE
        )

        final_df <- merge(
          merge(
            merge(
              final_df,
              international_chemical_identification_df,
              by = "index",
              all.x = TRUE
            ),
            ec_no_df,
            by = "index",
            all.x = TRUE
          ),
          cas_no_df,
          by = "index",
          all.x = TRUE
        )

        final_df <- subset(final_df, select = -index)

      } else {

        final_df <- data.frame(
          index_no = x$index_no,
          international_chemical_identification = trimws(
            gsub(
              pattern = "\n",
              replacement = " ", x$international_chemical_identification
            )
          ),
          ec_no = x$ec_no,
          cas_no = x$cas_no,
          stringsAsFactors = FALSE
        )

      }

      final_df$ec_no <- ifelse(
        test = final_df$index_no == "606-144-00-6" &
          final_df$cas_no == "57960-19-7",
        yes = NA_character_,
        no = final_df$ec_no
      )

      final_df

    }
  )

  clp_res <- do.call(what = "rbind", args = c(clp_res, make.row.names = FALSE))

  if (!is.logical(atp) || is.na(atp)) {

    atp <- TRUE

  }

  if (atp) {

    file_name <- unlist(strsplit(path, split = "/"))

    file_name <- file_name[grepl(pattern = ".xlsx", file_name)]

    atp_version <- regmatches(
      file_name,
      m = gregexpr(pattern = "[[:digit:]]", text = file_name)
    )

    atp_version <- as.integer(paste(unlist(atp_version), collapse = ""))

    clp_res <- transform(clp_res, atp = atp_version)

  }

  clp_res

}
