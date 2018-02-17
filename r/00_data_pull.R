#-------------------------------------------------------------------------------
# Takes approximately 12 minutes to load 1000 subjects without reduction
#-------------------------------------------------------------------------------
rm(list = ls()) 
cat("\014") 

setwd("/Users/Rachel/Documents/GitHub/VSB-Project")

# Load libraries and settings
library(dplyr)
library(ggplot2)
options(scipen=999)

# Assigning Variable Names #

var_names <- c("skeleID", "isMainSkeleton", "distFromControl", "time", 
               "c_hips_x", "c_hips_y", "c_hips_z",
               "head_x", "head_y", "head_z",
               "l_shoulder_x", "l_shoulder_y", "l_shoulder_z",
               "l_elbow_x", "l_elbow_y", "l_elbow_z",
               "l_wrist_x", "l_wrist_y", "l_wrist_z",
               "l_hand_x", "l_hand_y", "l_hand_z",
               "r_shoulder_x", "r_shoulder_y", "r_shoulder_z",
               "r_elbow_x", "r_elbow_y", "r_elbow_z",
               "r_wrist_x", "r_wrist_y", "r_wrist_z",
               "r_hand_x", "r_hand_y", "r_hand_z",
               "l_hips_x", "l_hips_y", "l_hips_z",
               "l_knee_x", "l_knee_y", "l_knee_z",
               "l_ankle_x", "l_ankle_y", "l_ankle_z",
               "r_hips_x", "r_hips_y", "r_hips_z",
               "r_knee_x", "r_knee_y", "r_knee_z",
               "r_ankle_x", "r_ankle_y", "r_ankle_z", 
               "c_shoulder_x", "c_shoulder_y", "c_shoulder_z")

# Creating lists for each of the types of data files #

# Creating list of Skeleton Logs
file_skele <- list.files(path = paste0(getwd(), "/data", "/2017-10_VSBData"), 
                         pattern="*SkeleLog.csv")

# Creating list of Interaction Event Logs 
file_int <- list.files(path = paste0(getwd(), "/data", "/2017-10_VSBData"), 
                                     pattern="*EventLog.csv")

# Creating list of Minigame Logs
file_mini <- list.files(path = paste0(getwd(), "/data", "/2017-10_VSBData"), 
                                     pattern="*MinigameLog.csv")

data_skele <- lapply(file_skele, function(i){
  pipe(paste0("awk 'BEGIN{i=0}{i++;if (i%4==0) print $1}" < file_skele[i]))
  tryCatch(read.csv(paste0("data/2017-10_VSVData/", i), skip = 5, header = F), 
           error = function(j){NULL})})
}



# Pull in data
system.time(
data <- lapply(file_names, function(i){
  tryCatch(read.csv(paste0("data/2017-10_VSVData/", i), skip = 5, header = F), 
           error = function(j){NULL})}) %>%
  bind_rows(.) %>%
  setNames(., var_names)
)

write.csv(1:1000, file='test.csv')
file.pipe <- pipe("awk 'BEGIN{i=0}{i++;if (i%4==0) print $1}' < test.csv")
res <- read.csv(file.pipe)
res
read.csv(pipe("gsed -n '2~4p' test.csv")) 

# Save data
saveRDS(data, file = "data/cleaned/Skeleton_09.10-09.16_500obs")
