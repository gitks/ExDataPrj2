#Copy the files from exdata-data-NEI_data.zip into the working directory and setwd to it.
 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
table(NEI$year)
dim(table(NEI$SCC))

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

total.emissions <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
barplot(height=total.emissions$Emissions, names.arg=total.emissions$year,
        xlab="Years", ylab=expression('Total PM'[2]*' emission'),
        main=expression('Total PM'[2]*' emissions at various years'))
dev.off()
