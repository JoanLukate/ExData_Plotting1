getwd()
setwd("C:/statistic//coursera_exploratory data analysis")

############load and read in data############

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";")
unlink(temp)

##### explore data ######
head(data)
summary(data$Date)

##### create workingset ######
#create new variable 'DateTime'
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
class(data$DateTime)
data[,10] <- as.D

#convert date info to class 'date' in format 'dd/mm/yyyy'
data[, 1] <- as.Date(data[,1], "%d/%m/%Y")
class(data$Date)

#subset
ws <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"), select = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "DateTime"))

head(ws)

#plot3
###### data preparation######
class(ws$Sub_metering_1) # deafult "factor"
#change column class to 'numeric'
ws[,7] <- as.numeric(as.character(ws[,7]))
ws[,8] <- as.numeric(as.character(ws[,8]))
ws[,9] <- as.numeric(as.character(ws[,9]))

##### plot ######
#create plot and save it to png file
#for plot in screen device, disable png file using "#" in front of first and last code line

png(file = "plot3.png", width = 480, height = 480, units = "px")
plot(ws$DateTime, ws$Sub_metering_1, type = "n", xlab = "", ylab = "Enegery sub metering")
points(ws$DateTime, ws$Sub_metering_1, col = "black", type = "l")
points(ws$DateTime, ws$Sub_metering_2, col = "red", type = "l")
points(ws$DateTime, ws$Sub_metering_3, col = "blue", type = "l")
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
