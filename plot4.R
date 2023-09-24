## Required packages
library(data.table)
library(dplyr)
library(lubridate)
## Download file into data folder. Make sure you have a data folder in your working directory
download.file(
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
    destfile = "./data/UCI_electric_power_consumption.zip")
unzip(zipfile = "./data/UCI_electric_power_consumption.zip", 
      exdir = "./data/UCI_electric_power_consumption")
## Read in the data, specifying "?" as NA
housepwr <- data.table::fread("./data/UCI_electric_power_consumption/household_power_consumption.txt", 
                              na.strings = "?")
## Change the Date class
housepwr$Date <- dmy(housepwr$Date)
## Subset out the two days of interest
feb07pwr <- housepwr[housepwr$Date >= "2007-02-01" & housepwr$Date <= "2007-02-02", ]
## Create an numeric index the length of the data table to plot against
feb07pwr$index <- 1:2880
## Open a png file
png(filename = "./ExData_Plotting1/plot4.png", width = 480, height = 480)
## Specify format
par(mfcol = c(2, 2))
## Plot 1:
plot(y = feb07pwr$Global_active_power, x = feb07pwr$index, type = "l", xaxt = "n", xlab = NA, ylab = "Global Active Power(kilowatts)")
axis(side = 1, at =c(1, 1400, 2880), labels = c("Thu", "Fri", "Sat"))
## Plot 2:
plot(Sub_metering_1 ~ index, data = feb07pwr, xaxt = "n", type = "l", ylab = "Energy sub metering", xlab = NA, col = "black")
lines(Sub_metering_2 ~ index, data = feb07pwr, col = "red")
lines(Sub_metering_3 ~ index, data = feb07pwr, col = "blue")
axis(side = 1, at =c(1, 1400, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", col = c("black", "red", "blue"), pch = "-", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Plot 3:
plot(y = feb07pwr$Voltage, x = feb07pwr$index, type = "l", xaxt = "n", xlab = "datetime", ylab = "Voltage")
axis(side = 1, at =c(1, 1400, 2880), labels = c("Thu", "Fri", "Sat"))
## Plot 4:
plot(y = feb07pwr$Global_reactive_power, x = feb07pwr$index, type = "l", xaxt = "n", xlab = "datetime", ylab = "Global_reactive_power")
axis(side = 1, at =c(1, 1400, 2880), labels = c("Thu", "Fri", "Sat"))
dev.off()