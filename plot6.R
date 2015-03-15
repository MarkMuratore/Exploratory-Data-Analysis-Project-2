setwd("~/Desktop/Coursera/Exploratory Data Analysis/Course Project 2")

library(plyr)
library(ggplot2)

### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



pm25_Bal <- subset(NEI, fips == "24510")
pm25_LA <- subset(NEI, fips == "06037")
CoalSrcVeh <- grepl.sub(data=SCC, pattern = "Vehicle",
                        Var = "EI.Sector")
BalVeh <- pm25_Bal[pm25_Bal$SCC %in% CoalSrcVeh$SCC,]
LAVeh <- pm25_LA[pm25_LA$SCC %in% CoalSrcVeh$SCC,]
combined <- rbind(BalVeh, LAVeh)
combined <- mutate(combined, city = ifelse(fips == "24510",
        "Baltimore", "Los Angeles"))

mvdata <- ddply(combined, c("year", "city"), summarise, 
        Total = sum(Emissions))


png("plot6.png")
ggplot(mvdata, aes(year, Total, color = city)) + geom_line() + 
        labs(x="Year") + 
        labs(y = expression("Total "~PM[2.5]~" Emissions (Tons)")) + 
        labs(title = "Baltimore City and Los Angeles Total "~PM[2.5]~ " Motor Vehicle Emissions by Year")
dev.off()

png("plot6A.png")
ggplot(mvdata, aes(year, Total)) + geom_line() + 
        facet_grid(.~city) + labs(x="Year") + 
        labs(y = expression("Total "~PM[2.5]~" Emissions (Tons)")) + 
        labs(title = "Baltimore City and Los Angeles Total "~PM[2.5]~ " Motor Vehicle Emissions by Year")
dev.off()
