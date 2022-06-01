#' Creates a tibble with random ICD-codes entries, from different ICD versions,
#' using \code{\link{create_test_df}}. Meant for testing.
#'
#' It is possible to create a mix of ICD-10 and ICD-9 codes to create
#' a more realistic testing dataset.
#'
#' @param n_icd10 Number of draws from ICD10
#' @param n_icd9 Number of draws from ICD9
#' @param icd10_indv A character vector.
#'                   The names of the individuals with ICD10 codes
#' @param icd9_indv A character vector.
#'                   The names of the individuals with ICD9 codes
#' @return A tibble with columns `ID`, `Event_age`, `primary_ICD`,
#' and `secondary_ICD` and random ICD codes, as well as age at event.
#'
#' @importFrom dplyr %>%
#' @export
create_test_df_multi_icd_ver <- function(n_icd10=50,
                                         n_icd9=20,
                                         icd10_indv=c("FG0000001", "FG0000002", "FG0000004", "FG0000005","FG0000006"), 
                                         icd9_indv=c("FG0000005", "FG0000007", "FG0000002", "FG0000008", "FG0000009")) { 
    samples_icd10 <- create_test_df(icd10_indv, n_icd10, "ICD10_2011")
    samples_icd9 <- create_test_df(icd9_indv, n_icd9, "ICD9_2015")
    icd_versions <- c(rep("10", n_icd10), rep("9", n_icd9))
    samples <- dplyr::bind_rows(samples_icd10, samples_icd9) %>%
                tibble::add_column(ICD_version = icd_versions)
}