# Navigating the Digital Landscape: Enhancing Brand Reputation with Cutting-Edge Social Media Monitoring

# Table of Content
1. Project Overview
2. Key Learning Points
3. Business Overview and Problem
4. Rationale for the Project
5. Project Aim
6. Data Description
7. Data Source
8. Tech Stack
9. Project Scope
10. EDA Questions
11. Business questions
12. Project Implementation
13. Data Validation
14. Actions Taken
15. Analysis, Insights, and Recommendations
16. Conclusion
    
## Project Overview
This project focuses on improving brand reputation through advanced social media monitoring techniques. The goal is to address AfriTech Electronics Ltd.'s challenges with negative social media buzz, customer complaints, product recalls, and competitive pressure.

## Key Learning Points
- Database Design: Creating efficient and scalable database structures.
- SQL Querying: Writing complex queries to extract and manipulate data.
- Data Transformation: Converting raw data into meaningful formats.
- Views: Creating virtual tables for easier data access.
- Stored Procedures and Functions: Automating repetitive tasks and calculations.
- Data Import and Export: Handling data exchange between different systems.

## Business Overview and Problem
### AfriTech Electronics Ltd. is struggling with:
- Negative Social Media Buzz: Damaging brand image through negative posts.
- Customer Complaints: Issues with product defects, customer support, and billing.
- Product Recalls: Media attention leading to customer panic.
- Competitive Pressure: Rivals capitalizing on reputation challenges.

## Rationale for the Project
- Protecting Market Position: Safeguarding brand reputation to retain market share.
- Customer Retention: Enhancing satisfaction to reduce churn.
- Crisis Mitigation: Detecting and addressing issues before they escalate.
- Data-Driven Decision-Making: Leveraging insights for better strategic decisions.
- Enhanced Marketing: Using customer insights to tailor marketing efforts.

## Aim of the Project
- Monitor Social Media Conversations: Track mentions and discussions about the company.
- Sentiment Analysis: Identify trends in positive and negative sentiment.
- Customer Issue Resolution: Prioritize and resolve complaints quickly.
- Crisis Detection: Implement systems to identify potential crises early.

## Data Description
- CustomerID: Unique identifier for each customer.
- Customer Name: Name of the customer.
- Region: Customer's region or state.
- Age: Age of the customer.
- Income: Customer's income.
- CustomerType: Type of customer ('New', 'Returning', 'VIP').
- Transaction Year: Year of the transaction.
- Transaction Date: Date of the transaction.
- Product Purchased: Product type (e.g., 'Smartphone', 'Tablet').
- Purchase Amount: Amount spent.
- Product Recalled: Whether the product was recalled.
- Competitor: Competitor related to the transaction.Interaction Date: Date of social media interaction.
- Platform: Social media platform (e.g., 'Twitter').
- Post Type: Type of post (e.g., 'Text', 'Image').
- Engagement Likes: Number of likes.
- Engagement Shares: Number of shares.
- Engagement Comments: Number of comments.
- User Followers: Number of followers of the user.
- Influencer Score: Influence score of the user.
- BrandMention: Whether the brand was mentioned.
- Competitor Mention: Whether a competitor was mentioned.
- Sentiment: Sentiment of the post ('Positive', 'Neutral', 'Negative').
- Crisis Event Time: Date of crisis event mentioned.
- First Response Time: Date of first response to a negative post.
- Resolution Status: Whether the crisis was resolved.
- NPS Response: Net Promoter Score (NPS) response associated with the post.

## Data source: https://www.amdari.io/

## Tech Stack
- PostgreSQL: Used for efficient querying, analysis, and management of the dataset.

## Project Scope
1.	Project Planning and Design (Phase 1): Design and plan each step for effective execution.
2.	Workflow Detailing (Phase 2): Utilize SQL to detail workflow from inception to completion.
3.	Ensuring Clarity and Success (Phase 3): Provide a comprehensive overview for structured project execution.

## EDA Questions 
1.	Are there any null values or missing columns in the customer and social media data?
2.	What are the data types, and do they align with the expected format?
3.	What is the relationship between age and income in customer demographics?
4.	What are the top-selling products by quantity and revenue?
5.	How do product recalls affect sales and average amounts?
6.	Which platform (TikTok, Instagram, etc.) generates the most likes and engagement?
7.	How many brand mentions are there across social media platforms?
8.	What’s the sentiment score breakdown (positive, neutral, negative) across platforms?
9.	How do engagement rates vary across platforms?
10.	Who are the top influencers, and how is their score calculated?
11.	What are the monthly trends in brand mentions and platform engagement?
12.	How has crisis response time changed over time?

## Business Questions
1. Who are our top buying customers, and which regions do they represent?
2. How do age and income affect customer purchasing behavior?
3. How can we optimize revenue generation on different social media platforms?
4. Which products generate the most revenue and which have been recalled?
5. How does brand sentiment compare to our competitors across social media?
6. What are the most effective marketing strategies based on platform-specific engagement?
7. How can we improve our crisis management response time and resolution rate?
8. What steps can we take to mitigate negative buzz surrounding certain products?


# Project Implementation
At first, I created database with the name CREATE DATABASE AfriTechDB;
Thereafter, I created a temporary table with the name stagingdata.
-- Verify the Imported Data: SELECT * FROM stagingdata LIMIT 10;
-- -- Check Data Integrity:
-- Check for null values
-- Verify specific column data types

I created 3 tables from the temporary table and these tables include:
1.	Customerdata
2.	Transactions
3.	SocialMediaInteractions

### Multiple tables were created from the temporary table to promote the following:
1.	Data Organization and Structure
2.	Normalization (Reduce data duplication, ensure data integrity and Improve database efficiency)
3.	Data Integrity and Consistency
4.	Performance Optimization
5.	Flexibility and Scalability
-- Insert data from Stagingdata into the Target Tables (Customerdata, Transactions and SocialMediaInteractions) 

### DROP TABLE stagingdata: 
This table is no longer needed as I have created three important tables which was used foe the project.

## Data Validation
1.	Customerdata table has 200 rows, no missing values
2.	Socialmediainteractions table has 73,586 rows
3.	Crisiseventtime column in Socialmediainteractions table have 60,203 null values
4.	Firstresponsetime column in Socialmediainteractions table have 60,203 null values
5.	Resolutionstatus column in in Socialmediainteractions table has 60,203 null values
6.	Transactions table has 147,172 rows
7.	competitor column in Transactions table has 35,622 null values
Note: only columns with null values are written out for emphasis

## Action taken
I keep the columns with null values and proceed with the dataset as is, without dropping or modifying these columns, due to several key reasons:
1.	Preserving Data Completeness and Context
2.	Reflecting Real-World Data Conditions
3.	Exploring Imputation or Advanced Analytical Techniques
4.	Focusing on Specific Analysis Goals
5.	Avoiding Data Loss
6.	Exploring Causation or Correlation
7.	Null Values Represent Meaningful Information: For instance, null values in the "CrisisEventTime" column could indicate that no crisis event occurred. If the context implies that the nulls have a specific, meaningful interpretation, overlooking them might be appropriate.

# The Analysis, Insights and Recommendations 
## Key Findings and Recommendations
## Data Analysis and Insights:

### Sentiment Analysis:
- Positive Sentiment: 41% of social media interactions were positive, indicating a generally favorable brand perception.
- Negative Sentiment: 18% of social media interactions were negative, highlighting areas for improvement in products, services, or customer experience.
- Neutral Sentiment: 40% of social media interactions were neutral, indicating a lack of strong positive or negative sentiment.

### Brand Mentions: 
- The brand was mentioned 37,773 times across social media platforms, indicating significant brand awareness and discussion.
### Platform Engagement: 
- TikTok and Instagram emerged as the most popular platforms for brand mentions, suggesting they are effective for reaching the target audience.
### Customer Engagement: 
- The average engagement rate was 12.35%, indicating room for improvement in terms of encouraging follower interaction.
### Crisis Management: 
- The resolution rate for crises was 47.59%, suggesting that the company's crisis management processes are somewhat effective but could be improved.
### Customer Satisfaction: 
- Analyzing customer feedback and sentiment can help identify areas where customer satisfaction can be improved.
### Product Performance: 
- Analyzing engagement metrics and sentiment for different products can identify areas where product quality or marketing efforts may need improvement.
### Crisis Response Time: 
- The average response time to crises was 4,559.29 hours (approximately 190 days or 5.2 months), indicating significant delays in addressing customer concerns.

## Business Implications:
### Brand Reputation: 
- The company should focus on addressing negative sentiment and improving crisis management processes to protect its brand reputation.
### Customer Satisfaction:
- Enhancing customer satisfaction is crucial for driving loyalty and repeat business.
### Product Improvement: 
- Identifying areas where products or services need improvement can help increase customer satisfaction and reduce negative sentiment.
### Marketing Optimization: 
- Tailor marketing efforts to specific platforms and customer segments to maximize engagement and drive sales.
### Crisis Management: 
- A robust crisis management plan can help mitigate the impact of negative events and protect the brand's reputation.

## Recommendations:
### Sentiment Analysis: 
- Continuously monitor social media sentiment to identify emerging trends and potential issues.
### Crisis Management: 
- Develop and implement a comprehensive crisis management plan to ensure prompt and effective responses to crises.
### Customer Feedback: 
- Actively seek customer feedback through surveys and social media channels to identify areas for improvement.
### Product Improvement: 
- Prioritize improvements based on insights from sentiment analysis and customer feedback.
### Marketing Optimization: 
- Tailor marketing efforts to specific platforms and customer segments to maximize engagement and drive sales.
### Customer Support: 
- Enhance customer support processes to address inquiries promptly and effectively.
### Data-Driven Decision Making:
- Use the insights from the social media monitoring system to make data-driven decisions related to marketing, product development, and customer service.

## Conclusion
By implementing these recommendations, AfriTech Electronics Ltd. can effectively leverage social media monitoring to enhance brand reputation, improve customer satisfaction, and drive business growth. The system provides valuable insights for data-driven decision making and helps the company stay ahead of emerging trends and customer needs.
