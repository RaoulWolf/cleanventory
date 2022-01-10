#' @title The ECHA EC Inventory
#' @description The EC inventory published below is a copy as received from the
#'   JRC in 2008 on the founding of ECHA. It is comprised of the following
#'   lists:
#'
#'   EINECS (European INventory of Existing Commercial chemical Substances) as
#'   published in O.J. C 146A, 15.6.1990. EINECS is an inventory of substances
#'   that were deemed to be on the European Community market between 1 January
#'   1971 and 18 September 1981. EINECS was drawn up by the European Commission
#'   in the application of Article 13 of Directive 67/548/EEC, as amended by
#'   Directive 79/831/EEC, and in accordance with the detailed provisions of
#'   Commission Decision 81/437/EEC. Substances listed in EINECS are considered
#'   phase-in substances under the REACH Regulation.
#'
#'   ELINCS (European LIst of Notified Chemical Substances) in support of
#'   Directive 92/32/EEC, the 7th amendment to Directive 67/548/EEC. ELINCS
#'   lists those substances which were notified under Directive 67/548/EEC, the
#'   Dangerous Substances Directive Notification of New Substances (NONS) that
#'   became commercially available after 18 September 1981.
#'
#'   NLP (No-Longer Polymers).  The definition of polymers was changed in April
#'   1992 by Council Directive 92/32/EEC amending Directive 67/548/EEC, with
#'   the result that substances previously considered to be polymers were no
#'   longer excluded from regulation. Thus the No-longer Polymers (NLP) list
#'   was drawn up, consisting of such substances that were commercially
#'   available between 18 September 1981 and 31 October 1993.
#'
#' More information on the columns can be found here:
#'   \url{https://echa.europa.eu/information-on-chemicals/ec-inventory}.
#' @format A data frame with 106,213 rows and 9 variables:
#' \describe{
#'   \item{id}{(Integer) index number}
#'   \item{ec_name}{(Character) EC name of the substance}
#'   \item{ec_no}{(Character) EC inventory number}
#'   \item{cas_no}{(Character) Chemical Abstract Service (CAS) registry number}
#'   \item{molecular_formula}{(Character) molecular formula of the substance}
#'   \item{description}{(Character) additional information}
#'   \item{infocard_url}{(Character) URL for the ECHA infocard}
#'   \item{echa_name}{(Character) ECHA name of the substance}
#'   \item{version}{(Character) version and date of the file}
#' }
#' @source \url{https://echa.europa.eu/information-on-chemicals/ec-inventory}
"ec"
