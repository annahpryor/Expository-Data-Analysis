fileURL = "household_power_consumption.txt"
powerdata = read.table(fileURL,sep=";",header=TRUE)

#Use the lubridate package to reformat the date column
##install.packages("lubridate")
library(lubridate)
powerdata$Date = dmy(powerdata$Date)


##Just get the dates: 2007-02-01 and 2007-02-02
powerdatasub = powerdata[(powerdata$Date == ymd(20070201) 
                          | powerdata$Date == ymd(20070202)),]

##Remove original data from memory
##rm(powerdata)

##Plot the histogram

png("plot1.png",width=480,height=480,res=72)
hist(as.numeric(powerdatasub$Global_active_power)/500,
     xlab="Global Active Power (kilowatts)", 
     main = "Global Active Power", col="red")
dev.off()