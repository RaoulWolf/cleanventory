
# clp

expect_equal(
  dim(
    read_eu_clp(
      path = {

        options(timeout = max(300, getOption("timeout")))

        tmp <- tempdir()

        download.file(
          url = paste0(
            "https://echa.europa.eu/documents/10162/17218/",
            "annex_vi_clp_table_atp17_en.xlsx/",
            "4dcec79c-f277-ed68-5e1b-d435900dbe34?t=1638888918944"
          ),
          destfile = paste(tmp, "annex_vi_clp_table_atp17_en.xlsx", sep = "/"),
          quiet = TRUE,
          mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
        )

        path <- paste(tmp, "annex_vi_clp_table_atp17_en.xlsx", sep = "/")

        path

      }
    )
  ),
  c(4702L, 4L)
)

# ec

expect_equal(
  dim(
    read_eu_eci(
      path = paste0(
        "https://echa.europa.eu/documents/10162/17222/ec_inventory_en.csv/",
        "326d9adb-27ed-5460-a2da-4f651b81e4b3"
      )
    )
  ),
  c(106213L, 8L)
)

# tsca

# expect_equal(
#   dim(
#     read_us_tsca(
#       path = {
#
#         tmp <- tempdir()
#
#         download.file(
#           url = paste0(
#             "https://www.epa.gov/system/files/other-files/2022-03/",
#             "csv-non-cbi-tsca-inventory-022022.zip"
#           ),
#           destfile = paste(
#             tmp,
#             "csv-non-cbi-tsca-inventory-022022.zip",
#             sep = "/"
#           ),
#           quiet = TRUE,
#           mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
#         )
#         unzip(zipfile = paste(
#           tmp,
#           "csv-non-cbi-tsca-inventory-022022.zip",
#           sep = "/"
#         ),
#         exdir = tmp
#         )
#
#         file_names <- list.files(tmp)
#
#         file_path <- file_names[grepl(pattern = "TSCA", file_names)]
#
#         path <- paste(tmp, file_path, sep = "/")
#
#         path
#
#       }
#     )
#   ),
#   c(68576L, 10L)
# )
