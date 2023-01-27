#building the png file
png("plot1.png")
# histogram as shown in the instructions
hist(df$Global_act_pow, col= "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
# close the device
dev.off()