##Part 1 
setwd("C:/Users/Ross/Documents/MSISS/Third Year/ST3002 - Stats 3")

#Establish file that you want plots to be saved to
pdf("trading_hr_110000.pdf", height = 5)

#Reading in the raw data
FTSE = read.csv("FTSE_1.csv", blank.lines.skip = TRUE)

#Finding the correct time limits
start = match("11:00:00", FTSE$DateTime)
end = match("11:59:59", FTSE$DateTime)

#Trimming the dataset
trimmedFTSE = FTSE[start:end,]


#Plotting the dashed line with red dots and labelled axes and header
plot(trimmedFTSE$Spot, type = "l", lty =3, lwd = 1.5, cex =10, pch = 20, col= "RED", xlab = "seconds after 11:00:00", ylab = "spot", main = "Trading hr 11:00-12:00")

#Imposing the dashed mean line on the existing plot
abline(h =mean(trimmedFTSE$Spot), type = "l", col = "BLUE", lty= 2)
#Save plots to predetermined file name
dev.off()


##Part 2
#Establish file that you want plots to be saved to
pdf("wolves.pdf", height = 5, width = 5)
#Read in sightings using tab separator and headers
sightings = read.table("coordinates.txt", sep = "\t", header = T)
#Read in labels using no separator and no headers
labels = read.table("labels.txt", sep = "")

#bind the labels column onto the corresponding sightings
alldata = cbind(sightings, labels)
#rename the new column correctly
colnames(alldata)[3] = "gender"

#create a vector of colours
colours <- character(nrow(alldata))

#colours for one gender
colours[ alldata$gender == 1 ] <- "RED"
#colours for other gender
colours[ alldata$gender == 2 ] <- "BLUE"

#Plot data using colours, axes limits, axes titles, main title, assigning the data point the bullet shape
plot(alldata$horizontal, alldata$vertical, col = colours, xlim = c(-1.5,1.5), ylim = c(-1.5,1.5), xlab = "lat", ylab = "lon",pch = 20, main = "sightings from base")
#Save plots to predetermined file name
dev.off()

