###############################################################################
#   Creates Functions on the Following:
#                  - Direct Standardised Rate
#                  - Dobson Confidence Interval
#                  - Benchmark Significance
#
# INSTALL PACKAGES ############################################################

#install.packages("tidyverse")
#install.packages("caTools")
#install.packages("randomForest")
#install.packages("caret")

# LOAD PACKAGES ###############################################################

library(tidyverse) #For data manipulation
library(caTools) #For creating testing and training datasets
library(randomForest) #For creating the Random Forest model
library(caret)

# DOWNLOAD DATA ###############################################################
    
df_lung <- read_csv("survey lung cancer.csv") %>%
  as.data.frame()

# PREPARE DATA ################################################################

# Check dataset for NA values - none found
colSums(is.na(df_lung))

# Change columns to numeric and factor for tree building
df_lung <- df_lung %>%
  mutate(LUNG_CANCER = as.factor(case_when(LUNG_CANCER == "NO" ~ 1,
                                           LUNG_CANCER == "YES" ~ 2,
                                           T ~ 3)),
          GENDER = case_when(GENDER == "M" ~1,
                             GENDER == "F" ~ 2,
                             T ~ 3))

# Create vector to split the data into training and test dataset
df <- sample.split(df_lung$LUNG_CANCER, SplitRatio = 0.7)

# Create training dataset  
train <- subset(df_lung, df == "TRUE")

# Create test dataset
test <- subset(df_lung, df == "FALSE")

# BUILD MODEL #################################################################

# Set seed for reproducibility 
set.seed(190622)

# Build model for Lung Cancer
model_RF = randomForest(x = train[-16],
                             y = train$LUNG_CANCER,
                             ntree = 1000, keep.forest = TRUE)

# Create predictions based on the model
y_pred = predict(model_RF, newdata = test[-16])

# EVALUATE MODEL ###############################################################

# Confusion matrix and other useful statistics for honing the model
confusionMatrix(y_pred, test[,16], mode="everything", positive = "1")


