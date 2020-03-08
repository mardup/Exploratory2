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
png(filename = "plot6.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")
##head(Pm2_5_Data)

## Get and Clean relevant data for Emissions from Motor Vehicles in Baltimore and Los Angeles
## Baltimore and Los Angeles
Baltimore_LosAngeles <- Pm2_5_Data[Pm2_5_Data$fips == "24510"|Pm2_5_Data$fips == "06037", ]

AllMotor <- grep("motor", MapData$Short.Name, ignore.case = T)
AllMotor <- MapData[AllMotor, ]
AllMotor <- Baltimore_LosAngeles[Baltimore_LosAngeles$SCC %in% AllMotor$SCC, ]

## Plot Emissions from Motor Vehicles in Baltimore and Los Angeles using ggplot
g <- ggplot(AllMotor, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y = "sum") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle("Total Emissions From Motor Vehicle \n in Baltimore and Los Angeles \n from 1999 to 2008") +
    scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))
dev.off()
