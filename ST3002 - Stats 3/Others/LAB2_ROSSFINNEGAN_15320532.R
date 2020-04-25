##Part 1
setwd("U:/ST3002")

#Read in the text file
EU = read.table("EU_20182501.txt", sep = ",", header = T)

#admin level has a full stop, I edit that out
levels(EU$job)[1] = "admin";

#Creating subset as required by manager
EUnew = subset(EU, 30<= EU$age & EU$age<= 40)
#Writing to csv file
write.csv(EUnew, file = "EU_cust_30_40.csv", row.names = F)

#Creating 2nd subset
EUtwo = subset(EU, (EU$education == "tertiary") & (EU$job=="blue-collar" | EU$job == "management"))
#Writing 2nd csv file
write.csv(EUtwo, file = "EU_cust_ter_bc_mgmt.csv", row.names = F)


##Part 2
#creating vector containing all occupation types
lvls = levels(EU$job)
#looping through each occupation type, generating the correct file path and subset, writing to a occupation specific csv
for(i in 1:length(lvls)){
  ext1 = "Eu_cust_occupation_"
  ext3 = ".csv"
  ext2 = lvls[i]
  filepath = paste(ext1, ext2, ext3, sep = "")
  newSet = subset(EU, EU$job == lvls[i])
  write.csv(newSet, file = filepath, row.names= F)
}


##Part 3
#Read in the US dataset with semi colon delimiter
US = read.table("US_2018_01_26.txt", sep = ";", header = T)

#admin level incorrect again; edit below
levels(US$job)[1] = "admin"

#Making copies that can be modified for merge
USmerge = US
EUmerge = EU

#To account for discrepencies in telephone variables, EU mobile/landline variable replaced by teleph
levels(EUmerge$contact)[1] = "teleph"
levels(EUmerge$contact)[2] = "teleph"

#US data lists balance in dollars, Converting 1 Dollar = 0.83 Euro
USmerge$balance = (USmerge$balance*0.83)

#US data does not record poutcome, therefore cannot be kept for the merge, removing column
EUmerge = EUmerge[,-16]

#Introduce a indicator variable for where the customer originates
#region: binary:("EU", "US")
#create the column to be inserted into each dataset
EUindic = rep("EU", length(EUmerge$age))
USindic = rep("US", length(USmerge$age))

#insert indicator vectors into existing data frames
EUmerge["indicator"] = EUindic
USmerge["indicator"] = USindic

#merge two completed data frames
mergedDF = rbind(EUmerge, USmerge)
write.csv(mergedDF, file = "EU_US_Merge.csv", row.names = F)



