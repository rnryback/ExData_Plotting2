# Load needed libraries
library(plyr)
# Read the rds data
setwd(getwd())
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Aggregate using filter with ddply(plyr). 24510 is for Baltimore
aggDataPerYear <- ddply(NEI[NEI$fips == "24510",], c("year"), 
                        function(df)sum(df$Emissions, na.rm=TRUE))
# Open graphics device
png(filename="plot2.png", width=480, height=480)
# Plot the final aggregate data to answer the question
plot(aggDataPerYear$year, aggDataPerYear$V1, type="l", xlab="Year", 
     ylab="PM2.5 (tons)", col="coral", main="PM2.5 Generated in Baltimore City, MD (1999-2008)")
# Shut graphic device off
dev.off()