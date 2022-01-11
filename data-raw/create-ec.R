# Setting up a temporary path and defining the URL from the official website:
# https://echa.europa.eu/information-on-chemicals/ec-inventory

tmp <- tempdir()

url <- "https://echa.europa.eu/documents/10162/17222/ec_inventory_en.csv/326d9adb-27ed-5460-a2da-4f651b81e4b3"

# Splitting the URL to retrieve the CSV file name

url_split <- unlist(strsplit(url, split = "/"))

file_name <- url_split[grepl(pattern = ".csv", url_split)]

download.file(
  url = url,
  destfile = paste(tmp, file_name, sep = "/"),
  mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
)

# Read-in the EC CSV in "cleanventory" format

ec <- cleanventory::read_ec(
  path = paste(tmp, file_name, sep = "/"),
  version = TRUE
)

# Remove temporary files

file.remove(paste(tmp, file_name, sep = "/"))

# Export the data as RDA

save(ec, file = "data/ec.rda")
tools::resaveRdaFiles(paths = "data/ec.rda")
