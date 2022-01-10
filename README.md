
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cleanventory

<!-- badges: start -->

[![R-CMD-check](https://github.com/RaoulWolf/cleanventory/workflows/R-CMD-check/badge.svg)](https://github.com/RaoulWolf/cleanventory/actions)
[![Codecov test
coverage](https://codecov.io/gh/RaoulWolf/cleanventory/branch/master/graph/badge.svg)](https://app.codecov.io/gh/RaoulWolf/cleanventory?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of cleanventory is to provide easy access to cleaned and
partially curated data sets of common chemical inventories.

As of 2022-01-10, the following inventories are included:

| Chemical Inventory | Name   | Version   | URL                                                                  |
|:-------------------|:-------|:----------|:---------------------------------------------------------------------|
| US EPA TSCA        | `tsca` | 2021-08   | <https://www.epa.gov/tsca-inventory>                                 |
| ECHA CLP Annex VI  | `clp`  | 17        | <https://echa.europa.eu/en/information-on-chemicals/annex-vi-to-clp> |
| ECHA EC            | `ec`   | *Unknown* | <https://echa.europa.eu/information-on-chemicals/ec-inventory>       |

## Installation

You can install the development version of cleanventory from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
remotes::install_github("RaoulWolf/cleanventory")
```

## Examples

This is an example which shows you how to get the data set of the US EPA
TSCA:

``` r
library(cleanventory)
str(tsca)
#> 'data.frame':    68191 obs. of  11 variables:
#>  $ id          : int  1 2 3 4 5 6 7 8 9 10 ...
#>  $ cas_rn      : chr  "50-00-0" "50-01-1" "50-02-2" "50-07-7" ...
#>  $ cas_reg_no  :integer64 50000 50011 50022 50077 50146 50215 50237 50248 ... 
#>  $ uid         : chr  NA NA NA NA ...
#>  $ exp         : int  NA NA NA NA NA NA NA NA NA NA ...
#>  $ chem_name   : chr  "Formaldehyde" "Guanidine, hydrochloride (1:1)" "Pregna-1,4-diene-3,20-dione, 9-fluoro-11,17,21-trihydroxy-16-methyl-, (11.beta.,16.alpha.)-" "Azirino[2',3':3,4]pyrrolo[1,2-a]indole-4,7-dione, 6-amino-8-[[(aminocarbonyl)oxy]methyl]-1,1a,2,8,8a,8b-hexahyd"| __truncated__ ...
#>  $ def         : chr  NA NA NA NA ...
#>  $ uvcb        : chr  NA NA NA NA ...
#>  $ flag        : chr  NA NA NA "S" ...
#>  $ activity    : chr  "ACTIVE" "ACTIVE" "ACTIVE" "ACTIVE" ...
#>  $ last_created: chr  "2021-08" "2021-08" "2021-08" "2021-08" ...
```
