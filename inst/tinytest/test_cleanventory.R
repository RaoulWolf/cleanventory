
# clp

expect_equal(
  dim(
    read_clp(
      path = {

        tmp <- tempdir()

        download.file(
          url = paste0(
            "https://echa.europa.eu/documents/10162/17218/",
            "annex_vi_clp_table_atp17_en.xlsx/",
            "4dcec79c-f277-ed68-5e1b-d435900dbe34?t=1638888918944"
          ),
          destfile = paste(tmp, "annex_vi_clp_table_atp17_en.xlsx", sep = "/"),
          quiet = TRUE,
          mode = ifelse(.Platform$OS.type == "windows", "wb", "")
        )

        path <- paste(tmp, "annex_vi_clp_table_atp17_en.xlsx", sep = "/")

        path

      },
      atp = FALSE
    )
  ),
  c(4702L, 4L)
)

# ec

expect_equal(
  dim(
    read_ec(
      path = paste0(
        "https://echa.europa.eu/documents/10162/17222/ec_inventory_en.csv/",
        "326d9adb-27ed-5460-a2da-4f651b81e4b3"
      ),
      version = TRUE
    )
  ),
  c(106213L, 9L)
)

# tsca

expect_equal(
  dim(
    read_tsca(
      path = {

        tmp <- tempdir()

        download.file(
          url = paste0(
            "https://www.epa.gov/system/files/other-files/2021-08/",
            "csv-non-cbi-tsca-inventory-202108.zip"
          ),
          destfile = paste(
            tmp,
            "csv-non-cbi-tsca-inventory-202108.zip",
            sep = "/"
          ),
          quiet = TRUE,
          mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
        )
        unzip(zipfile = paste(
          tmp,
          "csv-non-cbi-tsca-inventory-202108.zip",
          sep = "/"
        ),
        exdir = tmp
        )

        file_names <- list.files(tmp)

        file_path <- file_names[grepl(pattern = "TSCA", file_names)]

        path <- paste(tmp, file_path, sep = "/")

        path

      },
      last_created = FALSE
    )
  ),
  c(68191L, 10L)
)
