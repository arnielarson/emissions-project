
# emissions.R - Arnie Larson
#
# for Coursera Exploratory Analysis Course: 
# https://class.coursera.org/exdata-033
#
# Analysis code for part 2.
#

# Load databases if objects not found
NEIfilename <- "../data/summarySCC_PM25.rds"
SCCfilename <- "../data/Source_Classification_Code.rds"
if ( !exists("NEI") & file.exists(NEIfilename) ) {
    assign("NEI",NEIfilename, envir=.GlobalEnv)
}
if ( !exists("SCC") & file.exists(SCCfilename) ) {
    assign("SCC",readRDS(SCCfilename), envir=.GlobalEnv)
}



# load NEI and SCC database 
load <- function(force=FALSE){
    if (force | !exists("NEI")) {
        assign("NEI","summarySCC_PM25.rds", envir=.GlobalEnv)
    }
    if (force | !exists("SCC")) {
        assign("SCC",readRDS("Source_Classification_Code.rds"), envir=.GlobalEnv)
    }
}


