
CREATE DATABASE fraud_detection;
USE fraud_detection;


-- RAW TRANSACTIONS TABLE
-- ========================================================
-- original transaction data before feature engineering
CREATE TABLE IF NOT EXISTS raw_transactions (
    transaction_id BIGSERIAL PRIMARY KEY,
    time FLOAT NOT NULL,
    v1 FLOAT NOT NULL,
    v2 FLOAT NOT NULL,
    v3 FLOAT NOT NULL,
    v4 FLOAT NOT NULL,
    v5 FLOAT NOT NULL,
    v6 FLOAT NOT NULL,
    v7 FLOAT NOT NULL,
    v8 FLOAT NOT NULL,
    v9 FLOAT NOT NULL,
    v10 FLOAT NOT NULL,
    v11 FLOAT NOT NULL,
    v12 FLOAT NOT NULL,
    v13 FLOAT NOT NULL,
    v14 FLOAT NOT NULL,
    v15 FLOAT NOT NULL,
    v16 FLOAT NOT NULL,
    v17 FLOAT NOT NULL,
    v18 FLOAT NOT NULL,
    v19 FLOAT NOT NULL,
    v20 FLOAT NOT NULL,
    v21 FLOAT NOT NULL,
    v22 FLOAT NOT NULL,
    v23 FLOAT NOT NULL,
    v24 FLOAT NOT NULL,
    v25 FLOAT NOT NULL,
    v26 FLOAT NOT NULL,
    v27 FLOAT NOT NULL,
    v28 FLOAT NOT NULL,
    amount FLOAT NOT NULL,
    class INTEGER NOT NULL CHECK (class IN (0, 1)),  -- 0: Normal, 1: Fraud
    dataset_split VARCHAR(20) CHECK (dataset_split IN ('train', 'validation', 'test', 'production')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_time (time),
    INDEX idx_class (class),
    INDEX idx_dataset_split (dataset_split),
    INDEX idx_created_at (created_at)
);

-- PROCESSED TRANSACTIONS TABLE
-- ================================================
-- Stores transactions with engineered features
CREATE TABLE IF NOT EXISTS processed_transactions (
    transaction_id BIGINT PRIMARY KEY,
    raw_transaction_id BIGINT,
    
    time FLOAT NOT NULL,
    v1 FLOAT NOT NULL,
    v2 FLOAT NOT NULL,
    v3 FLOAT NOT NULL,
    v4 FLOAT NOT NULL,
    v5 FLOAT NOT NULL,
    v6 FLOAT NOT NULL,
    v7 FLOAT NOT NULL,
    v8 FLOAT NOT NULL,
    v9 FLOAT NOT NULL,
    v10 FLOAT NOT NULL,
    v11 FLOAT NOT NULL,
    v12 FLOAT NOT NULL,
    v13 FLOAT NOT NULL,
    v14 FLOAT NOT NULL,
    v15 FLOAT NOT NULL,
    v16 FLOAT NOT NULL,
    v17 FLOAT NOT NULL,
    v18 FLOAT NOT NULL,
    v19 FLOAT NOT NULL,
    v20 FLOAT NOT NULL,
    v21 FLOAT NOT NULL,
    v22 FLOAT NOT NULL,
    v23 FLOAT NOT NULL,
    v24 FLOAT NOT NULL,
    v25 FLOAT NOT NULL,
    v26 FLOAT NOT NULL,
    v27 FLOAT NOT NULL,
    v28 FLOAT NOT NULL,
    amount FLOAT NOT NULL,
    
    -- Engineered features
    amount_log FLOAT,
    amount_squared FLOAT,
    amount_sqrt FLOAT,
    hour FLOAT,
    day INTEGER,
    hour_sin FLOAT,
    hour_cos FLOAT,
    is_night INTEGER CHECK (is_night IN (0, 1)),
    is_morning INTEGER CHECK (is_morning IN (0, 1)),
    is_afternoon INTEGER CHECK (is_afternoon IN (0, 1)),
    is_evening INTEGER CHECK (is_evening IN (0, 1)),
    v_sum FLOAT,
    v_mean FLOAT,
    v_std FLOAT,
    v_min FLOAT,
    v_max FLOAT,
    v14_v12 FLOAT,
    v14_v10 FLOAT,
    v12_v10 FLOAT,
    amount_rolling_mean FLOAT,
    amount_rolling_std FLOAT,
    amount_zscore FLOAT,
    
    -- Target variable
    class INTEGER CHECK (class IN (0, 1)),
    
    -- -- Metadata
    -- dataset_split VARCHAR(20) CHECK (dataset_split IN ('train', 'validation', 'test', 'production')),
    -- processed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (raw_transaction_id) REFERENCES raw_transactions(transaction_id) ON DELETE CASCADE,
    INDEX idx_raw_transaction_id (raw_transaction_id),
    INDEX idx_class (class),
    INDEX idx_dataset_split (dataset_split),
    INDEX idx_processed_at (processed_at)
);


-- DATA QUALITY CHECKS TABLE
-- ============
-- Tracks data quality checks and issues
CREATE TABLE IF NOT EXISTS data_quality_checks (
    check_id SERIAL PRIMARY KEY,
    check_name VARCHAR(100) NOT NULL,
    check_type VARCHAR(50) NOT NULL,  -- e.g., 'missing_values', 'outliers', 'distribution_shift'
    check_status VARCHAR(20) DEFAULT 'pending' CHECK (check_status IN ('pending', 'passed', 'failed', 'warning')),
    check_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    affected_table VARCHAR(100),
    affected_rows INTEGER,
    check_details JSONB,  -- Store detailed check results
    resolution_notes TEXT,
    resolved_at TIMESTAMP,
    
    INDEX idx_check_status (check_status),
    INDEX idx_check_type (check_type),
    INDEX idx_check_date (check_date)
);

