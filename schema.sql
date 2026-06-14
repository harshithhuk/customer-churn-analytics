-- ========================================
-- CUSTOMER CHURN ANALYTICS DATABASE SCHEMA
-- ========================================
-- MySQL / SQL Server Compatible
-- Date Created: 2024-05-31
-- Purpose: Support business analysis for churn reduction and revenue growth

-- ==========================================
-- TABLE 1: CUSTOMERS
-- ==========================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    signup_date DATE NOT NULL,
    churn_status INT DEFAULT 0 COMMENT '0=Active, 1=Churned',
    lifetime_value DECIMAL(10, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indexes for performance
    INDEX idx_region (region),
    INDEX idx_churn_status (churn_status),
    INDEX idx_signup_date (signup_date)
);

-- ==========================================
-- TABLE 2: PRODUCTS
-- ==========================================
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Indexes
    INDEX idx_category (category),
    INDEX idx_price (price)
);

-- ==========================================
-- TABLE 3: ORDERS
-- ==========================================
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) 
        REFERENCES customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id) 
        REFERENCES products(product_id) ON DELETE CASCADE,
    
    -- Indexes
    INDEX idx_customer_id (customer_id),
    INDEX idx_product_id (product_id),
    INDEX idx_order_date (order_date)
);

-- ==========================================
-- OPTIONAL: VIEWS FOR BUSINESS ANALYSIS
-- ==========================================

-- View 1: Customer Summary with Metrics
CREATE VIEW v_customer_metrics AS
SELECT 
    c.customer_id,
    c.name,
    c.region,
    c.churn_status,
    c.lifetime_value,
    COUNT(o.order_id) as total_orders,
    MAX(o.order_date) as last_order_date,
    ROUND(AVG(o.quantity * p.price), 2) as avg_order_value,
    ROUND(SUM(o.quantity * p.price), 2) as total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name, c.region, c.churn_status, c.lifetime_value;

-- View 2: Revenue by Region
CREATE VIEW v_revenue_by_region AS
SELECT 
    c.region,
    COUNT(DISTINCT c.customer_id) as total_customers,
    SUM(CASE WHEN c.churn_status = 0 THEN 1 ELSE 0 END) as active_customers,
    SUM(CASE WHEN c.churn_status = 1 THEN 1 ELSE 0 END) as churned_customers,
    ROUND(SUM(c.lifetime_value), 2) as total_revenue,
    ROUND(AVG(c.lifetime_value), 2) as avg_customer_value
FROM customers c
GROUP BY c.region;

-- View 3: Product Performance
CREATE VIEW v_product_performance AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    COUNT(o.order_id) as order_count,
    SUM(o.quantity) as total_quantity_sold,
    ROUND(SUM(o.quantity * p.price), 2) as total_revenue,
    ROUND(AVG(o.quantity * p.price), 2) as avg_order_value
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price;

-- ==========================================
-- INDEXES FOR OPTIMIZATION
-- ==========================================
-- Already defined in table creation statements above
-- Additional indexes can be added as needed based on query patterns

-- ==========================================
-- DATA QUALITY CHECKS
-- ==========================================

-- Check 1: Ensure no negative prices
ALTER TABLE products ADD CONSTRAINT chk_price_positive CHECK (price > 0);

-- Check 2: Ensure quantity is positive
ALTER TABLE orders ADD CONSTRAINT chk_quantity_positive CHECK (quantity > 0);

-- Check 3: Ensure churn_status is binary
ALTER TABLE customers ADD CONSTRAINT chk_churn_binary CHECK (churn_status IN (0, 1));

-- ==========================================
-- SAMPLE DATA INSERTION
-- ==========================================
-- Use the customers.csv, orders.csv, products.csv files
-- to populate using: LOAD DATA INFILE or equivalent tool

-- Example insert for verification:
-- INSERT INTO customers (name, region, signup_date, churn_status, lifetime_value)
-- VALUES ('John Smith', 'London', '2023-01-10', 0, 3500.00);

-- ==========================================
-- BACKUP & MAINTENANCE RECOMMENDATIONS
-- ==========================================
-- 1. Weekly full backups of all tables
-- 2. Monthly archival of completed orders (> 6 months old)
-- 3. Quarterly index maintenance and optimization
-- 4. Real-time monitoring of table growth and query performance
