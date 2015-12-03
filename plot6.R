#
# plot6.R - Arnie Larson
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
# Compare emissions from motor vehicle sources in Baltimore City with
# emissions from motor vehicle sources in Los Angeles County, 

# Need to select motor vehicle emissions sources..
# after exploring SCC a little bit, determined that:
# - Search for "Mobile - On-Road" in SCC$IE.Sector seems best
mvs <- SCC[grepl("Mobile - On-Road",SCC$EI.Sector),"SCC"]

# Subset on Baltimore and LA (by fips) then by SCC
NEIs <- NEI[NEI$fips=='24510' | NEI$fips=="06037",]
NEImv <- NEIs[NEIs$SCC %in% mvs,]

# aggregate total Emissions by year 
NEImvb <- aggregate(Emissions ~ year, subset(NEImv,fips=="24510"), sum)
NEImvla <- aggregate(Emissions ~ year, subset(NEImv,fips=="06037"), sum)

# Issue is - aggregate emisson are vastly different, (roughly 10x) between
# the two cities.  Need to figure out how best to convey the two data 
# sets together.  Two plots?  Could put them on the same plot, (and aggregate
# them together with fips..

# now plot Emissions vs. Year, for each city (on the same graph)
png("plot6.png")
par(mfrow = c(2,1))
plot(Emissions ~ year, data=NEImvb, 
        main="Baltimore - Motor Vehicle Emissions, PM 2.5",
        ylab="(amount in tons)", 
        xaxp=c(1999,2008,3),
        col="red", type="l")
plot(Emissions ~ year, data=NEImvla, 
        main="LA - Motor Vehicle Emissions, PM 2.5",
        ylab="(amount in tons)", 
        xaxp=c(1999,2008,3),
        col="green", type="l")
dev.off()
    

# could add a linear trend line (not meaningful w/ 4 data points?)
# abline(lm(Emissions ~ year, data=em))

