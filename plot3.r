library(ggplot2)

#read data from National Emissions Inventory rds file
NEI <- readRDS("./summarySCC_PM25.rds")

#Subset data from NEI dataset for Baltimore City, Maryland with fips="24510"
BaltimoreCity<- subset(NEI, fips == "24510")

#Aggregate data from ploting by year and type
aggBaltimoreCity<- aggregate(BaltimoreCity[c("Emissions")], list(type=BaltimoreCity$type,year = BaltimoreCity$year), sum)

#Create Plot and direct the output to plot3.png
png('plot3.png', width=800, height=600)
p <- ggplot(aggBaltimoreCity, aes(x=year, y=Emissions, colour=type)) +
     geom_point(alpha=.3) +
     geom_smooth(alpha=.2, size=1, method="loess") +
     ggtitle(expression("Total Emissions "~ PM[2.5] ~" by Type in Baltimore City")) +
     labs(y=expression(PM[2.5] ~ "Emissions (tons)"), x="Year") +
     theme(panel.background=element_rect(fill='gray90',colour="grey0"))
print(p)

dev.off()