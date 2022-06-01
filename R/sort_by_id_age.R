#' Sorts a tidy data.frame by `ID` and `EVENT_AGE`.
#'
#' @param data A data.frame with at least column `ID`, and `EVENT_AGE`
#'
#' @return The data.drame sorted first by `ID`, and then by `EVENT_AGE`.
#'
#' @importFrom dplyr %>%
#' @export
sort_by_id_age <- function(data) {
    sorted_data <- data %>%
                    dplyr::arrange(ID, EVENT_AGE)
    return(sorted_data)
}