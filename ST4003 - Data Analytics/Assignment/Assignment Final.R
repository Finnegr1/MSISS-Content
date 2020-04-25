## ST4003 - Data Analytics: Assignment
## Ross Finnegan, 15320532 31/10/2018

##############
#Library - Need to arrange alphabetically
#################
install.packages("VIM")
install.packages("janitor")
install.packages("rbokeh")
install.packages("ggplot2")
install.packages("rpart.utils")
install.packages("caret")
install.packages(("prp"))
install.packages("rattle")
install.packages("ROCR")
install.packages("pROC")
install.packages("gplots")
install.packages("gridExtra")
install.packages("caTools")
install.packages("naniar")
install.packages(c("maps", "mapdata"))
install.packages("DMwR")
install.packages("randomForest")


library(readxl)
library(rbokeh)
library(randomForest)
library(caTools)
library(RColorBrewer)
library(pROC)
library(gridExtra)
library(VIM)
library(janitor)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ROCR)
library(caret)
library(visdat)
library(rattle)
library(rpart)
library(maps)
library(mapdata)
library(DMwR)

#Set working directory - please change as required
setwd("C:/Users/Ross/Documents/MSISS/Fourth Year/ST4003 - Data Analytics/Assignment")
###############
## PRELIMINARY ANALYSIS
################

#Reading in the datasets
file_one <- "churn .xlsx"
file_two <- "Kingscounty house data.xlsx"

#churn_dataset: Binary Outcome - Churn Yes/No
#house_price: Continous Outcome - Price
churn_dataset <- read_excel(file_one)
house_price_dataset <- read_excel(file_two)

#Types of Attributes - lots of character types. Redefine as factors
#Remove customer id
sapply(churn_dataset, class)
factor_cols <- c(2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,21)
churn_dataset[factor_cols] <- lapply(churn_dataset[factor_cols], factor)
#Remove unique ID
churn_dataset <- churn_dataset[,-1]


sapply(house_price_dataset, class)
#Zipcode shortened as every code has the same first two digits. This will make for easier analysis
house_price_dataset$zipcode <- house_price_dataset$zipcode%%1000
factor_cols <- c(4,5,8,9,10,11,12,15,17)
house_price_dataset[factor_cols] <- lapply(house_price_dataset[factor_cols], factor)
house_price_dataset$date <- as.Date(house_price_dataset$date, "%Y%m%dT000000" )

# Check for Duplicates - None & Clean data names
table(duplicated(churn_dataset))
table(duplicated(house_price_dataset))
churn_dataset <- clean_names(churn_dataset)
house_price_dataset <- clean_names(house_price_dataset)

#Missing data
#Summary gives general overview
summary(churn_dataset)
summary(house_price_dataset)

#Aggr calculates the amount of missing/imputed values - only 11 missing values in churn$total charges
vis_dat(churn_dataset)
vis_miss(churn_dataset)


vis_dat(house_price_dataset)
summary(aggr(churn_dataset))
summary(aggr(house_price_dataset))

missing_data <- churn_dataset[!complete.cases(churn_dataset),]
summary(missing_data$tenure)
#Set total charges to 0
churn_dataset$total_charges[is.na(churn_dataset$total_charges)] <-0



#Cleaned data :)

#Near Zero variance vars
ch = nearZeroVar(churn_dataset, saveMetric= TRUE)
hp =nearZeroVar(house_price_dataset, saveMetric= TRUE)

##############
#Derived Variables
###################

#Churn
#tenure group
churn_dataset = churn_dataset %>% mutate(tenure_group = cut(tenure, breaks = c(-1,13,25,37,49,61, Inf), labels = c("< 1 yr", "1-2 yrs", "2-3 yrs", "3-4 yrs", "4-5 yrs", "5+ yrs")))
#both phone and internet service
churn_dataset = churn_dataset %>% mutate(phone_and_internet_serv = (phone_service == "Yes" & internet_service != "No"))

#House Prices
#sqft difference
house_price_dataset = house_price_dataset %>% mutate(sqft_living_percent_diff = ((sqft_living - sqft_living15)/sqft_living15)*100, sqft_lot_percent_diff = ((sqft_lot - sqft_lot15)/sqft_lot15)*100)
#renovation type
house_price_dataset = house_price_dataset %>% mutate(renovation_type = cut(yr_renovated, breaks = c(-Inf,0,1999,2009,2013,Inf), labels = c("None","1900s", "2000s", "2010-2014","Last Two Years")))
#grade class
house_price_dataset = house_price_dataset %>% mutate(grade_class = cut(as.numeric(grade), breaks = c(-Inf,2,9,Inf), labels = c("Low", "Average", "High")))

############################
#Summary Statistics
###########################
#Churn
##############################

#1 - Tenure Group

summary(churn_dataset$tenure_group)

tg1 <- ggplot(churn_dataset, aes(x = `tenure_group`)) +
  xlab("Tenure Group") +
  geom_bar(fill = "#87CEEB") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Proportions bar charts
tg2 <- ggplot(churn_dataset, aes(x = `tenure_group` )) +
  geom_bar(fill = "#6495ED", aes(y = (..count..)/sum(..count..))) +
  xlab("Tenure Group") +
  scale_y_continuous(labels = scales::percent, name = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
grid.arrange(tg1, tg2, nrow = 1)


ggplot(churn_dataset, aes(tenure_group, ..count..)) +
  geom_bar(aes(fill = churn), position = "dodge") +
  xlab("Tenure Group") + ylab("Count")

#2 - Monthly charges
summary(churn_dataset$monthly_charges)

mc1 <- ggplot(churn_dataset, aes(x = churn, y = monthly_charges, fill= churn)) +
  geom_boxplot()+
  xlab("Churn") + ylab("Monthly Charge")+
  scale_fill_brewer(palette="BuPu")
mc1
#3 - Contract
c1 <- ggplot(churn_dataset, aes(x = `contract`)) +
  xlab("Contract") +
  geom_bar(fill = "#87CEEB") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
c1

ggplot(churn_dataset, aes(contract, ..count..)) +
  geom_bar(aes(fill = churn), position = "dodge") +
  xlab("Contract Type") + ylab("Count")
#############
#Kings
##############
#Location
minihouse <- house_price_dataset %>% select(lat, long, price)

# creates a color gradient of length 5
colours <- brewer.pal(5, "YlOrRd")
# computes quantiles to later break up the data set based on price
breaks <- quantile(minihouse$price, probs = seq(0, 1, 0.2))

cat1 <- minihouse %>% filter(price >= breaks[1] & price <= breaks[2])
cat2 <- minihouse %>% filter(price > breaks[2] & price <= breaks[3])
cat3 <- minihouse %>% filter(price > breaks[3] & price <= breaks[4])
cat4 <- minihouse %>% filter(price > breaks[4] & price <= breaks[5])
cat5 <- minihouse %>% filter(price > breaks[5] & price <= breaks[6])
cat1$color <- colours[1]
cat2$color <- colours[2]
cat3$color <- colours[3]
cat4$color <- colours[4]
cat5$color <- colours[5]

minihouse <- rbind(cat1, cat2, cat3, cat4, cat5)
minihouse %>% head

grayscale = '[{"featureType":"landscape","stylers":[{"saturation":-100},{"lightness":65},
{"visibility":"on"}]},{"featureType":"poi","stylers":[{"saturation":-100},{"lightness":51},
{"visibility":"simplified"}]},{"featureType":"road.highway","stylers":[{"saturation":-100},
{"visibility":"simplified"}]},{"featureType":"road.arterial","stylers":[{"saturation":-100},
{"lightness":30},{"visibility":"on"}]},{"featureType":"road.local","stylers":[{"saturation":-100},
{"lightness":40},{"visibility":"on"}]},{"featureType":"transit","stylers":[{"saturation":-100},
{"visibility":"simplified"}]},{"featureType":"administrative.province","stylers":
[{"visibility":"off"}]},{"featureType":"water","elementType":"labels","stylers":
[{"visibility":"on"},{"lightness":-25},{"saturation":-20}]},
{"featureType":"water","elementType":"geometry","stylers":[{"hue":"#ffff00"},
{"lightness":-25},{"saturation":-97}]}]'

gmap(lat = 47.530096, lng = -122.162723, zoom = 10,
     width = 800, height = 1000, map_style = grayscale, title = "Kings County House Price Heatmap") %>%
  ly_points(long, lat, data = minihouse, 
            fill_alpha = 0.15, line_alpha = 0, col = color)

#Sqft_ft_living_difference

mc1 <- ggplot(house_price_dataset, aes(x = 0, y = sqft_living_percent_diff)) +
  geom_boxplot(fill = "#6495ED")+
  xlab("") + ylab("% Living Space Difference")+
  scale_fill_brewer(palette="BuPu") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

plot(house_price_dataset$sqft_living_percent_diff)

ggplot(house_price_dataset,aes(x = price/1000, sqft_living_percent_diff )) +
  geom_point(alpha = 0.3) + stat_binhex() +
  xlab ("Price (000s)") + ylab ("Sq Foot Living % Difference") +
  geom_hline(yintercept=0, linetype="dashed", color = "red")

#Yr_built
house_price_dataset$real_year = as.numeric(as.character(house_price_dataset$yr_built))
ggplot(house_price_dataset, aes(x = real_year)) +
  xlab("Year Built") + ylab("Count") +
  geom_bar(fill = "#6495ED") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

mc1 <- ggplot(house_price_dataset, aes(x = factor(yr_built), y = price/1000, fill = "#6495ED")) +
  geom_boxplot()+
  scale_x_discrete(breaks = c(seq(from = 1900, to = 2010, by = 10))) +
  xlab("Yr Built") + ylab("Price (000s)") 
mc1


##############
#Trees
########################
##########
#Churn
##########
table(churn_dataset$churn)

#Split into test & training
set.seed(123)
churn_dataset$spl = sample.split(churn_dataset$churn, SplitRatio = 0.75)
churn_dataset_train <- subset(churn_dataset, spl == "TRUE")
nrow(churn_dataset_train)
ncol(churn_dataset_train)

churn_dataset_test <- subset(churn_dataset, spl == "FALSE")
#Removing the boolean set for sampling
churn_dataset_train <- churn_dataset_train[,-23]
churn_dataset_test <- churn_dataset_test[,-23]



# CP default to build shallow tree
fit1 <- rpart(churn_dataset_train$churn ~., method = "class", data = churn_dataset_train,
              parms = list(split="Gini"))
rpart.plot::rpart.plot(fit1,shadow.col="azure1",cex=0.6, type = 4, tweak = 1.1)


info_fit <-rpart(churn_dataset_train$churn ~., method = "class", data = churn_dataset_train,
                 parms = list(split="Information"))
rpart.plot::rpart.plot(info_fit,shadow.col="azure 1",cex=0.6, type = 4, tweak = 1.1)

#Purposely overwriting cp to have a big tree.
fit2 <- rpart(churn_dataset_train$churn ~., method = "class", data = churn_dataset_train,
              control = rpart.control(cp = 0.001), parms = list(split="Gini"))
rpart.plot::rpart.plot(fit2,shadow.col="azure1",cex=0.3, type = 4)
plotcp(fit2, col = "blue")

#cptable of fit 2 shows xerror starts to increase after xerror value of 0.7482168.
#The # of splits for this xerror is 10 so we will use cp = 0.0043 and rerun
fit3 <- prune(fit2,cp = 0.0043)
rpart.plot::rpart.plot(fit3,shadow.col="azure1",cex=0., type = 4)

printcp(fit3)
plotcp(fit3)

churn_predict1 <- predict(fit1, churn_dataset_test)
churn_predict2 <- predict(fit2, churn_dataset_test)
churn_predict3 <- predict(fit3, churn_dataset_test)


predics1 <- prediction(churn_predict1[,2], churn_dataset_test$churn)
predics2 <- prediction(churn_predict2[,2], churn_dataset_test$churn)
predics3 <- prediction(churn_predict3[,2], churn_dataset_test$churn)



auc1 <- performance(predics1,"auc")@y.values
auc2 <- performance(predics2,"auc")@y.values
auc3 <- performance(predics3,"auc")@y.values

auc1
auc2
auc3

fit1roc = performance(predics1,"tpr","fpr")
fit2roc = performance(predics2, "tpr", "fpr")
fit3roc = performance(predics3, "tpr", "fpr")

plot(fit1roc, col="blue", main = "ROC CURVE COMPARISON")
plot(fit2roc, col="red", add = T, lty =2)
plot(fit3roc, col = "green", add =T)
legend("bottomright",legend=c("Fit 1", "Fit 2", "Fit 3", "Lin Reg", "SMOTE Fit", "Random Forest"),
       col=c("blue", "red", "green", "yellow", "purple", "orange"), lty=1:2, cex=0.6)

linreg<-glm(churn~.,family=binomial,data=(churn_dataset_train))
lin_pred <- predict(linreg, churn_dataset_test)
lin_predics <- prediction(lin_pred, churn_dataset_test$churn)
perf_lin = performance(lin_predics, "tpr", "fpr")
plot(perf_lin, col="yellow", add = TRUE, lty = 2)
abline(a=0,b=1, col = "grey")

churn_dataset_test$churn_predicted <- predict(fit3, churn_dataset_test, type = 'class')
xlab <- table(actualclass = churn_dataset_test$churn, predictedclass = churn_dataset_test$churn_predicted)
cm <- confusionMatrix(xlab)

True_Value <- factor(c(0, 0, 1, 1))
Prediction <- factor(c(0, 1, 0, 1))
Y      <- c(cm$table[1], cm$table[2]
            , cm$table[3], cm$table[4])
df <- data.frame(True_Value, Prediction, Y)

ggplot(data =  df, mapping = aes(x = True_Value, y = Prediction)) +
  geom_tile(aes(fill = Y), colour = "white") +
  geom_text(aes(label = sprintf("%1.0f", Y)), vjust = 1) +
  scale_fill_gradient(low = "lightblue", high = "blue") +
  theme_bw() + theme(legend.position = "none")

#SMOTE
churn_dataset <- churn_dataset[,-23]
churn_dataset <- as.data.frame(churn_dataset)

new_churn <- SMOTE(churn ~., churn_dataset , perc.under = 200)

set.seed(123)
new_churn$spl = sample.split(new_churn$churn, SplitRatio = 0.75)
new_churn_train <- subset(new_churn, spl == "TRUE")

new_churn_test <- subset(new_churn, spl == "FALSE")
#Removing the boolean set for sampling
new_churn_train <- new_churn_train[,-23]
new_churn_test <- new_churn_test[,-23]


#Purposely overwriting cp to have a big tree. 
SMfit1 <- rpart(new_churn_train$churn ~., method = "class", data = new_churn_train,
                control = rpart.control(cp = 0.001), parms = list(split="Gini"))
summary(SMfit1)
SMfit1$cptable
#Xerror increases at 0.4297265, CP = 0.001426873, 56 nsplit
SMfit2 <- prune(SMfit1, cp =0.0024)
rpart.plot::rpart.plot(SMfit2,shadow.col="azure1",cex=0.3, type = 4)


new_churn_predict <- predict(SMfit2, new_churn_test)
new_churn_test$churn_predicted <- predict(SMfit2, new_churn_test, type = "class")
new_xlab <- table(actualclass = new_churn_test$churn, predictedclass = new_churn_test$churn_predicted)
cm2 <- confusionMatrix(new_xlab)

True_Value <- factor(c(0, 0, 1, 1))
Prediction <- factor(c(0, 1, 0, 1))
Y      <- c(cm2$table[1], cm2$table[2]
            , cm2$table[3], cm2$table[4])
df2 <- data.frame(True_Value, Prediction, Y)

ggplot(data =  df2, mapping = aes(x = True_Value, y = Prediction)) +
  geom_tile(aes(fill = Y), colour = "white") +
  geom_text(aes(label = sprintf("%1.0f", Y)), vjust = 1) +
  scale_fill_gradient(low = "lightblue", high = "blue") +
  theme_bw() + theme(legend.position = "none")


new_predics <- prediction(new_churn_predict[,2], new_churn_test$churn)

cm
cm2
SMroc <- performance(new_predics, "tpr","fpr")
plot(SMroc, col = "purple", add =T)

performance(new_predics, "auc")@y.values


############
#House Price
#############
house_price_dataset$price <- house_price_dataset$price/1000
set.seed(123)
house_price_dataset$spl <- sample.split(house_price_dataset$price, SplitRatio = 0)
house_price_train <- subset(house_price_dataset, spl == "TRUE")
house_price_test<-subset(house_price_dataset, spl == "FALSE")
house_price_train <- house_price_train[,-26]
house_price_test <- house_price_test[,-26]

fit1 <- rpart(house_price_train$price ~., method = "anova", data = house_price_train,
              control = rpart.control(cp = 0.05))

split.fun <- function(x, labs, digits, varlen, faclen)
{
  # replace commas with spaces (needed for strwrap)
  labs <- gsub(",", " ", labs)
  for(i in 1:length(labs)) {
    # split labs[i] into multiple lines
    labs[i] <- paste(strwrap(labs[i], width=25), collapse="\n")
  }
  labs
}
rpart.plot::prp(fit1, split.cex = 1, uniform = TRUE, split.fun=split.fun,
                type = 1, under = T,extra = 101, box.palette = c("pink", "palegreen"))
summary(fit1)

fit2 <- rpart(house_price_train$price ~., method = "anova", data = house_price_train,
              control = rpart.control(cp = 0.001))
fit2$cptable
plotcp(fit2)


#Xerror increasing at 0.2874504, CP = 0.004621982, nsplit = 13
fit3 <- prune(fit2,cp = 0.004621)
rpart.plot::prp(fit3, split.cex = 1, uniform = TRUE, split.fun=split.fun,
                type = 1, under = T,extra = 101, box.palette = c("pink", "palegreen"))

par(mfrow=c(1,1)) 
rsq.rpart(fit3)

price_pred3 <-predict(fit3, house_price_test, method = "anova")

cor(x = price_pred3, y = house_price_test$price)
RMSE(price_pred3, house_price_test$price)

fit4 <- prune(fit3,cp = 0.047)
rpart.plot::prp(fit4, split.cex = 1.6, uniform = TRUE, split.fun=split.fun,
                type = 1, under = T,extra = 101, box.palette = c("pink", "palegreen"))

price_pred4 <- predict(fit4, house_price_test, method = "anova")
cor(x = price_pred4, y = house_price_test$price)
RMSE(price_pred4, house_price_test$price)

residuals = (price_pred3 - house_price_test$price)
qplot(x = price_pred3, y = house_price_test$price)+ xlab("Predicted Price(000s)")+ 
  ylab("Actual Price (000s)") + geom_abline(col = "red",intercept = 0, slope = 1)


###########
#Random Forests
##############
######
#Churn
#####
#Split into test & training
set.seed(123)
new_churn$spl = sample.split(new_churn$churn, SplitRatio = 0.75)
new_churn_train <- subset(new_churn, spl == "TRUE")
nrow(new_churn_train)
ncol(new_churn_train)

new_churn_test <- subset(new_churn, spl == "FALSE")
#Removing the boolean set for sampling
new_churn_train <- new_churn_train[,-23]
new_churn_test <- new_churn_test[,-23]

# Create a Random Forest model with default parameters

forest2 <- randomForest(churn ~ ., data = new_churn_train, importance = TRUE)
forest2

forest3 <- randomForest(churn ~ ., data = new_churn_train, ntree = 500, mtry = 3, importance = TRUE)
forest3

a=c()
i=5
for (i in 3:8) {
  model3 <- randomForest(churn ~ ., data = new_churn_train, ntree = 500, mtry = i, importance = TRUE)
  predValid <- predict(model3, new_churn_test, type = "class")
  a[i-2] = mean(predValid == new_churn_test$churn)
}

a

plot(3:8,a, xlab= "mtry 3:8", ylab = "Accuracy of model",col = "blue", bg = "black", pch = 21) 

predTrain <- predict(forest2, new_churn_test, type = "prob")
# Checking classification accuracy
table(predTrain, new_churn_test$churn)  
mean(predTrain == new_churn_test$churn)

predic_rf <- prediction(predTrain[,2], new_churn_test$churn)
rf_perf <- performance(predic_rf,"tpr", "fpr")
plot(rf_perf, col = "orange", add =T, lty = 2)


varImpPlot(forest2, main = "Variable Importance for Random Forest", bg = "blue")
#####
#House Price
#####
#Split into test & training
set.seed(123)
#Convert some factor vars to numeric
house_price_dataset$zipcode <- as.numeric(house_price_dataset$zipcode)
house_price_dataset$yr_built <- as.numeric(house_price_dataset$yr_built)
house_price_dataset$spl = sample.split(house_price_dataset$price, SplitRatio = 0.75)
house_price_train <- subset(house_price_dataset, spl == "TRUE")
nrow(house_price_train)
ncol(house_price_train)

house_price_test <- subset(house_price_dataset, spl == "FALSE")
#Removing the boolean set for sampling
house_price_train <- house_price_train[,-26]
house_price_test <- house_price_test[,-26]

# Create a Random Forest model with default parameters
set.seed(123)
forest1 <- randomForest(price ~ ., data = house_price_train, mtry=3,  importance = TRUE)
forest1

varImpPlot(forest1,main = "Variable Importance for Random Forest", bg = "blue")


predTrain <- predict(forest1, house_price_test)

RMSE.forest <- sqrt(mean((predTrain - house_price_test$price)^2))
RMSE.forest

# Checking classification accuracy
table(predTrain, house_price_test$price)  
mean(predTrain == house_price_test$price)

########
#Other approach for growing trees - Chaid
#########

install.packages("partykit")
install.packages("CHAID", repos="http://R-Forge.R-project.org")
install.packages("rsample")
install.packages("kableExtra")


require(rsample) # for dataset and splitting also loads broom and tidyr
require(dplyr)
require(ggplot2)
theme_set(theme_bw()) # set theme
require(CHAID)
require(purrr)
require(caret)
library(kableExtra)

#Chaid can only take factors
churn_dataset %>%
  select_if(is.factor) %>%
  ncol

churn_dataset %>%
  select_if(is.numeric) %>%
  ncol

#Have to drop monthly charges & total charges, Tenure group will contain tenure
#Make monthly charges factor var using quartiles
churn_dataset <- within(churn_dataset, monthlycharge_quartile <- as.integer(cut(monthly_charges,
                                                                                quantile(monthly_charges, probs=0:4/4), 
                                                                                include.lowest=TRUE)))
churn_dataset$monthlycharge_quartile = as.factor(churn_dataset$monthlycharge_quartile)
churn_dataset$phone_and_internet_serv = as.factor(churn_dataset$phone_and_internet_serv)

fact_churn <- churn_dataset %>% 
  select_if(is.factor)
dim(fact_churn)


chaidattrit1 <- chaid(churn ~ ., data = fact_churn)
plot(chaidattrit1, type = "simple", gp = gpar(fontsize = 4, theme = "blue",
                                              lty = "solid",
                                              lwd = 1))

ctrl <- chaid_control(minsplit = 200, minprob = 0.05)

chaidattrit2 <- chaid(churn ~ ., data = fact_churn, control = ctrl)
print(chaidattrit2)
plot(chaidattrit2,  gp = gpar(fontsize = 4, theme = "blue",
                              lty = "solid",
                              lwd = 1))
ctrl <- chaid_control(maxheight = 3)
chaidattrit3 <- chaid(churn ~ ., data = fact_churn, control = ctrl)
print(chaidattrit3)
plot(chaidattrit3,gp = gpar(fontsize = 6.5, theme = "blue",
                            lty = "solid",
                            lwd = 1))
pmodel1 <- predict(chaidattrit1)
pmodel2 <- predict(chaidattrit2)
pmodel3 <- predict(chaidattrit3)

cm1 <-confusionMatrix(pmodel1, fact_churn$churn)
cm2 <-confusionMatrix(pmodel2, fact_churn$churn)
cm3 <-confusionMatrix(pmodel3, fact_churn$churn)

True_Value <- factor(c(0, 0, 1, 1))
Prediction <- factor(c(0, 1, 0, 1))
Y      <- c(cm3$table[1], cm3$table[2]
            , cm3$table[3], cm3$table[4])
df <- data.frame(True_Value, Prediction, Y)

ggplot(data =  df, mapping = aes(x = True_Value, y = Prediction)) +
  geom_tile(aes(fill = Y), colour = "white") +
  geom_text(aes(label = sprintf("%1.0f", Y)), vjust = 1) +
  scale_fill_gradient(low = "lightblue", high = "blue") +
  theme_bw() + theme(legend.position = "none")




modellist <- list(CHAID1 = chaidattrit1, CHAID2 = chaidattrit2, CHAID3 = chaidattrit3)
CHAIDResults <- map(modellist, ~ predict(.x)) %>% 
  map(~ confusionMatrix(fact_churn$churn, .x)) %>%
  map_dfr(~ cbind(as.data.frame(t(.x$overall)),as.data.frame(t(.x$byClass))), .id = "ModelNumb")
kable(CHAIDResults, "html") %>% 
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"), 
                font_size = 9)
sort(varimp(chaidattrit1), decreasing = TRUE)
plot(sort(varimp(chaidattrit1), decreasing = TRUE))

#########

