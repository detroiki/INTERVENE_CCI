#' Adds a column with numeric IDs to a tidy data.frame
#'
#' @param data A data.frame with at least column `ID`
#'
#' @return data A data.frame with at least column `ID`, and `ID_num`
#'
#' @examples
#' data <- create_test_df_multi_icd_ver()
#' data_with_num_id <- add_num_id_col(data)
#'
#' @importFrom dplyr %>%
#' @export
add_num_id_col <- function(data) {
    id_num_map <- dplyr::select(data, ID) %>%
                    dplyr::distinct(ID)
    id_num_map <- id_num_map %>%
                    tibble::add_column(ID_num = seq_len(nrow(id_num_map)))
    add_map_col(data, id_num_map, "ID")
}
