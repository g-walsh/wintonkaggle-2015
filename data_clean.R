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

## Now create the long version of the whole data frame
## Define the long data frame with only the normal day data - This conversion will take time so save as .RData afterwards

dflong <- df[,33:length(df)-4]
dflong <- reshape(dflong,
                  direction = "long",
                  varying = list(names(dflong)),
                  v.names = "price",
                  timevar = "Timepoint",
                  times = names(dflong))

dflong <- na.omit(dflong)
dflong <- transform(dflong, Timepoint=as.numeric(sub('Ret_','',Timepoint)))

save(dflong, file='testlong.RData')

## From now on we can import the .RData so we don't have to clean it every time!

load("~/R/kaggle/wintonkaggle-2015/testlong.RData")

## Plot the stock of choice as either timecourse or histogram

ggplot(dflong[dflong$id==2500,], aes(x=Timepoint, y=price, col=id)) + geom_point() + geom_line()
ggplot(dflong[dflong$id==2500,], aes(price)) + geom_histogram(bins=25)

# Generate long list of (100) plots and store in a list and then plot them all

pltlst <- list()

for (i in 1:20) {pltlst[[i]] <- ggplot(dflong[dflong$id==i*100,], aes(price)) + geom_histogram(bins=25)}
# multiplot(plotlist[[1]],plotlist[[2]],plotlist[[3]],plotlist[[4]],cols=2)
multiplot(plotlist=pltlst, cols=5)
