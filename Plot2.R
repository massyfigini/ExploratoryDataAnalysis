# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#    Use the base plotting system to make a plot answering this question.

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# I use dplyr
library(dplyr)
NEIdp <- tbl_df(NEI)
BaltimoraEmissionsForYear = summarize(group_by(filter(NEIdp, fips=="24510"), year), sum(Emissions))     # table with emissions per year of Baltimore
colnames(BaltimoraEmissionsForYear) <- c("Year", "Emissions")   # renamed columns

# Plot code
png('plot2.png')
barplot(BaltimoraEmissionsForYear$Emissions, names.arg=EmissionsForYear$Year, col="red", xlab='Years', ylab='Emissions (PM 2.5)', main =  'Baltimore City: Emissions (PM 2.5) per year')
dev.off()
