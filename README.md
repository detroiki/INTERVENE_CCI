# INTERVENE - Charlson Comorbidity Index
## Description
- This is an R package that calculates the Charlson Comorbidity Index on longitudinal data in INTERVENE format. 
  - The data should have at least the columns, `ID` and `primary_ICD`, and `ICD_version`. 
  - If you want to restrict the exposure period to calculate the index on, the data needs an additional column `Event_age`. 
- The package can handle different ICD-versions for the same individual. 
  - Possible entries for the column `ICD_version` are "10", "10CM", "9", or "9CM". 

## Dependencies
- assertthat
- comorbidity
- dplyr
- tibble
