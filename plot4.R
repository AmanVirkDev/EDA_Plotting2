library(ggplot2)

#read data from National Emissions Inventory rds file
NEI <- readRDS("./summarySCC_PM25.rds")

#read data from source code classification rds file
SRC<-readRDS("./Source_Classification_Code.rds")

Coal <- grep("coal",SRC$EI.Sector,value=T,ignore.case=T)
SRC.Coal <- subset(SRC, SRC$EI.Sector %in% Coal, select=SCC)
NEI.Coal <- subset(NEI, NEI$SCC %in%  SRC.Coal$SCC)

#Aggregate data from ploting by year and type
aggData<- aggregate(NEI.Coal[c("Emissions")], list(year = NEI.Coal$year), sum)

#Create Plot and direct the output to plot3.png
png('plot4.png', width=800, height=600)
p <- ggplot(aggData, aes(x=year, y=Emissions)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1, method="loess") +
  ggtitle(expression("Total US Emissions "~ PM[2.5] ~" from coal combustion-related sources")) +
  labs(y=expression(PM[2.5] ~ "Emissions (tons)"), x="Year") +
  theme(panel.background=element_rect(fill='gray90',colour="grey0"))
print(p)

dev.off()