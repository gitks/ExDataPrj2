#Copy the files from exdata-data-NEI_data.zip into the working directory and setwd to it.
 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
table(NEI$year)
dim(table(NEI$SCC))

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Get Baltimore emissions from motor vehicle sources
baltimore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
baltimore.emissions.aggr <- aggregate(Emissions ~ year, data=baltimore.emissions, FUN=sum)

# plot
library(ggplot2)
png("plot5.png")
ggplot(baltimore.emissions.aggr, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  xlab("Years") +
  ylab(expression("Total PM"[2.5]*" emissions")) +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")
dev.off()
