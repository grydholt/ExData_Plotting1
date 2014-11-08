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

# Plot
par(fg="black")
plot(subset$DateTime, subset$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type ="l")
legend("topright", col = c("black", "red", "blue"), lwd = c(1, 1, 1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

par(fg="red")
lines(subset$DateTime, subset$Sub_metering_2)
par(fg="blue")
lines(subset$DateTime, subset$Sub_metering_3)
