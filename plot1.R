#To save time I will describe the procedure I used to subset the database for the 2 days required
#the reason I will not implement again in this script is for saving time and memory space
#First of all I've downloaded the full database opened and assigned to the variable DB

#Later I wrote a file "Open_Dbase.R", with a function that will take as arguments the working
#directory and the filename, this function will write a csv file "sub_db.csv" as subset of the database selecting 
#only 2880 rows for the 2 days required

#the function "OpenDB(mydir = "", file = "household_power_consumption.txt") can be called
#with no arguments if the downloaded DB is in your working directory, and must be called
#only the first time, it will be enough, in the latter plot we could just read from the saved
#CSV File

#opening the subset dataframe
if(!file.exists("sub_db.csv")){
  source("Open_Dbase.R")
  sub_db <- OpenDB() #insert your path if different from working directory
}  else {read.csv("sub_db.csv", row.names = 1)}

#make a copy of the subset dataframe
df <- sub_db

#building the png file
png("plot1.png")
# histogram as shown in the instructions
hist(as.numeric(df$Global_act_pow), col= "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
#remove the copy of the subset dataframe
rm(df)
# close the device
dev.off()