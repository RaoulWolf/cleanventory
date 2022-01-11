#' @title The US EPA TSCA Data Set
#' @description The Toxic Substances Control Act (TSCA) Chemical Substance
#'   Inventory contains all existing chemical substances manufactured,
#'   processed, or imported in the United States that do not qualify for an
#'   exemption or exclusion under TSCA.
#'
#' This data set includes the non-confidential portion of the inventory.
#'
#' More information on the columns can be found here:
#'   \url{https://www.epa.gov/tsca-inventory/how-access-tsca-inventory}.
#' @format A data frame with 68,191 rows and 11 variables:
#' \describe{
#'   \item{id}{(Integer) record ID number}
#'   \item{cas_rn}{(Character) Chemical Abstracts Service (CAS) registry number}
#'   \item{cas_reg_no}{(Integer64) CAS registry number without "-" (dashes)}
#'   \item{uid}{(Character) unique identifier}
#'   \item{exp}{(Integer) expiration date}
#'   \item{chem_name}{(Character) preferred Chemical Abstracts (CA) index name}
#'   \item{def}{(Character) chemical substance definition}
#'   \item{uvcb}{(Character) UVCB flag}
#'   \item{flag}{(Character) EPA TSCA regulatory flag}
#'   \item{activity}{(Character) commercial activity status}
#'   \item{last_created}{(Character) year and month (YYYY-MM) of data set
#'     publication}
#' }
#' @source \url{https://www.epa.gov/tsca-inventory}
"tsca"
