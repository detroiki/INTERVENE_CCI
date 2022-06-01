test_that("sort_by_id_age works", {
  test_data <- tibble::tibble(ID = c("FG0004", "FG0002", "FG0004", "FG0003", "FG0004", "ABCD005", "FG0002", "FG0003"), #nolint 
         Event_age = c(92.2, 3.5, 12.2, 29.1, 1.2, 60.4, 54.2, 13.45))
  expected_res <- tibble::tibble(ID = c( "ABCD005", "FG0002", "FG0002", "FG0003", "FG0003",  "FG0004",  "FG0004", "FG0004"), #nolint 
         Event_age = c(60.4, 3.5, 54.2, 13.45, 29.1, 1.2, 12.2, 92.2))
  test_res <- sort_by_id_age(test_data)
  expect_equal(test_res, expected_res)
})
