library(dplyr)
# Change locale to English to get English labels in the plot (my system has another language per default)
Sys.setlocale("LC_ALL", "en_GB.UTF-8")
# Import data from source file
data <- read.csv("./household_power_consumption.txt", header = TRUE, stringsAsFactors=FALSE, na.strings=c("?"),
                 colClasses=c("character", "character","numeric","numeric","numeric","numeric",
                              "numeric","numeric","numeric"), sep = ";")

# Data subset as defined in the assignment
subset_data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

# Merge and convert Date&Time
tidy_datatime <- strptime(paste(subset_data$Date, subset_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
# construct data frame
df_datatime <- as.data.frame(tidy_datatime)
df_datatime <- df_datatime %>%
        mutate(Global_active_power = subset_data$Global_active_power, Global_reactive_power = subset_data$Global_reactive_power, Voltage = subset_data$Voltage, Global_intensity = subset_data$Global_intensity, Sub_metering_1 = subset_data$Sub_metering_1, Sub_metering_2 = subset_data$Sub_metering_2, Sub_metering_3 = subset_data$Sub_metering_3)

# Create Plot 4 and save as PNG file
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,5,4,2))
# Plot top left
plot(df_datatime$tidy_datatime,df_datatime$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")

# Plot bottom left
plot(df_datatime$tidy_datatime,df_datatime$Voltage, ylab="Voltage", xlab="datetime", type="l")
# Plot top right
plot(df_datatime$tidy_datatime, df_datatime$Sub_metering_1, ylab="Energy sub metering", xlab="", type="l", col="black")
points(df_datatime$tidy_datatime, df_datatime$Sub_metering_2, col="red", type="l")
points(df_datatime$tidy_datatime, df_datatime$Sub_metering_3, col="blue", type="l")
legend("topright", lwd = 1, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))

# Plot bottom right
plot(df_datatime$tidy_datatime, df_datatime$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")

dev.off()

