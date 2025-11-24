# Financial Fraud Detection System


This project implements a machine learning pipeline for detecting fraudulent credit card transactions. The system processes transaction data, engineers features, and prepares data for model training and evaluation. The dataset contains transactions made by European cardholders in September 2013, with only 0.173% of transactions being fraudulent, making it a highly imbalanced classification problem.

##  Features

- **Data Loading & Preprocessing**: Automated data loading with stratified train/validation/test splits
- **Feature Engineering**: Comprehensive feature engineering including:
  - Amount-based transformations (log, squared, sqrt)
  - Time-based features (hour, day, cyclical encoding)
  - V-feature aggregations (sum, mean, std, min, max)
  - Interaction features
  - Rolling statistics
- **Data Quality Checks**: Built-in data quality monitoring
- **Database Integration**: PostgreSQL schema for storing raw and processed transactions
<!-- - **Scalable Architecture**: Modular design for easy extension -->




## Data

### Dataset Information

- **Source**: Credit Card Fraud Detection Dataset
- **Total Transactions**: 284,807
- **Fraudulent Transactions**: 492 (0.173%)
- **Features**: 
  - `Time`: Seconds elapsed between transaction and first transaction
  - `V1-V28`: PCA-transformed features (anonymized)
  - `Amount`: Transaction amount
  - `Class`: Target variable (0 = Normal, 1 = Fraud)

### Data Splits

The system automatically creates stratified splits:
- **Training Set**: 70% (199,364 transactions, 345 frauds)
- **Validation Set**: 10% (28,481 transactions, 49 frauds)
- **Test Set**: 20% (56,962 transactions, 98 frauds)

##  Notebooks

### EDA.ipynb
- Data exploration and visualization
- Class distribution analysis
- Feature statistics and distributions
- Missing value analysis

### feature_engineering.ipynb
- Feature engineering pipeline
- Feature creation and transformation
- Data scaling and preprocessing

### model_development.ipynb
- Model training and evaluation
- Hyperparameter tuning
- Model comparison




##  Feature Engineering Details

The feature engineering pipeline creates 53 features from the original 31:

### Amount Features
- `Amount_log`: Log transformation of amount
- `Amount_squared`: Squared amount
- `Amount_sqrt`: Square root of amount

### Time Features
- `Hour`: Hour of day (0-23)
- `Day`: Day number
- `Hour_sin`, `Hour_cos`: Cyclical encoding of hour
- `Is_Night`, `Is_Morning`, `Is_Afternoon`, `Is_Evening`: Time segments

### V-Feature Aggregations
- `V_sum`, `V_mean`, `V_std`, `V_min`, `V_max`: Statistical aggregations

### Interaction Features
- `V14_V12`, `V14_V10`, `V12_V10`: Multiplications of top correlated features

### Rolling Statistics
- `Amount_rolling_mean`, `Amount_rolling_std`: Rolling window statistics
- `Amount_zscore`: Z-score based on rolling statistics





