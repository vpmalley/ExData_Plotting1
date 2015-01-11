
download <- function() {
  # downloading, unzipping files
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_consumption.zip", method = "curl");
  unzip("exdata_data_household_power_consumption.zip");
}

loadData <- function() {
  # loading the file in R
  t <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?");
  # subsetting the data to keep only the data for the 2 first days of February
  february <- t[t$Date=="1/2/2007" | t$Date=="2/2/2007",];
  # formatting date and time as Date
  febDate <- as.character(levels(february$Date))[february$Date];
  febTime <- as.character(levels(february$Time))[february$Time];
  february$DateTime <- strptime(paste(february$Date, febTime), "%d/%m/%Y %H:%M:%S");
  
}

plot4 <- function() {
  library(datasets);
  png(file = "plot4.png", width = 480, height = 480, units = "px");
  par(mfrow = c(2,2))
  with(february,
  {
  # reproduction of plot2, Global Active Power across time
  plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power", pch = "." )
  lines(DateTime, Global_active_power)
  
  # Voltage across time
  plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", pch = "." )
  lines(DateTime, Voltage)
  
  # reproduction of plot3, Energy sub metering across time
  plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", pch = "." )
  lines(DateTime, Sub_metering_1)
  lines(DateTime, Sub_metering_2, col = "red")
  lines(DateTime, Sub_metering_3, col = "blue")
  legend("topright", lty = par("lty"), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  
  
  # Global reactive power across time
  plot(DateTime, Global_reactive_power, xlab = "datetime", pch = "." )
  lines(DateTime, Global_reactive_power, col = "black")
  
  });
  dev.off();
}
