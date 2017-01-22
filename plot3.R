#Set directory to directory R script
directory<- dirname(sys.frame(1)$ofile)
setwd(directory)

#Download file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

#Select 
data <- read.table(unz(temp, "household_power_consumption.txt"), header= T, sep=";", dec =".", nrows = 2100000,
                   colClasses = c("character", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL"))

#Select lines to read in
index <-which(data$Date== "1/2/2007" | data$Date== "2/2/2007")
index<-c(index[1], index[length(index)])

#Read in lines from "1/2/2007" and "2/2/2007"
data <- read.table(unz(temp, "household_power_consumption.txt"), skip = index[1], sep=";", dec =".",
                   nrows=index[2]-index[1]+1, colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                                                 "numeric", "numeric", "numeric", "numeric"))

#Add names of original file
names(data)<- names(read.table(unz(temp, "household_power_consumption.txt"), header =T, sep=";", dec =".", nrows= 1))

#Remove temporary data
unlink(temp)

#Set default language to English
Sys.setenv(LANG = "en")

#Convert date and time columns
x<-strptime(paste(data$Date, data$Time),"%d/%m/%Y %H:%M:%S")

#Open png device
png(filename="plot3.png", width = 480, height = 480, units = "px")

#Set defaullt background to transparent
par(bg=NA)

#Create empty plot
plot(x, data$Sub_metering_1, type="n", xlab="\n", ylab="Energy sub metering")

#Add lines
lines(x, data$Sub_metering_1, col = "black")
lines(x, data$Sub_metering_2, col = "red")
lines(x, data$Sub_metering_3, col = "blue")

#Add legend
legend(x="topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd= 1)

#Switch off device
dev.off()