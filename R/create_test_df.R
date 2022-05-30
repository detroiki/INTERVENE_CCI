create_df_for_single_ICD_ver <- function(indiv_IDs, N_samples, ICD_version) {
    N_secondary_ICD = ceiling(N_samples / 20)
    data.frame(
    ID = sample(indiv_IDs, size = N_samples, replace = TRUE),
    EVENT_AGE = round(runif(N_samples, min=0, max=100), 1),
    PRIMARY_ICD = comorbidity::sample_diag(n = N_samples, version=ICD_version),
    SECONDARY_ICD = c(comorbidity::sample_diag(n = N_secondary_ICD), 
                        rep(NA, N_samples - N_secondary_ICD))
    )
}

create_test_df <- function() {
    N_ICD10 = 50
    N_ICD9 = 20
    ICD10_indv = c("FG0000001", "FG0000002", "FG0000004", "FG0000005", "FG0000006")
    ICD9_indv = c("FG0000005", "FG0000007", "FG0000002", "FG0000008", "FG0000009")
    samples_ICD10 = create_df_for_single_ICD_ver(ICD10_indv, N_ICD10, "ICD10_2011")
    samples_ICD9 = create_df_for_single_ICD_ver(ICD9_indv, N_ICD9, "ICD9_2015")
    icd_versions = c(rep("10", N_ICD10), rep("9", N_ICD9))
    samples = dplyr::bind_rows(samples_ICD10, samples_ICD9) %>% 
                tibble::add_column(ICD_VERSION = icd_versions)

    sorted_samples = samples %>% dplyr::arrange(ID, EVENT_AGE)
}