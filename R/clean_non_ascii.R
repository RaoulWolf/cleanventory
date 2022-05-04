.clean_non_ascii <- function(x, use_names = FALSE) {

  x <- as.character(x)

  res <- sapply(
    x,
    FUN = function(x) {

      x <- iconv(x, to = "ASCII", sub = "byte")

      x <- gsub(pattern = "<c2><ab>", replacement = "", x) # careful
      x <- gsub(pattern = "<c2><b0>", replacement = "degree", x)
      x <- gsub(pattern = "<c2><b1>", replacement = "plus-minus", x)
      x <- gsub(pattern = "<c2><b4>", replacement = "'", x)
      x <- gsub(pattern = "<c2><b5>", replacement = "micro", x)
      x <- gsub(pattern = "<c2><a0>", replacement = " ", x)
      x <- gsub(pattern = "<c2><a7>", replacement = "", x) # careful
      x <- gsub(pattern = "<c2><ae>", replacement = "(R)", x)
      x <- gsub(pattern = "<c2><b2>", replacement = "2", x)
      x <- gsub(pattern = "<c2><b3>", replacement = "3", x)
      x <- gsub(pattern = "<c2><b9>", replacement = "1", x)

      x <- gsub(pattern = "<c3><84>", replacement = "AE", x)
      x <- gsub(pattern = "<c3><96>", replacement = "OE", x)
      x <- gsub(pattern = "<c3><9c>", replacement = "UE", x)

      x <- gsub(pattern = "<c3><a4>", replacement = "ae", x)
      x <- gsub(pattern = "<c3><b6>", replacement = "oe", x)
      x <- gsub(pattern = "<c3><bc>", replacement = "ue", x)

      x <- gsub(pattern = "<c3><9f>", replacement = "beta", x) # careful
      x <- gsub(pattern = "<e1><ba><9e>", replacement = "Beta", x) # careful

      x <- gsub(pattern = "<c3><88>", replacement = "E", x)
      x <- gsub(pattern = "<c3><89>", replacement = "E", x)
      x <- gsub(pattern = "<c3><8f>", replacement = "I", x)

      x <- gsub(pattern = "<ce><91>", replacement = "Alpha", x)
      x <- gsub(pattern = "<ce><92>", replacement = "Beta", x)
      x <- gsub(pattern = "<ce><93>", replacement = "Gamma", x)
      x <- gsub(pattern = "<ce><94>", replacement = "Delta", x)
      x <- gsub(pattern = "<ce><95>", replacement = "Epsilon", x)
      x <- gsub(pattern = "<ce><96>", replacement = "Zeta", x)
      x <- gsub(pattern = "<ce><97>", replacement = "Eta", x)
      x <- gsub(pattern = "<ce><98>", replacement = "Theta", x)
      x <- gsub(pattern = "<ce><99>", replacement = "Iota", x)
      x <- gsub(pattern = "<ce><9a>", replacement = "Kappa", x)
      x <- gsub(pattern = "<ce><9b>", replacement = "Lamda", x)
      x <- gsub(pattern = "<ce><9c>", replacement = "Mu", x)
      x <- gsub(pattern = "<ce><9d>", replacement = "Nu", x)
      x <- gsub(pattern = "<ce><9e>", replacement = "Xi", x)
      x <- gsub(pattern = "<ce><9f>", replacement = "Omicron", x)
      x <- gsub(pattern = "<ce><a0>", replacement = "Pi", x)
      x <- gsub(pattern = "<ce><a1>", replacement = "Rho", x)
      x <- gsub(pattern = "<ce><a3>", replacement = "Sigma", x)
      x <- gsub(pattern = "<ce><a4>", replacement = "Tau", x)
      x <- gsub(pattern = "<ce><a5>", replacement = "Upsilon", x)
      x <- gsub(pattern = "<ce><a6>", replacement = "Phi", x)
      x <- gsub(pattern = "<ce><a7>", replacement = "Chi", x)
      x <- gsub(pattern = "<ce><a8>", replacement = "Psi", x)
      x <- gsub(pattern = "<ce><a9>", replacement = "Omega", x)

      x <- gsub(pattern = "<ce><b1>", replacement = "alpha", x)
      x <- gsub(pattern = "<ce><b2>", replacement = "beta", x)
      x <- gsub(pattern = "<ce><b3>", replacement = "gamma", x)
      x <- gsub(pattern = "<ce><b4>", replacement = "delta", x)
      x <- gsub(pattern = "<ce><b5>", replacement = "epsilon", x)
      x <- gsub(pattern = "<ce><b6>", replacement = "zeta", x)
      x <- gsub(pattern = "<ce><b7>", replacement = "eta", x)
      x <- gsub(pattern = "<ce><b8>", replacement = "theta", x)
      x <- gsub(pattern = "<ce><b9>", replacement = "iota", x)
      x <- gsub(pattern = "<ce><ba>", replacement = "kappa", x)
      x <- gsub(pattern = "<ce><bb>", replacement = "lamda", x)
      x <- gsub(pattern = "<ce><bc>", replacement = "mu", x)
      x <- gsub(pattern = "<ce><bd>", replacement = "nu", x)
      x <- gsub(pattern = "<ce><be>", replacement = "xi", x)
      x <- gsub(pattern = "<ce><bf>", replacement = "omicron", x)
      x <- gsub(pattern = "<ce><c0>", replacement = "pi", x)
      x <- gsub(pattern = "<ce><c1>", replacement = "rho", x)
      x <- gsub(pattern = "<ce><c3>", replacement = "sigma", x)
      x <- gsub(pattern = "<ce><c4>", replacement = "tau", x)
      x <- gsub(pattern = "<ce><c5>", replacement = "upsilon", x)
      x <- gsub(pattern = "<ce><c6>", replacement = "phi", x)
      x <- gsub(pattern = "<ce><c7>", replacement = "chi", x)
      x <- gsub(pattern = "<ce><c8>", replacement = "psi", x)
      x <- gsub(pattern = "<ce><c9>", replacement = "omega", x)

      x <- gsub(pattern = "<e2><80><93>", replacement = "-", x)
      x <- gsub(pattern = "<e2><80><98>", replacement = "'", x)
      x <- gsub(pattern = "<e2><80><99>", replacement = "'", x)
      x <- gsub(pattern = "<e2><80><9d>", replacement = "''", x)
      x <- gsub(pattern = "<e2><84><a2>", replacement = "TM", x)

      x <- gsub(
        pattern = paste(
          "<eb><b6><80><ec><97><ac><eb><90><98><ec><a7><80>",
          "<ec><95><8a><ec><9d><8c>"
          ),
        replacement = NA_character_,
        x
      )

    },
    USE.NAMES = use_names
  )

  res

}
