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

clp <- .clean_clp_chemical_indices(clp)

# exporting data as RDA

save(clp, file = "data/clp.rda")
tools::resaveRdaFiles(paths = "data/clp.rda")
