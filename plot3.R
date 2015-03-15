setwd("~/Desktop/Coursera/Exploratory Data Analysis/Course Project 2")

library(plyr)
library(ggplot2)

### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



pm25_Bal <- subset(NEI, fips == "24510")
Orioles <- ddply(pm25_Bal, c("year", "type"), summarise, 
        Total = sum(Emissions))

png("plot3.png", width = 540, height = 540)
ggplot(Orioles, aes(year, Total)) + geom_line() + 
        facet_grid(.~type) + labs(x="Year") + 
        labs(y = expression("Total "~PM[2.5]~" Emissions (Tons)")) + 
        labs(title = "Baltimore City Total "~PM[2.5]~ " Emissions Type by Year")
dev.off()
