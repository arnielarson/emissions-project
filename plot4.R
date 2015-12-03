#
# plot4.R - Arnie Larson
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
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

# Need to select coal sources..
# after exploring SCC a little bit, determined that:
# - Search for "Coal" in SCC$Short.Name
# - Search for "Comb" in SCC$EI.Sector OR "Combustion" in SCC$SCC.Level.One
# yields a few SCC's for EI.Sector Fuel Comb - * - Other, which have coal in
# the Short.Name
coalSCCs <- SCC[grepl("Coal",SCC$Short.Name),]
coalSCCs <- coalSCCs[grepl("Combustion",coalSCCs$SCC.Level.One),"SCC"]

# Subset the NEI data then aggregate on year
coalNEI <- NEI[NEI$SCC %in% coalSCCs,]
yearlyCoal <- aggregate(Emissions ~ year, data=coalNEI, sum)

# plot Emissions vs. Year, for each type..
png("plot4.png")
par(mfrow = c(1,1))
plot(Emissions ~ year, data=yearlyCoal, 
    main="PM2.5 Emissions from Coal Combustion", 
    ylab="Emissions (amount in tons)", 
    xaxp=c(1999,2008,3))
dev.off()



