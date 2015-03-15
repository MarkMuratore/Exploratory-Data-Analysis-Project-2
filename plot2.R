### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

pm25_Bal <- subset(NEI, fips == "24510")
pm25 <-tapply(pm25_Bal$Emissions, pm25_Bal$year, sum)

png("plot2.png")
plot(names(pm25), pm25, type = "l", main="Total Baltimore City"~PM[2.5]~
        "Emissions by Year", xlab = "Year",
         ylab = "Total"~ PM[2.5]~ "Emissions (Tons)")
dev.off()