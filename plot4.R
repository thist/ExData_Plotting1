# read data from file (assumes data file is in working directory)
powerData <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# convert date column
library(lubridate)
powerData$Date <- dmy(powerData$Date)

# exctract data for 2007-02-01 and 2007-02-02
library(dplyr)
relevantData <- filter(powerData, Date == ymd("2007-02-01") | Date == ymd("2007-02-02") )
relevantData$Date_and_time <- relevantData$Date + hms(relevantData$Time)

# load base libary
library(base)

# init multi-plot
png('plot4.png',width = 480, height = 480)
par(mfrow = c(2,2)) 

# plot 1: global active power vs. time
plot(relevantData$Date_and_time, relevantData$Global_active_power, type = "n", ylab="Global Active Power", xlab = "")
lines(relevantData$Date_and_time, relevantData$Global_active_power)

# plot 2: voltage vs. time
plot(relevantData$Date_and_time, relevantData$Voltage, type = "n", ylab="Voltage", xlab = "datetime")
lines(relevantData$Date_and_time, relevantData$Voltage)



# plot 3: data for sub-meters vs. time
plot(relevantData$Date_and_time, relevantData$Sub_metering_1, type = "n", ylab="Energy sub metering", xlab = "")
lines(relevantData$Date_and_time, relevantData$Sub_metering_1, col = "black")
lines(relevantData$Date_and_time, relevantData$Sub_metering_2, col = "red")
lines(relevantData$Date_and_time, relevantData$Sub_metering_3, col = "blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black", "red","blue"),bty = "n") 

# plot 4: global reactive power vs. time
plot(relevantData$Date_and_time, relevantData$Global_reactive_power, type = "n", ylab="Global_reactive_power", xlab = "datetime")
lines(relevantData$Date_and_time, relevantData$Global_reactive_power)

dev.off()



