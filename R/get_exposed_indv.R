#' Gets individuals matching exposure window
#' 
#' Subsets the data.frame to only include the entries from individuals
#' inside the exposure period. By default gets all data from the 
#' data.frame. The exposure has to be given as age. In this case the
#' data.frame also needs to have a column `Event_age`.
#' 
#' If either or both `exp_start` and `exp_end` are provided restricts
#' the entries to the exposure period for each individual.
#' 
#' @inheritParams calc_cci
#' 
#' @export
#' 
#' @author Kira E. Detrois
get_exposed_indv <- function(long_data,
                             exp_start=NA,
                             exp_end=NA) {
    if(!is.na(exp_start) | !is.na(exp_end)) {
        assertthat::assert_that("Event_age" %in% colnames(long_data))
        if(is.na(exp_end)) 
            exp_end = 200 # Change this in case super humans exist
        if(is.na(exp_start))
            exp_start = 0
        long_data <- dplyr::filter(long_data, 
                                   Event_age >=exp_start & 
                                    Event_age <= exp_end)
    } 
    return(long_data)               
}
