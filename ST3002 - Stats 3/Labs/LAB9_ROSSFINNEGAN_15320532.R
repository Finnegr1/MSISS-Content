##Part 1 
setwd("U:/ST3002")
source("EMalg.R")


#Define the number of samples
N <- 150
sd=0.1
#Generate 150 means from  three options with equal probabilities
labels <- sample(c(-1,0,1), size = 150, replace= TRUE, prob = c(0.33,0.33,0.33))
#this generates 150 samples from a mixture model 
samples <- rnorm(n=length(labels),mean=labels,sd=sd)
#This graphs the samples as a histogram with appropriate breaks for ease of interpretation
graph <- hist(samples, breaks = 75)

#Variation of the standard deviation causes the histogram spread to change considerably
#As sd is decrease, the more centred the histogram is around the three means
#This shows that it is easier to define clusters when the data is close to a mean value

#Part 2
#Output list from EM.GMM function
Emax <- EM.GMM(samples)

#Function that returns a mixture density function for each corresponding entry in the vector of values passed in, x
densfunc <- function(em_list,x){
  #create empty vector for my result
  res <- vector()
  #looping through each value in the vector
  for (i in 1:length(x)){
    #this variable is updated with each repetiton of the groups
    total <- 0
    #looping through each Group in the vector
    for (j in 1:em_list$G){
      total <-total + em_list$par$wei[j]*dnorm(x[i], em_list$par$mu[j], em_list$par$sd[j])
    }
    #update the correct value
    res[i] <- total
  }
  #return the list of values
  return (res)
}

#Creates a vector of 501 equally spaced points between -3 and 3
x_values <- seq(from = -3, to = 3,length.out = 501)
#This is passed into the function defined above
results <- densfunc(Emax,x_values)
plot(results, xlab = "x", ylab = "f(x)")

#Part 3
#This function takes the list outputted by GMM module and returns the BIC of the model fitted previously
bicfunc <- function (list){
  #This equation is taken from the function for maximum likelihood
  maxlikelihood <- list$loglike*(-2) +(3*list$G - 1)*log(length(list$data))
  return(maxlikelihood)
}

#By evaluating the Output of the bicfunc it is clear that the BIC is minimised when G=3 which is consistent
#with our simulation above
g <- EM.GMM(x=samples, G = 3)
bicfunc(g)

#As sd increases it is evident that BIC increases for all values of G
#However the model is robust as the correct number of values of G can still be determined as BIC is lowest when the G = 3


