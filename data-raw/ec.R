# download

tmp <- tempdir()

url <- "https://echa.europa.eu/documents/10162/17222/ec_inventory_en.csv/326d9adb-27ed-5460-a2da-4f651b81e4b3"

# splitting URL to retrieve contextual information

url_split <- unlist(strsplit(url, split = "/"))

file_name <- url_split[grepl(pattern = ".csv", url_split)]

download.file(
  url = url,
  destfile = paste(tmp, file_name, sep = "/"),
  mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
)

# read CSV

ec <- read.csv(
  file = paste(tmp, file_name, sep = "/"),
    na.strings = c("", "-")
)

colnames(ec) <- c(
  "id", "ec_name", "ec_no", "cas_no", "molecular_formula", "description",
  "infocard_url", "echa_name"
)

# remove temporary files

file.remove(
  c(
    paste(tmp, file_name, sep = "/")
  )
)

# adding ATP number and cleaning the file into flat format

ec$version <- paste("Unknown,", Sys.Date())

# exporting data as RDA

save(ec, file = "data/ec.rda")
tools::resaveRdaFiles(paths = "data/ec.rda")
