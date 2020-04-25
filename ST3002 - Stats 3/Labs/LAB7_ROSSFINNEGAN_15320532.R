##Part 1 
setwd("U:/ST3002")

#Read in the raw data set
data1 = read.table("breast_cancer.dat", sep = ",", header = T, stringsAsFactors = F)
#Use which function to locate the data that contains a ?
positions = which(data1 == "?",arr.ind = TRUE )

#Trim positions to get just row values
rows_only = positions[,1]
#This will remove the rows with errors from the data
cleaned = data1[-rows_only,]

#Removed id number to apply predictive model
prepared_data = cleaned[,-1]

#Recoding Class (diagnosis) to make it readable for GLM
prepared_data$class_tumor[prepared_data$class_tumor == 2]  <- 0
prepared_data$class_tumor[prepared_data$class_tumor == 4]  <- 1

#Setting bare nuclei column to numeric values to avoid incorrect factors being introduced
prepared_data$bare_nuclei = as.numeric(prepared_data$bare_nuclei)

#Applying glm to establish which vars may be useful for diagnosis
fit <- glm(class_tumor ~ ., data = prepared_data, family = binomial)
#Summary of fit
summary(fit)

##Removing variables that are not statistically significant at a 95% confidence level
#unif_cell_size, unif_cell_shape, epithelial_size, mitoses
removals <- c(2,3,5,9)
remodeled <- prepared_data[,-removals]

#Applying glm to establish which vars are now useful for diagnosis
fit2 <- glm(class_tumor ~ ., data = remodeled, family = binomial)
#Summary of fit
summary(fit2)
#All remaining variables are now statistically significant at all levels
#Predict function allows me to interpret which observations are likely to be malignant
predict.glm(fit2, newdata = remodeled, type = "response")
