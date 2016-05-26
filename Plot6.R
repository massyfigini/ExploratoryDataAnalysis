setwd("C:/Users/figinim/Documents/R")

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles 
#    County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# Read and prepare data
NEI <- readRDS("summarySCC_PM25.rds")
library(dplyr)
NEIdp <- tbl_df(NEI)
BaltimoraEmissionsVehicle = summarize(group_by(filter(NEIdp, fips=='24510', type=='ON-ROAD'), year), sum(Emissions))  # table with Motor Vehicle emissions per year of Baltimore
BaltimoraEmissionsVehicle = mutate(BaltimoraEmissionsVehicle, Place = 'Baltimore City') # add place name
LAEmissionsVehicle = summarize(group_by(filter(NEIdp, fips=='06037', type=='ON-ROAD'), year), sum(Emissions))  # table with Motor Vehicle emissions per year of LA County
LAEmissionsVehicle = mutate(LAEmissionsVehicle, Place = 'Los Angeles County') # add place name
BaltimoreLA <- rbind(BaltimoraEmissionsVehicle,LAEmissionsVehicle) # union
colnames(BaltimoreLA) <- c('Year', 'Emissions', 'Place')
BaltimoreLA$Year <- as.character(BaltimoreLA$Year)   # year converted to string

# plot
png('plot6.png')
qplot(Year,data=BaltimoreLA, geom="bar", weight=Emissions, facets=.~Place, fill=Year, main='Baltimore City/Los Angeles County: Emissions of motor vehicle', xlab='', ylab = 'Emissions (PM 2.5)')
dev.off()