#Copy the files from exdata-data-NEI_data.zip into the working directory and setwd to it.
 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
table(NEI$year)
dim(table(NEI$SCC))

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

baltimore.emissions <- NEI[NEI$fips=="24510",]

baltimore.emissions.aggr <- aggregate(Emissions ~ year + type,
                                      data=baltimore.emissions,
                                      FUN=sum)

library(ggplot2)
png("plot3.png", height=480, width=680)
ggplot(baltimore.emissions.aggr, aes(x=factor(year), y=Emissions, fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  xlab("Years") +
  ylab(expression("Total PM"[2.5]*" emission")) +
  ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                     "City by various source types", sep="")))
dev.off()
