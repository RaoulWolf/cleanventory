
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
partially curate data sets of common chemical inventories. The aim is to
document every step, from the raw (downloaded) files to the final
tables.

The dependencies of cleanventory are kept at as minimal as possible:
[openxlsx](https://cran.r-project.org/web/packages/openxlsx) for
handling .xlsx files, and the trio of
[pdftools](https://cran.r-project.org/web/packages/pdftools),
[magick](https://cran.r-project.org/web/packages/magick) and
[tesseract](https://cran.r-project.org/web/packages/tesseract) to
extract data from (image) .pdf files.

We suggest the following packages/functionalities in addition:
[`bit64::as.integer64()`](https://cran.r-project.org/web/packages/bit64)
to correctly handle the `us_tsca$cas_reg_no` column (kept as `double`
for compatibility).

As of 2022-07-19, the following inventories are included:

| Chemical Inventory | Function          | Compatible Version(s)                        | URL                                                                                                                                                     |
|:-------------------|:------------------|:---------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------|
| US TSCA            | `read_us_tsca()`  | 2021-08                                      | <https://www.epa.gov/tsca-inventory>                                                                                                                    |
| EU CLP Annex VI    | `read_eu_clp()`   | 9, 10, 13, 14, 15, 17                        | <https://echa.europa.eu/en/information-on-chemicals/annex-vi-to-clp>                                                                                    |
| EU ECI             | `read_eu_eci()`   | *Unknown*                                    | <https://echa.europa.eu/information-on-chemicals/ec-inventory>                                                                                          |
| Japan NITE         | `read_jp_nite()`  | March 2022                                   | <https://www.nite.go.jp/chem/english/ghs/ghs_download.html>                                                                                             |
| New Zealand IoC    | `read_nz_ioc()`   | December 2021                                | <https://www.epa.govt.nz/database-search/new-zealand-inventory-of-chemicals-nzioc/>                                                                     |
| South Korea NCIS   | `read_kr_ncis()`  | 4 May 2022                                   | <https://ncis.nier.go.kr/en/mttrList.do>                                                                                                                |
| Australia HCIS     | `read_au_hcis()`  | *Unknown*                                    | <http://hcis.safeworkaustralia.gov.au/HazardousChemical>                                                                                                |
| Australia ICI      | `read_au_ici()`   | 10 February 2022                             | <https://www.industrialchemicals.gov.au/search-inventory>                                                                                               |
| Taiwan CSI         | `read_tw_csi()`   | *Unknown*                                    | <https://gazette.nat.gov.tw/egFront/detail.do?metaid=73440&log=detailLog></br><https://gazette.nat.gov.tw/egFront/detail.do?metaid=78617&log=detailLog> |
| Philippine ICCS    | `read_ph_iccs()`  | 2017, 2020, 2021                             | <https://chemical.emb.gov.ph/?page_id=138>                                                                                                              |
| Japan CSCL         | `read_jp_cscl()`  | 31 May 2022</br>31 May 2022</br>1 April 2022 | <https://www.nite.go.jp/en/chem/chrip/chrip_search/sltLst>                                                                                              |
| Canada DSL         | `read_ca_dsl()`   | 14 June 2022                                 | <https://pollution-waste.canada.ca/substances-search/Substance?lang=en>                                                                                 |
| China IECSC        | `read_cn_iecsc()` | 2013                                         | <https://www.mee.gov.cn/gkml/hbb/bgg/201301/t20130131_245810.htm>                                                                                       |

## Installation

You can install the development version of cleanventory from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
remotes::install_github("ZeroPM-H2020/cleanventory")
```

## Examples

This is an example which shows you how to get the data set of the
(current) EU CLP Annex VI:

``` r
library(cleanventory)

tmp <- tempdir()

url <- paste0(
  "https://echa.europa.eu/documents/10162/17218/",
  "annex_vi_clp_table_atp17_en.xlsx/",
  "4dcec79c-f277-ed68-5e1b-d435900dbe34?t=1638888918944"
)

eu_clp_file <- download.file(
  url, 
  destfile = paste(tmp, "annex_vi_clp_table_atp17_en.xlsx", sep = "/"),
  quiet = TRUE,
  mode = ifelse(.Platform$OS.type == "windows", "wb", "w")
)

path <- paste(tmp, "annex_vi_clp_table_atp17_en.xlsx", sep = "/")

eu_clp <- read_eu_clp(path)

invisible(file.remove(path))

head(eu_clp)
#>       index_no international_chemical_identification     ec_no     cas_no
#> 1 001-001-00-9                              hydrogen 215-605-7  1333-74-0
#> 2 001-002-00-4             aluminium lithium hydride 240-877-9 16853-85-3
#> 3 001-003-00-X                        sodium hydride 231-587-3  7646-69-7
#> 4 001-004-00-5                       calcium hydride 232-189-2  7789-78-8
#> 5 003-001-00-4                               lithium 231-102-5  7439-93-2
#> 6 003-002-00-X                        n-hexyllithium 404-950-0 21369-64-2

str(eu_clp)
#> 'data.frame':    4702 obs. of  4 variables:
#>  $ index_no                             : chr  "001-001-00-9" "001-002-00-4" "001-003-00-X" "001-004-00-5" ...
#>  $ international_chemical_identification: chr  "hydrogen" "aluminium lithium hydride" "sodium hydride" "calcium hydride" ...
#>  $ ec_no                                : chr  "215-605-7" "240-877-9" "231-587-3" "232-189-2" ...
#>  $ cas_no                               : chr  "1333-74-0" "16853-85-3" "7646-69-7" "7789-78-8" ...
```

## Acknowledgement

This R package was developed at the [Norwegian Geotechnical Institute
(NGI)](https://www.ngi.no/eng) as part of the project [ZeroPM: Zero
pollution of Persistent, Mobile substances](https://zeropm.eu/). This
project has received funding from the European Union’s Horizon 2020
research and innovation programme under grant agreement No 101036756.

------------------------------------------------------------------------

If you find this package useful and can afford it, please consider
making a donation to a humanitarian non-profit organization, such as
[Sea-Watch](https://sea-watch.org/en/). Thank you.
