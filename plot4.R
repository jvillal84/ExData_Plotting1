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
png("plot4.png", width = 480, height = 480)
## Set the grid size to plot the four graphs
par(mfrow=c(2,2))
## 1st plot
plot(timestamp,data$Global_active_power, ylab = "Global Active Power (kilowatts)",xlab = "", type = "l")
## 2nd plot
plot(timestamp,data$Voltage, ylab = "Voltage",xlab = "datetime", type = "l")
## 3rd plot
plot(timestamp,data$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
lines(timestamp,data$Sub_metering_2,col="red")
lines(timestamp,data$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n", lty=1, col = c("black", "red", "blue"))
## 4th plot
plot(timestamp,data$Global_reactive_power, ylab = "Global_reactive_power",xlab = "datetime", type = "l")
## Finally, close the device
dev.off()