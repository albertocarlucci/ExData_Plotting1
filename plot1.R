library(dplyr)

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

# Create Plot 1 and save as PNG file
png("plot1.png", width=480, height=480)
par(mfrow=c(1,1),mar=c(5,4,4,2))
hist(df_datatime$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

