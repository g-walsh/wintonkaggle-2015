rm(list=ls())
library(ggplot2)

setwd("~/R/kaggle/wintonkaggle-2015")
df <- read.csv('train.csv', header = TRUE)

examplestock <- df[3,]
# View(examplestock)
tcexample <- examplestock[1,33:length(examplestock)-4]
# View(tcexample)

test <- reshape(tcexample,direction = "long",varying = list(names(tcexample)),v.names="price",timevar = "Timepoint",times = names(tcexample))

examplestock2 <- df[3:5,]
# View(examplestock2)
tcexample2 <- examplestock2[1:3,33:length(examplestock)-4]
# View(tcexample2)
test <- reshape(tcexample2,direction = "long",varying = list(names(tcexample2)),v.names="price",timevar = "Timepoint",times = names(tcexample2))
# View(test)

test <- na.omit(test)
test <- transform(test, Timepoint=as.numeric(sub('Ret_','',Timepoint)))

# ggplot(test, aes(x=Timepoint, y=price, col=id)) + geom_point() + geom_line()
ggplot(test[test$id==1,], aes(x=Timepoint, y=price, col=id)) + geom_point() + geom_line()
