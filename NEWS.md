# cleanventory 0.3.2 (2022-09-14) 

* Added new functions for the Malaysia Chemical Information Management System 
  (`read_my_cims()`), the United States Chemical Data Reporting Inventory 
  (`read_us_cdr()`), and the Substances in Preparations in Nordic Countries 
  inventory (`read_xn_spin()`). 

# cleanventory 0.3.1 (2022-07-19)

* Fixed function to clean up non-ASCII characters. 
* Added new function for the Chinese Inventory of Existing Chemical Substances 
  and Chemicals (`read_cn_iecsc()`). 
* Fixed tests. 

# cleanventory 0.3.0 (2022-07-15)

* Added 2-letter country/sovereign region indication to each function to make it
  easier to choose the right function. For example, `read_clp()` has become
  `read_eu_clp()`.
* Added new functions for new inventories: the Taiwan Chemical Substances 
  Inventory (`read_tw_csi()`), the Philippine Inventory of Chemicals and 
  Chemical Substances (`read_ph_iccs()`), the Japan Chemical Substances Control 
  Law (`read_jp_cscl()`), the Australia Inventory of Industrial Chemicals 
  (`read_au_iic()`), and the Canada Domestic Substances List (`read_ca_dsl()`).
* The tests have been updated to reflect the name changes of the functions. 

# cleanventory 0.2.4 (2022-05-30)

* Added functionality to read the Australia Industrial Chemicals Inventory 
  (`read_ici()`). 
* Added function `date_to_cas()` to repair the well-known .xls(x) 
  malformatting.
* Updated internal function `.clean_non_ascii()` with more characters. 

# cleanventory 0.2.3 (2022-05-04)

* Added functionality to read the South Korea National Chemicals Information 
  System (`read_ncis()`).
* Added functionality to read the Australia Hazardous Chemical Information 
  System (`read_hcis()`).
* Added functionality to reasonably clean non-ASCII characters 
  (`.clean_non_ascii()`).
* Detection of "date-ifyed" CAS Registry Numbers and automatic conversion back
  to CAS RNs for `read_ec()`.

# cleanventory 0.2.2 (2022-04-27)

* Adding functionality to read and clean the New Zealand Inventory of 
  Chemicals (`read_ioc()`).
* Fixed minor typos.

# cleanventory 0.2.1 (2022-04-26)

* Adding functionality to read and clean the Japanese NITE inventory.
* Updated information for the US EPA TSCA inventory. 
* Fixed rare timeout issue in testing

# cleanventory 0.1.0 (2022-01-19)

* Fixed Unix issue with `read_clp()`.

# cleanventory 0.0.4 (2022-01-14)

* Outsourcing data sets into seperate cleanventory.data package.
* Changing dependency from readxl to openxlsx.
* Fixing tests to reflect the above changes. 
* Adding new logo.

# cleanventory 0.0.3 (2022-01-11)

* Added ECHA CLP Annex VI data sets as `clp`.
* Added ECHA EC data set as `ec`.
* Added functions to clean original files: `clean_tsca()`, `clean_clp()` and 
  `clean_ec()`.

# cleanventory 0.0.1 (2022-01-07)

* Added US EPA TSCA data set (v. 2021-08) as `tsca`.
* Added support for tests *via* {tinytest}.
* Added support for continuous integration *via* GitHub Actions.
* Added support for code coverage *via* {covr}.
* Added a `NEWS.md` file to track changes to the package.
