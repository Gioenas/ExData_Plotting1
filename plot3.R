#To avoid downloading and reading the entire database all the time I have to create a plot
#I wrote a file "Open_Dbase.R", with a function that will take as arguments the working
#directory and the filename, this function will write a csv file "sub_db.csv" as subset of the database selecting 
#only 2880 rows for the 2 days required

#the function "OpenDB(mydir = "", file = "household_power_consumption.txt") can be called
#with no arguments if the downloaded DB is in your working directory, if not the user has to 
#insert his own path directory.

library(tidyr)
library(lubridate)


#opening the subset dataframe
if(!file.exists("sub_db.csv")){
  source("Open_Dbase.R")
  sub_db <- OpenDB() #insert your path if different from working directory
}  else {read.csv("sub_db.csv", row.names = 1)}

#make a copy of the subset dataframe
df <- sub_db

#opening the graphic device png
png("plot3.png")

#parse a varable time which contains either time and date, to be used to make the plot
time <- parse_date_time(paste(df$Date,df$Time), "ymd_HMS", tz = "")

#plot the global active power against the time variable
plot(df$Sub_KWh_1 ~ time, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n")
axis(1, at = c(min(time), mean(time), max(time)), labels = c("Thu", "Fri", "Sat"))
#second plot
lines(df$Sub_KWh_2 ~ time, type = "l", col = "red")
#third plot
lines(df$Sub_KWh_3 ~ time, type = "l", col = "blue")

#adding labels
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
      col = c("black","red", "blue"), lwd = 2)

#remove the dataframe to save space
rm(df)

#close the device
dev.off()