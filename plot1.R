# read data from file (assumes data file is in working directory)
powerData <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# convert date column
library(lubridate)
powerData$Date <- dmy(powerData$Date)

# exctract data for 2007-02-01 and 2007-02-02
library(dplyr)
relevantData <- filter(powerData, Date == ymd("2007-02-01") | Date == ymd("2007-02-02") )

# load base libary
library(base)

# plot histogram of global active power for two days
png('plot1.png',width = 480, height = 480)
hist(relevantData$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()

