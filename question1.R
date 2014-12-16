# Read the rds data
setwd(getwd())
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Sum of all emissions group by individual years
aggData<-with (NEI,aggregate(NEI[,'Emissions'],by=list(year), sum, na.rm=TRUE))
# Change the column names so the results are more clear
names(aggData) <- c('Year', 'TotEmission')
# Open the graphic device
png(filename='plot1.png', width=480, height=480, units='px')
# Plot the aggregated emissions data from PM2.5 for all years
plot(aggData, type="l", xlab="Year", ylab="Total PM2.5 emmisions", 
     col="coral", xaxt="n", main="Total Emissions (tons)")
# Plot the axis with the year
axis(1, at=as.integer(aggData$Year), las=1)
# Shut graphic device down
dev.off()