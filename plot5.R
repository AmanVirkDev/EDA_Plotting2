library(ggplot2)

#read data from National Emissions Inventory rds file
NEI <- readRDS("./summarySCC_PM25.rds")

#read data from source code classification rds file
SRC<-readRDS("./Source_Classification_Code.rds")

#read source code for vehicles from sector information  
Vehicle <- grep("vehicle",SRC$EI.Sector,value=T,ignore.case=T)
SRC.Vehicle <- subset(SRC, SRC$EI.Sector %in% Vehicle, select=SCC)

#subset data for balitmore city
Baltimore <- subset(NEI,fips == "24510")

#Subset Baltimore data where source is from vehicles
Baltimore.vehicle <- subset(Baltimore, Baltimore$SCC %in%  SRC.Vehicle$SCC)

#Aggregate data from ploting by year and type
aggData<- aggregate(Baltimore.vehicle[c("Emissions")], list(year = Baltimore.vehicle$year), sum)

#Create Plot and direct the output to plot3.png
png('plot5.png', width=800, height=600)
p <- ggplot(aggData, aes(x=year, y=Emissions)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1, method="loess") +
  ggtitle(expression("Total Emissions "~ PM[2.5] ~" in Baltimore city from vehicles")) +
  labs(y=expression(PM[2.5] ~ "Emissions (tons)"), x="Year") +
  theme(panel.background=element_rect(fill='gray90',colour="grey0"))
print(p)

dev.off()