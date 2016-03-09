## This script explores the National Emissions Inventory data to answer:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# using base plot system

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
data <- aggregate (Emissions ~ year, data = NEI, sum)

# Plot total emissions (tons) per year
plot_name <- "plot1.png"
png(filename = plot_name, width = 480, height = 480, units = "px", pointsize = 12)

plot(x= data$year, y=data$Emissions, type ="l", xlab="year", ylab="Emissions (Tons)")
title(main = "Evolution of Emissions")

dev.off();