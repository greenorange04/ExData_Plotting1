library(dplyr)
# read the lines that should contain the necessary days (according to a quick estimate)
dataset <- read.table(file = "household_power_consumption.txt", nrows = 6000, sep = ";", header = TRUE, comment.char ="", colClasses = "character", skip = 65000)
# read names
name <- read.table(file = "household_power_consumption.txt", nrows = 1, sep = ";")
# assign the read names to the names parameter of the dataset
names(dataset) <- as.vector(unlist(name))
# filter the two needed days
dataset <- filter(dataset, Date == "1/2/2007" | Date == "2/2/2007")
# create a date/time in the POSIX.lt format
dataset$datetime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")

dataset$Global_active_power <- as.numeric(dataset$Global_active_power)
# histogram code
png(file = "plot1.png")
hist(dataset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()