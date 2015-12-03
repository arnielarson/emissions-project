#
# plot1.R - Arnie Larson
#
# Script for creating plots 
# for Coursera Exploratory Analysis Course: 
# https://class.coursera.org/exdata-033
#
# What is the trend of total PM2.5 emissions in the US?
# 
# Have total emissions from PM2.5 decreased in the United States from 1999
# to 2008? Using the base plotting system, make a plot showing the total
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005,
# and 2008.
# 
# Assumption is: 
# - that the total (the sum of all Emissions measurements for a given year)
#   is representative of the total US 2.5 emissions.

# Load databases if objects not found
root<-"~/Documents/Coursera/exploratory/data"
NEIfilename <- paste0(root,"/summarySCC_PM25.rds")
SCCfilename <- paste0(root,"/Source_Classification_Code.rds")
if ( !exists("NEI") & file.exists(NEIfilename) ) {
    assign("NEI",readRDS(NEIfilename), envir=.GlobalEnv)
}
if ( !exists("SCC") & file.exists(SCCfilename) ) {
    assign("SCC",readRDS(SCCfilename), envir=.GlobalEnv)
}

# Aggregate the emissions data by year, using the sum as the statistic
em <- aggregate(Emissions ~ year, NEI, sum)
em$ktons <- em$Emissions/1000

png("plot1.png")
plot(ktons ~ year, data=em, 
        main="Total US PM2.5 Emissions", 
        ylab="Emissions (amount in kilotons)", 
        pch=20)
dev.off()

