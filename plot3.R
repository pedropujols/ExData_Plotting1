# Read table
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
datacomplete <- data[complete.cases(data),]
dateTime <- paste(datacomplete$Date, datacomplete$Time)
dateTime <- setNames(dateTime, "DateTime")
dataTime <- datacomplete[ ,!(names(datacomplete) %in% c("Date","Time"))]
dataDateTime <- cbind(dateTime, dataTime)
if(!file.exists('figures')) dir.create('figures')
png(filename = './figures/plot3.png', width = 480, height = 480, units='px')
# makes plot3
with(dataDateTime, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()