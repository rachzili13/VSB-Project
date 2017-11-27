# Load libraries and settings
library(dplyr)
library(ggplot2)
options(scipen=999)

# Needed vars
var_names <- c("skeleID", "isMainSkeleton", "distFromControl", "tbd", 
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
file_names <- list.files(path = paste0(getwd(),"/data", "/2017-09-10_09-16_VSBData/"), 
                         pattern="*SkeleLog.csv")

# Pulling in the data
data_list <- list()
for(i in 1:length(file_names)){
  tmp <- read.csv(paste0(getwd(), "/data", "/2017-09-10_09-16_VSBData/", file_names[i]), header = F)
  data_list[[i]] <- tmp
}
data <- bind_rows(data_list)

# Save data
saveRDS(data, file = "data/cleaned/Skeleton_09.10-09.16_200obs")