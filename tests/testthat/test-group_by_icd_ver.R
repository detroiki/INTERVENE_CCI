test_that("get_icd_ver_group_data works", {
  test_data = tibble(ICD_VERSION=c("10", "9", "10", "10", "10CM", "9", "9CM", "9", "9", "9", "9", "10", "10CM", "10CM")) # nolint
  test_res <- group_by_icd_ver(test_data)

  expected_group_keys <- c("10", "10CM", "9", "9CM")
  epxected_group_idxs <- list("10" = c(1, 3, 4, 12),
                              "10CM" = c(5, 13, 14),
                              "9" = c(2, 6, 8, 9, 10, 11),
                              "9CM" = c(7))

  expect_equal(test_res$keys, expected_group_keys)
  expect_equal(as.list(test_res$idxs), epxected_group_idxs)
})
