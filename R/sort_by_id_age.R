#' Sorts a tidy data.frame by `ID` and `Event_age`.
#'
#' @param data A data.frame with at least column `ID`, and `Event_age`
#'
#' @return The data.drame sorted first by `ID`, and then by `Event_age`.
#'
#' @importFrom dplyr %>%
#' @export
sort_by_id_age <- function(data) {
    sorted_data <- data %>%
                    dplyr::arrange(ID, Event_age)
    return(sorted_data)
}