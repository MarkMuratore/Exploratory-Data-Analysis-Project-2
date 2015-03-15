setwd("~/Desktop/Coursera/Exploratory Data Analysis/Course Project 2")

library(plyr)
library(DataCombine)
library(ggplot2)

### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### CoalSrc <- SCC[grepl("*Coal$", SCC$EI.Sector),]
CoalSrc <- grepl.sub(data=SCC, pattern = "Coal", Var = "EI.Sector")
NEIcoal <- NEI[NEI$SCC %in% CoalSrc$SCC,] 

UScoal <- ddply(NEIcoal, c("year"), summarise, 
                 Total = sum(Emissions))

png("plot4.png")
ggplot(UScoal, aes(year, Total)) + geom_point() +   
        geom_line() + labs(x="Year") + 
        labs(y = expression("Total "~PM[2.5]~" Emissions (Tons)")) + 
        labs(title = "U.S. Total "~PM[2.5]~ " by Year")
dev.off()
