?boxplot


setwd("U:/ST3002")
data = read.csv("AutoCollision.csv")

par(mfrow=c(1,2))
boxplot(data$Severity ~ data$Age, col = "bisque", main = "Severity of Claims by Age", ylab ="Severity of Claims (euro)", xlab = "Age Groups")
boxplot(data$Severity ~ data$Vehicle_Use, col = "lightblue", main = "Severity of Claims by Vehicle Use", ylab ="Severity of Claims (euro)", xlab = "Car Use Type")

boxplot(data$Claim_Count ~ data$Age, col = "bisque", main = "Number of Claims by Age", ylab ="Number of Claims", xlab = "Age Groups")
boxplot(data$Claim_Count ~ data$Vehicle_Use, col = "lightblue", main = "Number of Claims by Vehicle Use", ylab ="Number of Claims", xlab = "Age Groups")

fit <- glm(Claim_Count ~ Age+Vehicle_Use, data = data, family = poisson)
summary(fit)


#fit2 <- glm(data$Claim_Count ~ data$Vehicle_Use, data = data, family = poisson)
#summary(fit2)


predictions = fit$fitted.values
Predicted_Count = floor(predictions)

predictiontable =cbind(data, Predicted_Count )
newtat = predictiontable[-3]

#fit2$fitted.values

predictiontable
as.data.frame(predictiontable)


#predictive analysis
boxplot(data$Claim_Count ~ data$Age, col = "bisque", main = "Number of Claims by Age", ylab ="Number of Claims", xlab = "Age Groups")
boxplot(newtat$Predicted_Count ~ data$Age, col = "lightblue", main = "Predicted Number of Claims by Age", ylab ="Number of Claims", xlab = "Age Groups")
