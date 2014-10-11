# Read the file
data <- fread("household_power_consumption.txt", na.strings=c("?"))

# Convert Date from character to date
data$Date <- as.Date(data$Date,"%d/%m/%Y")

# Filter by dates (2 days range)
data <- data[data$Date >= '2007-02-01' & data$Date <= '2007-02-02',]

# Convert columns from character to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Create a nuew column with DateTime
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "),tz = "GMT")

# Create the PNG file
# I tried "bg = NA" for a transparent backgroung
# but it does not work very well, bad cuality
png("plot4.png", width = 480, height = 480) 

# Create Plot
par(mfrow = c(2, 2))

# Plot 1
plot(data$Global_active_power ~ data$DateTime, type="n", xlab="", ylab="Global Active Power")
lines(Global_active_power ~ DateTime, data)

# Plot 2
plot(data$Voltage ~ data$DateTime, type="n", xlab="datetime", ylab="Voltage")
lines(Voltage ~ DateTime, data)

# Draw lines
plot(data$Sub_metering_1 ~ data$DateTime, type="n", xlab="", ylab="Energy sub metering", ylim=range(0,data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3))
lines(Sub_metering_1 ~ DateTime, data, col="black")
lines(Sub_metering_2 ~ DateTime, data, col="red")
lines(Sub_metering_3 ~ DateTime, data, col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), bty = "n")

# Plot 4
plot(data$Global_reactive_power ~ data$DateTime, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(Global_reactive_power ~ DateTime, data)

# Finish and save the PNG
dev.off()

# Clean up
rm(data)