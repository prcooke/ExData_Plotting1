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
png(filename = "./ExData_Plotting1/plot3.png", width = 480, height = 480)
## Make a graph with the x axis as the index from above and the y axis as the first variable
plot(Sub_metering_1 ~ index, data = feb07pwr, xaxt = "n", type = "l", 
     ylab = "Energy sub metering", xlab = NA, col = "black")
## Add the other variable
lines(Sub_metering_2 ~ index, data = feb07pwr, col = "red")
lines(Sub_metering_3 ~ index, data = feb07pwr, col = "blue")
## Specify the x-axis
axis(side = 1, at =c(1, 1400, 2880), labels = c("Thu", "Fri", "Sat"))
## Add a legend
legend("topright", col = c("black", "red", "blue"), pch = "-", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
