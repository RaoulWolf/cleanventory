#' @source
#'   https://www.cas.org/support/documentation/chemical-substances/checkdig
.check_cas <- function(cas_rn, use_names = FALSE) {

  if (!is.logical(use_names) || is.na(use_names)) {
    use_names <- FALSE
  }

  res <- sapply(
    cas_rn,
    FUN = function(x) {

      if (is.na(x) || is.null(x)) {
        return(FALSE)
      }

      if (grepl(pattern = "[^[:digit:]|-]", x)) {
        return(FALSE)
      }

      if (nchar(gsub(pattern = "[^-]", replacement = "", x)) != 2) {
        return(FALSE)
      }

      cas_split <- unlist(strsplit(x, split = "-"))

      if (length(cas_split) != 3) {
        return(FALSE)
      }

      if (nchar(cas_split[1]) < 2 || nchar(cas_split[1]) > 7) {
        return(FALSE)
      }

      if (nchar(cas_split[2]) != 2) {
        return(FALSE)
      }

      if (nchar(cas_split[3]) != 1) {
        return(FALSE)
      }

      if (as.integer(cas_split[1]) < 50 &&
          !(
            x %in% c(
              "35-66-5", "35-67-6", "36-51-1", "36-88-4", "37-71-8", "37-82-1",
              "37-87-6", "38-26-6"
            )
          )
        ) {
        return(FALSE)
      }

      cas <- paste(cas_split, collapse = "")

      check_dig <- as.integer(substring(cas, first = nchar(cas)))

      cas_str <- substr(cas, start = 1, stop = nchar(cas) - 1)

      count <- nchar(cas_str):1

      number <- as.integer(unlist(strsplit(cas_str, split = "")))

      res <- sum(count * number) / 10

      res_dig <- as.integer(round(10 * (res %% 1)))

      res_dig == check_dig

    },
    USE.NAMES = use_names
  )

  res

}
