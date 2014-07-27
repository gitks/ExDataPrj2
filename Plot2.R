#Copy the files from exdata-data-NEI_data.zip into the working directory and setwd to it.
 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
table(NEI$year)
dim(table(NEI$SCC))

# Have total emissions from PM2.5 decreased in Baltimore City, Maryland from
# 1999 to 2008?
baltimore.emissions <- NEI[NEI$fips=="24510",]
# group emissions by year
baltimore.emissions.by.year <- aggregate(Emissions ~ year, baltimore.emissions, sum)

png('plot2.png')
barplot(height=baltimore.emissions.by.year$Emissions,
        names.arg=baltimore.emissions.by.year$year,
        xlab="Years", ylab=expression('Total PM'[2]*' emission'),
        main=expression('Total PM'[2]*' emissions in Baltimore City, Maryland at various years'))
dev.off()
