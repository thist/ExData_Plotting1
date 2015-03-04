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

# plot global active power vs. time
png('plot2.png',width = 480, height = 480)
plot(relevantData$Date_and_time, relevantData$Global_active_power, type = "n", ylab="Global Active Power (kilowatts)", xlab = "")
lines(relevantData$Date_and_time, relevantData$Global_active_power)
dev.off()

