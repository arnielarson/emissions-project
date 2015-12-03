#
# plot3.R - Arnie Larson
#
# 
# for Coursera Exploratory Analysis Course: 
# https://class.coursera.org/exdata-033
#
# 

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
# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City?

# In Baltimore, how do the emissions vary by type? (fips=24510)
# Subset on Baltimore (by fips), then aggregate the emissions data by year
NEIbaltimore <- NEI[NEI$fips=='24510',]

# aggregate total Emissions by year and type
NEIb2 <- aggregate(Emissions ~ year + type, NEIbaltimore, sum)

# now plot Emissions vs. Year, for each type..
# plot(em$Emissions ~ em$year, main="Total PM2.5 Emissions, Baltimore", ylab="Emissions (amount in tons)", pch=20)
par(mfrow = c(2,2))
with(subset(NEIb2, type=="POINT"), plot(Emissions ~ year, 
            main="Point PM2.5 Emissions", 
            ylab="Emissions (amount in tons)",
            xaxp=c(1999,2008,3)))
with(subset(NEIb2, type=="NONPOINT"), plot(Emissions ~ year, 
            main="Nonpoint PM2.5 Emissions", 
            ylab="Emissions (amount in tons)",
            xaxp=c(1999,2008,3)))
with(subset(NEIb2, type=="NON-ROAD"), plot(Emissions ~ year, 
            main="Non-Road PM2.5 Emissions", 
            ylab="Emissions (amount in tons)",
            xaxp=c(1999,2008,3)))
with(subset(NEIb2, type=="ON-ROAD"), plot(Emissions ~ year, 
            main="On-Road PM2.5 Emissions", 
            ylab="Emissions (amount in tons)",
            xaxp=c(1999,2008,3)))
#points(NEIb2[NEIb2$type=="POINT",]$Emissions, col="red") 

# could add a linear trend line (not meaningful w/ 4 data points?)
# abline(lm(Emissions ~ year, data=em))

