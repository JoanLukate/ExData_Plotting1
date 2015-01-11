getwd()
setwd("C:/statistic//coursera_exploratory data analysis")

############load and read in data############

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";")
unlink(temp)

########explore data########
head(data)
summary(data$Date)

##########create workingset############
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

#Plot 2
##### data preparation #####
#change column class to 'numeric'
class(ws$Global_active_power)
ws[,3] <- as.numeric(as.character(ws[,3]))

##### plot ######
#create plot and save it to png file
#for plot in screen device, disable png file using "#" in front of first and last code line

png(file = "plot2.png", width = 480, height = 480, units = "px")
with(ws, plot(ws$DateTime, ws$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" ))
dev.off()