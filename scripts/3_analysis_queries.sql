-- ==========================================
-- Yelp Data Analysis and Insights
-- ==========================================

-- This script contains 10 useful SQL queries 
-- for analyzing Yelp business and review data.

-- ==========================================
-- 1. Number of Businesses in Each Category
-- ==========================================
-- Counts how many businesses exist in each category.
SELECT category, COUNT(*) 
FROM (
    SELECT business_id, TRIM(value) AS category
    FROM tbl_yelp_businesses,
         LATERAL SPLIT_TO_TABLE(categories, ',') value
)
GROUP BY category
ORDER BY COUNT(*) DESC;

-- ==========================================
-- 2. Top 10 Users Reviewing Restaurant Businesses
-- ==========================================
-- Identifies top users based on number of distinct restaurants reviewed.
SELECT r.user_id, COUNT(DISTINCT r.business_id)
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b ON r.business_id = b.business_id
WHERE b.categories ILIKE '%restaurants%'
GROUP BY r.user_id
ORDER BY 2 DESC
LIMIT 10;

-- ==========================================
-- 3. Most Popular Categories (Based on Review Count)
-- ==========================================
-- Shows categories with the most reviews.
SELECT category, COUNT(*) 
FROM (
    SELECT business_id, TRIM(value) AS category
    FROM tbl_yelp_businesses,
         LATERAL SPLIT_TO_TABLE(categories, ',') value
) cte
JOIN tbl_yelp_reviews r ON cte.business_id = r.business_id
GROUP BY category
ORDER BY COUNT(*) DESC;

-- ==========================================
-- 4. Top 3 Most Recent Reviews per Business
-- ==========================================
-- Displays the 3 latest reviews for each business.
WITH cte AS (
    SELECT r.*, b.name,
           ROW_NUMBER() OVER (PARTITION BY r.business_id ORDER BY review_date DESC) as rn
    FROM tbl_yelp_reviews r
    JOIN tbl_yelp_businesses b ON r.business_id = b.business_id
)
SELECT * FROM cte WHERE rn <= 3;

-- ==========================================
-- 5. Month with Highest Number of Reviews
-- ==========================================
-- Analyzes review volume by month.
SELECT MONTH(review_date) as review_month, COUNT(*) as review_count
FROM tbl_yelp_reviews
GROUP BY review_month
ORDER BY review_count DESC;

-- ==========================================
-- 6. Percentage of 5-Star Reviews for Each Business
-- ==========================================
-- Calculates how many 5-star reviews each business received.
SELECT 
    b.business_id, b.name,
    COUNT(*) AS total_reviews,
    SUM(CASE WHEN r.review_stars = 5 THEN 1 ELSE 0 END) AS star5_reviews,
    (SUM(CASE WHEN r.review_stars = 5 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS percent_5_star
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b ON r.business_id = b.business_id
GROUP BY b.business_id, b.name;

-- ==========================================
-- 7. Top 5 Most Reviewed Businesses per City
-- ==========================================
-- Finds the most reviewed businesses in each city.
WITH cte AS (
    SELECT b.city, b.business_id, b.name, COUNT(*) AS total_reviews
    FROM tbl_yelp_reviews r
    JOIN tbl_yelp_businesses b ON r.business_id = b.business_id
    GROUP BY b.city, b.business_id, b.name
)
SELECT *
FROM cte 
QUALIFY ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_reviews DESC) <= 5;

-- ==========================================
-- 8. Average Rating for Businesses with ≥100 Reviews
-- ==========================================
-- Focuses on businesses with enough review data to calculate reliable averages.
SELECT b.business_id, b.name, COUNT(*) AS total_reviews,
       AVG(review_stars) AS average_rating
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b ON r.business_id = b.business_id
GROUP BY b.business_id, b.name
HAVING COUNT(*) >= 100;

-- ==========================================
-- 9. Top 10 Most Active Reviewers and Their Reviewed Businesses
-- ==========================================
-- Lists businesses reviewed by the 10 most active users.
WITH cte AS (
    SELECT user_id, COUNT(*) AS total_reviews
    FROM tbl_yelp_reviews
    GROUP BY user_id
    ORDER BY total_reviews DESC
    LIMIT 10
)
SELECT r.user_id, r.business_id
FROM tbl_yelp_reviews r
WHERE r.user_id IN (SELECT user_id FROM cte)
GROUP BY r.user_id, r.business_id
ORDER BY r.user_id;

-- ==========================================
-- 10. Top 10 Businesses with Most Positive Reviews
-- ==========================================
-- Highlights businesses receiving the most positive feedback.
SELECT r.business_id, b.name, COUNT(*) AS total_reviews
FROM tbl_yelp_reviews r
JOIN tbl_yelp_businesses b ON r.business_id = b.business_id
WHERE sentiments = 'Positive'
GROUP BY r.business_id, b.name
ORDER BY total_reviews DESC
LIMIT 10;
