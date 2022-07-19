.clean_non_ascii <- function(x, use_names = FALSE) {

  x <- as.character(x)

  x_check <- sapply(
    x,
    FUN = function(x) {
      pre <- iconv(x, from = "latin1", to = "ASCII")
      pre_res <- is.na(pre) | pre != x
      return(pre_res)
    },
    USE.NAMES = FALSE
  )

  res <- mapply(
    FUN = function(x, y) {
      if (!y) {
        return(x)
      } else {
        x <- iconv(x, to = "ASCII", sub = "byte")
        x <- gsub(pattern = "<c2><ab>", replacement = "", x) # careful
        x <- gsub(pattern = "<c2><b0>", replacement = "degree", x)
        x <- gsub(pattern = "<c2><b1>", replacement = "plus-minus", x)
        x <- gsub(pattern = "<c2><b4>", replacement = "'", x)
        x <- gsub(pattern = "<c2><b5>", replacement = "micro", x)
        x <- gsub(pattern = "<c2><a0>", replacement = " ", x)
        x <- gsub(pattern = "<c2><a1>", replacement = "i", x) # careful
        x <- gsub(pattern = "<c2><a7>", replacement = "", x) # careful
        x <- gsub(pattern = "<c2><ad>", replacement = "", x)
        x <- gsub(pattern = "<c2><ae>", replacement = "(R)", x)
        x <- gsub(pattern = "<c2><b2>", replacement = "2", x)
        x <- gsub(pattern = "<c2><b3>", replacement = "3", x)
        x <- gsub(pattern = "<c2><b7>", replacement = ".", x)
        x <- gsub(pattern = "<c2><b9>", replacement = "1", x)
        x <- gsub(pattern = "<c2><be>", replacement = "3/4", x)

        x <- gsub(pattern = "<c3><84>", replacement = "AE", x)
        x <- gsub(pattern = "<c3><91>", replacement = "N", x)
        x <- gsub(pattern = "<c3><96>", replacement = "OE", x)
        x <- gsub(pattern = "<c3><97>", replacement = ".x", x) # careful
        x <- gsub(pattern = "<c3><9c>", replacement = "UE", x)

        x <- gsub(pattern = "<c3><a4>", replacement = "ae", x)
        x <- gsub(pattern = "<c3><a8>", replacement = "e", x)
        x <- gsub(pattern = "<c3><a9>", replacement = "e", x)
        x <- gsub(pattern = "<c3><b6>", replacement = "oe", x)
        x <- gsub(pattern = "<c3><bc>", replacement = "ue", x)

        x <- gsub(pattern = "<c3><9f>", replacement = "beta", x) # careful
        x <- gsub(pattern = "<e1><ba><9e>", replacement = "Beta", x) # careful

        x <- gsub(pattern = "<c3><88>", replacement = "E", x)
        x <- gsub(pattern = "<c3><89>", replacement = "E", x)
        x <- gsub(pattern = "<c3><8f>", replacement = "I", x)

        x <- gsub(pattern = "<c6><90>", replacement = "epsilon", x)
        x <- gsub(pattern = "<c9><91>", replacement = "alpha", x)

        x <- gsub(pattern = "<cb><9c>", replacement = "-", x) # careful

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

        x <- gsub(pattern = "<cf><81>", replacement = "rho", x)
        x <- gsub(pattern = "<cf><88>", replacement = "psi", x)
        x <- gsub(pattern = "<cf><89>", replacement = "omega", x)

        x <- gsub(pattern = "<e2><80><8b>", replacement = "", x)
        x <- gsub(pattern = "<e2><80><93>", replacement = "-", x)
        x <- gsub(pattern = "<e2><80><98>", replacement = "'", x)
        x <- gsub(pattern = "<e2><80><99>", replacement = "'", x)
        x <- gsub(pattern = "<e2><80><9c>", replacement = "''", x)
        x <- gsub(pattern = "<e2><80><9d>", replacement = "''", x)
        x <- gsub(pattern = "<e2><80><a2>", replacement = " ", x) # careful
        x <- gsub(pattern = "<e2><80><b2>", replacement = "'", x)
        x <- gsub(pattern = "<e2><80><b3>", replacement = "''", x)
        x <- gsub(pattern = "<e2><80><ba>", replacement = ">", x)

        x <- gsub(pattern = "<e2><81><b0>", replacement = "0", x)
        x <- gsub(pattern = "<e2><81><b9>", replacement = "9", x)

        x <- gsub(pattern = "<e2><82><80>", replacement = "0", x)
        x <- gsub(pattern = "<e2><82><81>", replacement = "1", x)
        x <- gsub(pattern = "<e2><82><82>", replacement = "2", x)
        x <- gsub(pattern = "<e2><82><83>", replacement = "3", x)
        x <- gsub(pattern = "<e2><82><84>", replacement = "4", x)
        x <- gsub(pattern = "<e2><82><85>", replacement = "5", x)
        x <- gsub(pattern = "<e2><82><86>", replacement = "6", x)
        x <- gsub(pattern = "<e2><82><87>", replacement = "7", x)
        x <- gsub(pattern = "<e2><82><88>", replacement = "8", x)
        x <- gsub(pattern = "<e2><82><89>", replacement = "9", x)
        x <- gsub(pattern = "<e2><82><8b>", replacement = "-", x)
        x <- gsub(pattern = "<e2><82><93>", replacement = "x", x) # careful

        x <- gsub(pattern = "<e2><84><a2>", replacement = "TM", x)

        x <- gsub(pattern = "<e2><85><a1>", replacement = "II", x)
        x <- gsub(pattern = "<e2><85><a2>", replacement = "III", x)

        x <- gsub(pattern = "<e2><86><92>", replacement = "->", x) # careful

        x <- gsub(pattern = "<e2><88><bc>", replacement = "~", x) # careful

        x <- gsub(pattern = "<e2><89><a5>", replacement = ">=", x) # careful

        x <- gsub(pattern = "<e2><96><b3>", replacement = "D", x) # careful

        x <- gsub(pattern = "<ea><9e><8c>", replacement = "'", x)
        x <- gsub(pattern = "<ea><b3><bc>", replacement = "", x)

        x <- gsub(pattern = "<eb><aa><85>", replacement = "", x)

        x <- gsub(pattern = "<ec><8b><a4>", replacement = "", x)
        x <- gsub(pattern = "<ec><99><80>", replacement = "", x) # careful
        x <- gsub(pattern = "<ec><9d><98>", replacement = "", x)
        x <- gsub(pattern = "<ec><b4><9d>", replacement = "", x)
        x <- gsub(pattern = "<ec><b9><ad>", replacement = "", x)

        x <- gsub(pattern = "<ef><bc><82>", replacement = "''", x)

        x <- gsub(pattern = "<ef><bf><bd>", replacement = "?", x)


        x <- gsub(
          pattern = paste(
            "<eb><b6><80><ec><97><ac><eb><90><98><ec><a7><80>",
            "<ec><95><8a><ec><9d><8c>"
          ),
          replacement = NA_character_,
          x
        )
        return(x)
      }
    },
    x, x_check,
    USE.NAMES = FALSE
  )

  res

}
