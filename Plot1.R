## PLOT1.R Details

##Plot1.R reads the "Individual household electric power consumption Data Set" available from the UC Irvine Machine Learning Repository, and produces a histogram of the frequency of Global Active Power consumption in kilowatts for the dates February 1 and 2, 2007. 

##PLOT1.R LOGIC

##1 call the function plot1("household_power_consumption.txt") which starts the function. 
##2 the file is read into R and assigned to the power variable 
##3 the date column is reformatted as recommended in the assignment instructions
##4 the two days of interest are subsetted out of the power data frame and assigned to new data frame named "df"
##5 the Global_active_power col is reformatted as a numeric vector
##6 histogram is generated with the title "Global Active Power", red columns, and an x-axis label of "Global Active Power (kilowatts)"
##7 file is saved as "plot1.png"
##8 dev is closed
##9 a statement is printed to let know where the file has been saved

plot1 <- function(file) {
  
  power <- read.table(file, header=T, sep=";")
  power$Date <- as.Date(power$Date, format="%d/%m/%Y")
  
  df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
  
  df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
  
  hist(df$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("Plot1.png is saved in", getwd())
}

#main program

if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
plot1("household_power_consumption.txt")