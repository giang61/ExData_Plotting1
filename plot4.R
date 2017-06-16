# under Cygwin
# grep -e "^1/2/2007" house* > foo1.txt
# grep -e "^2/2/2007" house* > foo2.txt
# cat foo1.txt foo2.txt > foo.txt

data <- read.table ("foo.txt", sep=";")
colnames(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data$Date_Time <- with(data, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
data <- subset(data, select=Global_active_power:Date_Time)
data <- data[c(8,1:7)]



png(filename="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), cex=0.75)
with(data,plot(Date_Time,Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)"))
with(data,plot(Date_Time,Voltage,type="l", ylab="Voltage"))
with(data,plot(Date_Time,Sub_metering_1,type="l", col="black", xlab="", ylab="Energy Sub Metering"))
with(data, lines(Date_Time,Sub_metering_2, col="red"))
with(data, lines(Date_Time,Sub_metering_3, col="blue"))
legend("topright", cex=0.50, lty=1, col=c("black","red","blue"), legend=c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3") )
with(data,plot(Date_Time,Global_reactive_power,type="l"))
dev.off()