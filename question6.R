# Load needed libraries
library(ggplot2)
# Read the rds data
setwd(getwd())
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Subset on baltimore city (fips=24510) and LA (fips=06037) with "on-road" Type
NEIonRoad <- NEI[(NEI$fips %in% c("24510","06037")) & (NEI$type=="ON-ROAD"), ]
# Filter out from all emissions and calculate aggregate
aggData <- aggregate(NEIonRoad$Emissions, list(Year=NEIonRoad$year, 
                                               Location=as.factor(NEIonRoad$fips)), sum)
# Calculate which city has greater changes over time in motor vehicle emissions 
totData <- ddply(aggData,"Location",transform, Growth=c(0,(exp(diff(log(x)))-1)*100))
# Substitute the fips code back to respective cities to make sense in graph
totData<-as.data.frame(sapply(totData,gsub,pattern="06037",replacement="Los Angeles"))
totData<-as.data.frame(sapply(totData,gsub,pattern="24510",replacement="Baltimore"))
# Open graphics device
png(filename="plot6.png", width=480, height=480)
# Plot The growth on 2 cities with ggplot
ggplot(totData, aes(Year, Growth, fill = Location)) + 
        geom_bar(position = "dodge", stat="identity") + 
        labs(y="Variation (in %)") + 
        ggtitle(expression(atop(" variation of emission of PM2.5", 
                                atop(italic("from motor vehicle sources"), ""))))
# Shut device off
dev.off()