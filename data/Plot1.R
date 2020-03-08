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

png(filename = "plot1.png", 
    width = 480, height = 480, 
    units = "px")

TotalEmissions <- aggregate(Pm2_5_Data$Emissions, list(Pm2_5_Data$year), FUN = "sum")
plot(TotalEmissions, type = "l", xlab = "Year", 
     main = "United States Total Emissions from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.off()