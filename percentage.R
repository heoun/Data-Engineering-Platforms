library(tidyr)
library(dplyr)
library(magrittr)
library(reshape2)
options(scipen=999)

setwd("~/Desktop/Summer 2019/Data Engineering/final project")
county_data <- read.xlsx("FullData.xlsx", sheet = 3)
colnames(county_data)[4] <- "2010_census_population"
colnames(county_data)[5] <- "2011_population_estimate"
colnames(county_data)[6] <- "2012_population_estimate"
colnames(county_data)[7] <- "2013_population_estimate"
colnames(county_data)[8] <- "2014_population_estimate"
colnames(county_data)[9] <- "2015_population_estimate"
colnames(county_data)[10] <- "2016_population_estimate"
county_data_ex <- county_data[,c(1,4:10)]


county_data_ex$`2010_census_population` <- gsub('\\,', '', county_data_ex$`2010_census_population`)
county_data_ex$`2010_census_population` <- as.numeric(county_data_ex$`2010_census_population`)

county_data_ex$`2011_population_estimate`<- gsub('\\,', '', county_data_ex$`2011_population_estimate`)
county_data_ex$`2011_population_estimate` <- as.numeric(county_data_ex$`2011_population_estimate`)

county_data_ex$`2012_population_estimate`<- gsub('\\,', '', county_data_ex$`2012_population_estimate`)
county_data_ex$`2012_population_estimate` <- as.numeric(county_data_ex$`2012_population_estimate`)

county_data_ex$`2013_population_estimate`<- gsub('\\,', '', county_data_ex$`2013_population_estimate`)
county_data_ex$`2013_population_estimate` <- as.numeric(county_data_ex$`2013_population_estimate`)

county_data_ex$`2014_population_estimate`<- gsub('\\,', '', county_data_ex$`2014_population_estimate`)
county_data_ex$`2014_population_estimate` <- as.numeric(county_data_ex$`2014_population_estimate`)

county_data_ex$`2015_population_estimate`<- gsub('\\,', '', county_data_ex$`2015_population_estimate`)
county_data_ex$`2015_population_estimate` <- as.numeric(county_data_ex$`2015_population_estimate`)

county_data_ex$`2016_population_estimate`<- gsub('\\,', '', county_data_ex$`2016_population_estimate`)
county_data_ex$`2016_population_estimate` <- as.numeric(county_data_ex$`2016_population_estimate`)



###state
state_data <- read.xlsx("FullData.xlsx", sheet = 4)
state_data <- melt(state_data, id.vars=c("StateFIPS", "State", "state_ab"))
colnames(state_data)[4] <- "variable_name"
colnames(state_data)[5] <- "measure_value"
state_data$variable_name <- gsub('\\.', '_', state_data$variable_name)
state_data$variable_name <- (gsub("\\,", "", state_data$variable_name))
state_data$variable_name <- tolower(state_data$variable_name)

state_data <- dcast(state_data, StateFIPS + State + state_ab ~ variable_name, value.var="measure_value")
state_data_ex <- state_data[,c(1,3:41)]
state_data_ex <- state_data_ex %>%
  drop_na(state_ab)


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

health_data <- merge(health_data, county_data_ex, by = "FIPS", all.x = TRUE)

health_data$adult_diabetes_2013 <- (health_data$adult_diabetes_2013_percent/100) * health_data$`2013_population_estimate`
health_data$adult_diabetes_2013 <- format(round(health_data$adult_diabetes_2013, 0), nsmall = 0)

health_data$adult_obesity_2013 <- (health_data$adult_obesity_2013_percent/100) * health_data$`2013_population_estimate`
health_data$adult_obesity_2013 <- format(round(health_data$adult_obesity_2013, 0), nsmall = 0)

health_data$FIPS <- paste("cs", health_data$FIPS,sep = "")
health_data <- health_data[,c(1,19,20)]
health_data <- melt(health_data, id.vars=c("FIPS"))
colnames(health_data)[1] <- "location_key"
colnames(health_data)[2] <- "variable_name"
colnames(health_data)[3] <- "measure_value"

## key
health_data$category_key <- "43"
health_data$year_key <- "7"
health_data$program_attribute_key <- "67"
health_data$population_segment_key <- "29"
health_data$measure_name_key <- "104"



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

ses_data <- merge(ses_data, county_data_ex, by = "FIPS", all.x = TRUE)

ses_data$american_indian_alaska_native_2010 <- (ses_data$american_indian_alaska_native_2010_percent/100) * ses_data$`2010_census_population`
ses_data$asian_2010 <- (ses_data$asian_2010_percent/100) * ses_data$`2010_census_population`
ses_data$black_2010 <- (ses_data$black_2010_percent/100) * ses_data$`2010_census_population`
ses_data$hawaiian_pacific_islander_2010 <- (ses_data$hawaiian_pacific_islander_2010_percent/100) * ses_data$`2010_census_population`
ses_data$hispanic_2010 <- (ses_data$hispanic_2010_percent/100) * ses_data$`2010_census_population`
ses_data$population_65_years_or_older_2010 <- (ses_data$population_65_years_or_older_2010_percent/100) * ses_data$`2010_census_population`
ses_data$population_under_age_18_2010 <- (ses_data$population_under_age_18_2010_percent/100) * ses_data$`2010_census_population`
ses_data$white_2010 <- (ses_data$white_2010_percent/100) * ses_data$`2010_census_population`
ses_data$poverty_2015 <- (ses_data$poverty_2015_percent/100) * ses_data$`2015_population_estimate`
ses_data$poverty_2015 <- format(round(ses_data$poverty_2015, 0), nsmall = 0)

ses_data$FIPS <- paste("cs", ses_data$FIPS,sep = "")
ses_data <- ses_data[,c(1,25:33)]
ses_data <- melt(ses_data, id.vars=c("FIPS"))
colnames(ses_data)[1] <- "location_key"
colnames(ses_data)[2] <- "variable_name"
colnames(ses_data)[3] <- "measure_value"
ses_data$id <- seq.int(nrow(ses_data))

##cat key
ses_data_pop <- ses_data %>%
  filter(!grepl("poverty", variable_name))
ses_data_pop$category_key <- "44"

ses_data_pov <- ses_data %>%
  filter(grepl("poverty", variable_name))
ses_data_pov$category_key <- "46"

ses_data <- rbind(ses_data_pop, ses_data_pov)

#year key
ses_data_2010 <- ses_data %>%
  filter(grepl("2010", variable_name)) 
ses_data_2010$year_key <- "4"

ses_data_2015 <- ses_data %>%
  filter(grepl("2015", variable_name)) 
ses_data_2015$year_key <- "9"

ses_data <- rbind(ses_data_2010, ses_data_2015) 


##program attribute key
ses_data_income <- ses_data %>%
  filter(grepl("poverty", variable_name))
ses_data_income$program_attribute_key <- "68"

ses_data_income_non <- ses_data %>%
  filter(!grepl("poverty", variable_name))
ses_data_income_non$program_attribute_key <- "62"

ses_data <- rbind(ses_data_income, ses_data_income_non)


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

ses_data_non_pop <- rbind(ses_data_ai, ses_data_as, ses_data_bl, ses_data_hw, ses_data_his, ses_data_wh,
                          ses_data_65)
ses_data_pop <- ses_data[!(ses_data$id %in% ses_data_non_pop$id),]
ses_data_pop$population_segment_key <- "29"

ses_data <- rbind(ses_data_non_pop, ses_data_pop)

##measure name key
ses_data$measure_name_key <- "104"
ses_data <- subset(ses_data, select = -id)


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

assistance_data <- assistance_data[,c(1:3,10,11,36,37,45,46,26,27,23,24,28,29,30,31,33,34,7,8,42,43,4,5,39,40,15,16,13,14)]
assistance_data <- merge(assistance_data, county_data_ex, by = "FIPS", all.x = TRUE)

assistance_data$snap_participants_2012 <- (assistance_data$snap_participants_2012_percent/100) * assistance_data$`2012_population_estimate`
assistance_data$snap_participants_2012 <- format(round(assistance_data$snap_participants_2012, 0), nsmall = 0)

assistance_data$snap_participants_2016 <- (assistance_data$snap_participants_2016_percent/100) * assistance_data$`2016_population_estimate`
assistance_data$snap_participants_2016 <- format(round(assistance_data$snap_participants_2016, 0), nsmall = 0)

assistance_data$snap_participants_eligible_2014 <- (assistance_data$snap_participants_eligible_2014_percent/100) * assistance_data$`2014_population_estimate`
assistance_data$snap_participants_eligible_2014 <- format(round(assistance_data$snap_participants_eligible_2014, 0), nsmall = 0)

assistance_data$wic_participants_2015 <- (assistance_data$wic_participants_2015_percent/100) * assistance_data$`2015_population_estimate`
assistance_data$wic_participants_2015 <- format(round(assistance_data$wic_participants_2015, 0), nsmall = 0)

assistance_data$FIPS <- paste("cs", assistance_data$FIPS,sep = "")
assistance_data <- assistance_data[,c(1,39:42)]
assistance_data <- melt(assistance_data, id.vars=c("FIPS"))
colnames(assistance_data)[1] <- "location_key"
colnames(assistance_data)[2] <- "variable_name"
colnames(assistance_data)[3] <- "measure_value"
assistance_data$id <- seq.int(nrow(assistance_data))

#cat key
assistance_data$category_key <- "41"

##year key
assistance_data_2012 <- assistance_data %>%
  filter(grepl("2012", variable_name))
assistance_data_2012$year_key <- "6"

assistance_data_2016 <- assistance_data %>%
  filter(grepl("2016", variable_name))
assistance_data_2016$year_key <- "10"

assistance_data_2015 <- assistance_data %>%
  filter(grepl("2015", variable_name))
assistance_data_2015$year_key <- "9"

assistance_data_2014 <- assistance_data %>%
  filter(grepl("2014", variable_name))
assistance_data_2014$year_key <- "8"

assistance_data <- rbind(assistance_data_2014, assistance_data_2012, 
                              assistance_data_2015, assistance_data_2016)


##program attribute key

assistance_data_snap <- assistance_data %>%
  filter(grepl("snap", variable_name))
assistance_data_snap$program_attribute_key <- "73"

assistance_data_wic <- assistance_data %>%
  filter(grepl("wic", variable_name))
assistance_data_wic$program_attribute_key <- "78"

assistance_data <- rbind(assistance_data_snap, assistance_data_wic)

###population key
assistance_data$population_segment_key <- "29"

##measure name key
assistance_data$measure_name_key <- "104"

assistance_data <- subset(assistance_data, select = -id)

final <- rbind(health_data, ses_data, assistance_data)

write.csv(final, "data_percent_count_convert.csv", row.names = FALSE)
