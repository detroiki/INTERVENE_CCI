test_that("calc_cci works", {
  set.seed(82312)
  sample_data <- create_test_df_multi_icd_ver(n_icd10 = 100)  
  # Adding a test code in ICD-9 for patient 2
  sample_data <- tibble::add_row(sample_data, 
                                  ID = "FG0000002", 
                                  EVENT_AGE = 74, 
                                  PRIMARY_ICD = "2000", 
                                  SECONDARY_ICD = NA, 
                                  ICD_VERSION = "9")

  cci_scores <- calc_cci(sample_data)
  # First patient has CPD and nothing else -> score of 1
  expect_equal(dplyr::filter(cci_scores, ID == "FG0000001")$score, 1)

  # Second patient has two cancer records, 
  # peptic ulcers (pud), and hemiplegia (hp) -> score of 7
  expect_equal(dplyr::filter(cci_scores, ID == "FG0000002")$score, 7)
})
