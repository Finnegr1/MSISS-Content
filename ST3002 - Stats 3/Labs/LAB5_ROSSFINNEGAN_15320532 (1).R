##Part 1 
setwd("U:/finnegr1/ST3002")

draw.a.circle <- function( centre, radius, Npt=100, add = FALSE, linecol = "BLACK", linetype = 1, linewidth = 1)
{
  #centre gives the centre of the circle and radius the radius
  #the Npt argument gives how refined the circle should look
  #add == FALSE means don't add to the current plotting device; otherwise overlay
  #on the current plotting device
  
  #linecol takes the colour of the line
  #linetype i.e. dashed, dotted, etc.. (range from 0-6), default value is 1 "solid"
  #linewidth is the width of the line
  t <- seq(0,2*pi,length=Npt)
  coords <- t(rbind( centre[1]+sin(t)*radius, centre[2]+cos(t)*radius))
  if( !add ) plot(coords, type="l", lty = linetype, col = linecol, lwd = linewidth) else points( coords, type="l", lty = linetype, col = linecol, lwd = linewidth) 
}

#Assigning a centre to my circle
centre = c(1,3);
#Drawing a circle with the additional arguments utilised
draw.a.circle(centre,3,  linecol = "blue", linetype = 2, linewidth = 3);

##Part 2

#Establishing a blank plot without labels and axes for my grid
plot(NULL, xlim=c(0,5), ylim=c(-0.5,5), axes = F, xlab = "", ylab = "")

#Setup a grid of points for centres of circles
coordinates = which(matrix(TRUE, 3,3), arr.ind = T)
#Swap the column containing the y coordinates to allow for correct numbering
coordinates[,2] = rev(coordinates[,2]);

#Create 9 circles containing the correct number and circle size
for(i in 1:nrow(coordinates)){
  centre = c(coordinates[i,1], coordinates[i,2]);
  draw.a.circle(centre, 0.4, add = T, linecol = i, linetype = 1, linewidth = 2);
  text(coordinates[i,1],coordinates[i,2], labels = i, col = i);
}


##Part 3
#Vector containing the values of the bootom row of keypad
labels = c("*", 0, "#");
#loop through three times adding the final three circles
for(i in 1:3){
  #These circles are a different line type (dashed)
  draw.a.circle(c(coordinates[i,1], 0), 0.4, add = T, linecol = i, linetype = 2, linewidth = 4);
  #This text is bold and bigger
  text(coordinates[i,1],0, labels = labels[i], col = i, font = 2, cex = 2);
}

