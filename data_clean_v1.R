library(openxlsx)
library(tidyr)
library(dplyr)
library(magrittr)
library(reshape2)
options(scipen=999)

setwd("~/Desktop/Summer 2019/Data Engineering/final project")

##access data --
access_data <- read.xlsx("FullData.xlsx", sheet = 5)
access_data[,c(4:44)] <- format(round(access_data[,c(4:44)], 4), nsmall = 4)

##change variable names
colnames(access_data)[4] <- "population_low_access_store_2010"
colnames(access_data)[5] <- "population_low_access_store_2015"
colnames(access_data)[6] <- "population_low_access_store_2010_2015_percent_change"
colnames(access_data)[7] <- "population_low_access_store_2010_percent"
colnames(access_data)[8] <- "population_low_access_store_2015_percent"
colnames(access_data)[9] <- "low_income_low_access_store_2010"
colnames(access_data)[10] <- "low_income_low_access_store_2015"
colnames(access_data)[11] <- "low_income_low_access_store_2010_2015_percent_change"
colnames(access_data)[12] <- "low_income_low_access_store_2010_percent"
colnames(access_data)[13] <- "low_income_low_access_store_2015_percent"
colnames(access_data)[14] <- "households_no_car_low_access_store_2010"
colnames(access_data)[15] <- "households_no_car_low_access_store_2015"
colnames(access_data)[16] <- "households_no_car_low_access_store_2010_2015_percent_change"
colnames(access_data)[17] <- "households_no_car_low_access_store_2010_percent"
colnames(access_data)[18] <- "households_no_car_low_access_store_2010_percent"
colnames(access_data)[19] <- "snap_household_low_access_store_2015"
colnames(access_data)[20] <- "snap_household_low_access_store_2015_percent"
colnames(access_data)[21] <- "children_low_access_store_2010"
colnames(access_data)[22] <- "children_low_access_store_2015"
colnames(access_data)[23] <- "children_low_access_store_2010_2015_percent_change"
colnames(access_data)[24] <- "children_low_access_store_2010_percent"
colnames(access_data)[25] <- "children_low_access_store_2015_percent"
colnames(access_data)[26] <- "seniors_low_access_store_2010"
colnames(access_data)[27] <- "seniors_low_access_store_2015"
colnames(access_data)[28] <- "seniors_low_access_store_2010_2015_percent_change"
colnames(access_data)[29] <- "seniors_low_access_store_2010_percent"
colnames(access_data)[30] <- "seniors_low_access_store_2015_percent"
colnames(access_data)[31] <- "white_low_access_store_2015"
colnames(access_data)[32] <- "white_low_access_store_2015_percent"
colnames(access_data)[33] <- "black_low_access_store_2015"
colnames(access_data)[34] <- "black_low_access_store_2015_percent"
colnames(access_data)[35] <- "hispanic_low_access_store_2015"
colnames(access_data)[36] <- "hispanic_low_access_store_2015_percent"
colnames(access_data)[37] <- "asian_low_access_store_2015"
colnames(access_data)[38] <- "asian_low_access_store_2015_percent"
colnames(access_data)[39] <- "american_indian_alaska_native_low_access_store_2015"
colnames(access_data)[40] <- "american_indian_alaska_native_low_access_store_2015_percent"
colnames(access_data)[41] <- "hawaiian_pacific_islander_low_access_store_2015"
colnames(access_data)[42] <- "hawaiian_pacific_islander_low_access_store_2015_percent"
colnames(access_data)[43] <- "multiracial_low_access_store_2015"
colnames(access_data)[44] <- "multiracial_low_access_store_2015_percent"

access_data <- melt(access_data, id.vars=c("FIPS", "State", "County"))
access_data$FIPS <- paste("cs", access_data$FIPS,sep = "")
colnames(access_data)[1] <- "location_key"
colnames(access_data)[4] <- "variable_name"
colnames(access_data)[5] <- "measure_value"
access_data$id <- seq.int(nrow(access_data))
access_data$category_key <- "40"

##year key
access_data_2010 <- access_data %>%
  filter(grepl("_2010$", variable_name) | grepl("_2010_percent$", variable_name))
access_data_2010$year_key <- "4"

access_data_2015 <- access_data %>%
  filter(grepl("_2015$", variable_name) | grepl("_2015_percent$", variable_name))
access_data_2015$year_key <- "9"

access_data_year <- rbind(access_data_2010, access_data_2015)
access_data_no_year <- access_data[!(access_data$id %in% access_data_year$id),]
access_data_no_year$year_key <- "NA"

access_data <- rbind(access_data_year, access_data_no_year)

##program attribute key
access_data_snap <- access_data %>%
  filter(grepl("^snap", variable_name))
access_data_snap$program_attribute_key <- "73"

access_data_demo <- access_data[!(access_data$id %in% access_data_snap$id),]
access_data_demo$program_attribute_key <- "62"

access_data <- rbind(access_data_snap, access_data_demo)

###population segment key
access_data_snap$population_segment_key <- "31"

access_data_children <- access_data %>%
  filter(grepl("^children", variable_name))
access_data_children$population_segment_key <- "24"

access_data_seniors <- access_data %>%
  filter(grepl("^senior", variable_name))
access_data_seniors$population_segment_key <- "28"

access_data_white <- access_data %>%
  filter(grepl("^white", variable_name))
access_data_white$population_segment_key <- "30"

access_data_black <- access_data %>%
  filter(grepl("^black", variable_name))
access_data_black$population_segment_key <- "23"

access_data_hisp <- access_data %>%
  filter(grepl("^hispanic", variable_name))
access_data_hisp$population_segment_key <- "26"

access_data_asian <- access_data %>%
  filter(grepl("^asian", variable_name))
access_data_asian$population_segment_key <- "22"

access_data_american_indian <- access_data %>%
  filter(grepl("^american_indian", variable_name))
access_data_american_indian$population_segment_key <- "21"

access_data_hawaiian <- access_data %>%
  filter(grepl("^hawaiian", variable_name))
access_data_hawaiian$population_segment_key <- "25"

access_data_multi <- access_data %>%
  filter(grepl("^multi", variable_name))
access_data_multi$population_segment_key <- "27"

access_data_non_total <- rbind(access_data_american_indian, access_data_asian, access_data_black, access_data_children,
                     access_data_hawaiian, access_data_hisp, access_data_multi, access_data_seniors, access_data_snap,
                     access_data_white)

access_data_total <- access_data[!(access_data$id %in% access_data_non_total$id),]
access_data_total$population_segment_key <- "29"

access_data <- rbind(access_data_total, access_data_non_total)

##measure key
access_data_low_access <- access_data %>%
  filter(grepl("low_access_store", variable_name)) %>%
  filter(!grepl("low_income", variable_name)) %>%
  filter(!grepl("no_car", variable_name)) %>%
  filter(!grepl("percent", variable_name))
access_data_low_access$measure_name_key <- "118"

access_data_low_access_low_income <- access_data %>%
  filter(grepl("low_income", variable_name)) %>%
  filter(!grepl("percent", variable_name))
access_data_low_access_low_income$measure_name_key <- "119"

access_data_low_access_no_car <- access_data %>%
  filter(grepl("no_car", variable_name)) %>%
  filter(!grepl("percent", variable_name))
access_data_low_access_no_car$measure_name_key <- "100"

access_data_measure <- rbind(access_data_low_access, access_data_low_access_low_income, access_data_low_access_no_car)
access_data_no_measure <- access_data[!(access_data$id %in% access_data_measure$id),]
access_data_no_measure$measure_name_key <- "NA"
access_data <- rbind(access_data_measure, access_data_no_measure)

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(access_data, "access_data_clean.csv", row.names = FALSE)

########stores data----
setwd("~/Desktop/Summer 2019/Data Engineering/final project")

store_data <- read.xlsx("FullData.xlsx", sheet = 6)

colnames(store_data)[4] <- "grocery_stores_2009"
colnames(store_data)[5] <- "grocery_stores_2014"
colnames(store_data)[6] <- "grocery_store_2009_2014_percent_change"
colnames(store_data)[7] <- "grocery_store_per_pop_2009"
colnames(store_data)[8] <- "grocery_store_per_pop_2014"
colnames(store_data)[9] <- "grocery_store_per_pop_2009_2014_percent_change"
colnames(store_data)[10] <- "supercenters_club_stores_2009"
colnames(store_data)[11] <- "supercenters_club_stores_2014"
colnames(store_data)[12] <- "supercenters_club_stores_2009_2014_percent_change"
colnames(store_data)[13] <- "supercenters_club_stores_per_pop_2009"
colnames(store_data)[14] <- "supercenters_club_stores_per_pop_2014"
colnames(store_data)[15] <- "supercenters_club_stores_per_pop_2009_2014_percent_change"
colnames(store_data)[16] <- "convenience_stores_2009"
colnames(store_data)[17] <- "convenience_stores_2014"
colnames(store_data)[18] <- "convenience_stores_2009_2014_percent_change"
colnames(store_data)[19] <- "convenience_stores_per_pop_2009"
colnames(store_data)[20] <- "convenience_stores_per_pop_2014"
colnames(store_data)[21] <- "convenience_stores_per_pop_2009_2014_percent_change"
colnames(store_data)[22] <- "specialized_food_stores_2009"
colnames(store_data)[23] <- "specialized_food_stores_2014"
colnames(store_data)[24] <- "specialized_food_stores_2009_2014_percent_change"
colnames(store_data)[25] <- "specialized_food_stores_per_pop_2009"
colnames(store_data)[26] <- "specialized_food_stores_per_pop_2014"
colnames(store_data)[27] <- "specialized_food_stores_per_pop_2009_2014_percent_change"
colnames(store_data)[28] <- "snap_authorized_stores_2012"
colnames(store_data)[29] <- "snap_authorized_stores_2016"
colnames(store_data)[30] <- "snap_authorized_stores_2012_2016_percent_change"
colnames(store_data)[31] <- "snap_authorized_stores_per_pop_2012"
colnames(store_data)[32] <- "snap_authorized_stores_per_pop_2016"
colnames(store_data)[33] <- "snap_authorized_stores_per_pop_2012_2016_percent_change"
colnames(store_data)[34] <- "wic_authorized_stores_2008"
colnames(store_data)[35] <- "wic_authorized_stores_2012"
colnames(store_data)[36] <- "wic_authorized_stores_2008_2012_percent_change"
colnames(store_data)[37] <- "wic_authorized_stores_per_pop_2008"
colnames(store_data)[38] <- "wic_authorized_stores_per_pop_2012"
colnames(store_data)[39] <- "wic_authorized_stores_per_pop_2008_2012_percent_change"

store_data <- melt(store_data, id.vars=c("FIPS", "State", "County"))
store_data$FIPS <- paste("cs", store_data$FIPS,sep = "")
colnames(store_data)[1] <- "location_key"
colnames(store_data)[4] <- "variable_name"
colnames(store_data)[5] <- "measure_value"
store_data$id <- seq.int(nrow(store_data))

##category key
store_data_au <- store_data %>%
  filter(grepl("authorized", variable_name))
store_data_au$category_key <- "42"

store_data_store <- store_data[!(store_data$id %in% store_data_au$id),]
store_data_store$category_key <- "47"

store_data <- rbind(store_data_au, store_data_store)

##year key
store_data_2009 <- store_data %>%
  filter(grepl("_2009$", variable_name))
store_data_2009$year_key <- "3"

store_data_2014 <- store_data %>%
  filter(grepl("_2014$", variable_name)) %>%
  filter(!grepl("2009_2014_percent_change", variable_name)) 
store_data_2014$year_key <- "8"

store_data_2012 <- store_data %>%
  filter(grepl("_2012$", variable_name)) %>%
  filter(!grepl("2008_2012_percent_change", variable_name))
store_data_2012$year_key <- "6"

store_data_2016 <- store_data %>%
  filter(grepl("_2016$", variable_name)) %>%
  filter(!grepl("2012_2016_percent_change", variable_name))
store_data_2016$year_key <- "10"

store_data_2008 <- store_data %>%
  filter(grepl("_2008$", variable_name))
store_data_2008$year_key <- "2"

store_data_year <- rbind(store_data_2009, store_data_2014, store_data_2012, store_data_2016, store_data_2008)
store_data_no_year <- store_data[!(store_data$id %in% store_data_year$id),]
store_data_no_year$year_key <- "NA"

store_data <- rbind(store_data_year, store_data_no_year)

##program attribute key
store_data_groc <- store_data %>%
  filter(grepl("^grocery", variable_name))
store_data_groc$program_attribute_key <- "66"

store_data_superc <- store_data %>%
  filter(grepl("^supercenter", variable_name))
store_data_superc$program_attribute_key <- "77"

store_data_conv <- store_data %>%
  filter(grepl("^convenience", variable_name))
store_data_conv$program_attribute_key <- "61"

store_data_spec <- store_data %>%
  filter(grepl("^specialize", variable_name))
store_data_spec$program_attribute_key <- "74"

store_data_snap <- store_data %>%
  filter(grepl("^snap", variable_name))
store_data_snap$program_attribute_key <- "73"

store_data_wic <- store_data %>%
  filter(grepl("^wic", variable_name))
store_data_wic$program_attribute_key <- "78"

store_data <- rbind(store_data_groc, store_data_conv, store_data_snap, store_data_spec, store_data_superc,
                    store_data_wic)

###population key
store_data$population_segment_key <- "29"

###measure name key
store_data_count <- store_data %>%
  filter(grepl("[1-9]$", variable_name)) %>%
  filter(!grepl("per_pop", variable_name))
store_data_count$measure_name_key <- "102"

store_data_per_pop <- store_data %>%
  filter(grepl("per_pop", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
store_data_per_pop$measure_name_key <- "103"

store_data_measure <- rbind(store_data_count, store_data_per_pop)
store_data_no_measure <- store_data[!(store_data$id %in% store_data_measure$id),]
store_data_no_measure$measure_name_key <- "NA"

store_data <- rbind(store_data_measure, store_data_no_measure)

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(store_data, "store_data_clean.csv", row.names = FALSE)

#####restaurant
setwd("~/Desktop/Summer 2019/Data Engineering/final project")

restaurant_data <- read.xlsx("FullData.xlsx", sheet = 7)

colnames(restaurant_data)[4] <- "fast_food_2009"
colnames(restaurant_data)[5] <- "fast_food_2014"
colnames(restaurant_data)[6] <- "fast_food_2009_2014_percent_change"
colnames(restaurant_data)[7] <- "fast_food_per_pop_2009"
colnames(restaurant_data)[8] <- "fast_food_per_pop_2014"
colnames(restaurant_data)[9] <- "fast_food_per_pop_2009_2014_percent_change"
colnames(restaurant_data)[10] <- "full_service_restaurant_2009"
colnames(restaurant_data)[11] <- "full_service_restaurant_2014"
colnames(restaurant_data)[12] <- "full_service_restaurant_2009_2014_percent_change"
colnames(restaurant_data)[13] <- "full_service_restaurant_per_pop_2009"
colnames(restaurant_data)[14] <- "full_service_restaurant_per_pop_2014"
colnames(restaurant_data)[15] <- "full_service_restaurant_per_pop_2009_2014_percent_change"
colnames(restaurant_data)[16] <- "expenditure_per_capita_fast_food_2007"
colnames(restaurant_data)[17] <- "expenditure_per_capita_fast_food_2012"
colnames(restaurant_data)[18] <- "expenditure_per_capita_restaurant_2007"
colnames(restaurant_data)[19] <- "expenditure_per_capita_restaurant_2012"

restaurant_data <- melt(restaurant_data, id.vars=c("FIPS", "State", "County"))
restaurant_data$FIPS <- paste("cs", restaurant_data$FIPS,sep = "")
colnames(restaurant_data)[1] <- "location_key"
colnames(restaurant_data)[4] <- "variable_name"
colnames(restaurant_data)[5] <- "measure_value"
restaurant_data$id <- seq.int(nrow(restaurant_data))

##category key
restaurant_data$category_key <- "45"

##year key
restaurant_data_2009 <- restaurant_data %>%
  filter(grepl("_2009$", variable_name))
restaurant_data_2009$year_key <- "3"

restaurant_data_2014 <- restaurant_data %>%
  filter(grepl("_2014$", variable_name)) %>%
  filter(!grepl("2009_2014_percent_change", variable_name)) 
restaurant_data_2014$year_key <- "8"

restaurant_data_2012 <- restaurant_data %>%
  filter(grepl("_2012$", variable_name)) 
restaurant_data_2012$year_key <- "6"

restaurant_data_2007 <- restaurant_data %>%
  filter(grepl("_2007$", variable_name))
restaurant_data_2007$year_key <- "1"

restaurant_data_year <- rbind(restaurant_data_2009, restaurant_data_2014, restaurant_data_2012, restaurant_data_2007)
restaurant_data_no_year <- restaurant_data[!(restaurant_data$id %in% restaurant_data_year$id),]
restaurant_data_no_year$year_key <- "NA"

restaurant_data <- rbind(restaurant_data_year, restaurant_data_no_year)

##program attribute key
restaurant_data_fast <- restaurant_data %>%
  filter(grepl("fast", variable_name))
restaurant_data_fast$program_attribute_key <- "64"

restaurant_data_rest <- restaurant_data %>%
  filter(grepl("restaurant", variable_name))
restaurant_data_rest$program_attribute_key <- "65"

restaurant_data <- rbind(restaurant_data_fast, restaurant_data_rest)

###population key
restaurant_data$population_segment_key <- "29"

###measure name key
restaurant_data_count <- restaurant_data %>%
  filter(grepl("[1-9]$", variable_name)) %>%
  filter(!grepl("per_pop", variable_name)) %>%
  filter(!grepl("per_capita", variable_name))
restaurant_data_count$measure_name_key <- "102"

restaurant_data_per_pop <- restaurant_data %>%
  filter(grepl("per_pop", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
restaurant_data_per_pop$measure_name_key <- "103"

restaurant_data_per_cap <- restaurant_data %>%
  filter(grepl("per_cap", variable_name)) 
restaurant_data_per_cap$measure_name_key <- "106"

restaurant_data_measure <- rbind(restaurant_data_count, restaurant_data_per_pop, restaurant_data_per_cap)
restaurant_data_no_measure <- restaurant_data[!(restaurant_data$id %in% restaurant_data_measure$id),]
restaurant_data_no_measure$measure_name_key <- "NA"

restaurant_data <- rbind(restaurant_data_measure, restaurant_data_no_measure)

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(restaurant_data, "restaurant_data_clean.csv", row.names = FALSE)


#####assistance
setwd("~/Desktop/Summer 2019/Data Engineering/final project")

assistance_data <- read.xlsx("FullData.xlsx", sheet = 8)

colnames(assistance_data)[4] <- "snap_redemptions_snap_authorized_stores_2012"
colnames(assistance_data)[5] <- "snap_redemptions_snap_authorized_stores_2016"
colnames(assistance_data)[6] <- "snap_redemptions_snap_authorized_stores_2012_2016_percent_change"
colnames(assistance_data)[7] <- "snap_participants_2012_percent"
colnames(assistance_data)[8] <- "snap_participants_2016_percent"
colnames(assistance_data)[9] <- "snap_participants_percent_pop_2012_2016_percent_change"
colnames(assistance_data)[10] <- "snap_benefit_per_capita_2010"
colnames(assistance_data)[11] <- "snap_benefit_per_capita_2015"
colnames(assistance_data)[12] <- "snap_benefit_per_capita_2010_2015_percent_change"
colnames(assistance_data)[13] <- "snap_participants_eligible_2008_percent"
colnames(assistance_data)[14] <- "snap_participants_eligible_2014_percent"
colnames(assistance_data)[15] <- "snap_online_application_2009"
colnames(assistance_data)[16] <- "snap_online_application_2016"
colnames(assistance_data)[17] <- "snap_combined_application_project_2009"
colnames(assistance_data)[18] <- "snap_combined_application_project_2016"
colnames(assistance_data)[19] <- "snap_broad_based_categorical_eligibility_2009"
colnames(assistance_data)[20] <- "snap_broad_based_categorical_eligibility_2016"
colnames(assistance_data)[21] <- "snap_simplified_reporting_2009"
colnames(assistance_data)[22] <- "snap_simplified_reporting_2016"
colnames(assistance_data)[23] <- "national_school_lunch_program_participants_2009_percent"
colnames(assistance_data)[24] <- "national_school_lunch_program_participants_2015_percent"
colnames(assistance_data)[25] <- "national_school_lunch_program_participants_2009_2015_percent_change"
colnames(assistance_data)[26] <- "students_eligible_free_lunch_2009_percent"
colnames(assistance_data)[27] <- "students_eligible_free_lunch_2014_percent"
colnames(assistance_data)[28] <- "students_eligible_reduced_price_lunch_2009_percent"
colnames(assistance_data)[29] <- "students_eligible_reduced_price_lunch_2014_percent"
colnames(assistance_data)[30] <- "school_breakfast_program_participants_2009_percent"
colnames(assistance_data)[31] <- "school_breakfast_program_participants_2015_percent"
colnames(assistance_data)[32] <- "school_breakfast_program_participants_2009_2015_percent_change"
colnames(assistance_data)[33] <- "summer_food_service_program_participants_2009_percent"
colnames(assistance_data)[34] <- "summer_food_service_program_participants_2015_percent"
colnames(assistance_data)[35] <- "summer_food_service_program_participants_2009_2015_percent_change"
colnames(assistance_data)[36] <- "wic_redemptions_per_capita_2008"
colnames(assistance_data)[37] <- "wic_redemptions_per_capita_2012"
colnames(assistance_data)[38] <- "wic_redemptions_per_capita_2008_2012_percent_change"
colnames(assistance_data)[39] <- "wic_redemptions_wic_authorized_stores_2008"
colnames(assistance_data)[40] <- "wic_redemptions_wic_authorized_stores_2012"
colnames(assistance_data)[41] <- "wic_redemptions_wic_authorized_stores_2008_2012_percent_change"
colnames(assistance_data)[42] <- "wic_participants_2009_percent"
colnames(assistance_data)[43] <- "wic_participants_2015_percent"
colnames(assistance_data)[44] <- "wic_participants_2009_2015_percent_change"
colnames(assistance_data)[45] <- "child_adult_care_2009_percent"
colnames(assistance_data)[46] <- "child_adult_care_2015_percent"
colnames(assistance_data)[47] <- "child_adult_care_2009_2015_percent_change"
colnames(assistance_data)[48] <- "FDPIR_sites_2012"

assistance_data <- melt(assistance_data, id.vars=c("FIPS", "State", "County"))
assistance_data$FIPS <- paste("cs", assistance_data$FIPS,sep = "")
colnames(assistance_data)[1] <- "location_key"
colnames(assistance_data)[4] <- "variable_name"
colnames(assistance_data)[5] <- "measure_value"
assistance_data$id <- seq.int(nrow(assistance_data))

##category key
assistance_data$category_key <- "41"

##year key
assistance_data_2012 <- assistance_data %>%
  filter(grepl("2012", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_2012$year_key <- "6"

assistance_data_2016 <- assistance_data %>%
  filter(grepl("2016", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_2016$year_key <- "10"

assistance_data_2010 <- assistance_data %>%
  filter(grepl("2010", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_2010$year_key <- "4"

assistance_data_2015 <- assistance_data %>%
  filter(grepl("2015", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_2015$year_key <- "9"

assistance_data_2008 <- assistance_data %>%
  filter(grepl("2008", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_2008$year_key <- "2"

assistance_data_2014 <- assistance_data %>%
  filter(grepl("2014", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_2014$year_key <- "8"

assistance_data_2009 <- assistance_data %>%
  filter(grepl("2009", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_2009$year_key <- "3"

assistance_data_year <- rbind(assistance_data_2009, assistance_data_2014, assistance_data_2012, assistance_data_2008, 
                              assistance_data_2015, assistance_data_2016, assistance_data_2010)

assistance_data_no_year <- assistance_data[!(assistance_data$id %in% assistance_data_year$id),]
assistance_data_no_year$year_key <- "NA"

assistance_data <- rbind(assistance_data_year, assistance_data_no_year)

##program attribute key
assistance_data_child <- assistance_data %>%
  filter(grepl("child", variable_name))
assistance_data_child$program_attribute_key <- "60"

assistance_data_lunch <- assistance_data %>%
  filter(grepl("lunch", variable_name))
assistance_data_lunch$program_attribute_key <- "69"

assistance_data_break <- assistance_data %>%
  filter(grepl("breakfast", variable_name))
assistance_data_break$program_attribute_key <- "71"

assistance_data_snap <- assistance_data %>%
  filter(grepl("snap", variable_name))
assistance_data_snap$program_attribute_key <- "73"

assistance_data_sum<- assistance_data %>%
  filter(grepl("summer", variable_name))
assistance_data_sum$program_attribute_key <- "76"

assistance_data_wic <- assistance_data %>%
  filter(grepl("wic", variable_name))
assistance_data_wic$program_attribute_key <- "78"

assistance_data_prog <- rbind(assistance_data_break, assistance_data_child, assistance_data_lunch,
                              assistance_data_snap, assistance_data_sum, assistance_data_wic)

assistance_data_no_prog <- assistance_data[!(assistance_data$id %in% assistance_data_prog$id),]
assistance_data_no_prog$program_attribute_key <- "NA"

assistance_data <- rbind(assistance_data_prog, assistance_data_no_prog)

###population key
assistance_data$population_segment_key <- "29"

###measure name key
assistance_data_percent <- assistance_data %>%
  filter(grepl("child", variable_name) | variable_name == "snap_participants_2012_percent" |
           variable_name == "snap_participants_2016_percent") %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_percent$measure_name_key <- "124"

assistance_data_online <- assistance_data %>%
  filter(grepl("online", variable_name))
assistance_data_online$measure_name_key <- "123"

assistance_data_benefit_per_cap <- assistance_data %>%
  filter(grepl("benefit_per_cap", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_benefit_per_cap$measure_name_key <- "101"

assistance_data_eli <- assistance_data %>%
  filter(grepl("eligib", variable_name)) %>%
  filter(!grepl("percent_change", variable_name)) %>%
  filter(!grepl("snap", variable_name))
assistance_data_eli$measure_name_key <- "125"

assistance_data_eli_pro <- assistance_data %>%
  filter(grepl("eligib", variable_name)) %>%
  filter(!grepl("percent_change", variable_name)) %>%
  filter(grepl("snap", variable_name)) %>%
  filter(grepl("percent$", variable_name))
assistance_data_eli_pro$measure_name_key <- "128"

assistance_data_pro_pc <- assistance_data %>%
  filter(grepl("program", variable_name) | grepl("wic", variable_name)) %>%
  filter(!grepl("percent_change", variable_name)) %>%
  filter(grepl("percent$", variable_name))
assistance_data_pro_pc$measure_name_key <- "129"

assistance_data_redem_per_cap <- assistance_data %>%
  filter(grepl("redemptions_per_capita", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_redem_per_cap$measure_name_key <- "130"

assistance_data_redem_au <- assistance_data %>%
  filter(grepl("redemptions_snap_authorized", variable_name) | grepl("redemptions_wic_authorized", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
assistance_data_redem_au$measure_name_key <- "131"

assistance_data_measure <- rbind(assistance_data_percent, assistance_data_online, assistance_data_benefit_per_cap,
                                 assistance_data_eli, assistance_data_eli_pro, assistance_data_pro_pc,
                                 assistance_data_redem_per_cap, assistance_data_redem_au)

assistance_data_no_measure <- assistance_data[!(assistance_data$id %in% assistance_data_measure$id),]
assistance_data_no_measure$measure_name_key <- "NA"

assistance_data <- rbind(assistance_data_measure, assistance_data_no_measure)

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(assistance_data, "assistance_data_clean.csv", row.names = FALSE)


#####insecurity
setwd("~/Desktop/Summer 2019/Data Engineering/final project")

insecurity_data <- read.xlsx("FullData.xlsx", sheet = 9)

colnames(insecurity_data)[4] <- "household_food_insecurity_2010_2012_percent"
colnames(insecurity_data)[5] <- "household_food_insecurity_2013_2015_percent"
colnames(insecurity_data)[6] <- "household_food_insecurity_2012_2015_percent_change"
colnames(insecurity_data)[7] <- "household_very_low_food_security_2010_2012_percent"
colnames(insecurity_data)[8] <- "household_very_low_food_security_2013_2015_percent"
colnames(insecurity_data)[9] <- "household_very_low_food_security_2012_2015_percent_change"
colnames(insecurity_data)[10] <- "household_child_food_insecurity_2001_2007_percent"
colnames(insecurity_data)[11] <- "household_child_food_insecurity_2003_2011_percent"

insecurity_data <- melt(insecurity_data, id.vars=c("FIPS", "State", "County"))
insecurity_data$FIPS <- paste("cs", insecurity_data$FIPS,sep = "")
colnames(insecurity_data)[1] <- "location_key"
colnames(insecurity_data)[4] <- "variable_name"
colnames(insecurity_data)[5] <- "measure_value"
insecurity_data$id <- seq.int(nrow(insecurity_data))

##category key
insecurity_data$category_key <- "43"

##year key
insecurity_data_2001_2007 <- insecurity_data %>%
  filter(grepl("2001_2007", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
insecurity_data_2001_2007$year_key <- "11"

insecurity_data_2003_2011 <- insecurity_data %>%
  filter(grepl("2003_2011", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
insecurity_data_2003_2011$year_key <- "12"

insecurity_data_2010_2012 <- insecurity_data %>%
  filter(grepl("2010_2012", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
insecurity_data_2010_2012$year_key <- "13"

insecurity_data_2013_2015 <- insecurity_data %>%
  filter(grepl("2013_2015", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
insecurity_data_2013_2015$year_key <- "14"

insecurity_data_year <- rbind(insecurity_data_2001_2007, insecurity_data_2003_2011, insecurity_data_2010_2012, insecurity_data_2013_2015) 
                              
insecurity_data_no_year <- insecurity_data[!(insecurity_data$id %in% insecurity_data_year$id),]
insecurity_data_no_year$year_key <- "NA"

insecurity_data <- rbind(insecurity_data_year, insecurity_data_no_year)

##program attribute key
insecurity_data$program_attribute_key <- "75"

###population key
insecurity_data_child <- insecurity_data %>%
  filter(grepl("child", variable_name))
insecurity_data_child$population_segment_key <- "24"

insecurity_data_pop <- insecurity_data[!(insecurity_data$id %in% insecurity_data_child$id),]
insecurity_data_pop$population_segment_key <- "29"

insecurity_data <- rbind(insecurity_data_child, insecurity_data_pop)

###measure name key
insecurity_data_percent <- insecurity_data %>%
  filter(grepl("percent", variable_name)) %>%
  filter(!grepl("percent_change", variable_name)) %>%
  filter(!grepl("low", variable_name))
insecurity_data_percent$measure_name_key <- "116"

insecurity_data_percent_low <- insecurity_data %>%
  filter(grepl("low", variable_name)) %>%
  filter(!grepl("percent_change", variable_name)) 
insecurity_data_percent_low$measure_name_key <- "117"

insecurity_data_measure <- rbind(insecurity_data_percent, insecurity_data_percent_low)
            
insecurity_data_no_measure <- insecurity_data[!(insecurity_data$id %in% insecurity_data_measure$id),]
insecurity_data_no_measure$measure_name_key <- "NA"

insecurity_data <- rbind(insecurity_data_measure, insecurity_data_no_measure)

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(insecurity_data, "insecurity_data_clean.csv", row.names = FALSE)


#####local
setwd("~/Desktop/Summer 2019/Data Engineering/final project")

local_data <- read.xlsx("FullData.xlsx", sheet = 11)

local_vars <- c("FIPS", "State", "County", "FMRKT_CREDIT16", "FMRKT_SFMNP16", "FMRKT_SNAP16", "FMRKT_WICCASH16", 
                "FMRKT_WIC16", "FMRKT_ANMLPROD16", "FMRKT_BAKED16", "FMRKT_FRVEG16",
                "FMRKT_OTHERFOOD16", "FMRKT09", "FMRKT16", "FMRKTPTH09", "FMRKTPTH16")

local_data <- local_data[,local_vars]

colnames(local_data)[4] <- "farmers_markets_accept_credit_cards_2016"
colnames(local_data)[5] <- "farmers_markets_accept_SFMNP_2016"
colnames(local_data)[6] <- "farmers_markets_accept_snap_2016"
colnames(local_data)[7] <- "farmers_markets_accept_wic_cash_2016"
colnames(local_data)[8] <- "farmers_markets_accept_wic_2016"
colnames(local_data)[9] <- "farmers_markets_sell_animal_products_2016"
colnames(local_data)[10] <- "farmers_markets_sell_baked_goods_2016"
colnames(local_data)[11] <- "farmers_markets_sell_fruits_vegetables_2016"
colnames(local_data)[12] <- "farmers_markets_sell_other_food_2016"
colnames(local_data)[13] <- "farmers_markets_2009"
colnames(local_data)[14] <- "farmers_markets_2016"
colnames(local_data)[15] <- "farmers_markets_2009_per_pop_percent"
colnames(local_data)[16] <- "farmers_markets_2016_per_pop_percent"

local_data <- melt(local_data, id.vars=c("FIPS", "State", "County"))
local_data$FIPS <- paste("cs", local_data$FIPS,sep = "")
colnames(local_data)[1] <- "location_key"
colnames(local_data)[4] <- "variable_name"
colnames(local_data)[5] <- "measure_value"
local_data$id <- seq.int(nrow(local_data))

##category key
local_data_assist <- local_data %>%
  filter(grepl("snap", variable_name) | grepl("SFMNP", variable_name) | grepl("wic", variable_name))
local_data_assist$category_key <- "41"

local_data_non_assist <- local_data[!(local_data$id %in% local_data_assist$id),]
local_data_non_assist$category_key <- "47"

local_data <- rbind(local_data_assist, local_data_non_assist)

##year key
local_data_2016 <- local_data %>%
  filter(grepl("2016", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
local_data_2016$year_key <- "10"

local_data_2009 <- local_data %>%
  filter(grepl("2009", variable_name)) %>%
  filter(!grepl("percent_change", variable_name))
local_data_2009$year_key <- "3"

local_data <- rbind(local_data_2009, local_data_2016)

##program attribute key
local_data_farm <- local_data %>%
  filter(grepl("farmers", variable_name)) %>%
  filter(!grepl("wic", variable_name)) %>%
  filter(!grepl("snap", variable_name)) %>%
  filter(!grepl("SFMNP", variable_name))
local_data_farm$program_attribute_key <- "63"

local_data_wic <- local_data %>%
  filter(grepl("wic", variable_name)) 
local_data_wic$program_attribute_key <- "78"

local_data_snap <- local_data %>%
  filter(grepl("snap", variable_name)) 
local_data_snap$program_attribute_key <- "73"

local_data_sf <- local_data %>%
  filter(grepl("SFMNP", variable_name)) 
local_data_sf$program_attribute_key <- "72"

local_data <- rbind(local_data_farm, local_data_wic, local_data_snap, local_data_sf)

###population key
local_data$population_segment_key <- "29"

###measure name key
local_data_count <- local_data %>%
  filter(variable_name == "farmers_markets_2009" | variable_name == "farmers_markets_2016") 
local_data_count$measure_name_key <- "102"

local_data_percent <- local_data %>%
  filter(variable_name == "farmers_markets_2009_per_pop_percent" | variable_name == "farmers_markets_2016_per_pop_percent") 
local_data_percent$measure_name_key <- "103"

local_data_card <- local_data %>%
  filter(variable_name == "farmers_markets_accept_credit_cards_2016") 
local_data_card$measure_name_key <- "107"

local_data_sfm <- local_data %>%
  filter(variable_name == "farmers_markets_accept_SFMNP_2016") 
local_data_sfm$measure_name_key <- "108"

local_data_snap <- local_data %>%
  filter(variable_name == "farmers_markets_accept_snap_2016") 
local_data_snap$measure_name_key <- "109"

local_data_wic_c <- local_data %>%
  filter(variable_name == "farmers_markets_accept_wic_cash_2016") 
local_data_wic_c$measure_name_key <- "111"

local_data_wic <- local_data %>%
  filter(variable_name == "farmers_markets_accept_wic_2016") 
local_data_wic$measure_name_key <- "110"

local_data_animal <- local_data %>%
  filter(variable_name == "farmers_markets_sell_animal_products_2016") 
local_data_animal$measure_name_key <- "112"

local_data_baked <- local_data %>%
  filter(variable_name == "farmers_markets_sell_baked_goods_2016") 
local_data_baked$measure_name_key <- "113"

local_data_veg <- local_data %>%
  filter(variable_name == "farmers_markets_sell_fruits_vegetables_2016") 
local_data_veg$measure_name_key <- "114"

local_data_oth <- local_data %>%
  filter(variable_name == "farmers_markets_sell_other_food_2016") 
local_data_oth$measure_name_key <- "115"

local_data <- rbind(local_data_count, local_data_percent, local_data_card, local_data_sfm, local_data_snap,
                    local_data_wic_c, local_data_wic, local_data_animal, local_data_baked, local_data_veg,
                    local_data_oth)

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(local_data, "local_data_clean.csv", row.names = FALSE)

#####health
setwd("~/Desktop/Summer 2019/Data Engineering/final project")

health_data <- read.xlsx("FullData.xlsx", sheet = 12)

health_vars <- c("FIPS", "State", "County","PCT_DIABETES_ADULTS08", "PCT_DIABETES_ADULTS13", "PCT_OBESE_ADULTS08",
                 "PCT_OBESE_ADULTS13", "RECFAC09", "RECFAC14", "RECFACPTH09", 
                 "RECFACPTH14")

health_data <- health_data[,health_vars]

colnames(health_data)[4] <- "adult_diabetes_2008_percent"
colnames(health_data)[5] <- "adult_diabetes_2013_percent"
colnames(health_data)[6] <- "adult_obesity_2008_percent"
colnames(health_data)[7] <- "adult_obesity_2013_percent"
colnames(health_data)[8] <- "recreation_fitness_facilities_2009"
colnames(health_data)[9] <- "recreation_fitness_facilities_2014"
colnames(health_data)[10] <- "recreation_fitness_facilities_2009_per_pop_percent"
colnames(health_data)[11] <- "recreation_fitness_facilities_2014_per_pop_percent"

health_data <- melt(health_data, id.vars=c("FIPS", "State", "County"))
health_data$FIPS <- paste("cs", health_data$FIPS,sep = "")
colnames(health_data)[1] <- "location_key"
colnames(health_data)[4] <- "variable_name"
colnames(health_data)[5] <- "measure_value"
health_data$id <- seq.int(nrow(health_data))

##category key
health_data$category_key <- "43"

##year key
health_data_2008 <- health_data %>%
  filter(grepl("2008", variable_name)) 
health_data_2008$year_key <- "2"

health_data_2009 <- health_data %>%
  filter(grepl("2009", variable_name)) 
health_data_2009$year_key <- "3"

health_data_2013 <- health_data %>%
  filter(grepl("2013", variable_name)) 
health_data_2013$year_key <- "7"

health_data_2014 <- health_data %>%
  filter(grepl("2014", variable_name)) 
health_data_2014$year_key <- "8"

health_data <- rbind(health_data_2008, health_data_2009, health_data_2013, health_data_2014) 

##program attribute key
health_data_fitness <- health_data %>%
  filter(grepl("fitness", variable_name))
health_data_fitness$program_attribute_key <- "70"

health_data_health <- health_data[!(health_data$id %in% health_data_fitness$id),]
health_data_health$program_attribute_key <- "67"

health_data <- rbind(health_data_fitness, health_data_health)

###population key
health_data_adult <- health_data %>%
  filter(grepl("adult", variable_name))
health_data_adult$population_segment_key <- "20"

health_data_pop <- health_data[!(health_data$id %in% health_data_adult$id),]
health_data_pop$population_segment_key <- "29"

health_data <- rbind(health_data_adult, health_data_pop)

###measure name key
health_data_count <- health_data %>%
  filter(variable_name == "recreation_fitness_facilities_2009" | variable_name == "recreation_fitness_facilities_2014") 
health_data_count$measure_name_key <- "102"

health_data_percent_fit <- health_data %>%
  filter(variable_name == "recreation_fitness_facilities_2009_per_pop_percent" | variable_name == "recreation_fitness_facilities_2014_per_pop_percent") 
health_data_percent_fit$measure_name_key <- "103"

health_data_diab_rate <- health_data %>%
  filter(variable_name == "adult_diabetes_2008_percent" | variable_name == "adult_diabetes_2013_percent") 
health_data_diab_rate$measure_name_key <- "105"

health_data_obs_rate <- health_data %>%
  filter(variable_name == "adult_obesity_2008_percent" | variable_name == "adult_obesity_2013_percent") 
health_data_obs_rate$measure_name_key <- "122"

health_data <- rbind(health_data_count, health_data_percent_fit, health_data_diab_rate, health_data_obs_rate)

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(health_data, "health_data_clean.csv", row.names = FALSE)


#####ses
setwd("~/Desktop/Summer 2019/Data Engineering/final project")

ses_data <- read.xlsx("FullData.xlsx", sheet = 13)

ses_vars <- c("FIPS", "State", "County", "PCT_NHNA10", "PCT_NHASIAN10", "PCT_NHBLACK10", "PCT_NHPI10",
              "PCT_HISP10", "PCT_65OLDER10", "PCT_18YOUNGER10","PCT_NHWHITE10", "CHILDPOVRATE15",
              "MEDHHINC15", "METRO13", "PERCHLDPOV10", "PERPOV10", "POVRATE15")

ses_data <- ses_data[,ses_vars]

colnames(ses_data)[4] <- "american_indian_alaska_native_2010_percent"
colnames(ses_data)[5] <- "asian_2010_percent"
colnames(ses_data)[6] <- "black_2010_percent"
colnames(ses_data)[7] <- "hawaiian_pacific_islander_2010_percent"
colnames(ses_data)[8] <- "hispanic_2010_percent"
colnames(ses_data)[9] <- "population_65_years_or_older_2010_percent"
colnames(ses_data)[10] <- "population_under_age_18_2010_percent"
colnames(ses_data)[11] <- "white_2010_percent"
colnames(ses_data)[12] <- "child_poverty_2015_percent"
colnames(ses_data)[13] <- "median_household_income_2015"
colnames(ses_data)[14] <- "metro_nonmetro_counties_2010"
colnames(ses_data)[15] <- "persistent_child_poverty_counties_2010"
colnames(ses_data)[16] <- "persistent_poverty_counties_2010"
colnames(ses_data)[17] <- "poverty_2015_percent"


ses_data <- melt(ses_data, id.vars=c("FIPS", "State", "County"))
ses_data$FIPS <- paste("cs", ses_data$FIPS,sep = "")
colnames(ses_data)[1] <- "location_key"
colnames(ses_data)[4] <- "variable_name"
colnames(ses_data)[5] <- "measure_value"
ses_data$id <- seq.int(nrow(ses_data))

##category key
ses_data_pop <- ses_data %>%
  filter(grepl("percent$", variable_name)) %>%
  filter(!grepl("child", variable_name)) %>%
  filter(!grepl("poverty", variable_name))
ses_data_pop$category_key <- "44"

ses_data_ses <- ses_data[!(ses_data$id %in% ses_data_pop$id),]
ses_data_ses$category_key <- "46"

ses_data <- rbind(ses_data_pop, ses_data_ses)

##year key
ses_data_2010 <- ses_data %>%
  filter(grepl("2010", variable_name)) 
ses_data_2010$year_key <- "4"

ses_data_2015 <- ses_data %>%
  filter(grepl("2015", variable_name)) 
ses_data_2015$year_key <- "9"

ses_data <- rbind(ses_data_2010, ses_data_2015) 

##program attribute key
ses_data_income <- ses_data %>%
  filter(grepl("income", variable_name) | grepl("poverty", variable_name))
ses_data_income$program_attribute_key <- "68"

ses_data_demo <- ses_data[!(ses_data$id %in% ses_data_income$id),]
ses_data_demo$program_attribute_key <- "62"

ses_data <- rbind(ses_data_income, ses_data_demo)

###population key
ses_data_ai <- ses_data %>%
  filter(grepl("american_indian_alaska_native", variable_name))
ses_data_ai$population_segment_key <- "21"

ses_data_as <- ses_data %>%
  filter(grepl("asian", variable_name))
ses_data_as$population_segment_key <- "22"

ses_data_bl <- ses_data %>%
  filter(grepl("black", variable_name))
ses_data_bl$population_segment_key <- "23"

ses_data_hw <- ses_data %>%
  filter(grepl("hawaiian", variable_name))
ses_data_hw$population_segment_key <- "25"

ses_data_his <- ses_data %>%
  filter(grepl("hispanic", variable_name))
ses_data_his$population_segment_key <- "26"

ses_data_wh <- ses_data %>%
  filter(grepl("white", variable_name))
ses_data_wh$population_segment_key <- "30"

ses_data_65 <- ses_data %>%
  filter(grepl("65", variable_name))
ses_data_65$population_segment_key <- "28"

ses_data_ch <- ses_data %>%
  filter(grepl("child", variable_name) | grepl("18", variable_name))
ses_data_ch$population_segment_key <- "24"

ses_data_non_pop <- rbind(ses_data_ai, ses_data_as, ses_data_bl, ses_data_hw, ses_data_his, ses_data_wh,
                 ses_data_65, ses_data_ch)
ses_data_pop <- ses_data[!(ses_data$id %in% ses_data_non_pop$id),]
ses_data_pop$population_segment_key <- "29"

ses_data <- rbind(ses_data_non_pop, ses_data_pop)

###measure name key
ses_data_median <- ses_data %>%
  filter(variable_name == "median_household_income_2015")
ses_data_median$measure_name_key <- "120"

ses_data_metro <- ses_data %>%
  filter(variable_name == "metro_nonmetro_counties_2010") 
ses_data_metro$measure_name_key <- "121"

ses_data_pov_count <- ses_data %>%
  filter(variable_name == "persistent_child_poverty_counties_2010" | variable_name == "persistent_poverty_counties_2010") 
ses_data_pov_count$measure_name_key <- "126"

ses_data_pov_rate <- ses_data %>%
  filter(variable_name == "poverty_2015_percent" | variable_name == "child_poverty_2015_percent") 
ses_data_pov_rate$measure_name_key <- "127"

ses_data_ex <- rbind(ses_data_median, ses_data_metro, ses_data_pov_count, ses_data_pov_rate)
ses_data_ex_1 <- ses_data[!(ses_data$id %in% ses_data_ex$id),]
ses_data_ex_1$measure_name_key <- "124"

ses_data <- rbind(ses_data_ex, ses_data_ex_1)

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(ses_data, "ses_data_clean.csv", row.names = FALSE)


###combining all cleaned tabs
clean_access <- read.csv("access_data_clean.csv")
clean_access <- clean_access[order(clean_access$id),]
clean_access$measure_value <- as.numeric(as.character(clean_access$measure_value))

clean_assistance <- read.csv("assistance_data_clean.csv")
clean_assistance <- clean_assistance[order(clean_assistance$id),]

clean_health <- read.csv("health_data_clean.csv")
clean_health <- clean_health[order(clean_health$id),]

clean_insecurity <- read.csv("insecurity_data_clean.csv")
clean_insecurity <- clean_access[order(clean_insecurity$id),]

clean_local <- read.csv("local_data_clean.csv")
clean_local <- clean_access[order(clean_local$id),]

clean_rest <- read.csv("restaurant_data_clean.csv")
clean_rest <- clean_rest[order(clean_rest$id),]

clean_ses <- read.csv("ses_data_clean.csv")
clean_ses <- clean_ses[order(clean_ses$id),]

clean_store <- read.csv("store_data_clean.csv")
clean_store <- clean_store[order(clean_store$id),]

final_data <- rbind(clean_access, clean_assistance, clean_health,
                    clean_insecurity, clean_local, clean_rest,
                    clean_ses, clean_store)
write.csv(final_data, "final_data_full.csv", row.names = FALSE)

final_data <- final_data[,-c(2,3,6)]
write.csv(final_data, "final_data_sql.csv", row.names = FALSE)



###supplemental table-county
setwd("~/Desktop/Summer 2019/Data Engineering/final project")

county_data <- read.xlsx("FullData.xlsx", sheet = 3)

colnames(county_data)[4] <- "2010_census_population"
colnames(county_data)[5] <- "2011_population_estimate"
colnames(county_data)[6] <- "2012_population_estimate"
colnames(county_data)[7] <- "2013_population_estimate"
colnames(county_data)[8] <- "2014_population_estimate"
colnames(county_data)[9] <- "2015_population_estimate"
colnames(county_data)[10] <- "2016_population_estimate"

county_data <- melt(county_data, id.vars=c("FIPS", "State", "County"))
county_data$FIPS <- paste("cs", county_data$FIPS,sep = "")
colnames(county_data)[1] <- "location_key"
colnames(county_data)[4] <- "variable_name"
colnames(county_data)[5] <- "measure_value"
county_data$id <- seq.int(nrow(county_data))

##category key
county_data$category_key <- "44"

##year key
county_data_2010 <- county_data %>%
  filter(grepl("2010", variable_name)) 
county_data_2010$year_key <- "4"

county_data_2011 <- county_data %>%
  filter(grepl("2011", variable_name)) 
county_data_2011$year_key <- "5"

county_data_2012 <- county_data %>%
  filter(grepl("2012", variable_name)) 
county_data_2012$year_key <- "6"

county_data_2013 <- county_data %>%
  filter(grepl("2013", variable_name)) 
county_data_2013$year_key <- "7"

county_data_2014 <- county_data %>%
  filter(grepl("2014", variable_name)) 
county_data_2014$year_key <- "8"

county_data_2015 <- county_data %>%
  filter(grepl("2015", variable_name)) 
county_data_2015$year_key <- "9"

county_data_2016 <- county_data %>%
  filter(grepl("2016", variable_name)) 
county_data_2016$year_key <- "10"

county_data <- rbind(county_data_2010, county_data_2011, county_data_2012, county_data_2013,
                     county_data_2014, county_data_2015, county_data_2016) 

##program attribute key
county_data$program_attribute_key <- "62"

###population key
county_data$population_segment_key <- "29"

###measure name key
county_data$measure_name_key <- "104"

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(county_data, "county_data_clean.csv", row.names = FALSE)


###supplemental table state
setwd("~/Desktop/Summer 2019/Data Engineering/final project")

state_data <- read.xlsx("FullData.xlsx", sheet = 4)

state_data <- melt(state_data, id.vars=c("StateFIPS", "State"))
colnames(state_data)[3] <- "variable_name"
colnames(state_data)[4] <- "measure_value"
state_data$id <- seq.int(nrow(state_data))
state_data$variable_name <- gsub('\\.', '_', state_data$variable_name)
state_data$variable_name <- (gsub("\\,", "", state_data$variable_name))
state_data$variable_name <- tolower(state_data$variable_name)

##category key
state_data_pop <- state_data %>%
  filter(grepl("^state", variable_name))
state_data_pop$category_key <- "44"

state_data_non_pop <- state_data[!(state_data$id %in% state_data_pop$id),]
state_data_non_pop$category_key <- "41"

state_data <- rbind(state_data_pop, state_data_non_pop)


##year key
state_data_2009 <- state_data %>%
  filter(grepl("2009", variable_name)) 
state_data_2009$year_key <- "3"

state_data_2010 <- state_data %>%
  filter(grepl("2010", variable_name)) 
state_data_2010$year_key <- "4"

state_data_2011 <- state_data %>%
  filter(grepl("2011", variable_name)) 
state_data_2011$year_key <- "5"

state_data_2012 <- state_data %>%
  filter(grepl("2012", variable_name)) 
state_data_2012$year_key <- "6"

state_data_2013 <- state_data %>%
  filter(grepl("2013", variable_name)) 
state_data_2013$year_key <- "7"

state_data_2014 <- state_data %>%
  filter(grepl("2014", variable_name)) 
state_data_2014$year_key <- "8"

state_data_2015 <- state_data %>%
  filter(grepl("2015", variable_name)) 
state_data_2015$year_key <- "9"

state_data_2016 <- state_data %>%
  filter(grepl("2016", variable_name)) 
state_data_2016$year_key <- "10"

state_data <- rbind(state_data_2009, state_data_2010, state_data_2011, state_data_2012, state_data_2013,
                    state_data_2014, state_data_2015, state_data_2016) 

state_data <- state_data %>%
  drop_na(StateFIPS)

##program attribute key
state_data_child <- state_data %>%
  filter(grepl("child", variable_name))
state_data_child$program_attribute_key <- "60"

state_data_lunch <- state_data %>%
  filter(grepl("lunch", variable_name))
state_data_lunch$program_attribute_key <- "69"

state_data_break <- state_data %>%
  filter(grepl("breakfast", variable_name))
state_data_break$program_attribute_key <- "71"

state_data_pop <- state_data %>%
  filter(grepl("population", variable_name))
state_data_pop$program_attribute_key <- "62"

state_data_sum <- state_data %>%
  filter(grepl("summer", variable_name))
state_data_sum$program_attribute_key <- "76"

state_data_wic <- state_data %>%
  filter(grepl("wic", variable_name))
state_data_wic$program_attribute_key <- "78"

state_data <- rbind(state_data_child, state_data_lunch, state_data_break,
                    state_data_pop, state_data_sum, state_data_wic )


###population key
state_data$population_segment_key <- "29"

###measure name key
state_data_pop_count <- state_data %>%
  filter(grepl("population", variable_name))
state_data_pop_count$measure_name_key <- "104"

state_data_non_count <- state_data[!(state_data$id %in% state_data_pop_count$id),]
state_data_non_count$measure_name_key <- "132"

state_data <- rbind(state_data_non_count, state_data_pop_count)

setwd("~/Desktop/Summer 2019/Data Engineering/final project/nutrition_access_table")
write.csv(state_data, "state_data_clean.csv", row.names = FALSE)


##combining sup data
clean_county <- read.csv("county_data_clean.csv")
clean_county <- clean_county[order(clean_county$id),]
clean_county <- clean_county[,-c(2,3,6)]

write.csv(clean_county, "clean_county_sql.csv", row.names = FALSE)

clean_state <- read.csv("state_data_clean.csv")
clean_state <- clean_state[order(clean_state$id),]
clean_state <- clean_state[,-c(2,5)]

write.csv(clean_state, "clean_state_sql.csv", row.names = FALSE)
