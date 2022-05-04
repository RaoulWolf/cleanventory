
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cleanventory <img src="man/figures/logo.svg" align="right" height="139" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/RaoulWolf/cleanventory/workflows/R-CMD-check/badge.svg)](https://github.com/RaoulWolf/cleanventory/actions)
[![Codecov test
coverage](https://codecov.io/gh/RaoulWolf/cleanventory/branch/master/graph/badge.svg)](https://app.codecov.io/gh/RaoulWolf/cleanventory?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

> A [ZeroPM](https://zeropm.eu/) R package

The goal of cleanventory is to provide simple functionality to clean and
partially curate data sets of common chemical inventories.

The dependencies of cleanventory are kept at as minimal as possible:
[openxlsx](https://cran.r-project.org/web/packages/openxlsx) for
handling .xlsx files.

We suggest the following packages/functionalities in addition:
[`bit64::as.integer64()`](https://cran.r-project.org/web/packages/bit64)
to correctly handle the `tsca$cas_reg_no` column (kept as `double` for
compatibility).

As of 2022-05-04, the following inventories are included:

| Chemical Inventory | Function      | Compatible Version(s) | URL                                                                                 |
|:-------------------|:--------------|:----------------------|:------------------------------------------------------------------------------------|
| US EPA TSCA        | `read_tsca()` | 2021-08               | <https://www.epa.gov/tsca-inventory>                                                |
| ECHA CLP Annex VI  | `read_clp()`  | 9, 10, 13, 14, 15, 17 | <https://echa.europa.eu/en/information-on-chemicals/annex-vi-to-clp>                |
| ECHA EC            | `read_ec()`   | *Unknown*             | <https://echa.europa.eu/information-on-chemicals/ec-inventory>                      |
| Japan NITE         | `read_nite()` | March 2022            | <https://www.nite.go.jp/chem/english/ghs/ghs_download.html>                         |
| New Zealand IoC    | `read_ioc()`  | December 2021         | <https://www.epa.govt.nz/database-search/new-zealand-inventory-of-chemicals-nzioc/> |
| South Korea NCIS   | `read_ncis()` | 4 May 2022            | <https://ncis.nier.go.kr/en/mttrList.do>                                            |
| Australia HCIS     | `read_hcis()` | *Unknown*             | <http://hcis.safeworkaustralia.gov.au/HazardousChemical>                            |

## Installation

You can install the development version of cleanventory from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
remotes::install_github("ZeroPM-H2020/cleanventory")
```

## Examples

This is an example which shows you how to get the data set of the US EPA
TSCA:

``` r
library(cleanventory)

tmp <- tempdir()

url <- paste0(
  "https://echa.europa.eu/documents/10162/17218/",
  "annex_vi_clp_table_atp17_en.xlsx/",
  "4dcec79c-f277-ed68-5e1b-d435900dbe34?t=1638888918944"
)

clp_file <- download.file(
  url, 
  destfile = paste(tmp, "annex_vi_clp_table_atp17_en.xlsx", sep = "/"),
  quiet = TRUE,
  mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
)

path <- paste(tmp, "annex_vi_clp_table_atp17_en.xlsx", sep = "/")

clp <- read_clp(path)

invisible(file.remove(path))

head(clp)
#>       index_no international_chemical_identification     ec_no     cas_no atp
#> 1 001-001-00-9                              hydrogen 215-605-7  1333-74-0  17
#> 2 001-002-00-4             aluminium lithium hydride 240-877-9 16853-85-3  17
#> 3 001-003-00-X                        sodium hydride 231-587-3  7646-69-7  17
#> 4 001-004-00-5                       calcium hydride 232-189-2  7789-78-8  17
#> 5 003-001-00-4                               lithium 231-102-5  7439-93-2  17
#> 6 003-002-00-X                        n-hexyllithium 404-950-0 21369-64-2  17

str(clp)
#> 'data.frame':    4702 obs. of  5 variables:
#>  $ index_no                             : chr  "001-001-00-9" "001-002-00-4" "001-003-00-X" "001-004-00-5" ...
#>  $ international_chemical_identification: chr  "hydrogen" "aluminium lithium hydride" "sodium hydride" "calcium hydride" ...
#>  $ ec_no                                : chr  "215-605-7" "240-877-9" "231-587-3" "232-189-2" ...
#>  $ cas_no                               : chr  "1333-74-0" "16853-85-3" "7646-69-7" "7789-78-8" ...
#>  $ atp                                  : int  17 17 17 17 17 17 17 17 17 17 ...
```

## Acknowledgement

This R package was developed by the EnviData initiative at the
[Norwegian Geotechnical Institute (NGI)](https://www.ngi.no/eng) as part
of the project [ZeroPM: Zero pollution of Persistent, Mobile
substances](https://zeropm.eu/). This project has received funding from
the European Union’s Horizon 2020 research and innovation programme
under grant agreement No 101036756.

------------------------------------------------------------------------

If you find this package useful and can afford it, please consider
making a donation to a humanitarian non-profit organization, such as
[Sea-Watch](https://sea-watch.org/en/). Thank you.
