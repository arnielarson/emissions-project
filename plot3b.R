#
# plot3.R - Arnie Larson
#
# 
# for Coursera Exploratory Analysis Course: 
# https://class.coursera.org/exdata-033
#
# 

#load ggplot2
library(ggplot2)

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
NEIb2$type <- as.factor(NEIb2$type)

# plots x, y, with colors labeled by factor type
png("plot3.png")
p<-qplot(year, Emissions,  data=NEIb2, col=type, 
        geom="line",
        ylab="Emissions (in tons)",
        main="Total PM2.5 Emissions, Baltimore")
print(p)
dev.off()

# Note - it's also quite interesting to looks at the distibution 
# of these variables:
par(mfrow=c(2,2))
with(subset(NEIbaltimore, type=="POINT"), boxplot(Emissions ~ year,
    main="Point PM2.5 Emissions",
    ylab="Emissions (amount in tons)",
    xaxp=c(1999,2008,3)))
with(subset(NEIbaltimore, type=="NONPOINT"), boxplot(Emissions ~ year,
    main="NonPoint PM2.5 Emissions",
    ylab="Emissions (amount in tons)",
    xaxp=c(1999,2008,3)))
with(subset(NEIbaltimore, type=="ON-ROAD"), boxplot(Emissions ~ year,
    main="On Road PM2.5 Emissions",
    ylab="Emissions (amount in tons)",
    xaxp=c(1999,2008,3)))
with(subset(NEIbaltimore, type=="NON-ROAD"), boxplot(Emissions ~ year,
    main="Non Road PM2.5 Emissions",
    ylab="Emissions (amount in tons)",
    xaxp=c(1999,2008,3)))

