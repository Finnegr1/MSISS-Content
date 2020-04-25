setwd("C:/Users/Ross/Downloads")


c = read.csv("text.txt",h = F)


countvector = c(0,0,0,0,0,0,0,0,0,0,0)
namevector = c("Dwan", "Hooly", "Patrick", "Donal", "CK", "Ross", "Ruairc", "COG", "Stiffer", "Drewski", "Shoido")
for(i in 1:26756){
  if(grepl("Matthew Sheedy:", c[i,1])){
    countvector[11] = countvector[11] + 1
  }
}
for(i in 1:26756){
  if(grepl("Matthew Sheedy:", c[i,2])){
    countvector[11] = countvector[11] + 1
  }
}
countvector
plot(namevector, countvector)
hist(countvector)
plot(countvector)

barplot(countvector, xlab = namevector)
merge(namevector, countvector)
per = round(countvector/26756*100, digits = 2)
df2 = data.frame("Name" = namevector, "Total Messages" = countvector, "Percentage of Total" = per)


table(df)
yp<- structure(countvector, .Dim = c(11L), .Dimnames = list(c("Dwan", "Hooly", "Patrick", "Donal", "CK", "Ross", "Ruairc", "COG", "Stiffer", "Drewski", "Shoido") ), class = "table")
barplot(yp)

countvec =0 
for(i in 1:26756){
  if(grepl("scenes", c[i,2])){
    countvec = countvec + 1
  }
}

countvec
df 