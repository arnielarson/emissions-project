#
# plot5.R - Arnie Larson
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
# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

# Need to select motor vehicle emissions sources..
# after exploring SCC a little bit, determined that:
# - Search for "Mobile - On-Road" in SCC$IE.Sector seems best
mvs <- SCC[grepl("Mobile - On-Road",SCC$EI.Sector),"SCC"]

# Subset on Baltimore (by fips) then by SCC
NEIbaltimore <- NEI[NEI$fips=='24510',]
NEImvb <- NEIbaltimore[NEIbaltimore$SCC %in% mvs,]


# aggregate total Emissions by year 
NEImvbem <- aggregate(Emissions ~ year, NEImvb, sum)

# now plot Emissions vs. Year
png("plot5.png")
par(mfrow = c(1,1))
plot(Emissions ~ year, data=NEImvbem, 
        main="Balitmore Motor Vehicle Emissions",
        ylab="PM 2.5 Emissions (amount in tons)", 
        xaxp=c(1999,2008,3))
dev.off()
    

# could add a linear trend line (not meaningful w/ 4 data points?)
# abline(lm(Emissions ~ year, data=em))

