download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
              , destfile = "./week1.zip")
unzip("./week1.zip", exdir = "./week1.txt")

EPdt <- read.table("./week1.txt/household_power_consumption.txt", header = TRUE, sep = ";")
library(dplyr)
february <- filter(EPdt, Date == "1/2/2007" | Date == "2/2/2007")
february <- transform(february, Global_active_power = as.numeric(february$Global_active_power), 
                      Sub_metering_1 = as.numeric(Sub_metering_1),
                      Sub_metering_2 = as.numeric(Sub_metering_2), 
                      Sub_metering_3 = as.numeric(Sub_metering_3))
february <- mutate(february, Datetime = paste(Date, Time, sep = " "))
february <- transform(february, Datetime = strptime(february$Datetime, "%d/%m/%Y %H:%M:%S"))

par(mfcol = c(2, 2))
plot(february$Datetime, february$Global_active_power, xlab = "", 
     ylab = "Global Active Power", type = "l")

with(february, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Enery sub metering")) 
with(february, lines(datetime, Sub_metering_2, type = "l", col = "red")) 
with(february, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, cex = 0.50)

plot(february$Datetime, february$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

plot(february$Datetime, february$Global_reactive_power, 
     xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

