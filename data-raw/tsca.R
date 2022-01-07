# download

tmp <- tempdir()

url <- "https://www.epa.gov/system/files/other-files/2021-08/csv-non-cbi-tsca-inventory-202108.zip"

# splitting URL to retrieve contextual information

url_split <- unlist(strsplit(url, split = "/"))

zip_file <- url_split[grepl(pattern = ".zip", url_split)]

last_created <- url_split[grepl(
  pattern = "202[[:digit:]]-",
  url_split
)]

download.file(
  url = url,
  destfile = paste(tmp, zip_file, sep = "/"),
  mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
)

# unzip

zip_list <- unzip(
  zipfile = paste(tmp, zip_file, sep = "/"),
  list = TRUE
)

file_name <- zip_list$Name[grepl(pattern = "TSCA", zip_list$Name)]

unzip(
  zipfile = paste(tmp, zip_file, sep = "/"),
  files = file_name,
  exdir = tempdir()
)

# read CSV

tsca <- read.csv(
  file = paste(tmp, file_name, sep = "/"),
  na.strings = c(""),
  colClasses = c("UID" = "character", "EXP" = "integer")
)

# remove temporary files

file.remove(
  c(
    paste(tmp, zip_file, sep = "/"),
    paste(tmp, file_name, sep = "/")

  )
)

# column names to lower case

colnames(tsca) <- tolower(colnames(tsca))

# adding "last created" column for version control

tsca$last_created <- last_created

# exporting data as RDA

usethis::use_data(tsca, overwrite = TRUE)
