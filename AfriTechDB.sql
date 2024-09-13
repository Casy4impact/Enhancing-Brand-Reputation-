CREATE DATABASE AfriTechDB;

CREATE TABLE stagingdata (
    CustomerID INT,            			   -- Unique identifier for each customer
    CustomerName TEXT,               		   -- Name of the customer
    Region TEXT,                     		   -- Region associated with the customer
    Age INT,                                  -- Age of the customer
    Income NUMERIC(10, 2),                    -- Income of the customer
    CustomerType TEXT,               		   -- Type of customer (e.g., 'New', 'Returning', 'VIP')
    TransactionYear INT,                      -- Year of the transaction
    TransactionDate DATE,                     -- Date of the transaction
    ProductPurchased TEXT,            		   -- Product purchased (e.g., 'Smartphone', 'Tablet')
    PurchaseAmount NUMERIC(10, 2),            -- Amount spent on the purchase
    ProductRecalled BOOLEAN,                  -- Indicates if the product was recalled
    Competitor TEXT,              			   -- Competitor associated with the transaction
    InteractionDate DATE,                     -- Date of the social media interaction
    Platform TEXT,                    		   -- Social media platform (e.g., 'Twitter', 'Facebook')
    PostType text,                   		   -- Type of social media post (e.g., 'Text', 'Image')
    EngagementLikes INT,                      -- Number of likes the post received
    EngagementShares INT,                     -- Number of shares or retweets
    EngagementComments INT,                   -- Number of comments on the post
    UserFollowers INT,                        -- Number of followers the user has
    InfluencerScore NUMERIC(5, 2),            -- Score representing the influence of the user
    BrandMention BOOLEAN,                     -- Indicates if the post mentioned the brand
    CompetitorMention BOOLEAN,                -- Indicates if the post mentioned a competitor
    Sentiment TEXT,                    	   -- Sentiment of the post (e.g., 'Positive', 'Neutral', 'Negative')
    CrisisEventTime DATE,                     -- Date of a crisis event mentioned in a negative post
    FirstResponseTime DATE,                   -- Date of the first response to a negative post
    ResolutionStatus BOOLEAN,                 -- Indicates if the crisis was resolved
    NPSResponse INT                           -- Net Promoter Score (NPS) response associated with the post
);

-- Verify the Imported Data: 
-- Run a quick query to ensure the data is correctly imported and the columns have the right data types:
SELECT * FROM stagingdata LIMIT 10;

-- Check Data Integrity: 
-- You might want to run some data integrity checks to ensure there are no missing values or incorrect data types. For example:
-- Check for null values
SELECT * 
FROM stagingdata
WHERE CustomerID IS NULL;

-- Verify specific column data types
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'stagingdata';

-- Table to store customer information
CREATE TABLE Customerdata (
    CustomerID INT PRIMARY KEY,               -- Unique identifier for each customer
    CustomerName TEXT,                		   -- Name of the customer
    Region TEXT,                       	   -- Region associated with the customer
    Age INT,                                  -- Age of the customer
    Income NUMERIC(10, 2),                    -- Income of the customer
    CustomerType TEXT                  -- Type of customer (e.g., 'New', 'Returning', 'VIP')
);


-- Table to store transaction information
CREATE TABLE Transactions (
    TransactionID SERIAL PRIMARY KEY,          -- Unique identifier for each transaction
    CustomerID INT,                            -- Reference to Customerdata table
    TransactionYear INT,               		-- Year of the transaction
    TransactionDate DATE,                      -- Date of the transaction
    ProductPurchased TEXT,                     -- Product purchased (e.g., 'Smartphone', 'Tablet')		
    PurchaseAmount NUMERIC(10, 2),             -- Amount spent on the purchase
    ProductRecalled BOOLEAN,                   -- Indicates if the product was recalled
    Competitor TEXT, 	                    -- Indicates if the post mentioned a competitor
    FOREIGN KEY (CustomerID) REFERENCES Customerdata(CustomerID) -- Foreign key reference to Customerdata 
);

-- Table to store social media interactions
CREATE TABLE SocialMediaInteractions (
    InteractionID SERIAL PRIMARY KEY,          -- Unique identifier for each social media interaction
    CustomerID INT,                            -- Reference to Customerdata table
    InteractionDate DATE,                      -- Date of the social media interaction
    Platform TEXT,      	                   -- Social media platform (e.g., 'Twitter', 'Facebook')
    PostType TEXT,		                       -- Type of social media post (e.g., 'Text', 'Image')
    EngagementLikes INT,                       -- Number of likes the post received
    EngagementShares INT,                      -- Number of shares or retweets
    EngagementComments INT,                    -- Number of comments on the post
    UserFollowers INT,                         -- Number of followers the user has
    InfluencerScore NUMERIC(10, 2),            -- Score representing the influence of the user
    BrandMention BOOLEAN,                      -- Indicates if the post mentioned the brand
    CompetitorMention BOOLEAN,                 -- Indicates if the post mentioned a competitor
    Sentiment TEXT,                            -- Sentiment of the post (e.g., 'Positive', 'Neutral', 'Negative')
    CrisisEventTime DATE,                      -- Date of a crisis event mentioned in a negative post
    FirstResponseTime DATE,                    -- Date of the first response to a negative post
    ResolutionStatus BOOLEAN,                  -- Indicates if the crisis was resolved
    NPSResponse INT,                           -- Net Promoter Score (NPS) response associated with the post
    FOREIGN KEY (CustomerID) REFERENCES Customerdata(CustomerID) -- Foreign key reference to Customerdata
);

-- Insert data from Stagingdata into the Target Tables

-- Insert Customer Data
INSERT INTO Customerdata(CustomerID, CustomerName, Region, Age, Income, CustomerType)
SELECT DISTINCT CustomerID, CustomerName, Region, Age, Income, CustomerType
FROM stagingdata;

-- Insert Transaction data
INSERT INTO Transactions(CustomerID, TransactionYear, TransactionDate, ProductPurchased, PurchaseAmount, ProductRecalled, Competitor)
SELECT CustomerID, TransactionYear, TransactionDate, ProductPurchased, PurchaseAmount, ProductRecalled, Competitor
FROM stagingdata WHERE TransactionDate IS NOT NULL;

-- Insert Social Media Data
INSERT INTO SocialMediaInteractions 
(CustomerID, InteractionDate, Platform, PostType, EngagementLikes, EngagementShares, EngagementComments, UserFollowers, InfluencerScore, BrandMention, CompetitorMention, Sentiment, CrisisEventTime, FirstResponseTime, ResolutionStatus, NPSResponse)
SELECT CustomerID, InteractionDate, Platform, PostType, EngagementLikes, EngagementShares, EngagementComments, UserFollowers, InfluencerScore, BrandMention, CompetitorMention, Sentiment, CrisisEventTime, FirstResponseTime, ResolutionStatus, NPSResponse
FROM stagingdata 
WHERE InteractionDate IS NOT NULL; 

DROP TABLE stagingdata;

-- EDA
-- Data Validation
SELECT COUNT(*) 
FROM customerdata;

SELECT COUNT(*) 
FROM socialmediainteractions;

SELECT COUNT(*) 
FROM Transactions;

SELECT * 
FROM Transactions;

SELECT * 
FROM customerdata
LIMIT 5;

SELECT * 
FROM socialmediainteractions
LIMIT 5;

SELECT * 
FROM Transactions
LIMIT 5;

-- Identifying Missing Columns
SELECT COUNT(*) FROM customerdata
WHERE customerid IS NULL;

SELECT COUNT(*) FROM socialmediainteractions
WHERE interactionid IS NULL;

SELECT COUNT(*) FROM socialmediainteractions
WHERE crisiseventtime IS NULL;

SELECT COUNT(*) FROM socialmediainteractions
WHERE firstresponsetime IS NULL;

SELECT COUNT(*) FROM socialmediainteractions
WHERE sentiment IS NULL;

SELECT COUNT(*) FROM socialmediainteractions
WHERE resolutionstatus IS NULL;

SELECT COUNT(*) FROM socialmediainteractions
WHERE npsresponse IS NULL;

SELECT COUNT(*) FROM Transactions
WHERE transactionid IS NULL;

SELECT COUNT(*) FROM Transactions
WHERE competitor IS NULL;

-- Identifying Missing Columns Customer table
SELECT * FROM customerdata
WHERE customerid IS NULL
	 OR CustomerName IS NULL               		
     OR Region IS NULL                       	   
     OR Age IS NULL                                 
     OR Income IS NULL                    
     OR CustomerType IS NULL;

-- Identifying Missing Columns from Customer table
SELECT 
customerid,
CustomerName,                		
Region,                   	   
Age,                                 
Income,                     
CustomerType 
FROM customerdata
WHERE customerid IS NULL
	 OR CustomerName IS NULL               		
     OR Region IS NULL                       	   
     OR Age IS NULL                                 
     OR Income IS NULL                    
     OR CustomerType IS NULL;

-- Identifying Missing Columns from social media table
SELECT COUNT(*)
FROM socialmediainteractions
WHERE CustomerID IS NULL
	OR InteractionDate IS NULL
	OR Platform IS NULL 
	OR PostType IS NULL 
	OR EngagementLikes IS NULL 
	OR EngagementShares IS NULL 
	OR EngagementComments IS NULL 
	OR UserFollowers IS NULL 
	OR InfluencerScore IS NULL 
	OR BrandMention IS NULL 
	OR CompetitorMention IS NULL 
	OR Sentiment IS NULL 
	OR CrisisEventTime IS NULL 
	OR FirstResponseTime IS NULL 
	OR ResolutionStatus IS NULL 
	OR NPSResponse IS NULL;

SELECT *
FROM socialmediainteractions
WHERE CustomerID IS NULL
	OR InteractionDate IS NULL
	OR Platform IS NULL 
	OR PostType IS NULL 
	OR EngagementLikes IS NULL 
	OR EngagementShares IS NULL 
	OR EngagementComments IS NULL 
	OR UserFollowers IS NULL 
	OR InfluencerScore IS NULL 
	OR BrandMention IS NULL 
	OR CompetitorMention IS NULL 
	OR Sentiment IS NULL 
	OR CrisisEventTime IS NULL 
	OR FirstResponseTime IS NULL 
	OR ResolutionStatus IS NULL 
	OR NPSResponse IS NULL;

-- Identifying Missing Columns from social media table
SELECT 
CustomerID, 
InteractionDate, 
Platform, 
PostType, 
EngagementLikes, 
EngagementShares, 
EngagementComments, 
UserFollowers, 
InfluencerScore, 
BrandMention, 
CompetitorMention, 
Sentiment, 
CrisisEventTime, 
FirstResponseTime, 
ResolutionStatus, 
NPSResponse
FROM socialmediainteractions
WHERE CustomerID IS NULL
	OR InteractionDate IS NULL
	OR Platform IS NULL 
	OR PostType IS NULL 
	OR EngagementLikes IS NULL 
	OR EngagementShares IS NULL 
	OR EngagementComments IS NULL 
	OR UserFollowers IS NULL 
	OR InfluencerScore IS NULL 
	OR BrandMention IS NULL 
	OR CompetitorMention IS NULL 
	OR Sentiment IS NULL 
	OR CrisisEventTime IS NULL 
	OR FirstResponseTime IS NULL 
	OR ResolutionStatus IS NULL 
	OR NPSResponse IS NULL;

-- Identifying columns without null vales 
SELECT 'customerName' AS ColumnName, COUNT(*) AS NullCount
FROM customerdata
WHERE CustomerName IS NOT Null
UNION
SELECT 'Region' AS columnName, COUNT(*) AS NullCount
FROM customerdata
WHERE Region IS NOT NULL;

-- EDA

-- Data Types and Summary Statistics:
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name IN ('customerdata', 'socialmediainteractions', 'transactions');

SELECT AVG(Income), MIN(Age), MAX(Age), AVG(PurchaseAmount)
FROM customerdata, Transactions;

-- Relationship between Age and Income
SELECT Age, ROUND(AVG(Income),2) AS Avg_Income 
FROM customerdata 
GROUP BY Age;

-- Customer Demographics
SELECT region, COUNT(*) AS CustomerCount
FROM customerdata
GROUP BY region

SELECT COUNT(DISTINCT customerid) AS UniqueCustomer
FROM customerdata;


-- Transanctions EDA
SELECT 
	AVG(purchaseamount) AS Avg_Purchage_Amount,
	MIN(purchaseamount) AS Min_Purchage_Amount,
	MAX(purchaseamount) AS Max_Purchage_Amount,
	SUM(purchaseamount) AS Total_Sales
FROM transactions;

-- Transanctions EDA
SELECT 
	TO_CHAR(AVG(purchaseamount), '$999,999,999.99') AS Avg_Purchage_Amount,
	TO_CHAR(MIN(purchaseamount), '$999,999,999.99') AS Min_Purchage_Amount,
	TO_CHAR(MAX(purchaseamount), '$999,999,999.99') AS Max_Purchage_Amount,
	TO_CHAR(SUM(purchaseamount),'$999,999,999,999.99') AS Total_Sales
FROM transactions;

-- -- Sales By Products and Qty
SELECT
	ProductPurchased,
	COUNT(*) AS Number_Of_Sales,
	Sum(PurchaseAmount) As Total_Sales
	FROM Transactions
	GROUP BY ProductPurchased;

-- Sales By Products and Qty  ($ sign added)
SELECT
	ProductPurchased,
	COUNT(*) AS Number_Of_Sales,
	TO_CHAR(Sum(PurchaseAmount), '$999,999,999.99') As Total_Sales
	FROM Transactions
	GROUP BY ProductPurchased;

SELECT
	ProductPurchased,
	COUNT(*) AS Number_Of_Sales,
	TO_CHAR(Sum(PurchaseAmount), '$999,999,999.99') As Total_Sales
	FROM Transactions
	WHERE ProductPurchased IS NOT NULL
	GROUP BY ProductPurchased;

-- Product Recalled By Qty and Avg Amount
SELECT
	ProductRecalled,
	COUNT(*) AS Transaction_Count,
	To_CHAR(AVG(PurchaseAmount), '$999,999,999.99') As Avg_Amount
	FROM Transactions
	WHERE PurchaseAmount IS NOT NULL
	GROUP BY ProductRecalled;


-- Social Media EDA
-- Platform BY Total Likes and  Avg Likes 
SELECT 
	Platform,
	ROUND(AVG(EngagementLikes), 2) AS AvgLikes,
	ROUND(SUM(EngagementLikes), 2) AS TotalLikes
FROM socialmediainteractions
GROUP BY PLatform;

--  Count of Sentiments
SELECT
	sentiment,
	COUNT (*) AS Sentiment_Count
FROM socialmediainteractions
WHERE sentiment IS NOT NULL
GROUP BY sentiment;

-- Count of Platform and Sentiment
SELECT 
	'Platform' AS ColumnName,
	COUNT(*) AS NullCount
FROM socialmediainteractions
WHERE Platform IS NOT NULL
UNION
SELECT 
	'Sentiment' As ColumnName,
	COUNT(*) AS NullCount
FROM socialmediainteractions
WHERE sentiment IS NOT NULL;

-- Count the total number of brand mentioned across social media platforms
SELECT COUNT(*) AS Number_Of_Mentions
FROM socialmediainteractions
WHERE brandmention = 'TRUE';

SELECT platform, COUNT(*) AS Number_Of_Mentions
FROM socialmediainteractions
WHERE brandmention = 'TRUE'
GROUP BY platform
ORDER BY platform DESC;

-- Sentiment Score 
SELECT sentiment, COUNT(*) * 100/ (SELECT COUNT(*) FROM socialmediainteractions) AS Percentage
FROM socialmediainteractions
GROUP BY sentiment
ORDER BY sentiment DESC;


-- Engageement Rate
SELECT AVG((EngagementLikes + Engagementshares + Engagementcomments) / 
NULLIF(userfollowers, 0)) AS EngagementRate
FROM socialmediainteractions;

-- Brand mention by competition mention 
SELECT 
	SUM(CASE WHEN brandmention = 'TRUE' THEN 1 ELSE 0 END) AS BrandMentions,
	SUM(CASE WHEN competitormention = 'TRUE' THEN 1 ELSE 0 END) AS CompetitorMentions
FROM socialmediainteractions;

-- Influencer Score
SELECT ROUND(AVG(influencerscore), 2) AS AVG_Influencer_Score
FROM socialmediainteractions;

-- Time Trend Analysis
SELECT TO_CHAR(DATE_TRUNC('month', interactiondate), 'YYYY-MM') AS Month,
COUNT(*) AS mention 
FROM socialmediainteractions
WHERE brandmention = 'TRUE'
GROUP BY month;

-- Time Trend Analysis: Monthly and Platform Trends
SELECT TO_CHAR(DATE_TRUNC('month', interactiondate), 'YYYY-MM') AS Month,
COUNT(*) AS mention, platform
FROM socialmediainteractions
WHERE brandmention = 'TRUE'
GROUP BY month, platform;


-- Crisis Response Over Time
SELECT AVG(
    DATE_PART('epoch', CAST(firstresponsetime AS TIMESTAMP) - CAST(crisiseventtime AS TIMESTAMP))) / 3600 AS AVG_Response_Time_Hours
FROM socialmediainteractions
WHERE crisiseventtime IS NOT NULL AND firstresponsetime IS NOT NULL;

-- Resolution Rate
SELECT COUNT(*) * 100.0/ 
(SELECT COUNT(*) FROM socialmediainteractions WHERE crisiseventtime IS NOT NULL) AS Resolution_Rate
FROM socialmediainteractions
WHERE resolutionstatus = 'TRUE'

-- Top Influencer score
SELECT customerid, round(AVG(influencerscore), 0) AS Influencer_Score
FROM socialmediainteractions
GROUP BY customerid
ORDER BY Influencer_Score
LIMIT 5;

-- Content Effectiveness
SELECT posttype, ROUND(AVG(EngagementLikes + Engagementshares + Engagementcomments), 2) AS Engagement 
FROM socialmediainteractions
GROUP BY posttype
ORDER BY Engagement DESC;

-- Total Revenue by Platform
SELECT s.platform, SUM(t.purchaseamount) AS Total_Revenue
FROM socialmediainteractions s
LEFT JOIN transactions t ON s.customerid = t.customerid
WHERE t.purchaseamount IS NOT NULL
GROUP BY s.platform
ORDER BY Total_Revenue DESC;

-- Total Revenue by Platform ($ sign added)
SELECT s.platform, TO_CHAR(SUM(t.purchaseamount), '$9,999,999,9999.99') AS Total_Revenue
FROM socialmediainteractions s
LEFT JOIN transactions t ON s.customerid = t.customerid
WHERE t.purchaseamount IS NOT NULL
GROUP BY s.platform
ORDER BY Total_Revenue DESC;

-- Top Buying Customers by Region
SELECT
	c.customerid,
	c.customername,
	c.region,
	COALESCE(SUM(t.purchaseamount),0) AS Total_Purchase_Amount
FROM customerdata c
LEFT JOIN transactions t ON c.customerid = t.customerid
GROUP BY c.customerid, c.customername, c.region
ORDER BY Total_Purchase_Amount DESC
LIMIT 10;

-- Average Engagement Metrics by Product
SELECT
	t.productpurchased,
	AVG(s.EngagementLikes) AS Avg_Likes,
	AVG(s.Engagementshares) AS Avg_shares,
	AVG(s.Engagementcomments) AS Avg_Comments	
FROM transactions t
LEFT JOIN socialmediainteractions s ON t.customerid = s.customerid
GROUP BY t.productpurchased
ORDER BY Avg_Likes, Avg_shares, Avg_Comments DESC;

-- Products with Negative Buzz and Product Recalls
with NegativeBuzzAndRecalls AS (
	SELECT
		t.ProductPurchased,
		COUNT(DISTINCT CASE WHEN s.sentiment = 'Negative' THEN s.customerid END) AS NegativeBuzzCount,
		COUNT(DISTINCT CASE WHEN t.productrecalled = TRUE THEN t.customerid END) AS RecalledCount
	FROM transactions t
	LEFT JOIN socialmediainteractions s ON t.customerid = s.customerid
	GROUP BY t.ProductPurchased
)
SELECT
	n.ProductPurchased,
	n.NegativeBuzzCount,
	n.RecalledCount
FROM NegativeBuzzAndRecalls n
WHERE n.NegativeBuzzCount > 0 OR n.RecalledCount > 0;


-- Creating a view for brand mentions
Create or Replace VIEW Brandmentions AS
SELECT
	interactiondate,
	COUNT(*) BrandMentionCount
FROM socialmediainteractions
WHERE Brandmention
GROUP BY interactiondate
ORDER BY interactiondate;

-- Creating a view for brand mentions
CREATE OR REPLACE VIEW BrandMentions AS
SELECT
    interactiondate,
    COUNT(*) AS BrandMentionCount
FROM socialmediainteractions
WHERE Brandmention = TRUE 
GROUP BY interactiondate
ORDER BY interactiondate;

select * FROM  BrandMentions;


-- Stored Procedure for Crisis Response Time
CREATE OR REPLACE FUNCTION CalculateAvgResponseTime() 
RETURNS TABLE (
    Platform VARCHAR(50),                -- Platform name with a max length of 50 characters
    AVG_Response_Time_Hours NUMERIC(10, 2)  -- Average response time in hours, with precision
) AS $$
BEGIN 
    RETURN QUERY (
        SELECT 
            CAST(s.Platform AS VARCHAR(50)),  -- Explicitly cast Platform to VARCHAR(50)
            ROUND(AVG(EXTRACT(EPOCH FROM CAST(s.firstresponsetime AS TIMESTAMP) - CAST(s.crisiseventtime AS TIMESTAMP)) / 3600), 2) 
            AS AVG_Response_Time_Hours   -- Calculates the average response time in hours
        FROM socialmediainteractions s
        WHERE s.crisiseventtime IS NOT NULL AND s.firstresponsetime IS NOT NULL
        GROUP BY s.Platform
    );
END;
$$ LANGUAGE plpgsql;


SELECT * FROM CalculateAvgResponseTime();