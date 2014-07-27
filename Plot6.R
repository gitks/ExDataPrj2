#Copy the files from exdata-data-NEI_data.zip into the working directory and setwd to it.
 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
table(NEI$year)
dim(table(NEI$SCC))

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Get Baltimore emissions from motor vehicle sources
baltimore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
baltimore.emissions.aggr <- aggregate(Emissions ~ year, data=baltimore.emissions, FUN=sum)

# Get Los Angeles emissions from motor vehicle sources
la.emissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
la.emissions.aggr <- aggregate(Emissions ~ year, data=la.emissions, FUN=sum)

baltimore.emissions.aggr$County <- "Baltimore City, MD"
la.emissions.aggr$County <- "Los Angeles County, CA"
combined.emissions <- rbind(baltimore.emissions.aggr, la.emissions.aggr)

# plot
library(ggplot2)
png("plot6.png")
ggplot(combined.emissions, aes(x=factor(year), y=Emissions, fill=County)) +
  geom_bar(stat="identity") + 
  facet_grid(County  ~ ., scales="free") +
  ylab("Total emissions (tons)") + 
  xlab("Years") +
  ggtitle(expression("Motor vehicle emission variation\n in Baltimore and Los Angeles"))
dev.off()
