fileURL = "household_power_consumption.txt"
powerdata = read.table(fileURL,sep=";",header=TRUE)

#Use the lubridate package to reformat the date column
##install.packages("lubridate")
library(lubridate)
powerdata$Date = dmy(powerdata$Date)

##Paste date and time into 
powerdata$DateTime = paste(powerdata$Date,powerdata$Time)


##Just get the dates: 2007-02-01 and 2007-02-02
powerdatasub = powerdata[(powerdata$Date == ymd(20070201) 
                          | powerdata$Date == ymd(20070202)),]
temp = format(powerdatasub$DateTime,format="%d/%m/%Y %H %m %s")
powerdatasub$DateTime = strptime(temp,"%Y-%m-%d %H:%M:%S")


png("plot3.png",width=480,height=480,res=72)
plot(powerdatasub$DateTime,as.integer(powerdatasub$Sub_metering_1),type="l",ylab =
       "Energy Sub metering",xlab="",yaxt="n")
lines(powerdatasub$DateTime,as.integer(powerdatasub$Sub_metering_2)/8,col="red")
lines(powerdatasub$DateTime,as.integer(powerdatasub$Sub_metering_3),col="blue")

legend("topright",col=c("black","red","blue"),
       legend = c("Sub_metering_1",
       "Sub_metering_2","Sub_metering_3"),lwd=1,cex=.85)
ticks = c(0,10,20,30)
axis(side=2, at = ticks)
dev.off()