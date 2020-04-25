##Part 1
setwd("U:/ST3002")

#Generate 1000 times 100 matrix of standard normal random variates
X =matrix(rnorm(1000*100), nrow = 1000)

#Function to calculate the sum of squared entries in any row/column
sum_of_square = function(input){
  sum = sum(input^2)
  return(sum)
}

#Function to calculate exp(x) +1 
exp_plus_one = function(input){
  #first generate the exp of each element in the row
  exprow = exp(input)
  #add the length of the row, which accounts for +1 on each element, to the sum of the rows exps
  ret = sum(exprow)+length(input)
  return(ret)
}

#Using apply function to generate some summary statistics
row_means = apply(X, MARGIN = 1, mean)
col_means = apply(X, MARGIN = 2, mean)
sum_of_square_rows = apply(X,MARGIN = 1, sum_of_square)
sum_exp = apply(X,  MARGIN = 1, exp_plus_one)


##Part 2 

#Function to return a list of row/column vector means and standard deviations
#Default value 1 of marg makes it default to row vectors
summary.ouput = function(X, marg = 1){
  #for columns
  if(marg == 2){
    means = apply(X, MARGIN = 2, mean)
    sds = apply(X, MARGIN = 2, sd)
    number = 1:ncol(X)
    
    meantags = paste("Column", number, "Mean", sep = " ")
    sdtags = paste("Column", number, "St Dev" , sep = " ")
    
    names(means) = meantags
    names(sds) = sdtags
    
    ret = list(means = means, sds = sds)
  }
  #for rows
  else if(marg == 1){
    means = apply(X, MARGIN = 1, mean)
    sds = apply(X, MARGIN = 1, sd)
    number = c(1:nrow(X))
    
    meantags = paste("Row", number, "Mean", sep = " ")
    sdtags = paste("Row", number, "St Dev", sep = " ")
    
    names(means) = meantags
    names(sds) = sdtags
    
    ret = list(means = means, sds = sds)
  }
  #for invalid input
  else{
    stop("Please give proper arguments!")
  }
}

##Part 3 
#finding a suitable plotting limits
lim = sd(row_means)
mean_r = mean(row_means)
limits = c(mean_r-3*lim, mean_r+3*lim)

#breaks are 40 to eliminate chunky boxes
hist(row_means, xlim = limits, breaks = 40)

X2 =matrix(rnorm(1000*1000), nrow = 1000)
row_means2 = apply(X2, MARGIN = 1, mean)


hist(row_means2, xlim = limits, breaks = 40)


#The first histogram has a wider spread of values around the mean
#The second histogram is a lot more concentrated around the mean 

#The standard deviation is 1/sqrt(n), as n gets bigger the deviation from the mean will reduce 
#This is evident from the histograms as the scale reduces by 1/3 which is the equivalent of 1/sqrt(10000):1/sqrt(100000)



