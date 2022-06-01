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
    data <- preprocess_data(data)
    grouped_data <- group_by_icd_ver(data)

    total_cci_score <- tibble::tibble()
    for (icd_version in grouped_data$keys) {
        current_data <- get_current_data(grouped_data, icd_version)
        current_res <- comorbidity::comorbidity(current_data,
                                                "ID_num",
                                                "primary_ICD",
                                                map = get_comorb_icd_ver_str(icd_version),
                                                assign0 = FALSE)
        cci_score <- comorbidity::score(current_res,
                                        weights = "charlson",
                                        assign0 = FALSE)
        # CAREFUL!!! score aparently sorts the individuals by their (numeric) names. 
        cci_score_tib <- tibble::tibble(ID_num = sort(unique(current_data$ID_num)),
                                        score = cci_score)
        total_cci_score <- dplyr::bind_rows(total_cci_score, cci_score_tib)
    }

    total_cci_score <- dplyr::group_by(total_cci_score, ID_num) %>%
                    dplyr::summarise_all(sum)

    total_cci_score <- add_map_col(total_cci_score,
                                   dplyr::select(data, ID, ID_num),
                                   "ID_num")                                   
    return(total_cci_score)
}

preprocess_data <- function(data) {
    # data <- sort_by_id_age(data)
    data <- add_num_id_col(data)
    return(data)
}

get_current_data <- function(grouped_data, icd_version) {
    tryCatch(
        expr = {
            return(grouped_data$data[grouped_data$idxs[[icd_version]], ])
        },
        error = function(e) {
            message("Careful, if you have an index out of bounds error this might be because the ICD_version column is of type integer instead of character.")
            print(e)
        }
    )
}