#' Calculates the Charlson Comorbidity Index, based on longitudinal data 
#' in INTERVENE format.
#'
#' Maps data onto the relevant conditions for the charlson-deyo
#' comorbidity index, using \code{\link[comorbidity]{comorbidity}}.
#' Then calculates the scores, using \code{\link[comorbidity]{score}}
#'
#' Can handle different ICD-versions also for a single patient, by adding
#' up the results.
#'
#' @param data A data.frame with at least column `ID`, `EVENT_AGE`,
#'              and `PRIMARY_ICD`.
#'
#' @return A tibble with columns `ID` and `score` with the charlson
#'          weighted comorbidity scores for each individual.
#'
#' @importFrom dplyr %>%
#' @export
calc_cci <- function(data) {
    sorted_data <- sort_by_id_age(data)
    data_num_id <- add_num_id_col(sorted_data)
    grouped_data <- group_by_icd_ver(data_num_id)

    total_cci_score <- tibble::tibble()
    for (icd_version in grouped_data$keys) {
        current_data <- data_num_id[grouped_data$idxs[[icd_version]], ]
        current_res <- comorbidity::comorbidity(current_data,
                                                "ID_num",
                                                "PRIMARY_ICD",
                                                map = get_comorb_icd_ver_str(icd_version),
                                                assign0 = FALSE)

        cci_score <- comorbidity::score(current_res,
                                        weights = "charlson",
                                        assign0 = FALSE)
        cci_score_tib <- tibble::tibble(ID = unique(current_data$ID),
                                        score = cci_score)
        total_cci_score <- dplyr::bind_rows(total_cci_score, cci_score_tib)
    }

    total_cci_score <- dplyr::group_by(total_cci_score, ID) %>%
                    dplyr::summarise_all(sum)

    return(total_cci_score)
}