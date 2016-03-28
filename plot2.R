library(dplyr)
# read the lines that should contain the necessary days (according to a quick estimate)
dataset <- read.table(file = "household_power_consumption.txt", nrows = 6000, sep = ";", header = TRUE, comment.char ="", colClasses = "character", skip = 65000)
# read names
name <- read.table(file = "household_power_consumption.txt", nrows = 1, sep = ";")
# assign the read names to the names parameter of the dataset
names(dataset) <- as.vector(unlist(name))
# filter the two needed days
dataset <- filter(dataset, Date == "1/2/2007" | Date == "2/2/2007")
# add an NA entry for the first minute of 3 February, just to be able to display 
# the label Sat under the x-axis
dataset <- rbind(dataset, c("3/2/2007", "00:00:00", rep(NA, times = 7)))
# create a date/time in the POSIX.lt format
dataset$datetime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")


dataset$Global_active_power <- as.numeric(dataset$Global_active_power)
# some preparation
# positions of the two labels of the x-axis
lab2.pos = match("2/2/2007", dataset$Date)
lab3.pos = nrow(dataset)
# the labels themselves
x.labels = unique(format(dataset$datetime, "%a"))
# plot code
png(file = "plot2.png")
plot(dataset$Global_active_power, type ="l", axes = FALSE, xlab = "", 
     ylab = "Global Active Power (kilowatts)")
axis(1, at = c(1, lab2.pos, lab3.pos), x.labels)
axis(2)
box()
dev.off()