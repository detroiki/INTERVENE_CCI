#' Groups the data according to the ICD-versions.
#'
#' @param data A tidy data.frame with at least column `ICD_version`.
#'
#' @return A list c(`groups`, `group_keys`, `group_idxs`):
#'          - `groups` The grouped tibble.
#'          - `group_keys` A list.
#'                         The name of each group, so the ICD-versions
#'                         present in the data.
#'          - `group_idxs` A named list.
#'                         The indices of the elements of each group
#'                         in the original data. The names are the group names.
#' @importFrom dplyr %>%
#' @export
group_by_icd_ver <- function(data) {
    groups <- data %>%
                dplyr::group_by(ICD_version, .drop = FALSE)
    group_keys <-  groups %>%
                    dplyr::group_keys() %>%
                    dplyr::pull(ICD_version)
    group_idxs <- groups %>%
                    dplyr::group_rows()
    names(group_idxs) <- group_keys

    return(list(data = groups,
                keys = group_keys,
                idxs = group_idxs))
}