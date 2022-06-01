#library(comorbidity) # For working with ICDs and calculating the CCI
#library(dplyr) # For data.frame manipulation
#library(readr) # For reading in the files
#library(tibble) # For better behaving data.frames
#library(zeallot) # For unpacking using %<-% like normally in python
#library(stringi) # Dependency of comoorbidity package
#library(purrr)

#longitud_data = readr::read_delim("data/#test_data_detailed_longitudinal_INTERVENE_format.tsv", delim="\t") %>% 
#                    dplyr::select(-"Personal Description")
#longitud_data %>% select(PRIMARY_ICD)
#longitud_data

set.seed(82312)
sample_data <- create_test_df_multi_icd_ver(n_icd10 = 100)
sample_data <- sort_by_id_age(sample_data)
#comorb_table_res <- get_comorb_table(sample_data)
#cci_scores <- calc_cci(sample_data)
#print(cci_scores)