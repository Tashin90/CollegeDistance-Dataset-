# CollegeDistance Dataset — Introduction to Data Science Midterm Project

This repository is intended to contain an R-based midterm project built on the
**CollegeDistance** dataset. The documented workflow covers practical data
preprocessing, data quality improvement, exploratory analysis, and
regression-oriented feature preparation.

## Repository Contents

- `README.md` — Project overview and workflow documentation.

The R source file, raw dataset, and processed CSV outputs described below are
not currently committed to this repository. Add those artifacts before
describing the analysis as reproducible or running the workflow from a fresh
clone.

## Documented Workflow

### 1) Missing Value Creation and Handling
- Create controlled missing-value scenarios for analysis.
- Apply missing-value handling strategies:
  - **Discard Instances**
  - **Mean/Mode imputation** (based on attribute type)

### 2) Noise Detection and Handling
- Check and handle:
  - **Numerical noise** (unexpected numeric anomalies)
  - **Categorical noise** (inconsistent/invalid category values)

### 3) Invalid Data Checking
- Validate logically incorrect or out-of-range values.
- Correct or remove invalid records according to preprocessing rules.

### 4) Data Normalization and Transformation
- Apply normalization/transformation to prepare features for modeling.
- Ensure numeric attributes are on comparable scales where required.

### 5) Outlier Detection
- Identify outliers using statistical/visual techniques.
- Treat outliers according to the project’s preprocessing strategy.

### 6) Descriptive Statistics and Visualization
- Generate descriptive statistics to summarize central tendency and spread.
- Produce scatter plots to observe relationships between key variables.

### 7) Train/Test Split
- Split data into:
  - **80% Training set**
  - **20% Testing set**

### 8) Regression-Based Feature Selection
- Use regression-oriented analysis to evaluate and select influential features.

## Expected Project Artifacts

When the analysis is added, the repository should contain:

- `College_dataset.R` — R script for the preprocessing and analysis workflow.
- `CollegeDistance.csv` — Original/raw dataset.
- Processed CSV files generated during preprocessing and transformation.

## Tools and Environment

- **Language:** R
- **Project type:** Introduction to Data Science Midterm Project
- **Repository:** `Tashin90/CollegeDistance-Dataset-`
