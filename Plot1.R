setwd("C:/Users/figinim/Documents/R")

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#    Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 
#    1999, 2002, 2005, and 2008.

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# I use dplyr
library(dplyr)
NEIdp <- tbl_df(NEI)
EmissionsForYear = summarize(group_by(NEIdp, year), sum(Emissions))    # table with emissions per year
colnames(EmissionsForYear) <- c("Year", "Emissions")   # renamed columns
EmissionsForYear$EmissionsInMillions = EmissionsForYear$Emissions / 1000000   #new column with emissions in million (for the y axis)

# Plot code
png('plot1.png')
barplot(EmissionsForYear$EmissionsInMillions, names.arg=EmissionsForYear$Year, col="blue", xlab='Years', ylab='Emissions (PM 2.5) in millions', main =  'Emissions (PM 2.5) per year')
dev.off()
