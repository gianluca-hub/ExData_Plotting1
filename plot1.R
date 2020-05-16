download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
              , destfile = "./week1.zip")
unzip("./week1.zip", exdir = "./week1.txt")

EPdt <- read.table("./week1.txt/household_power_consumption.txt", header = TRUE, sep = ";")
library(dplyr)
february <- filter(EPdt, Date == "1/2/2007" | Date == "2/2/2007")
february <- transform(february, Global_active_power = as.numeric(february$Global_active_power))

hist(february$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()