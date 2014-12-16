# Load needed libraries
library(plyr)
library(ggplot2)
# Read the rds data
setwd(getwd())
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Total Emission for Baltimore (fips=24510) (1999-2008)
totData <- ddply(NEI[NEI$fips == "24510",], c("year", "type"), 
                 function(df)sum(df$Emissions, na.rm=TRUE))
# Open graphics device
png(filename="plot3.png", width=480, height=480)
# Plot data to answerthe question
ggplot(data=totData, aes(x=year, y=V1, group=type, colour=type)) +
        geom_line() +
        xlab("Year") +
        ylab("PM2.5 (tons)") +
        ggtitle("Total PM2.5 emissions (tons)/year/source type")
# Shut device off
dev.off()