## Load the dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv2(unz(temp,"household_power_consumption.txt"), header = TRUE, na.strings = "?", dec = ".")
unlink(temp)

## Format the date and filter by desired days
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"))
## Join Date and Time to get the timestamp
timestamp <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

## Select the png device with the desired name and size
png("plot3.png", width = 480, height = 480)
## Construct the plot
plot(timestamp,data$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
lines(timestamp,data$Sub_metering_2,col="red")
lines(timestamp,data$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col = c("black", "red", "blue"))
## Finally, close the device
dev.off()