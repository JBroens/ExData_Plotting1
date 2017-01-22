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

#Set defaullt background to transparent
par(bg="gray")

#Open png device
png(filename="plot1.png", width = 480, height = 480, units = "px")

#Set defaullt background to transparent
par(bg=NA)

#Create plot
hist(data$Global_active_power, main = "Global Active Power", xlab ="Global Active Power (kilowatts)", 
     col = "Red")

#Switch off device
dev.off()