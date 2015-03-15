setwd("~/Desktop/Coursera/Exploratory Data Analysis/Course Project 2")

library(plyr)
library(ggplot2)

### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



pm25_Bal <- subset(NEI, fips == "24510")
CoalSrcVeh <- grepl.sub(data=SCC, pattern = "Vehicle",
                        Var = "EI.Sector")
BalVeh <- pm25_Bal[pm25_Bal$SCC %in% CoalSrcVeh$SCC,]


Orioles <- ddply(BalVeh, c("year"), summarise, 
        Total = sum(Emissions))

png("plot5.png")
ggplot(Orioles, aes(year, Total)) + geom_line() + 
        labs(x="Year") + 
        labs(y = expression("Total "~PM[2.5]~" Emissions (Tons)")) + 
        labs(title = "Baltimore City Total "~PM[2.5]~ " Motor Vehicle Emissions by Year")
dev.off()
