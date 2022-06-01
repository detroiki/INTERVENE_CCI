#' Adds a new column to a tidy data.frame from a map with a common column.
#'
#' @param data A data.frame with at least column `common_col`
#' @param map_tib A data.frame with two columns, one being `common_col`,
#'                  and the other being the new column to add.
#' @param common_col A string. The common column as basis of the mapping.
#'
#' @return The data.frame with the new mapped column.
#'
#' @export
add_map_col <- function(data, map_tib, common_col) {
    data_joined <- dplyr::left_join(data,
                                    # Makes sure not to add multiple rows
                                    # just because there's the same
                                    # entry in the map multiple times.
                                    dplyr::distinct(map_tib, .keep_all = TRUE),
                                    by = {{common_col}})
    return(data_joined)
} 