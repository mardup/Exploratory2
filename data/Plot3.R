##getwd()
setwd("~/R/Testing/Test/Exploratory2/data/")

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fileName <- "exdata_data_NEI_data.zip"

## Download and unzip the data
download.file(fileURL, fileName, method="curl")
unzip(fileName)

# Confirm if data exist or need to be loaded.
if (!"Pm2_5_Data" %in% ls()) {
  Pm2_5_Data <- readRDS("summarySCC_PM25.rds")
}
if (!"MapData" %in% ls()) {
  MapData <- readRDS("Source_Classification_Code.rds")
}

library(ggplot2)
png(filename = "plot3.png", 
    width = 480, height = 480, 
    units = "px")

Pm2_5_Data_Baltimore <- Pm2_5_Data[Pm2_5_Data$fips == "24510", ] 

g <- ggplot(Pm2_5_Data_Baltimore, aes(year, Emissions, color = type))

g + geom_line(stat = "summary", fun.y = "sum") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle("Baltimore City total emissions from 1999 to 2008")
dev.off()
