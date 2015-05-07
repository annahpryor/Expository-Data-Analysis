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


##Remove original data from memory
##rm(powerdata)


png("plot2.png",width=480,height=480,res=72)
plot(powerdatasub$DateTime,as.integer(powerdatasub$Global_active_power)/500,type="l",ylab =
       "Global Active Power (Kilowtts)",xlab="")
      
dev.off()