##Part 1 
setwd("U:/finnegr1/ST3002")

#establish explanatory variables
x <- 1:100
#intercept param = 0.1, slope param = 0.2, errors normally distributed with sd = 0.1
y <- 0.1+0.2*x+rnorm(100, sd = 1)
plot(x,y)

##Part 2
#Define list using named entries for x and y
data <- list(x=x,y=y)
#Pass beta as a vector and data as a list
my.func = function(beta, data){
  return(sum((data$y-beta[1]-beta[2]*data$x)^2))
}

##Part 3
#Use optim function to estimate regression parameters
opt <- optim( par=c(2,2), fn = my.func, data = data, method = "BFGS")
#Print the calculated parameters to compare to what they should be
opt$par

##Part 4
#Establishing an empty matrix of 1000 rows and 2 columns
optimals = matrix(NA, 1000,2)
#Looping through each row I populate the matrix with the parameter estimates for each simulation
for(i in 1:1000){
  x <- 1:100
  y <- 0.1+0.2*x+rnorm(100, sd = 1)
  currentdata <- list(x=x,y=y)
  curropt <-optim( par=c(2,2), fn = my.func, data = currentdata, method = "BFGS")
  optimals[i, ] <- curropt$par
}

#Plot the kernal density estimate of the intercept parameter
plot(density(optimals[,1]))
#Plot the kernal density estimate of the slope parameter
plot(density(optimals[,2]))


#Should the standard deviation be lowered you could expect the plot of the kernal densities to be more centered around
#the mean and have smaller spread.
#This is a result of the Simple Linear Regression model being more fitted.