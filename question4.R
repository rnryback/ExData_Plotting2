# Load needed libraries
library(ggplot2)
# Read the rds data
setwd(getwd())
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Filter out all Coal related source names from SCC Table
coalSources <- SCC[grep("^Coal ", SCC$Short.Name, ignore.case=F),"SCC"]
# Filter out all related emission sources for all the above Coal Sources
aggData <- ddply(NEI[NEI$SCC %in% coalSources,], c("year"), 
                 function(df)sum(df$Emissions, na.rm=TRUE))
# Change column names to something clearer 
names(aggData) <- c('Year', 'Emissions')
# Open graphics device
png(filename="plot4.png", width=480, height=480)
# Plot data to answer question
ggplot(aggData, aes(x=Year,y=Emissions))+
        geom_line()+
        xlab('Year')+
        ylab('Total PM2.5 Emissions (tons)')+
        ggtitle('Total emissions trend from coal combustion-related sources')
# Shut device off
dev.off()