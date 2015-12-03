# Assignment 2 for Exploratory dAta Analysis course

# https://class.coursera.org/exdata-033
 
This assignment uses a dataset from the EPA National Emissions Inventory,
     with pollutants, emissions, sources, year..  There is a Source code,
     which is available in a second dataset.  The data is unzipped into two rds
     files.

Data for Peer Assessment is clean and can be read in with:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

The goal for this assignment is to answer the questions:
- have total emissions for PM2.5 decreased?
- have total emissions for PM2.5 decreased in Baltimore?
- of the types of emissions, which have decreased or increased for Baltimore?
- accross the US, how have emissions changed for Coal Combustion related sources?
- motor vehicle sources (MVS) in Baltimore?
- Compare emissions from MVS in Baltimore and Los Angelas.

Fips for Baltimore is 24510, and fips for LA is 06037

Notes on the Data:
NEI - 6.5M rows, this is an object ~ 425 Mb
SCC - 11k rows, 3Mb, source codes provide more information on data in NEI 

Initial comments after exploring the data
NEI - all data has NEI$Pollutant of "PM25-PRI"
NEI - appears to be no NA (sum(is.na(NEI$*)) is 0 
No neagtive emissions values :  sum(NEI$Emissions<0)
Can create a table to look at number of observations:
NEI - 4 Years 99, 02, 05, 08 w/ 1108469 1698677 1713850 1976655 obs respectively
    - aggregate(Emissions ~ Year, NEI, sum) # simply aggregate
NEI - table(NEI$SCC, NEI$year) shows that a given SCC is not necessarily 
        measured consistently year to year.. e.g. this is a sparse matrix.  
        Not sure how to interpret that..
        
NEI$Emissions is the primary variable of interest
Summary, shows that Emissions:  
    min:    0.0
    1st:    0.0
    median: 0.0
    mean:   3.4
    3rd:    0.1
    max:    646952

So this is a super left skewed distribution - making it somewhat interesting
to analyze.. probably a power law dist.
In fact, if you look at density of pretty much any slice of the data, you
notice that yes, it looks very power law like.

e.g. explore the density plots:
plot(density(NEI[NEI$Emisions>1000,"Emissions"]))
plot(density(NEI[NEI$Emisions>10 & NEI$Emisions<100,"Emissions"]))
plot(density(NEI[NEI$Emisions<10"Emissions"]))

Skewness
> sum(NEI$Emissions > 100)
    [1] 35726
> sum(oNEI$Emissions>1000)
    [1] 2671
> sum(oNEI$Emissions>10000)
    [1] 37

The skew arrises from only a handful of Source Codes, 
> unique(oNEI[oNEI$Emissions>5000,"SCC"])
yields 25 values, w/ the largest outliers coming from forest fires..
> SCC[SCC$SCC %in% unique(oNEI[oNEI$Emissions>10000,"SCC"]),"Short.Name"]
[1] Ext Comb /Electric Gen /Bituminous Coal /Pulverized Coal: Dry Bottom
[2] Ext Comb /Industrial /Bagasse /All Boiler Sizes                     
[3] Marine Vessels, Commercial /Residual /Underway emissions            
[4] Forest Wildfires - Wildfires - Unspecified                          
[5] Prescribed Forest Burning /Unspecified                              
[6] Open Fire /Not categorized 

I outputed the largest Emissions (>1000 tons) to a file, large-emissions.csv
Pretty interesting.

Answering the first few questions, just aggregating and plotting.
1. Trend in total US emissions per year
2. Trend toal emissions per year, for Baltimore
3. Trend in total emissions, in Baltimore vs. Type
    Note - the POINT source, has some large values for 2005, 
    but the majority of the density may still be going down.
    Can look at the density of POINT type vs. year (w/ a boxplot)
    and dig into the possible outliers:
    30599999, 30201599, 30201599, 10200602
4. Trend in emissions due to "coal combustion related sources"
    Needed to determine, from SCC which sources match this.
5. Trend in emissions due to motor vehicle sources in Baltimore?
    SCC$EI.Sector starts with "Mobile - On Road" is pretty inclusive, gets on
    road diesel|gasoline light|heavy duty vehicles.  
    SCC$SCC.Level.One with "Mobile Sources" is more inclusive, but also
    includes dust, locomotives, aircraft, marine vessels
    Did a few versions of this plot:
    2 side by side w/ base - (autofit on y axis is better)
    2 side by side w/ ggplot, and lm trend lines..
    on same graph in base



