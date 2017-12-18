# FILE   Load_data_clean.R
# Author: Edgar Alirio Rodriguez
# 18 Decembebr 2017

# Load packages
library(chron)

#Download Zip file
zip_Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file <-"household_power_consumption.zip"


if (!file.exists(zip_File)) {
  download.file(zip_Url, zip_File, mode = "wb")
}
#unzip file
unzip(zip_file)

#Reading all registers
df_hpc <-read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)

# Filtering only valid registers which are into period of time
df_hpc_2 <-df_hpc[((df_hpc$Date=="1/2/2007" | df_hpc$Date=="2/2/2007") &
                     (df_hpc$Global_active_power !="?" | df_hpc$Sub_metering_1 !="?" | df_hpc$Sub_metering_2 !="?" | df_hpc$Sub_metering_3 !="?")),]
#Erasing unused object
rm(df_hpc)
# Formatting columns to appropriate format
df_hpc_2$Global_active_power <-as.numeric(df_hpc_2$Global_active_power)
df_hpc_2$Sub_metering_1 <-as.numeric(df_hpc_2$Sub_metering_1)
df_hpc_2$Sub_metering_2 <-as.numeric(df_hpc_2$Sub_metering_2)
df_hpc_2$Sub_metering_3 <-as.numeric(df_hpc_2$Sub_metering_3)
df_hpc_2$Date<-as.Date(df_hpc_2$Date,"%d/%m/%Y")

# Depicting Third Plot
png(filename ="plot3.png", width = 480, height = 480)
plot(c(df_hpc_2$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering", lab=c(3,4,31) , xaxt = "n")
axis(side=1, at=c(1, 1440, 2880), labels=c("Thu","Fri","Sat"))
lines(df_hpc_2$Sub_metering_2,col="red")
lines(df_hpc_2$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()
###
