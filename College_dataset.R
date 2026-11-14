# Load CSV dataset
df <- read.csv("CollegeDistance.csv")

# Check dataset dimensions
dim(df)

# View first 6 rows
head(df)

# Check feature names
names(df)

#we are checking values
#there is no missing values
# Missing values in every column
colSums(is.na(df))

# Total missing values
sum(is.na(df))

# Missing percentage
round(colMeans(is.na(df)) * 100, 2)

#we are creating missing values

# Keep original dataset unchanged
df_missing <- df

# Numerical Features (4)
df_missing$score[1:25] <- NA
df_missing$distance[26:50] <- NA
df_missing$tuition[51:75] <- NA
df_missing$wage[76:100] <- NA

# Categorical Features (4)
df_missing$gender[101:125] <- NA
df_missing$ethnicity[126:150] <- NA
df_missing$fcollege[151:175] <- NA
df_missing$income[176:200] <- NA

# Check missing values in each feature
colSums(is.na(df_missing))

# Total missing values
sum(is.na(df_missing))


# save missing data set
write.csv(df_missing,
          "CollegeDistance_Missing.csv",
          row.names = FALSE)


#we are handling missing values by using Discard Instances and Replace by Average (Mean)

# Method 1: Discard Instances
df_discard <- na.omit(df_missing)

# Check dataset dimensions
dim(df_discard)

# Check remaining missing values
colSums(is.na(df_discard))

# Total missing values
sum(is.na(df_discard))


# Method 2: Replace by Average (Mean)
df_replace <- df_missing

# Numerical Features: Replace by Average (Mean)

df_replace$score[is.na(df_replace$score)] <-
  mean(df_replace$score, na.rm = TRUE)

df_replace$distance[is.na(df_replace$distance)] <-
  mean(df_replace$distance, na.rm = TRUE)

df_replace$tuition[is.na(df_replace$tuition)] <-
  mean(df_replace$tuition, na.rm = TRUE)

df_replace$wage[is.na(df_replace$wage)] <-
  mean(df_replace$wage, na.rm = TRUE)

# Categorical Features: Replace by Most Frequent (Mode)

mode_gender <- names(which.max(table(df_replace$gender)))
df_replace$gender[is.na(df_replace$gender)] <- mode_gender

mode_ethnicity <- names(which.max(table(df_replace$ethnicity)))
df_replace$ethnicity[is.na(df_replace$ethnicity)] <- mode_ethnicity

mode_fcollege <- names(which.max(table(df_replace$fcollege)))
df_replace$fcollege[is.na(df_replace$fcollege)] <- mode_fcollege

mode_income <- names(which.max(table(df_replace$income)))
df_replace$income[is.na(df_replace$income)] <- mode_income

# Check Missing Values

colSums(is.na(df_replace))

sum(is.na(df_replace))

print(df_replace)

# Save Discard Instances Dataset
write.csv(df_discard, "CollegeDistance_Discard.csv",
          row.names = FALSE)

# Save Mean/Mode Replaced Dataset
write.csv(df_replace, "CollegeDistance_Replace.csv",
          row.names = FALSE)


# Add noise value
df_noisy <- df_replace

# Numerical Noise
df_noisy$score[c(5, 15, 25)] <- -100
df_noisy$distance[c(10, 20, 30)] <- -50
df_noisy$tuition[c(35, 45, 55)] <- -200
df_noisy$education[c(60, 70, 80)] <- 100

# Categorical Noise
df_noisy$gender <- as.character(df_noisy$gender)
df_noisy$income <- as.character(df_noisy$income)

df_noisy$gender[c(6, 16, 26)] <- "Unknown"
df_noisy$income[c(8, 18, 28)] <- "Invalid"

print(df_noisy)

# Detect Noisy Values
# Numerical Noise Detection
sum(df_noisy$score < 0)
sum(df_noisy$distance < 0)
sum(df_noisy$tuition < 0)
sum(df_noisy$education < 12 | df_noisy$education > 18)

# Categorical Noise Detection
table(df_noisy$gender)
table(df_noisy$income)

#Handle Numerical Noise
# Convert invalid numerical values to NA

df_noisy$score[df_noisy$score < 0] <- NA

df_noisy$distance[df_noisy$distance < 0] <- NA

df_noisy$tuition[df_noisy$tuition < 0] <- NA

df_noisy$education[df_noisy$education < 12 |
                     df_noisy$education > 18] <- NA

# Replace NA with Average (Mean)

df_noisy$score[is.na(df_noisy$score)] <-
  mean(df_noisy$score, na.rm = TRUE)

df_noisy$distance[is.na(df_noisy$distance)] <-
  mean(df_noisy$distance, na.rm = TRUE)

df_noisy$tuition[is.na(df_noisy$tuition)] <-
  mean(df_noisy$tuition, na.rm = TRUE)

df_noisy$education[is.na(df_noisy$education)] <-
  mean(df_noisy$education, na.rm = TRUE)

#Handle Categorical Noise
# Convert invalid categorical values to NA

df_noisy$gender[df_noisy$gender == "Unknown"] <- NA

df_noisy$income[df_noisy$income == "Invalid"] <- NA


mode_gender <- names(which.max(table(df_noisy$gender)))

df_noisy$gender[is.na(df_noisy$gender)] <- mode_gender


mode_income <- names(which.max(table(df_noisy$income)))

df_noisy$income[is.na(df_noisy$income)] <- mode_income

# Convert back to Factor

df_noisy$gender <- factor(df_noisy$gender)

df_noisy$income <- factor(df_noisy$income)

#Check After Handling
# Numerical Noise Check
sum(df_noisy$score < 0)
sum(df_noisy$distance < 0)
sum(df_noisy$tuition < 0)
sum(df_noisy$education < 12 | df_noisy$education > 18)

# Categorical Noise Check
table(df_noisy$gender)
table(df_noisy$income)

# Missing Value Check
sum(is.na(df_noisy))


# 5 Check Invalid Data (All 14 Features)
# Numerical Features

sum(df_noisy$score < 0 | df_noisy$score > 100, na.rm = TRUE)

sum(df_noisy$unemp < 0 | df_noisy$unemp > 100, na.rm = TRUE)

sum(df_noisy$wage < 0, na.rm = TRUE)

sum(df_noisy$distance < 0, na.rm = TRUE)

sum(df_noisy$tuition < 0, na.rm = TRUE)

sum(df_noisy$education < 12 | df_noisy$education > 18,
    na.rm = TRUE)


# Categorical Features

sum(!is.na(df_noisy$gender) &
      !df_noisy$gender %in% c("male", "female"))

sum(!is.na(df_noisy$ethnicity) &
      !df_noisy$ethnicity %in% c("afam", "hispanic", "other"))

sum(!is.na(df_noisy$fcollege) &
      !df_noisy$fcollege %in% c("yes", "no"))

sum(!is.na(df_noisy$mcollege) &
      !df_noisy$mcollege %in% c("yes", "no"))

sum(!is.na(df_noisy$home) &
      !df_noisy$home %in% c("yes", "no"))

sum(!is.na(df_noisy$urban) &
      !df_noisy$urban %in% c("yes", "no"))

sum(!is.na(df_noisy$income) &
      !df_noisy$income %in% c("high", "low"))

sum(!is.na(df_noisy$region) &
      !df_noisy$region %in% c("west", "other"))


# Check Missing Values

colSums(is.na(df_noisy))

# 6. Data Normalization and Transformation

df_normalized <- df_noisy

# Min-Max Normalization (Numerical Features)

df_normalized$score <-
  (df_noisy$score - min(df_noisy$score)) /
  (max(df_noisy$score) - min(df_noisy$score))

df_normalized$unemp <-
  (df_noisy$unemp - min(df_noisy$unemp)) /
  (max(df_noisy$unemp) - min(df_noisy$unemp))

df_normalized$wage <-
  (df_noisy$wage - min(df_noisy$wage)) /
  (max(df_noisy$wage) - min(df_noisy$wage))

df_normalized$distance <-
  (df_noisy$distance - min(df_noisy$distance)) /
  (max(df_noisy$distance) - min(df_noisy$distance))

df_normalized$tuition <-
  (df_noisy$tuition - min(df_noisy$tuition)) /
  (max(df_noisy$tuition) - min(df_noisy$tuition))

df_normalized$education <-
  (df_noisy$education - min(df_noisy$education)) /
  (max(df_noisy$education) - min(df_noisy$education))

# Check Normalized Data
summary(df_normalized)

# Data Transformation (Categorical to Numerical)

df_transformed <- df_normalized

df_transformed$gender <-
  as.numeric(factor(df_normalized$gender))

df_transformed$ethnicity <-
  as.numeric(factor(df_normalized$ethnicity))

df_transformed$fcollege <-
  as.numeric(factor(df_normalized$fcollege))

df_transformed$mcollege <-
  as.numeric(factor(df_normalized$mcollege))

df_transformed$home <-
  as.numeric(factor(df_normalized$home))

df_transformed$urban <-
  as.numeric(factor(df_normalized$urban))

df_transformed$income <-
  as.numeric(factor(df_normalized$income))

df_transformed$region <-
  as.numeric(factor(df_normalized$region))

# Check Transformed Data
head(df_transformed)
summary(df_transformed)

# Check Normalized Numerical Features
summary(df_normalized$score)
summary(df_normalized$distance)

# Check Transformed Categorical Features
table(df_transformed$gender)
table(df_transformed$income)

# Check Missing Values
sum(is.na(df_transformed))

# Check Dataset Dimensions
dim(df_transformed)

# 7. Check Data Outliers
  
  # Score
  Q1 <- quantile(df_noisy$score, 0.25)
Q3 <- quantile(df_noisy$score, 0.75)
IQR_value <- Q3 - Q1

sum(df_noisy$score < (Q1 - 1.5 * IQR_value) |
      df_noisy$score > (Q3 + 1.5 * IQR_value))


# Unemployment
Q1 <- quantile(df_noisy$unemp, 0.25)
Q3 <- quantile(df_noisy$unemp, 0.75)
IQR_value <- Q3 - Q1

sum(df_noisy$unemp < (Q1 - 1.5 * IQR_value) |
      df_noisy$unemp > (Q3 + 1.5 * IQR_value))


# Wage
Q1 <- quantile(df_noisy$wage, 0.25)
Q3 <- quantile(df_noisy$wage, 0.75)
IQR_value <- Q3 - Q1

sum(df_noisy$wage < (Q1 - 1.5 * IQR_value) |
      df_noisy$wage > (Q3 + 1.5 * IQR_value))


# Distance
Q1 <- quantile(df_noisy$distance, 0.25)
Q3 <- quantile(df_noisy$distance, 0.75)
IQR_value <- Q3 - Q1

sum(df_noisy$distance < (Q1 - 1.5 * IQR_value) |
      df_noisy$distance > (Q3 + 1.5 * IQR_value))


# Tuition
Q1 <- quantile(df_noisy$tuition, 0.25)
Q3 <- quantile(df_noisy$tuition, 0.75)
IQR_value <- Q3 - Q1

sum(df_noisy$tuition < (Q1 - 1.5 * IQR_value) |
      df_noisy$tuition > (Q3 + 1.5 * IQR_value))


# Education
Q1 <- quantile(df_noisy$education, 0.25)
Q3 <- quantile(df_noisy$education, 0.75)
IQR_value <- Q3 - Q1

sum(df_noisy$education < (Q1 - 1.5 * IQR_value) |
      df_noisy$education > (Q3 + 1.5 * IQR_value))



# 7. Descriptive Statistics (Plot)

# Numerical Features - Histogram

hist(df_noisy$score, main = "Score", xlab = "Score")
hist(df_noisy$unemp, main = "Unemployment", xlab = "Unemployment")
hist(df_noisy$wage, main = "Wage", xlab = "Wage")
hist(df_noisy$distance, main = "Distance", xlab = "Distance")
hist(df_noisy$tuition, main = "Tuition", xlab = "Tuition")
hist(df_noisy$education, main = "Education", xlab = "Education")

# Numerical Features - Boxplot

boxplot(df_noisy$score, main = "Score")
boxplot(df_noisy$unemp, main = "Unemployment")
boxplot(df_noisy$wage, main = "Wage")
boxplot(df_noisy$distance, main = "Distance")
boxplot(df_noisy$tuition, main = "Tuition")
boxplot(df_noisy$education, main = "Education")

# Categorical Features - Bar Plot

barplot(table(df_noisy$gender), main = "Gender")
barplot(table(df_noisy$ethnicity), main = "Ethnicity")
barplot(table(df_noisy$fcollege), main = "Father College")
barplot(table(df_noisy$mcollege), main = "Mother College")
barplot(table(df_noisy$home), main = "Home Ownership")
barplot(table(df_noisy$urban), main = "Urban")
barplot(table(df_noisy$income), main = "Income")
barplot(table(df_noisy$region), main = "Region")

# 7. Descriptive Statistics (Scatter Plot)

# Score vs Education
plot(df_noisy$score, df_noisy$education,
     main = "Score vs Education",
     xlab = "Score",
     ylab = "Education",
     col = "blue", pch = 19)

# Distance vs Education
plot(df_noisy$distance, df_noisy$education,
     main = "Distance vs Education",
     xlab = "Distance",
     ylab = "Education",
     col = "red", pch = 19)

# Tuition vs Education
plot(df_noisy$tuition, df_noisy$education,
     main = "Tuition vs Education",
     xlab = "Tuition",
     ylab = "Education",
     col = "green", pch = 19)

# Wage vs Education
plot(df_noisy$wage, df_noisy$education,
     main = "Wage vs Education",
     xlab = "Wage",
     ylab = "Education",
     col = "purple", pch = 19)

# Unemployment vs Education
plot(df_noisy$unemp, df_noisy$education,
     main = "Unemployment vs Education",
     xlab = "Unemployment",
     ylab = "Education",
     col = "orange", pch = 19)

# Descriptive Statistics

summary(df_noisy)

# 8. Dataset Split (80% Training, 20% Testing)

set.seed(123)

# Total number of rows
n <- nrow(df_noisy)

# Randomly select 80% rows for training
train_index <- sample(1:n, size = round(0.8 * n))

# Training Dataset
train_data <- df_noisy[train_index, ]

# Testing Dataset
test_data <- df_noisy[-train_index, ]

# Check dimensions
dim(train_data)
dim(test_data)

#Create Regression Model
# 9. Feature Selection (Regression Model)

# Remove row index from model data
train_model <- train_data[, names(train_data) != "rownames"]

# Multiple Linear Regression
model <- lm(education ~ ., data = train_model)

# Model Summary
summary(model)

#Feature Selection
# Stepwise Feature Selection

selected_model <- step(model, direction = "both")

# Selected Model Summary
summary(selected_model)

# 9.3 Check Selected Features
# Show Selected Features

names(coef(selected_model))

# Show Selected Model Formula

formula(selected_model)

write.csv(df_noisy,
          "CollegeDistance_Updated.csv",
          row.names = FALSE)