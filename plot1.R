## Load the dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv2(unz(temp,"household_power_consumption.txt"), header = TRUE, na.strings = "?", dec = ".")
unlink(temp) 

## Format the date and filter by desired days
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"))

## Select the png device with the desired name and size
png("plot1.png", width = 480, height = 480)
## Construct the histogram
with(data,hist(Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red"))
## Finally, close the device
dev.off()