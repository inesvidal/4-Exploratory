## This script loads the National Emissions Inventory data for further exploration

read_data <- function() {
    
    # variable initialisation
    zipfile = "./exdata-data-NEI_data.zip"
    nei_file = "./summarySCC_PM25.rds"
    scc_file = "./Source_Classification_Code.rds"
    
    # set working directory
    setwd("/Users/inesv/Coursera/4-Exploratory/w3")
    
    # unzip if required
    if(!(file.exists(nei_file) && file.exists(scc_file))) {
        unzip (zipfile, exdir = "./", junkpaths = TRUE)
    }
    
    # load data, if not done yet
    if(!(exists("NEI") && exists("SCC"))){
        NEI <- readRDS(nei_file)
        SCC <- readRDS(scc_file)
    }
    
}