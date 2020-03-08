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
png(filename = "plot4.png", 
    width = 480, height = 480, 
    units = "px")

##summary(CoalCombustion)

CoalCombustion <- grep("coal", MapData$Short.Name, ignore.case = T)
CoalCombustion <- MapData[CoalCombustion, ]
CoalCombustion <- Pm2_5_Data[Pm2_5_Data$SCC %in% CoalCombustion$SCC, ]

coalEmissions <- aggregate(CoalCombustion$Emissions, list(CoalCombustion$year), FUN = "sum")

plot(coalEmissions, type = "l", xlab = "Year", 
     main = "Total emissions from  various Coal Combustion-related\n Sources from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.off()

