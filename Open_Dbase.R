#load libraries
library(tidyr)
library(lubridate)
# list of names for the features
labels <- c("Date", "Time","Global_act_pow", "Global_react_pow","Voltage",
            "Global_intensity", "Sub_KWH_1", "Sub_KWh_2", "Sub_KWh_3")
OpenDB <- function(mydir = "", file = "household_power_consumption.txt"){
  
  full_path <- paste0(mydir, file)
  DB <- read.csv(full_path)
  #I then used the tidyr function separate() to divide each column
  db <- separate(DB, names(DB), labels, sep = ";") 
  
  #if is not a dataframe format, transform to dataframe
  if(!is.data.frame(db)){
    db <- as.data.frame(db) }
  
  #transform the column Date from character do Date
  db$Date <- as.Date(parse_date_time(db$Date, "dmy"))
  #subset the database
  sub_db <- subset(db, Date >= "2007-02-01" & Date <= "2007-02-02", rownames = FALSE)
  #also need to transform the time column from character to time
  sub_db$Time <- parse_date_time(sub_db$Time, "HMS")
  #save the subset dataframe to be read next time we need to use it saving time 
  #and memory space
  rownames(sub_db) <- 1: nrow(sub_db)
  write.csv(sub_db, "sub_db.csv")
  rm(db)
  sub_db
}

