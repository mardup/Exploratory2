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
library(plyr)
png(filename = "plot5.png", 
    width = 480, height = 480, 
    units = "px")

## Get and Clean relevant data for Emissions from Motor Vehicles in Baltimore City
Baltimore_Motor <- ddply(Pm2_5_Data[Pm2_5_Data$fips == "24510" & Pm2_5_Data$type == "ON-ROAD",],
               .(type,year), summarise,
               TotalEmissions = sum(Emissions))


## Plot Emissions from Motor Vehicles in Baltimore City using ggplot
ggplot(Baltimore_Motor, aes(year, TotalEmissions)) +
 geom_line() + geom_point() +
  labs(title = "Total Emissions from Motor Vehicles in Baltimore City",
       x = "Year", y = "Total Emissions")
dev.off()



