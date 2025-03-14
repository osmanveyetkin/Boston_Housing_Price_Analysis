# 📊 Boston Housing Price Prediction

## **Project Overview**
This project analyzes the **Boston Housing Dataset** using **Exploratory Data Analysis (EDA), data visualization, and machine learning models** (Linear Regression & Random Forest). The goal is to predict median house prices based on various factors such as crime rate, number of rooms, property tax, etc.

---
![scatter_rooms_price](https://github.com/user-attachments/assets/78676206-5352-4198-b184-629b1a7ca9d7)
![hist_median_price](https://github.com/user-attachments/assets/e042641d-b1d4-4435-9c6d-57e1ee1012c3)
![correlation_heatmap](https://github.com/user-attachments/assets/ae857303-7659-4026-86e1-63f3dec65fdd)

## **📈 Model Comparison & Results**
We trained two models for price prediction:

### **Model Performance (RMSE values)**
| Model                 | RMSE (Lower is Better) |
|----------------------|----------------------|
| **Linear Regression** | **5.77** |
| **Random Forest** | **3.2** |

- **Random Forest performed better**, reducing the RMSE by approximately **45%** compared to Linear Regression.
- The **Random Forest model explained 85.22% of variance**, whereas Linear Regression only explained **56.58%**.
- The most influential features were **Number of Rooms (positive impact)** and **Crime Rate & Tax (negative impact)**.

### **Example Predictions vs. Actual Prices**
| Actual Price ($1000s) | Predicted Price ($1000s) |
|----------------------|----------------------|
| 34.7 | 33.4 |
| 28.7 | 26.1 |
| 16.5 | 18.8 |
| 15.0 | 21.1 |
| 20.4 | 20.2 |

This comparison highlights the model’s **accuracy and potential areas for improvement**.

## **🔹 How to Run the Project**
### **1️⃣ Install Required Software**
Before running the project, make sure you have:
- **R (version 4.0 or later)**
- **RStudio (latest version)**

### **2️⃣ Clone the Repository or Download the Script**
- gh repo clone osmanveyetkin/Boston_Housing_Price_Analysis
  ```
- Alternatively, download the `boston_analysis.R` file and place it in your working directory.

### **3️⃣ Open and Run the Script**
#### **Using RStudio:**
1. Open `boston_analysis.R` in **RStudio**.
2. Click on **Run** or press `Cmd + Shift + Enter` (Mac) / `Ctrl + Shift + Enter` (Windows/Linux).
3. The script will:
   - Install required packages
   - Load and clean the dataset
   - Perform Exploratory Data Analysis (EDA)
   - Train models and evaluate them
   - Save the best model (`random_forest_model.rds`)
   - Save visualization plots

#### **Using the Terminal or R Console:**
1. Set your working directory (if needed):
   ```r
   setwd("~/Desktop/Boston_Housing_Price_Analysis")
   ```
2. Run the script:
   ```r
   source("boston_analysis.R")
   ```

---

## **🔹 Project Breakdown**
### **📌 Step 1: Install and Load Required Packages**
The script installs and loads necessary packages:
```r
required_packages <- c("ggplot2", "dplyr", "caret", "corrplot", "MASS", "randomForest")
```

---

### **📌 Step 2: Load the Dataset**
The **Boston Housing Dataset** from the `MASS` package is loaded:
```r
data("Boston")
```

---

### **📌 Step 3: Exploratory Data Analysis (EDA)**
- Summary statistics
- Missing value check
- Visualizations:
  1. **Histogram of Median House Prices**
  2. **Scatter Plot: Rooms vs. Price**
  3. **Correlation Heatmap**

---

### **📌 Step 4: Feature Engineering**
- A **log transformation** is applied to `CrimeRate`
- The dataset is split into **80% training and 20% testing**.

---

### **📌 Step 5: Train Models**
1. **Linear Regression**
2. **Random Forest**
  
```r
lm_model <- lm(MedPrice ~ Rooms + CrimeRate + Distance + Highways + Tax, data = train_data)
rf_model <- randomForest(MedPrice ~ ., data = train_data, ntree = 100)
```

---

### **📌 Step 6: Model Evaluation**
Root Mean Squared Error (RMSE) is calculated:
```r
lm_rmse <- sqrt(mean((test_data$MedPrice - lm_predictions)^2))
rf_rmse <- sqrt(mean((test_data$MedPrice - rf_predictions)^2))
```
**Results:**
✅ **Linear Regression RMSE:** `5.77`  
✅ **Random Forest RMSE:** `3.20` (Better!)

---

### **📌 Step 7: Save and Reload the Best Model**
```r
saveRDS(rf_model, file = "random_forest_model.rds")
loaded_model <- readRDS("random_forest_model.rds")
```

---

### **📌 Step 8: Predict and Compare Actual vs. Predicted Prices**
```r
new_predictions <- predict(loaded_model, test_data)
comparison <- data.frame(Actual = test_data$MedPrice, Predicted = new_predictions)
```

---

## **🔹 Output Files**
| File Name | Description |
|-----------|-------------|
| `random_forest_model.rds` | Trained machine learning model |
| `hist_median_price.png` | Histogram of house prices |
| `scatter_rooms_price.png` | Scatter plot of rooms vs. prices |
| `correlation_heatmap.png` | Correlation matrix |
| `all_graphs.pdf` | PDF containing all plots |

---

## **🔹 Final Thoughts**
✅ **Successfully built a predictive model** for Boston Housing Prices.  
✅ **Random Forest model performed better than Linear Regression.**  
✅ **Saved and reloaded the trained model for future use.**  
✅ **Generated multiple visualizations to analyze the dataset.**  

---

### **📌 Future Improvements**
- **Hyperparameter tuning** for Random Forest.
- **Feature selection** to remove redundant variables.
- **Neural Network model** to improve predictions.

---

## **💡 Author**
- **Name:** Osman Yetkin  
- **Email:** osmnytkn02@gmail.com  
