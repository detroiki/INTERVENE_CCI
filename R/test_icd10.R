library(comorbidity) # For working with ICDs and calculating the CCI
library(dplyr) # For data.frame manipulation
library(readr) # For reading in the files
library(tibble) # For better behaving data.frames
library(zeallot) # For unpacking using %<-% like normally in python
library(stringi) # Dependency of comoorbidity package
library(purrr)

set.seed(82312)
longitud_data = readr::read_delim("data/test_data_detailed_longitudinal_INTERVENE_format.tsv", delim="\t") %>% 
                    dplyr::select(-"Personal Description")
longitud_data %>% select(PRIMARY_ICD)
longitud_data


samples = create_test_data()

calc_CCI(samples)