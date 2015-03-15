### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

pm25 <-tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png")
plot(names(pm25), pm25, type = "l", main="Total US"~PM[2.5]~
        "Emissions by Year", xlab = "Year",
         ylab = "Total"~ PM[2.5]~ "Emissions (Tons)")
dev.off()