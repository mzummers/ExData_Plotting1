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

## Plotting third graph (comparison in one graph)
## Use plot function old fashion style by plotting one line after another,
## add legend at the end.

with(power_data, {
        
        plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering") 
        lines(DateTime, Sub_metering_2, col="red")
        lines(DateTime, Sub_metering_3, col="blue")
        
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2",
        "Sub_metering_3"),lwd=1, col=c("black", "red", "blue"))
})

dev.copy(png, file = "plot3.png",width=480,height=480)
dev.off()

