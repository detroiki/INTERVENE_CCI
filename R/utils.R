add_num_ID_col <- function(data) {
    ID_num_map = data %>% dplyr::select(ID) %>% dplyr::distinct()
    ID_num_map = ID_num_map %>% tibble::add_column(ID_num=1:nrow(ID_num_map))
    data %>% dplyr::left_join(ID_num_map, by="ID")
}
get_icd_ver_grouped_data <- function(data) {
    groups = data %>% dplyr::group_by(ICD_VERSION, .drop=FALSE)
    group_keys =  groups %>% dplyr::group_keys() %>% pull(ICD_VERSION)
    group_idxs = groups %>% dplyr::group_rows()
    names(group_idxs) = group_keys
    return(list(groups=groups, group_keys=group_keys, group_idxs=group_idxs))
}
get_comorb_icd_ver_str <- function(icd_version) {
    if("10" %in% icd_version)
        return("charlson_icd10_quan")
    else if("9" %in% icd_version) {
        return("charlson_icd9_quan")
    }
    else {
        return("")
    }
}