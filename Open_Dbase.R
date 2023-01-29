#load libraries
library(tidyr)
library(lubridate)
# list of names for the features
labels <- c("Date", "Time","Global_act_pow", "Global_react_pow","Voltage",
            "Global_intensity", "Sub_KWh_1", "Sub_KWh_2", "Sub_KWh_3")
OpenDB <- function(mydir = "", file = "household_power_consumption.txt"){
  
  full_path <- paste0(mydir, file)
  DB <- read.csv(full_path)
  #I then used the tidyr function separate() to divide each column
  db <- separate(DB, names(DB), labels, sep = ";") 
  
  #if is not a dataframe format, transform to dataframe
  if(!is.data.frame(db)){
    db <- as.data.frame(db) }
  
  #select a variable "time" to store the value of the date and time
  time <- parse_date_time(paste(db$Date,db$Time), "dmy_HMS", tz = "")

  #subset the database
  sub_db <- subset(db, time >= "2007-01-31 23:30:00" & time <= "2007-02-03 00:01:00", rownames = FALSE)

  #transform the column Date from character do Date
  sub_db$Date <- as.Date(parse_date_time(sub_db$Date, "dmy"))
 
  #save the subset dataframe to be read next time we need to use it saving time 
  #and memory space
  rownames(sub_db) <- 1: nrow(sub_db)
  write.csv(sub_db, "sub_db.csv")
  rm(db, DB)
  sub_db
}

