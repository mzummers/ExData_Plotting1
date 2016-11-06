library(dplyr)

myDir <- "~/_R/Class4_ExploratoryDataAnalysis"
setwd(myDir)

## Reading Data
power_data = read.table("household_power_consumption.txt", header = TRUE, sep=";"
        ,na.strings="?", stringsAsFactors = FALSE)

## Format Date Column
power_data$DateFormatted  <- as.Date(power_data$Date, format="%d/%m/%Y")

## Subset Power_Data
power_data <- subset(power_data, "2007-02-01" <= DateFormatted & DateFormatted <= "2007-02-02")

## Combine date and time into one column, might be required for plotting data in 
## descending order 
power_data$DateTime <- strptime(paste(power_data$Date, power_data$Time), 
                         format="%d/%m/%Y %H:%M:%S")
power_data$DateTime <- as.POSIXct(power_data$DateTime)
power_data <- power_data[order(power_data$DateTime),]

## Plotting first graph (historgram)

with(power_data, hist(Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red"))
     
dev.copy(png, file = "plot1.png",width=480,height=480)
dev.off()


