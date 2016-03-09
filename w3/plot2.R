## This script explores the National Emissions Inventory data to answer:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? 

#### load data
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
#### Prepare data
NEI_baltimore <- NEI[NEI$fips == "24510", ]
data_baltimore <- aggregate (Emissions ~ year, data = NEI_baltimore, sum)

# Plot total emissions (tons) per year in Baltimore
plot_name <- "plot2.png"
png(filename = plot_name, width = 480, height = 480, units = "px", pointsize = 12)

plot(x= data_baltimore$year, y=data_baltimore$Emissions, type ="l", 
     xlab="year", ylab="Emissions (Tons)")
title(main = "Evolution of Emissions in Baltimore")

dev.off();


