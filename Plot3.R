## PLOT3.R Details

##Reads the "Individual household electric power consumption Data Set" available from the UC Irvine Machine Learning Repository, and produces one line graph of three sub metering levels for the dates February 1 and 2, 2007. 

##PLOT 3 Logic

##1 plot2("household_power_consumption.txt") starts the function 
##2 the file is read into R and assigned to the power data frame 
##3 the date column is reformatted as recommended in the assignment instructions
##4 the two days of interest are subsetted out of the power data frame and assigned to new data frame named "df"
##5 the Sub_metering cols are reformatted as numeric vectors
##6 the time column is reformatted as a value replacement of the Time field
##7 plot is generated with df$Time on x-axis and sub metering levels on y-axis. Default x-axis label is removed. Y-axis label is specified. Legend is added with to the top right with line colors and variable names. 
##8 png is generated as a 480 pixel by 480 pixel image. Its saved as "plot3.png". 
##9 statement is printed to let you know where the file has been successfully saved

plot3 <- function(file) {
  power <- read.table(file, header=T, sep=";")
  power$Date <- as.Date(power$Date, format="%d/%m/%Y")
  df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
  
  df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
  df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
  df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
  
  df$Time <- strptime(df$Time, format="%H:%M:%S")
  df[1:1440,"Time"] <- format(df[1:1440,"Time"],"2007-02-01 %H:%M:%S")
  df[1441:2880,"Time"] <- format(df[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

  plot(df$Time,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(df$Time,df$Sub_metering_2,col="red")
  lines(df$Time,df$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
  title(main="Energy sub-metering")
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
  cat("plot3.png is saved in", getwd())
}
#main program

if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
plot3("household_power_consumption.txt")
