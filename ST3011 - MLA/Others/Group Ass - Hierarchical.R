  # Attempt Hierarchical clustering via gower metric
  # Gower metric: each variable (column) is first standardized consequently 
  # the rescaled variable has range [0,1], exactly
  
  # Gower metric works with all data types (nominal, ordinal & binary)
  # However will firstly investigate all the numeric variables (column 3-16)
  
  library(cluster)
  
  #removes the date column 
  weatherwithoutdate = weather_diag[,-1]
  
  #dissimilarities calculated and columns standardised
  weatherdis = daisy(weatherwithoutdate, metric = "gower", stand = FALSE)
  
  #matrix of dissimilarities
  weatherdismat = as.matrix(weatherdis)
  
  #
  cl = hclust(weatherdis, method = "average")
  plot(cl)
  ?hclust
  
  
  ################################################################
  # Trying without first two columns and no gower 
  
  weathernum = weather_diag[, -c(1:2)]
  
  #Standarisation may not be ideal when we wish to give less weight
  #to a variable that carries less info - eg has a small variation
  #Check variation of each column
  scaledweathernum = scale(weathernum)
  
  swndis = dist(scaledweathernum, method="euclidean")
  swndismat = as.matrix(swndis)
  
  cl2 = hclust(swndis, method = "average")
  plot(cl2)
    
  cl$height
  
  
  
  ############################################################
  #Different standardisation method
  
  stdevs = apply(weatherwithoutdate, 2, sd)
  stdevs
  
  stdweather = sweep(weatherwithoutdate,2,stdevs, "/")
  
  stdweatherdis = dist(stdweather, method = "euclidean")
  
  cl3 = hclust(stdweatherdis, method = "average")
  
  plot(cl3)
  
  
  
  #########################################################
  #Attempt 4
  
  stdevs2 = apply(weathernum, 2, sd)
  stdevs2
  
  stdweather2 = sweep(weathernum,2,stdevs, "/")
  
  stdweatherdis2 = dist(stdweather2, method = "euclidean")
  
  cl4 = hclust(stdweatherdis2, method = "average")
  
  plot(cl4)
  
  
  
  ############################################################
  # I reckon cl3 looks best atm
  
  heights = cl3$height
  aveheight = mean(heights)
  sdheight = sd(heights)
  
  cutoff =aveheight + 3*sdheight
  
  plot(cl3)
  abline(h=cutoff, lty=2, col=2)
  
  
  weatherlabel= cutree(cl3, h=cutoff)
  
  palette(rainbow(10))
  plot(stdweatherdis[,1], stdweatherdis[,2], col =weatherlabel)
  pairs(stdweatherdis, col = weatherlabel)
  
