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

clp <- cleanventory::read_clp(
  path = paste(tmp, file_name, sep = "/"),
)

# remove temporary files

file.remove(
  c(
    paste(tmp, file_name, sep = "/")
  )
)

# exporting data as RDA

save(clp, file = "data/clp.rda")
tools::resaveRdaFiles(paths = "data/clp.rda")
