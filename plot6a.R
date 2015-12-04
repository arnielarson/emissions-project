#
# plot6a.R - Arnie Larson
# Uses ggplot to compare motor vehicle emission trends for 
# Baltimore and LA
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

# Add Seattle King County:  53033
# Add Washington DC: 11001
# Subset on Baltimore and LA (by fips) then by SCC
NEIs <- NEI[NEI$fips=='24510' | NEI$fips=='11001' | 
    NEI$fips=='53033' | NEI$fips=="06037",]
NEImv <- NEIs[NEIs$SCC %in% mvs,]

# aggregate total Emissions by year 
NEImva <- aggregate(Emissions ~ year + fips, NEImv, sum)

# Just playing around with ggplot - this is a pretty cool (and fast) 
# representation of the Baltimore and LA data, side by side, w/ trendline
q<-qplot(year,Emissions , data=NEImva, 
    facets=.~fips, 
    geom=c("point","smooth"), # add a trendline, use points
    method="lm",
    ylab="Emissions (amount in tons)",
    main="PM2.5 Motor Vehicle Emissions") 
#q <- q + stat_smooth(method="lm")
print(q)
ggsave("plot6gg.png")

