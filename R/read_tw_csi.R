#' @title Read-In and Clean the Taiwan Chemical Substance Inventory
#' @description This function reads-in and automatically cleans the Taiwan
#'   Chemical Substance Inventory.
#' @param path (Character) The path to the PDF file.
#' @param pages (Integer) Range of pages to read-in. See
#'   \link[pdftools]{pdf_convert} for details. Defaults to \code{NULL}, i.e.,
#'   all pages.
#' @param dpi (Integer) Resolution of the PDF image PNG render. See
#'   \link[pdftools]{pdf_convert} for details. Defaults to \code{600L}.
#' @param radius (Integer) Noise reduction radius. See
#'   \link[magick]{image_reducenoise} for details. Defaults to \code{2L}.
#' @param threshold (Integer) Black-and-white conversion threshold. See
#'   \link[magick]{image_threshold} for details. Defaults to \code{77L}.
#' @param whitelist (Character) Limited allowed character set, optimized to
#'   recognize CAS Registry Numbers. See \link[tesseract]{tesseract} for
#'   details. Defaults to \code{"- 0123456789CENP"}.
#' @details This function reads-in and automatically cleans the Taiwan
#'   Chemical Substance Inventory.
#' @return Returns a data frame.
#' @author Raoul Wolf (\url{https://github.com/RaoulWolf/})
#' @note Tested with the 1 January and 8 September 2019 versions.
#' @examples \dontrun{
#' download.file(
#'   url = paste(
#'     "https://gazette2.nat.gov.tw/EG_FileManager/eguploadpub/eg021170/ch08",
#'     "type3/gov82/num29/images/Eg01.pdf",
#'     sep = "/"
#'   ),
#'   destfile = "Eg01.pdf"
#' )tesseract
#'
#' path <- "Eg01.pdf"
#'
#' tcsi <- read_tw_csi(path)
#' }
#' @importFrom magick image_read image_reducenoise
#' @importFrom pdftools pdf_convert
#' @importFrom tesseract ocr
#' @export
read_tw_csi <- function(
    path, pages = NULL, dpi = 600L, radius = 2L, threshold = 77L,
    whitelist = "- 0123456789CENP"
) {

  file_name <- unlist(strsplit(path, split = "/"))
  file_name <- file_name[grepl(pattern = ".pdf", file_name)]
  file_name <- gsub(pattern = ".pdf", replacement = "", file_name)

  pngfile <- suppressMessages(
    pdftools::pdf_convert(
      path, pages = pages, dpi = dpi, antialias = FALSE, verbose = FALSE
    )
  )

  res <- do.call(
    what = "c",
    args = sapply(
      pngfile,
      FUN = function(x) {

        gc(verbose = FALSE)

        pngfile_m <- magick::image_read(path = x)
        pngfile_m <- magick::image_reducenoise(
          image = pngfile_m, radius = radius
        )
        pngfile_m <- magick::image_threshold(
          image = pngfile_m, threshold = paste0(threshold, "%")
        )

        pre_res <- tesseract::ocr(
          image = pngfile_m,
          engine = tesseract::tesseract(
            options = list("tessedit_char_whitelist" = whitelist)
          )
        )

        pre_res_split <- lapply(
          pre_res,
          FUN = function(y) {
            unlist(strsplit(y, split = "\n"))
          }
        )

        res_vec <- do.call(
          what = "c",
          args = lapply(
            pre_res_split,
            FUN = function(z) {
              res <- unlist(strsplit(z, split = " "))
              return(res)
            }
          )
        )

        res_ret <- unique(res_vec)

        res_ret

      },
      USE.NAMES = FALSE
    )
  )

  res_out <- data.frame(cas_or_serial_no = unique(res), stringsAsFactors = FALSE)
  res_out <- transform(
    res_out,
    cas_val = .check_cas(cas_or_serial_no),
    strl = nchar(cas_or_serial_no),
    strs = substr(cas_or_serial_no, start = 1, stop = 1),
    str7 = substr(cas_or_serial_no, start = 7, stop = 7)
  )
  res_out <- subset(
    res_out,
    subset = cas_val |
      (
        strl == 10L &
         grepl(
           pattern = paste(
             unlist(
               strsplit(
                 gsub(
                   pattern = "[^[:alpha:]]",
                   replacement = "",
                   whitelist
                  ),
                split = ""
              )
              ),
             collapse = "|"),
           strs
          ) &
         str7 == "-"
      ),
    select = -c(cas_val, strl, strs, str7)
  )
  row.names(res_out) <- NULL

  invisible(
    file.remove(
      list.files(pattern = paste(c(file_name, ".png"), collapse = "|"))
    )
  )

  gc(verbose = FALSE)

  res_out

}
