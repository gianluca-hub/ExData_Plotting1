download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
              , destfile = "./week1.zip")
unzip("./week1.zip", exdir = "./week1.txt")

EPdt <- read.table("./week1.txt/household_power_consumption.txt", header = TRUE, sep = ";")
library(dplyr)
february <- filter(EPdt, Date == "1/2/2007" | Date == "2/2/2007")
february <- transform(february, Global_active_power = as.numeric(february$Global_active_power)) 
february <- mutate(february, Datetime = paste(Date, Time, sep = " "))
february <- transform(february, Datetime = strptime(february$Datetime, "%d/%m/%Y %H:%M:%S"))

plot(february$Datetime, february$Global_active_power, xlab = "", 
     ylab = "Global Active Power (kilowatts)", type = "l")

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()