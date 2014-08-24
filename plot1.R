
#read National Emissions Inventory data from rds file
NEI <- readRDS("./summarySCC_PM25.rds")

#summarized data Emissions value by year
PM25ByYear <- tapply(NEI$Emissions, NEI$year, sum)

#Convert emissions value to thousand tons
PM25ByYear<-PM25ByYear/1000

#direct output to png file
png("plot1.png",width=800,height=600)

#plot Emissions by year to view the trend
plot(names(PM25ByYear), PM25ByYear, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (thousand tons)"),
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()