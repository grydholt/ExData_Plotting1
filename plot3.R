Sys.setlocale(category = "LC_ALL", locale = "C") # make sure we get English day names
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

dataset <- read.csv2(filename, colClasses = c("myDate", "character", rep("numeric", 7)), na.strings = "?", dec = ".")
subset <- dataset[dataset$Date>="2007-02-01" & dataset$Date<"2007-02-03",]

subset$DateTime <- strptime(paste(subset$Date, " ", subset$Time), format = "%Y-%m-%d %H:%M:%S")

#Plot (default for png is 480x480)
png(filename = "plot3.png")
with(subset, plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type ="l"))
with(subset, lines(DateTime, Sub_metering_2, col="red"))
with(subset, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", col = c("black", "red", "blue"), lwd = c(1, 1, 1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.off()
