rm(list = ls()) 
cat("\014")  

# Load libraries and settings
library(dplyr)
library(tidyr)
library(ggplot2)
library(gridExtra)
options(scipen=999)

# Read data
data <- readRDS("data/cleaned/Skeleton_09.10-09.16_200obs")

# Create physical variables
summ <- data %>% 
  group_by(., skeleID) %>%
  summarise(., 
            height = max(head_y - l_ankle_y),
            oh = max(r_hand_x - l_hand_x),
            sw = max(r_shoulder_x - l_shoulder_x),
            ral = max(sqrt((r_shoulder_x - r_hand_x)^2 + (r_shoulder_y - r_hand_y)^2 + (r_shoulder_z - r_hand_z)^2)))

# Normalize all data
norm <- data %>%
  group_by(., skeleID) %>% # groups by ID
  #filter(., skeleID %in% unique(data$skeleID)[sample(1:length(unique(data$skeleID)), 1)]) %>% # grabs three random participants
  mutate_at(., colnames(.)[grepl("_x", colnames(norm))], funs(.- .[1, 41])) %>%
  select(., skeleID, l_ankle_x:l_ankle_z, head_x:head_z) %>% 
  gather(., body_part, coord, -skeleID)

# Normalize sample data
ran_id <- 72057594038044960 #unique(data$skeleID)[sample(1:158, 1)]
ran_obs <- data[which(data$skeleID == ran_id),]
x_val <- ran_obs[1, "l_ankle_x"]; y_val <- ran_obs[1, "l_ankle_y"]; z_val <- ran_obs[1, "l_ankle_z"]
ran_obs_norm <- ran_obs %>% 
  mutate_at(., colnames(.)[grepl("_x", colnames(.))], funs(. - x_val)) %>%
  mutate_at(., colnames(.)[grepl("_y", colnames(.))], funs(. - y_val)) %>%
  mutate_at(., colnames(.)[grepl("_z", colnames(.))], funs(. - z_val))

# Plotting density
p1 <- 
  ggplot(summ, aes(x = height)) + 
  geom_histogram(aes(y = ..density..), binwidth = .5, color="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") +
  ggtitle("Histogram of Height") +
  xlab("Height (m.)") + ylab("Density") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p2 <-
  ggplot(summ, aes(x = oh)) + 
  geom_histogram(aes(y = ..density..), binwidth = .5, color="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") +
  ggtitle("Histogram of Outstretched Hands") +
  xlab("Distance Between Hands (m.)") + ylab("Density") +
  coord_cartesian(xlim = c(0, 1.4)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p3 <-
  ggplot(summ, aes(x = sw)) + 
  geom_histogram(aes(y = ..density..), binwidth = .5, color="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") +
  ggtitle("Histogram of Shoulder Width") +
  xlab("Shoulder Width (m.)") + ylab("Density") +
  coord_cartesian(xlim = c(0, 0.6)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p4 <-
  ggplot(summ, aes(x = ral)) + 
  geom_histogram(aes(y = ..density..), binwidth = .5, color="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") +
  ggtitle("Histogram of Right Arm Length") +
  xlab("Length of Right Arm (m.)") + ylab("Density") +
  coord_cartesian(xlim = c(0, 1.3)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
grid.arrange(p1, p2, p3, p4)
ggsave("reports/Body EDA.pdf", plot = arrangeGrob(p1, p2, p3, p4), height = 8.5, width = 11)

# Plotting count histogram
p1 <- 
  ggplot(summ, aes(x = height)) + 
  geom_histogram(color="black", fill="#FF6666") +
  ggtitle("Histogram of Height") +
  xlab("Height (m.)") + ylab("Count") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p2 <-
  ggplot(summ, aes(x = oh)) + 
  geom_histogram(color="black", fill="#FF6666") +
  ggtitle("Histogram of Outstretched Hands") +
  xlab("Distance Between Hands (m.)") + ylab("Count") +
  coord_cartesian(xlim = c(0, 1.4)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p3 <-
  ggplot(summ, aes(x = sw)) + 
  geom_histogram(color="black", fill="#FF6666") +
  ggtitle("Histogram of Shoulder Width") +
  xlab("Shoulder Width (m.)") + ylab("Count") +
  coord_cartesian(xlim = c(0, 0.6)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p4 <-
  ggplot(summ, aes(x = ral)) + 
  geom_histogram(color="black", fill="#FF6666") +
  ggtitle("Histogram of Right Arm Length") +
  xlab("Length of Right Arm (m.)") + ylab("Count") +
  coord_cartesian(xlim = c(0, 1.3)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
grid.arrange(p1, p2, p3, p4)
ggsave("reports/Body EDA_count.pdf", plot = arrangeGrob(p1, p2, p3, p4), height = 8.5, width = 11)

# Plotting together
ran_obs <- select(ran_obs, l_ankle_x, l_ankle_z, r_ankle_x, r_ankle_z)
ran_obs_norm <- select(ran_obs_norm, l_ankle_x, l_ankle_z, r_ankle_x, r_ankle_z)
obs_melt <- reshape::melt.data.frame(ran_obs, measure.vars = 1:ncol(ran_obs)) %>%
  setNames(., c("body_id", "coord"))
obs_norm_melt <- reshape::melt.data.frame(ran_obs_norm, measure.vars = 1:ncol(ran_obs)) %>%
  setNames(., c("body_id", "coord"))

p1 <- ggplot(ran_obs) + 
  geom_line(aes(x = l_ankle_x, y = l_ankle_z)) +
  geom_point(aes(x = l_ankle_x, y = l_ankle_z)) +
  ggtitle("Movement of Left Ankle") +
  xlab("Left/Right Movement") + ylab("Forward/Backward Movement") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

p2 <- ggplot(ran_obs_norm) + 
  geom_line(aes(x = l_ankle_x, y = l_ankle_z)) +
  geom_point(aes(x = l_ankle_x, y = l_ankle_z)) +
  geom_vline(xintercept = 0) +
  geom_hline(yintercept = 0) +
  ggtitle("Movement of Left Ankle") +
  xlab("Left/Right Movement") + ylab("Forward/Backward Movement") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
