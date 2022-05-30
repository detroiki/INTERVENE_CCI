calc_CCI <- function(data) {
    data_with_num_ID_col = create_num_ids(data)

    c(groups, group_keys, group_idxs) %<-% get_icd_ver_grouped_data(data_with_num_ID_col)

    for(icd_version in group_keys) {
        com_res = comorbidity::comorbidity(data_with_num_ID_col[group_idxs[[icd_version]],], "ID_num", "PRIMARY_ICD", map=get_comorb_icd_ver_str(icd_version), assign0=FALSE)
        com_res = com_res %>% 
                    dplyr::left_join(dplyr::distinct(data_with_num_ID_col, ID, .keep_all=TRUE) %>% 
                    select(ID, ID_num), by="ID_num")
    }
    #
}