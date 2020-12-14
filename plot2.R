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
png(filename = './figures/plot2.png', width = 480, height = 480, units='px')
# makes plot2
with(dataDateTime, plot(dataDateTime$Global_active_power~dataDateTime$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()