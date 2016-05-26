setwd("C:/Users/figinim/Documents/R")

# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Read and prepare data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(NEI, SCC, by="SCC") # merge the tables
library(dplyr)
NEISCCdp <- tbl_df(NEISCC)
NEISCCdp <- mutate(NEISCCdp, coal = grepl("coal", NEISCCdp$Short.Name, ignore.case=TRUE)) # search for "coal" and create boolean column
EmissionsCoalYear <- summarize(group_by(filter(NEISCCdp, coal==TRUE),year),sum(Emissions))
colnames(EmissionsCoalYear) <- c("Year", "Emissions")  #renamed columns
EmissionsCoalYear$Year <- as.character(EmissionsCoalYear$Year)   # year converted to string
EmissionsCoalYear$EmissionsInTousands = EmissionsCoalYear$Emissions / 1000   #new column with emissions in thousands (for the y axis)

# plot
library(ggplot2)
png('plot4.png')
g <- ggplot(EmissionsCoalYear, aes(Year, EmissionsInTousands))
g+geom_bar(stat='identity')+labs(title="Emissions from coal combustion-related sources", x="Years",y="Emissions (PM 2.5) in thousands")
dev.off()