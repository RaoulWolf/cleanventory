# download

tmp <- tempdir()

url <- "https://echa.europa.eu/documents/10162/17218/annex_vi_clp_table_atp17_en.xlsx/4dcec79c-f277-ed68-5e1b-d435900dbe34?t=1638888918944"

# splitting URL to retrieve contextual information

url_split <- unlist(strsplit(url, split = "/"))

file_name <- url_split[grepl(pattern = ".xlsx", url_split)]

download.file(
  url = url,
  destfile = paste(tmp, file_name, sep = "/"),
  mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
)

# read XLSX

clp <- as.data.frame(
  readxl::read_xlsx(
    path = paste(tmp, file_name, sep = "/"),
    range = cellranger::cell_limits(ul = c(6, 1), lr = c(NA, 4)),
    na = "-", trim_ws = FALSE
  )
)

colnames(clp) <- c(
  "index_no", "international_chemical_identification", "ec_no", "cas_no"
)

# remove temporary files

file.remove(
  c(
    paste(tmp, file_name, sep = "/")
  )
)

# adding ATP number and cleaning the file into flat format

clp$atp <- as.integer(
  paste(
    unlist(
      regmatches(
        file_name, m = gregexpr(
          pattern = "[[:digit:]]", text = file_name
          )
        )
      ),
    collapse = ""
    )
  )

.clean_clp_chemical_indices <- function(x) {

  x_split <- split(x, x$index_no)

  x_res <- lapply(x_split,
                  FUN = function(x) {

                    if (any(grepl(pattern = "\\[[[:digit:]]+\\]\r\n", x$international_chemical_identification),
                            grepl(pattern = "\\[[[:digit:]]+\\]\r\n", x$ec_no),
                            grepl(pattern = "\\[[[:digit:]]+\\]\r\n", x$cas_no))) {

                      international_chemical_identification_split <- unlist(strsplit(x$international_chemical_identification, split = "\\[[[:digit:]]+\\]\r\n"))
                      international_chemical_identification_index <- unlist(regmatches(x$international_chemical_identification, m = gregexpr(pattern = "\\[[[:digit:]]+\\]", text = x$international_chemical_identification)))
                      international_chemical_identification_index <- as.integer(unlist(regmatches(international_chemical_identification_index, m = gregexpr(pattern = "[[:digit:]]+", text = international_chemical_identification_index))))
                      international_chemical_identification_split <- trimws(gsub(pattern = "\r\n", replacement = " ", international_chemical_identification_split))
                      international_chemical_identification_df <- data.frame(index = international_chemical_identification_index,
                                                                             international_chemical_identification = international_chemical_identification_split,
                                                                             stringsAsFactors = FALSE)

                      ec_no_split <- unlist(strsplit(x$ec_no, split = "\\[[[:digit:]]+\\]\r\n"))
                      ec_no_index <- unlist(regmatches(x$ec_no, m = gregexpr(pattern = "\\[[[:digit:]]+\\]", text = x$ec_no)))
                      ec_no_index <- as.integer(unlist(regmatches(ec_no_index, m = gregexpr(pattern = "[[:digit:]]+", text = ec_no_index))))
                      if (length(ec_no_index) == 0) {
                        ec_no_index <- NA_integer_
                      }
                      ec_no_split <- trimws(gsub(pattern = "\r\n]", replacement = "", ec_no_split))
                      ec_no_split <- ifelse(nchar(ec_no_split) < 9, NA_character_, ec_no_split)

                      ec_no_df <- data.frame(index = ec_no_index,
                                             ec_no = ec_no_split,
                                             stringsAsFactors = FALSE)

                      cas_no_split <- unlist(strsplit(x$cas_no, split = "\\[[[:digit:]]+\\]\r\n"))
                      cas_no_index <- unlist(regmatches(x$cas_no, m = gregexpr(pattern = "\\[[[:digit:]]+\\]", text = x$cas_no)))
                      cas_no_index <- as.integer(unlist(regmatches(cas_no_index, m = gregexpr(pattern = "[[:digit:]]+", text = cas_no_index))))
                      if (length(cas_no_index) == 0) {
                        cas_no_index <- NA_integer_
                      }
                      cas_no_split <- trimws(gsub(pattern = "\r\n]", replacement = "", cas_no_split))
                      cas_no_df <- data.frame(index = cas_no_index,
                                              cas_no = cas_no_split,
                                              stringsAsFactors = FALSE)

                      final_df <- data.frame(index = 1:max(international_chemical_identification_index, ec_no_index, cas_no_index, na.rm = TRUE),
                                             index_no = x$index_no,
                                             stringsAsFactors = FALSE)

                      final_df <- merge(
                        merge(
                          merge(
                            final_df, international_chemical_identification_df, by = "index", all.x = TRUE),
                          ec_no_df, by = "index", all.x = TRUE),
                        cas_no_df, by = "index", all.x = TRUE)

                      final_df <- subset(final_df, select = -c(index))
                      final_df$atp <- x$atp

                    } else {

                      final_df <- data.frame(index_no = x$index_no,
                                             international_chemical_identification = trimws(gsub(pattern = "\r\n", replacement = " ", x$international_chemical_identification)),
                                             ec_no = x$ec_no,
                                             cas_no = x$cas_no,
                                             atp = x$atp,
                                             stringsAsFactors = FALSE)

                    }

                    final_df$ec_no <- ifelse(final_df$index_no == "606-144-00-6" & final_df$cas_no == "57960-19-7",NA_character_, final_df$ec_no)

                    final_df

                  })

  x_res <- do.call("rbind", args = c(x_res, make.row.names = FALSE))

  x_res

}

clp <- .clean_clp_chemical_indices(clp)

# exporting data as RDA

save(clp, file = "data/clp.rda")
tools::resaveRdaFiles(paths = "data/clp.rda")
