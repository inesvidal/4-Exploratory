## This script explores the National Emissions Inventory data to answer:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

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
scc_index1 <- grepl("coal", SCC$text, ignore.case = T)
scc_index2 <- grepl("comb", SCC$text, ignore.case = T)

scc_coal <- SCC[scc_index1 & scc_index2,]$SCC

# get levels for these particles
NEI_coal <- NEI[NEI$SCC %in% scc_coal, ]
data_coal <- aggregate (Emissions ~ year, data = NEI_coal, sum)

# Plot total emissions (tons) per year 
plot_name <- "plot4.png"
png(filename = plot_name, width = 480, height = 480, units = "px", pointsize = 12)

library(ggplot2)
a <- ggplot(data = data_coal, aes(x = year, y = Emissions)) + 
    geom_line() +  
    xlab("Year") + ylab("Emissions (Tons)") + 
    ggtitle("Evolution of Emissions of coal combustion") 
print(a) 
dev.off();


