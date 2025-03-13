# Function to install & load required packages
install_and_load <- function(package_names) {
  for (package in package_names) {
    if (!require(package, character.only = TRUE)) {
      install.packages(package, dependencies = TRUE)
      library(package, character.only = TRUE)
    }
  }
}

# Define required packages
required_packages <- c("ggplot2", "dplyr", "caret", "corrplot", "MASS", "randomForest")

# Install and load all packages
install_and_load(required_packages)

# Load dataset
data("Boston")

# View first few rows
print(head(Boston))

# Check for missing values
print(sum(is.na(Boston)))  # Should be 0 since this dataset has no missing values

# Summary statistics
print(summary(Boston))

# Rename columns for better readability
colnames(Boston) <- c("CrimeRate", "ZonedLand", "Industry", "River", "NO2",
                      "Rooms", "Age", "Distance", "Highways", "Tax", "PTRatio",
                      "Black", "LStat", "MedPrice")

# Exploratory Data Analysis (EDA)
# Histogram of Median House Prices
ggplot(Boston, aes(x = MedPrice)) +
  geom_histogram(binwidth = 2, fill = "blue", alpha = 0.7) +
  labs(title = "Distribution of House Prices", x = "Median Price (in $1000s)", y = "Frequency")

# Correlation heatmap
cor_matrix <- cor(Boston)
corrplot(cor_matrix, method = "circle", type = "lower", tl.cex = 0.8)

# Scatter plot: Number of Rooms vs. Median Price
ggplot(Boston, aes(x = Rooms, y = MedPrice)) +
  geom_point(color = "darkred") +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "Number of Rooms vs. Median House Price", x = "Average Number of Rooms", y = "Median Price ($1000s)")

# Feature Engineering: Log Transformation for Skewed Data
Boston$Log_CrimeRate <- log1p(Boston$CrimeRate)

# Split dataset into training and test sets (80-20 split)
set.seed(123)
train_index <- createDataPartition(Boston$MedPrice, p = 0.8, list = FALSE)
train_data <- Boston[train_index, ]
test_data <- Boston[-train_index, ]

# Train a Linear Regression Model
lm_model <- lm(MedPrice ~ Rooms + CrimeRate + Distance + Highways + Tax, data = train_data)
print(summary(lm_model))

# Train a Random Forest Model
rf_model <- randomForest(MedPrice ~ ., data = train_data, ntree = 100)
print(rf_model)

# Model Evaluation: Predict on Test Data
lm_predictions <- predict(lm_model, test_data)
rf_predictions <- predict(rf_model, test_data)

# Calculate RMSE for both models
lm_rmse <- sqrt(mean((test_data$MedPrice - lm_predictions)^2))
rf_rmse <- sqrt(mean((test_data$MedPrice - rf_predictions)^2))

print(paste("Linear Regression RMSE:", round(lm_rmse, 2)))
print(paste("Random Forest RMSE:", round(rf_rmse, 2)))

# Save the best model (Random Forest)
saveRDS(rf_model, file = "random_forest_model.rds")

# Load and use the saved model
loaded_model <- readRDS("random_forest_model.rds")
new_predictions <- predict(loaded_model, test_data)

# Compare actual vs. predicted prices
comparison <- data.frame(Actual = test_data$MedPrice, Predicted = new_predictions)
print(head(comparison))