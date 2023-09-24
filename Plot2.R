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
## I tried so many things with the Date and Time columns, pasted them together, removed the axes,
## changed the classes a ton of different ways. This is the only way I could get the x-axis correct
feb07pwr$index <- 1:2880
## Open a png file
png(filename = "./ExData_Plotting1/plot2.png", width = 480, height = 480)
## Make the plot
plot(y = feb07pwr$Global_active_power, x = feb07pwr$index, type = "l", xaxt = "n", xlab = NA, ylab = "Global Active Power(kilowatts)")
axis(side = 1, at =c(1, 1400, 2880), labels = c("Thu", "Fri", "Sat"))
dev.off()