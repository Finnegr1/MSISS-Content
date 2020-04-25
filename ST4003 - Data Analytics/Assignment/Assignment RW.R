## ST4003 - Data Analytics: Assignment
## Ross Finnegan, 15320532 31/10/2018

#packages required
install.packages("janitor")

library(readxl)
library(janitor)
library(dplyr)
library(naniar)
library(visdat)
library(ggplot2)
#Set working directory - please change as required
setwd("C:/Users/Ross/Documents/MSISS/Fourth Year/ST4003 - Data Analytics/Assignment")

## PRELIMINARY ANALYSIS
#Reading in the datasets
file_one <- "churn .xlsx"
file_two <- "Kingscounty house data.xlsx"

#Dataset One: Binary Outcome - Churn Yes/No
#Dataset Two: Continous Outcome - Price
dataset_one <- read_excel(file_one)
dataset_two <- read_excel(file_two)

#read_excel doesn't convert strings as factors - manually convert applicable columns
d_one_types <- sapply(dataset_one, class)
#columns required to be factors (categorical data)
cols_one <- c(2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,21)
dataset_one[cols_one] <- lapply(dataset_one[cols_one], factor)

cols_two <- c(4,5,8,9,10,11,12,15,16,17)
dataset_two[cols_two] <- lapply(dataset_two[cols_two], factor)

#Checking for duplicates - tabled results show no dupes in either dataset
chdup <- duplicated(dataset_one)
table(chdup)
chdup_two <- duplicated(dataset_two)
table(chdup_two)

#cleaning data
dataset_one <- clean_names(dataset_one)
dataset_two <- clean_names(dataset_two)

#Dpylr stuff

d_one <- tbl_df(dataset_one)
df <- filter(d_one, gender == "Male")
df <- filter(d_one, monthly_charges %in% c(70, 90))

Fib_or_DSL <- filter(d_one, internet_service %in% c("DSL", "Fiber optic"))

indiv <- select(d_one, payment_method)   
range <- select(d_one, payment_method:monthly_charges)
charg <- select(d_one, ends_with("Charges"))

sortd <- arrange(d_one, desc(monthly_charges))
sortd
comparison <- mutate(d_one, direct_charges = monthly_charges*tenure, differnce = total_charges - direct_charges)

View(d_one)

by_service <- group_by(d_one, internet_service)
summarise(by_service, total = sum(total_charges, na.rm = TRUE))
?select
select(d_one, internet_service, total_charges)

sum
library(visdat)
visdat::vis_dat(d_one)


summarise(filter(by_service, !is.na(monthly_charges)),
          med = median(monthly_charges),
          mean = mean(monthly_charges),
          max = max(monthly_charges),
          q90 = quantile(monthly_charges, 0.85))

?qplot
