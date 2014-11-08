setwd("~/GitHub/ExData_Plotting1")
downloadurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "data/household_power_consumption.txt"

if(!file.exists(filename)) {
        temp <- tempfile()
        download.file(url = downloadurl, destfile = temp)
        unzip(temp, exdir="data")
        unlink(temp)
        if (!file.exists(filename)) {
                stop("Couldn't get the data");
        }
}
setClass('myDate')
setAs("character", "myDate", function(from) as.Date(from, format="%d/%m/%Y"))
setClass('myTime')
setAs("character", "myTime", function(from) strptime(from, format="%H:%M:%S"))

dataset <- read.csv2(filename, colClasses = c("myDate", "character", rep("numeric", 7)), na.strings = "?", dec = ".")
subset <- dataset[dataset$Date>="2007-02-01" & dataset$Date<"2007-02-03",]

subset$DateTime <- strptime(paste(subset$Date, " ", subset$Time), format = "%Y-%m-%d %H:%M:%S")

hist(subset$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")