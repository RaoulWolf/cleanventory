# read_cn_iecsc <- function(path) {
#
#   pre_iecsc <- suppressMessages(pdftools::pdf_data(path))
#   pre_iecsc_1 <- pre_iecsc[3]
#   pre_iecsc_2 <- pre_iecsc[4:4058]
#   pre_iecsc_3 <- pre_iecsc[4059:length(pre_iecsc)]
#
#   pre_iecsc_1 <- lapply(
#     pre_iecsc_1,
#     FUN = function(x) {
#       res <- subset(x, subset = height < 14 & (y >= 173 & y < 560))
#       return(res)
#     }
#   )
#
#   pre_iecsc_2 <- lapply(
#     pre_iecsc_2,
#     FUN = function(x) {
#       res <- subset(x, subset = y >= 126 & y < 560)
#       return(res)
#     }
#   )
#
#   pre_iecsc_3 <- lapply(
#     pre_iecsc_3,
#     FUN = function(x) {
#       res <- subset(x, subset = y >= 92 & y < 806)
#       return(res)
#     }
#   )
#
#   x <- pre_iecsc_3[[1]]
#
#   iecsc_3 <- lapply(
#     pre_iecsc_3[5],
#     FUN = function(x) {
#       pre_res <- x[order(x$x, x$y), ]
#       pre_res <- transform(pre_res, serial_number = x == 478L)
#       pre_res <- pre_res[order(pre_res$y, -pre_res$x), ]
#       pre_res <- transform(pre_res, serial_number = cumsum(serial_number))
#       pre_res <- pre_res[order(pre_res$y, pre_res$x), ]
#
#       pre_split <- split(pre_res, ~ serial_number)
#
#       res <- do.call(
#         what = "rbind",
#         args = c(
#           lapply(
#             pre_split[1],
#             FUN = function(y) {
#               out <- data.frame(
#                 serial_number = y[y$x <= 96L, ]$text,
#                 class_name = paste(y[y$x >= 272L & y$x < 478L, ]$text, collapse = " "),
#                 serial_no = y[y$x == 478L, ]$text,
#                 stringsAsFactors = FALSE
#               )
#               return(out)
#             }
#           ),
#           make.row.names = FALSE
#         )
#       )
#
#       return(res)
#     }
#   )
#
#
#   y <- subset(res, subset = y <= 251)
#   y <- y[order(y$x, y$y), ]
#   y <- transform(
#     y,
#     colname = ifelse(
#       test = x < 112,
#       yes = "serial_number",
#       no = ifelse(
#         test = x >= 112 & x < 235,
#         yes = "chinese_name",
#         no = ifelse(
#           test = x > 235 & x < 318,
#           yes = "chinese_alias",
#           no = ifelse(
#             test = x >= 318 & x < 516,
#             yes = "english_name",
#             no = ifelse(
#               test = x >= 516 & x < 665,
#               yes = "english_alias",
#               no = ifelse(
#                 test = x >= 665 & x < 722,
#                 yes = "molecular_formula",
#                 no = ifelse(
#                   test = x >= 722,
#                   yes = "cas_number_or_serial_number",
#                   no = NA_character_
#                 )
#               )
#             )
#           )
#         )
#       )
#     ))
#   y <- subset(y, subset = !(colname %in% c("chinese_name", "chinese_alias", "molecular_formula")))
#   y <- transform(
#     y,
#     colname = factor(colname, levels = c("serial_number", "english_name", "english_alias", "cas_number_or_serial_number"))
#   )
#
#   y_split <- split(y, ~ colname)
#
#   do.call(
#     what = "data.frame",
#     args = lapply(
#     y_split,
#     FUN = function(x) {
#       res <- x[order(x$y, x$x), ]
#       return(paste(x$text, collapse = " "))
#     }
#   )
#   ) |>
#     transform(serial_number = as.integer(serial_number)) |>
#     str()
#
#   y <- transform(
#     y,
#     col = ifelse(
#
#     )
#   )
#
#
# }
