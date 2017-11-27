# Load libraries and settings
library(dplyr)
library(ggplot2)
library(gridExtra)
options(scipen=999)

# Read data
data <- readRDS("data/cleaned/Skeleton_09.10-09.16_200obs")
summ <- data %>% 
  group_by(., skeleID) %>%
  summarise(., 
            height = max(head_z) - min(r_ankle_z),
            oh = max(r_hand_x) - min(l_hand_x),
            sw = max(r_shoulder_x) - min(l_shoulder_x),
            ral = max(r_shoulder_z) - min(r_hand_z))

# Plotting density
p1 <- 
  ggplot(summ, aes(x = height)) + 
  geom_histogram(aes(y = ..density..), binwidth = .5, color="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") +
  ggtitle("Histogram of Height") +
  xlab("Height (in.)") + ylab("Density") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p2 <-
  ggplot(summ, aes(x = oh)) + 
  geom_histogram(aes(y = ..density..), binwidth = .5, color="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") +
  ggtitle("Histogram of Outstretched Hands") +
  xlab("Distance Between Hands (in.)") + ylab("Density") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p3 <-
  ggplot(summ, aes(x = sw)) + 
  geom_histogram(aes(y = ..density..), binwidth = .5, color="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") +
  ggtitle("Histogram of Shoulder Width") +
  xlab("Shoulder Width (in.)") + ylab("Density") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p4 <-
  ggplot(summ, aes(x = ral)) + 
  geom_histogram(aes(y = ..density..), binwidth = .5, color="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") +
  ggtitle("Histogram of Right Arm Length") +
  xlab("Length of Right Arm (in.)") + ylab("Density") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
grid.arrange(p1, p2, p3, p4)
ggsave("reports/Body EDA.pdf", plot = arrangeGrob(p1, p2, p3, p4), height = 8.5, width = 11)

# Plotting count histogram
p1 <- 
  ggplot(summ, aes(x = height)) + 
  geom_histogram(color="black", fill="#FF6666") +
  ggtitle("Histogram of Height") +
  xlab("Height (in.)") + ylab("Count") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p2 <-
  ggplot(summ, aes(x = oh)) + 
  geom_histogram(color="black", fill="#FF6666") +
  ggtitle("Histogram of Outstretched Hands") +
  xlab("Distance Between Hands (in.)") + ylab("Count") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p3 <-
  ggplot(summ, aes(x = sw)) + 
  geom_histogram(color="black", fill="#FF6666") +
  ggtitle("Histogram of Shoulder Width") +
  xlab("Shoulder Width (in.)") + ylab("Count") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
p4 <-
  ggplot(summ, aes(x = ral)) + 
  geom_histogram(color="black", fill="#FF6666") +
  ggtitle("Histogram of Right Arm Length") +
  xlab("Length of Right Arm (in.)") + ylab("Count") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
grid.arrange(p1, p2, p3, p4)
ggsave("reports/Body EDA_count.pdf", plot = arrangeGrob(p1, p2, p3, p4), height = 8.5, width = 11)

















ggplot(summ, aes(x = )) + 
  geom_histogram(breaks=seq(20, 50, by = 2), 
                 col="red", 
                 fill="green", 
                 alpha = .2) + 
  labs(title="Histogram for Age") +
  labs(x="Age", y="Count")