# Setting up a temporary path and defining the URL from the official website:
# https://www.epa.gov/tsca-inventory/how-access-tsca-inventory

tmp <- tempdir()

url <- "https://www.epa.gov/system/files/other-files/2021-08/csv-non-cbi-tsca-inventory-202108.zip"

# Splitting the URL to retrieve the ZIP file name

url_split <- unlist(strsplit(url, split = "/"))

zip_file <- url_split[grepl(pattern = ".zip", url_split)]

# Downloading the ZIP file to the temporary location

download.file(
  url = url,
  destfile = paste(tmp, zip_file, sep = "/"),
  mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
)

# Identify the TSCA CSV file name

zip_list <- unzip(
  zipfile = paste(tmp, zip_file, sep = "/"),
  list = TRUE
)

file_name <- zip_list$Name[grepl(pattern = "TSCA", zip_list$Name)]

# Unzipping the TSCA CSV from the ZIP file

unzip(
  zipfile = paste(tmp, zip_file, sep = "/"),
  files = file_name,
  exdir = tempdir()
)

# Read-in the TSCA CSV in "cleanventory" format

tsca <- cleanventory::read_tsca(path = paste(tmp, file_name, sep = "/"))

# Remove temporary files

file.remove(
  c(paste(tmp, zip_file, sep = "/"), paste(tmp, file_name, sep = "/"))
)

# Export the data as RDA

save(tsca, file = "data/tsca.rda")
tools::resaveRdaFiles(paths = "data/tsca.rda")
