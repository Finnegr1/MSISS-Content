library(cluster)
## first row removed as this is the column associated with the date
## also will shift the data to highlight the incubation period

rawdata = weather_diag

shift = function(x,n){
  c(x[-(seq(n))], rep(NA, n))
}
shifteddata = rawdata
shifteddata$Diagnosis= shift(shifteddata$Diagnosis, 21)

adjshifted = rawdata[,2:16]
prepdata = scale(adjshifted)

#Instance 1: Include diagnosis var
#Results: single = 53 clusters; average = 65; complete = 81

weatherdiagdis = daisy(prepdata, metric = "gower", stand = FALSE)
cl = hclust(weatherdiagdis, method = "average")
plot(cl)

heights = cl$height
aveheight = mean(heights)
sdheight = sd(heights)
cutoff =aveheight + 3*sdheight


abline(h=cutoff, lty=1, col=2)

#cutree function k = number of groups, h = certain height
max(cutree(cl,h=cutoff))

abline(h=cutoff, lty=1, col=2)

#Instance 2: Same with Brett's standardisation tools
#Results: Euclid: single = 42; average = 62; complete = 77
#Results: Manhat: single = 56; average = 67; complete = 76
#Results: Maximu: single = 29; average = 49; complete = 73

swddis = dist(prepdata, method="maximum")
cl2 = hclust(swddis, method = "complete")
plot(cl2)

heights2 = cl2$height
aveheight2 = mean(heights2)
sdheight2 = sd(heights2)
cutoff2 =aveheight2 + 3*sdheight2


abline(h=cutoff2, lty=1, col=2)
max(cutree(cl2,h=cutoff2))


#Instance 3: Instance 1 without Diag
#Results: single = 34; average = 67; complete = 86
rawweather = prepdata[,-c(1)]

weatherdis = daisy(rawweather, metric = "gower", stand = FALSE)
cl3 = hclust(weatherdis, method = "complete")
plot(cl3)

heights3 = cl3$height
aveheight3 = mean(heights3)
sdheight3 = sd(heights3)
cutoff3 =aveheight3 + 3*sdheight3

abline(h=cutoff3, lty=1, col=2)
max(cutree(cl3,h=cutoff3))


#Instance 4: Instance 2 without Diag
#Results: Euclid: single = 44; average = 67; complete = 76
#Results: Manhat: single = 41; average = 67; complete = 78
#Results: Maximu: single = 40; average = 53; complete = 66
swddis2 = dist(rawweather, method="maximum")
cl4 = hclust(swddis2, method = "single")
plot(cl4)

heights4 = cl4$height
aveheight4 = mean(heights4)
sdheight4 = sd(heights4)
cutoff4 =aveheight4 + 3*sdheight4

abline(h=cutoff4, lty=1, col=2)
max(cutree(cl4,h=cutoff4))

