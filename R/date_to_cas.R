.date_to_cas <- function(x, split = "/", format = "321", use_names = FALSE) {

  res <- sapply(
    x,
    FUN = function(x) {
      cas_split <- unlist(strsplit(x, split = split), use.names = FALSE)

      if (format == "321") {
        cas_new <- paste(
          cas_split[3], cas_split[2], as.integer(cas_split[1]), sep = "-"
        )
      } else if (format == "312") {
        cas_new <- paste(
          cas_split[3], cas_split[1], as.integer(cas_split[2]), sep = "-"
        )
      } else {
        NA_character_
      }

      return(cas_new)
    },
    USE.NAMES = use_names
  )

  res
}
