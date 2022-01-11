# Setting up a temporary path and defining the URLs from the official website:
# https://echa.europa.eu/en/information-on-chemicals/annex-vi-to-clp

tmp <- tempdir()

urls <- c(
  "https://echa.europa.eu/documents/10162/17218/annex_vi_clp_table_atp09_en.xlsx/7e62b5d4-ea9f-4671-8022-e52cdbe88c2a?t=1537522562541",
  "https://echa.europa.eu/documents/10162/17218/annex_vi_clp_table_atp10_en.xlsx/a4e1a93a-dac7-abc7-b106-7f63e877c3c8?t=1552581078113",
  "https://echa.europa.eu/documents/10162/17218/annex_vi_clp_table_atp13_en.xlsx/83d29faf-89e4-f140-2cff-481e1c2d7f9e?t=1553184240440",
  "https://echa.europa.eu/documents/10162/17218/annex_vi_clp_table_atp14_en.xlsx/c767afd2-4d53-b8d5-de2b-0820680cac95?t=1589980064047",
  "https://echa.europa.eu/documents/10162/17218/annex_vi_clp_table_atp15_en.xlsx/27c0e515-0da2-5eb0-b5ca-3ba8556f1f6a?t=1608304207954",
  "https://echa.europa.eu/documents/10162/17218/annex_vi_clp_table_atp17_en.xlsx/4dcec79c-f277-ed68-5e1b-d435900dbe34?t=1638888918944"
)


# Splitting the URLs to retrieve the XLSX file names

urls_split <- unlist(strsplit(urls, split = "/"))

file_names <- urls_split[grepl(pattern = ".xlsx", urls_split)]

# Downloading the XLSX files to the temporary location

invisible(
  mapply(
    FUN = "download.file",
    url = urls,
    destfile = paste(tmp, file_names, sep = "/"),
    MoreArgs = list(
      quiet = TRUE,
      mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
    )
  )
)

# Read-in the CLP XLSX in "cleanventory" format

clp <- lapply(
  paste(tmp, file_names, sep = "/"),
  FUN = cleanventory::read_clp
)

clp <- do.call(what = "rbind", args = c(clp, make.row.names = FALSE))

# Remove temporary files

file.remove(paste(tmp, file_names, sep = "/"))

# Export the data as RDA

save(clp, file = "data/clp.rda")
tools::resaveRdaFiles(paths = "data/clp.rda")
