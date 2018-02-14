# This is a comment line.
#
# This program introduces Homework 3 for Econometrics 4750
# at the Terry College of Business.
# This comment last modified: February 12, 2018.
# Rachel Korn
#
install.packages('car')
library(car)
# Clear memory
rm(list=ls())
#
#### (a) Estimate model where height at age 33 explains income at age 33.
# Import data set into R
install.packages('readxl')
library(readxl)
heightwage_british_males <- read_excel("heightwage_british_males.xlsx")
View(heightwage_british_males)
# Store the data set.
str(heightwage_british_males)
# Run OLS Regression to estimate model
height33 <- heightwage_british_males$height33
wage33 <- heightwage_british_males$gwage33
income33 <- heightwage_british_males$gwage33*40
OLSResults = lm(wage33 ~ height33, data = )
OLSResults
#
# (b) Scatterplot of height and income at age 33.
plot(height33, wage33, xlab= "Height", ylab="Income", main= "Height on Income at Age 33")
outlierTest(OLSResults)
qqPlot(OLSResults)
leveragePlots(OLSResults)
# av.plots(OLSResults)
# Cook's Distance ti identify infuential obs
cutoff = 4/
#
# (c) Exclude observations with wages/hr > 400 British pounds and height < 40 inches
excludewage33 <- (wage33 < 400)
excludeheight33 <- (height33 > 40)
plot(excludeheight33, excludewage33)
excluded = data.frame(excludeheight33, excludewage33)

heightwage = data.frame(height33, wage33)

subset = subset(heightwage, wage33 < 400 & height33 > 40)
subset
subset_model = lm(wage33 ~ height33, data = subset)
anova(subset_model)
summary(subset_model)
subset2 = subset(heightwage, height33 > 40)
outlierTest(OLSResults)
subset2
plot(subset)
lm()