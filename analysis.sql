-- ========================================
-- CUSTOMER CHURN & SALES ANALYTICS
-- ========================================

-- 1. REVENUE ANALYSIS BY REGION
SELECT
    c.region,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    SUM(CASE WHEN c.churn_status = 0 THEN 1 ELSE 0 END) AS active_customers,
    SUM(CASE WHEN c.churn_status = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (SUM(CASE WHEN c.churn_status = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT c.customer_id)), 
        2
    ) AS churn_rate_pct,
    ROUND(SUM(c.lifetime_value), 2) AS total_revenue,
    ROUND(AVG(c.lifetime_value), 2) AS avg_customer_value
FROM customers c
GROUP BY c.region
ORDER BY total_revenue DESC;

-- 2. CHURN RISK CUSTOMERS - MARKETING FOCUS
SELECT
    c.customer_id,
    c.name,
    c.region,
    c.signup_date,
    c.lifetime_value,
    COUNT(o.order_id) AS order_count,
    MAX(o.order_date) AS last_order_date,
    DATEDIFF(DAY, MAX(o.order_date), '2024-05-31') AS days_since_last_order,
    CASE 
        WHEN DATEDIFF(DAY, MAX(o.order_date), '2024-05-31') > 90 THEN 'High Risk'
        WHEN DATEDIFF(DAY, MAX(o.order_date), '2024-05-31') > 60 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE c.churn_status = 1
GROUP BY c.customer_id, c.name, c.region, c.signup_date, c.lifetime_value
ORDER BY days_since_last_order DESC;

-- 3. TOTAL REVENUE ANALYSIS
SELECT
    ROUND(SUM(o.quantity * p.price), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(AVG(o.quantity * p.price), 2) AS avg_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- 4. REVENUE BY PRODUCT CATEGORY
SELECT
    p.category,
    p.product_name,
    COUNT(o.order_id) AS order_count,
    SUM(o.quantity) AS total_quantity,
    ROUND(SUM(o.quantity * p.price), 2) AS category_revenue,
    ROUND(AVG(o.quantity * p.price), 2) AS avg_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category, p.product_name
ORDER BY category_revenue DESC;

-- 5. CUSTOMER SEGMENTATION - RETENTION TARGETS
SELECT
    c.customer_id,
    c.name,
    c.region,
    c.lifetime_value,
    c.churn_status,
    COUNT(o.order_id) AS purchase_frequency,
    ROUND(AVG(o.quantity * p.price), 2) AS avg_purchase_value,
    CASE 
        WHEN c.lifetime_value > 5000 THEN 'VIP'
        WHEN c.lifetime_value > 3000 THEN 'Premium'
        WHEN c.lifetime_value > 1500 THEN 'Standard'
        ELSE 'At-Risk'
    END AS customer_segment
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.name, c.region, c.lifetime_value, c.churn_status
ORDER BY c.lifetime_value DESC;

-- 6. MONTHLY REVENUE TREND
SELECT
    CONVERT(DATE, o.order_date) AS order_date,
    COUNT(DISTINCT o.order_id) AS daily_orders,
    ROUND(SUM(o.quantity * p.price), 2) AS daily_revenue,
    ROUND(AVG(o.quantity * p.price), 2) AS avg_daily_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY CONVERT(DATE, o.order_date)
ORDER BY order_date DESC;

-- 7. KEY PERFORMANCE INDICATORS (KPIs)
SELECT
    'Total Revenue' AS kpi_name,
    CAST(SUM(o.quantity * p.price) AS VARCHAR(20)) AS kpi_value,
    'GBP' AS unit
FROM orders o
JOIN products p ON o.product_id = p.product_id
UNION ALL
SELECT 'Churn Rate %', 
    CAST(ROUND((SUM(CASE WHEN churn_status = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS VARCHAR(20)),
    '%'
FROM customers
UNION ALL
SELECT 'Average Customer Value',
    CAST(ROUND(AVG(lifetime_value), 2) AS VARCHAR(20)),
    'GBP'
FROM customers
UNION ALL
SELECT 'Total Customers',
    CAST(COUNT(*) AS VARCHAR(20)),
    'Count'
FROM customers;
