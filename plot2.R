#
# plot1.R - Arnie Larson
#
# Script for creating plots 
# for Coursera Exploratory Analysis Course: 
# https://class.coursera.org/exdata-033
#
# What is the trend of total Emissions PM in just Baltimore? (fips=24510)
# 
# Have total emissions from PM2.5 decreased in Baltimore MD from 1999
# to 2008? Using the base plotting system, make a plot showing the total
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005,
# and 2008.

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


# Subset on Baltimore (by fips), then aggregate the emissions data by year
sNEI <- NEI[NEI$fips=='24510',]

# sum Emissions by year
em <- aggregate(Emissions ~ year, sNEI, sum)

# plot Emissions vs. Year
png("plot2.png")
barplot(height=em$Emissions, names.arg=em$Yearsmain, 
        main="Total PM2.5 Emissions, Baltimore", 
        xlab='Year',
        ylab="Emissions (amount in tons)" )
# Add a linearl trend line - really not useful for 4 points..
#abline(lm(Emissions ~ year, data=em))
dev.off()


