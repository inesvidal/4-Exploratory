## This script explores the National Emissions Inventory data to answer:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

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
# filter coal + combustion related codes
SCC$text <- paste(SCC$SCC.Level.One, SCC$SCC.Level.Two, 
                  SCC$SCC.Level.Three, SCC$SCC.Level.Four, 
                  sep = " ")
scc_index_vehicles <- grepl("vehicle", SCC$text, ignore.case = T)

scc_vehicles <- SCC[scc_index_vehicles ,]$SCC

# get levels for these particles
NEI_vehicles <- NEI[NEI$SCC %in% scc_vehicles, ]
NEI_vehicles_compare <- NEI_vehicles[NEI_vehicles$fips == "24510" | NEI_vehicles$fips == "06037", ]
data_vehicles_compare <- aggregate (Emissions ~ year + fips, 
                                    data = NEI_vehicles_compare, sum)

# Plot total emissions (tons) per year in Baltimore related to vehicles
plot_name <- "plot6.png"
png(filename = plot_name, width = 480, height = 480, units = "px", pointsize = 12)

library(ggplot2)
a <- ggplot(data = data_vehicles_compare, aes(x = year, y = Emissions, 
                                                color = fips)) + 
    geom_line() +  
    xlab("Year") + ylab("Emissions (Tons)") + 
    ggtitle("Evolution of Emissions related to vehicles \nin Baltimore (24510) & Los Angeles (06037)") 
print(a) 
dev.off();


