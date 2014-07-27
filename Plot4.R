#Copy the files from exdata-data-NEI_data.zip into the working directory and setwd to it.
 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
table(NEI$year)
dim(table(NEI$SCC))

# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999 to 2008?

# Find coal combustion-related sources
is.combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[is.combustion.coal,]

# Find emissions from coal combustion-related sources
combustion.emissions <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

# group by year
combustion.emissions.by.year <- aggregate(Emissions ~ year, data=combustion.emissions, FUN=sum)

# plot
library(ggplot2)
png("plot4.png")
ggplot(combustion.emissions.by.year, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  xlab("Years") +
  ylab(expression("Total PM"[2.5]*" emissions")) +
  ggtitle("Emissions from coal combustion-related sources")
dev.off()
