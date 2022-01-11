#' @title The ECHA CLP Annex VI Data Set
#' @description ECHA has prepared an excel table containing all updates to the
#'   harmonised classification and labelling of hazardous substances, which are
#'   available in Table 3 of Annex VI to the CLP Regulation.
#'
#'   The harmonised classification and labelling of hazardous substances is
#'   updated through an "Adaptation to Technical Progress (ATP)" which is
#'   issued yearly by the European Commission. Following the adoption of the
#'   opinion on the harmonised classification and labelling of a substance by
#'   the Committee for Risk Assessment (RAC), the European Commission takes a
#'   decision and publishes the updated list in an ATP.
#'
#' More information on the columns can be found here:
#'   \url{https://echa.europa.eu/en/information-on-chemicals/annex-vi-to-clp}.
#' @format A data frame with 4,702 rows and 5 variables:
#' \describe{
#'   \item{index_no}{(Integer) index number}
#'   \item{international_chemical_identification}{(Character) name of the
#'     substance}
#'   \item{ec_no}{(Character) EC inventory number}
#'   \item{cas_no}{(Character) Chemical Abstract Service (CAS) registry number}
#'   \item{atp}{(Integer) ATP version of the annex}
#' }
#' @source \url{https://echa.europa.eu/en/information-on-chemicals/annex-vi-to-clp}
"clp"
