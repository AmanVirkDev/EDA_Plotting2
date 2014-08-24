
#read data from National Emissions Inventory rds file
NEI <- readRDS("./summarySCC_PM25.rds")

#Subset data from NEI dataset for Baltimore City, Maryland with fips="24510"
BaltimoreCity<- subset(NEI, fips == "24510")

#Aggregate data from ploting
aggBaltimoreCity<- aggregate(BaltimoreCity[c("Emissions")], list(year = BaltimoreCity$year), sum)

# Create Plot to show the trend of emissions by year for Baltimore City
# Direct the output to plot2.png file 
png('plot2.png', width=800, height=600)
plot(aggBaltimoreCity$year, aggBaltimoreCity$Emissions, type = "l", 
     main = expression("Total Emissions from "~PM[2.5]~" in Baltimore City"),
     xlab = "Year", ylab=expression(PM[2.5] ~ "Emissions (tons)"))
dev.off()