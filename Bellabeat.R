
# Data Analytics Project with R : Bellabeat Comapny**
  
  
# Setting up my Environment
  
#To begin my analysis, I will set up my R environment by loading the necessary R packages. 
#Additionally,I will load packages specifically designed for data cleaning to ensure my dataset is properly prepared for analysis.


# loading packages
  
# {r loading packages, message=FALSE, warning=FALSE}

library(tidyverse)
library(lubridate)
library(ggplot2)
library(tidyr)
library(dplyr)
library(here)
library(skimr)
library(janitor)


# checking working directory
  
#To import the CSV files required for this analysis, I will need to verify the 
#current working directory using the "getwd()" function.

getwd()

# Import the dataset
  
# Importing dailyActivity dataset
  
# {r import dailyActivity_merged dataset, message=FALSE, warning=FALSE}
activity <- read.csv("C:/Users/Hashi/Desktop/Project/dailyActivity_merged.csv")
head(activity)
str(activity)
colnames(activity)
View(activity)

# Importing Calories dataset

# {r import dailyCalories_merged data, message=FALSE, warning=FALSE}

calories <- read.csv("C:/Users/Hashi/Desktop/Project/dailyCalories_merged.csv")
head(calories)
str(calories)
colnames(calories)
View(calories)

# Importing dailyIntensities_merged dataset
  
# {r import dailyIntensities_merged data, message=FALSE, warning=FALSE}

intensities <- read.csv("C:/Users/Hashi/Desktop/Project/dailyIntensities_merged.csv")
head(intensities)
str(intensities)
colnames(intensities)
View(intensities)

# Importing heartrate_seconds_merged dataset
  
# {r import heartrate_seconds_merged data, message=FALSE, warning=FALSE}

heartrate <- read.csv("C:/Users/Hashi/Desktop/Project/heartrate_seconds_merged.csv")
head(heartrate)
str(heartrate)
colnames(heartrate)
View(heartrate)


# Importing sleepDay_merged dataset
  
# {r import sleepDay_merged data, message=FALSE, warning=FALSE}

sleep <- read.csv("C:/Users/Hashi/Desktop/Project/SleepDay_merged.csv")
head(sleep)
str(sleep)
colnames(sleep)
View(sleep)


# Importing weightLogInfo_merged dataset
  
# {r import weightLogInfo_merged data, message=FALSE, warning=FALSE}
weightlog <- read.csv("C:/Users/Hashi/Desktop/Project/weightLogInfo_merged.csv")
head(weightlog)
str(weightlog)
colnames(weightlog)
View(weightlog)

# Cleaning the dataset
  
# activity dataset

# {r message=FALSE, warning=FALSE}
glimpse(activity)


# convert ActivityDate column to date format

# {r message=FALSE, warning=FALSE}

activity$ActivityDate=as.POSIXct(activity$ActivityDate, format="%m/%d/%y", tz=Sys.timezone())
activity$date <- format(activity$ActivityDate, format = "%m/%d/%y")
activity$ActivityDate=as.Date(activity$ActivityDate, format="%m/%d/%y", tz=Sys.timezone())
activity$date=as.Date(activity$date, format="%m/%d/%y")
str(activity)


# calories dataset

# {r message=FALSE, warning=FALSE}

glimpse(calories)


# convert calories ActivityDay column to date format

# {r message=FALSE, warning=FALSE}

calories$ActivityDay <- as.Date(calories$ActivityDay, format="%m/%d/%Y")
str(calories)


#intensities dataset

# {r message=FALSE, warning=FALSE}

glimpse(intensities)


# convert intensities ActivityDay column to date format

# {r message=TRUE, warning=FALSE}

intensities$ActivityDay=as.POSIXct(intensities$ActivityDay, format="%m/%d/%y", tz=Sys.timezone())
intensities$date <- format(intensities$ActivityDay, format = "%m/%d/%y")
intensities$ActivityDay=as.Date(intensities$ActivityDay, format="%m/%d/%y", tz=Sys.timezone())
intensities$date=as.Date(intensities$date, format="%m/%d/%y")
str(intensities)


# heartrate dataset

#{r message=FALSE, warning=FALSE}

glimpse(heartrate)


#convert heartrate Time column to date-time format and split

#{r message=FALSE, warning=FALSE}

heartrate$Time <- strptime(heartrate$Time, format = "%m/%d/%Y %I:%M:%S %p", tz = Sys.timezone())
heartrate$Date <- as.Date(heartrate$Time)
heartrate$Time <- format(heartrate$Time, format = "%H:%M:%S")
str(heartrate)

# sleep dataset

#{r message=FALSE, warning=FALSE}

glimpse(sleep)


# convert sleep SleepDay column to date-time format and split

# {r message=FALSE, warning=FALSE}

sleep$SleepDay <- as.POSIXct(sleep$SleepDay, format = "%m/%d/%Y %H:%M", tz = "UTC")
sleep$Date <- format(sleep$SleepDay,  format = "%m%d%Y")
sleep$SleepDay =as.Date(sleep$SleepDay, format = "%m%d%Y %H:%M", tz = "UTC")
sleep$Date = as.Date(sleep$SleepDay, format="%m%d%Y")
str(sleep)

# weightlog dataset

#{r message=FALSE, warning=FALSE}

glimpse(weightlog)


# Identifying a significant number of missing values in Fat column, 
# so, I have decided to remove that column from the weightlog dataset.

# {r message=FALSE, warning=FALSE}

weightlog$Fat <- NULL
str(weightlog)


# convert weightlog Date column to date-time format and split

# {r message=FALSE, warning=FALSE}
weightlog$Date <- as.POSIXct(weightlog$Date, format = "%m/%d/%Y %H:%M", tz = "UTC")
weightlog$DateOnly <- format(weightlog$Date, format= "%m%d%Y")
weightlog$DateOnly =as.Date(weightlog$Date, format= "%m%d%Y")
str(weightlog)

# Summarize the dataset 
  
# Find the total number of participants in activity data set

# {r message=FALSE, warning=FALSE}

activity %>%
  summarise(activity_participants = n_distinct(activity$Id))


# Find the total number of participants in calories data set

# {r message=FALSE, warning=FALSE}

calories %>%
  summarize(calories_participants = n_distinct(calories$Id))


# Find the total number of participants in intensities data set

# {r message=FALSE, warning=FALSE}

intensities %>%
  summarize(intensities_participants= n_distinct(intensities$Id))


# Find the total number of participants in heartrate data set

# {r message=FALSE, warning=FALSE}

heartrate %>%
  summarize(heartrate_participants= n_distinct(heartrate$Id))


# Find the total number of participants in sleep data set

# {r message=FALSE, warning=FALSE}

sleep %>%
  summarize(sleep_participants= n_distinct(sleep$Id))


# Find the total number of participants in weightlog data set

# {r message=FALSE, warning=FALSE}

weightlog %>%
  summarize(weightlog_participants=n_distinct(weightlog$Id))


# Here I will performed some summary statistics about each data frame
  
# activity
  
# summary statistics for the activity data

# {r message=FALSE, warning=FALSE}

activity %>%
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes, Calories) %>%
  summary()


# Also conduct correlation analysis to understand the relationships between 
# TotalSteps, TotalDistance, SedentaryMinutes, and Calories.

# {r message=FALSE, warning=FALSE}

selected_activity_data <- activity[, c("TotalSteps", "TotalDistance", "SedentaryMinutes", "Calories")]
cor_matrix <- cor(selected_activity_data)
print(cor_matrix)


# calories
  
# summary statistics for the calories data

# {r message=FALSE, warning=FALSE}

calories %>%
  select(Calories) %>%
  summary()


# intensities
  
# summary statistics for the intensities data

# {r message=FALSE, warning=FALSE}

intensities %>%
  select(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes) %>%
  summary()

# sleep
  
# summary statistics for the sleep data

# {r message=FALSE, warning=FALSE}

sleep %>%
  select(TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed) %>%
  summary()


# Data Visualization
  
# Here I will create some visualization based on my analysis

# Create  relationship between TotalSteps and SedentaryMinutes

# {r message=FALSE, warning=FALSE}

ggplot(data=activity)+geom_point(mapping = aes(x=TotalSteps, y= SedentaryMinutes,color= Id))+
  geom_smooth(mapping = aes(x=TotalSteps, y= SedentaryMinutes))+
  labs(title="TotalSteps vs. SedentaryMinutes",
       subtitle = "Sample of Physical Activity of Fitbit Users")


# Create relationship between TotalSteps and Calories

# {r message=FALSE, warning=FALSE}

ggplot(data=activity)+geom_point(mapping = aes(x=TotalSteps, y=Calories,alpha= Id))+
  geom_smooth(mapping = aes(x=TotalSteps,y=Calories))+
  labs(title = "TotalSteps vs. Calories",
       subtitle = "Sample of Physical Activity of Fitbit Users")


# Create relationship between TotalSteps and TotalDistance

# {r message=FALSE, warning=FALSE}

ggplot(data=activity)+geom_point(mapping = aes(x=TotalSteps, y=TotalDistance))+
  geom_smooth(mapping = aes(x=TotalSteps,y= TotalDistance))+
  labs(title = "TotalSteps vs. TotalDistance",
       subtitle = "Sample of Physical Activity of Fitbit Users")


# Create relationship between TotalMinutesAsleep and TotalTimeInBed

# {r message=FALSE, warning=FALSE}

ggplot(data=sleep)+geom_point(mapping = aes(x=TotalMinutesAsleep, y=TotalTimeInBed,alpha= Id))+
  geom_smooth(mapping = aes(x=TotalMinutesAsleep,y=TotalTimeInBed))+
  labs(title = "TotalMinutesAsleep vs. TotalTimeInBed",
       subtitle = "Sample of Sleep Monitoring of Fitbit Users")


# Create ggplot to visualize intensities over time
  
# Note:I merge the intensities and weightlog data sets, and then I use the ggplot2 
# function to create a graph that visualizes intensities over time.

# {r message=FALSE, warning=FALSE}

intensities$ActiveIntensity <- intensities$VeryActiveMinutes/60
Combined_data <- merge(weightlog, intensities, by = "Id", all = TRUE)
Combined_data$time <- format(Combined_data$Date, format = "%H:%M:%S %p")


# {r message=FALSE, warning=FALSE}

ggplot(data = Combined_data, aes(x = time, y = ActiveIntensity)) +
  geom_histogram(stat = "identity", width = 0.6,fill = "red", color = "blue") +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "VeryActiveIntensity vs. Time",
       x = "Time",
       y = "Very Active Intensity")






