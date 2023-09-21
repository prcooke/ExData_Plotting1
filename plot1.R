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
## Open a png file
png(filename = "./ExData_Plotting1/plot1.png", width = 480, height = 480)
## Make the histogram
hist(feb07pwr$Global_active_power, col = "red", 
     xlab = "Global_active_power (kilowatts)", ylab = "Frquency", main = "Global Active Power")
dev.off()
