getwd()
setwd("C:/statistic//coursera_exploratory data analysis")

############ load data & read data in ############

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";")
unlink(temp)

########explore data########
head(data)

##########create workingset############
#create new variable 'DateTime'
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
class(data$DateTime)
data[,10] <- as.D

# convert date info in format 'dd/mm/yyyy'
# convert date info to class 'date'
data[, 1] <- as.Date(data[,1], "%d/%m/%Y")
class(data$Date)

#subset
ws <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"), select = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "DateTime"))

head(ws)

#plot4
#change column class to 'numeric'
class(ws$Voltage) # default: "factor"
ws[,3] <- as.numeric(as.character(ws[,3]))
ws[,4] <- as.numeric(as.character(ws[,4]))
ws[,5] <- as.numeric(as.character(ws[,5]))
ws[,8] <- as.numeric(as.character(ws[,8]))
ws[,9] <- as.numeric(as.character(ws[,9]))
ws[,7] <- as.numeric(as.character(ws[,7]))
ws[,8] <- as.numeric(as.character(ws[,8]))
ws[,9] <- as.numeric(as.character(ws[,9]))

##### plot ######
#create plot and save it to png file
#for plot in screen device, disable png file using "#" in front of first and last code line

png(file='plot4.png', width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4,4,2,1))
with(ws, {
  plot(ws$DateTime, ws$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
  plot(ws$DateTime, ws$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  plot(ws$DateTime, ws$Sub_metering_1, type = "n", xlab = "", ylab = "Enegery sub metering")
  points(ws$DateTime, ws$Sub_metering_1, col = "black", type = "l")
  points(ws$DateTime, ws$Sub_metering_2, col = "red", type = "l")
  points(ws$DateTime, ws$Sub_metering_3, col = "blue", type = "l")
  legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bg = "transparent", box.col = "transparent", cex = 0.95)
  plot(ws$DateTime, ws$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type ="l" )
})
dev.off()
