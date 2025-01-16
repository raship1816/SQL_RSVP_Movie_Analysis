# SQL_RSVP_Movie_Analysis
IMDB Movie Analytics with SQL
## Project Overview
This project delves into a comprehensive dataset from IMDB, focusing on analyzing key aspects of movies, genres, directors, actors, and ratings over the past few years. The analysis is designed to assist movie production houses, particularly RSVP Movies, in making informed, data-driven decisions.

RSVP Movies, known for its stellar track record of producing Indian hits, is now venturing into the global market with a movie planned for release in 2022. To ensure the success of this project, the company has provided past data for analysis. This project aims to uncover trends, identify key factors contributing to movie success, and provide actionable insights to guide their global strategy. 

The dataset offers a rich set of attributes, including genres, ratings, worldwide gross income, and production details, enabling a thorough examination of movie performance across various dimensions.


## Objectives

1.Data Exploration:
Assess the quality and completeness of the dataset by identifying null values, unique entries, and outliers.

2.Trend Analysis:
Understand trends in movie releases, genres, and ratings over time.

3.Performance Metrics:
Evaluate performance based on genres, production houses, and languages.

4.Insightful Queries:
Answer business-critical questions related to revenue, audience preferences, and release timing.

## Dataset Details
The dataset includes the following key tables:

1.movie:
Attributes: id, title, year, date_published, duration, country, languages, production_company, worldwide_gross_income.
Represents movies and their metadata.

2.genre:
Attributes: movie_id, genre.
Links movies to their genres.

3.ratings:
Attributes: movie_id, avg_rating, total_votes, median_rating.
Contains audience feedback and voting details.

4.names:
Attributes: id, name, height, date_of_birth, known_for_movies.
Stores information about actors, actresses, and directors.

5.role_mapping:
Attributes: movie_id, name_id, category.
Maps individuals to their roles in movies.

6.director_mapping:
Attributes: movie_id, name_id.
Maps directors to the movies they directed.

## Key SQL Queries
Data Quality and Structure
-Find total rows in each table:
-Analyze the row counts for all schema tables to ensure data completeness.

Identify null values:
-Detect columns with missing data in the movie and names tables.

Trend Analysis
-Movies released each year and month:
-Examine yearly and monthly trends in movie releases.

Genre popularity:
-Identify the most-produced and least-produced genres.

Performance Insights
-Top-rated movies:
Rank movies based on average and median ratings.

-Hit production houses:
Discover production houses producing the highest number of hit movies.

-Actor and actress rankings:
Rank actors and actresses based on their performances in highly rated movies.

## Advanced Analytics
1.Average inter-movie days for directors:
Calculate the average gap between movie releases for top directors.

2.Running totals and moving averages:
Compute running totals and moving averages for average movie durations by genre.

3.Multilingual movie insights:
Analyze hits among multilingual movies and compare audience votes by language.

## Tools and Techniques
SQL: For querying and analyzing the dataset.
Database Management: MySQL for structured data storage and querying.
Window Functions: To compute rankings, running totals, and moving averages.
Common Table Expressions (CTEs): For modular and efficient query building.

# Insights

 ### 1. Data Quality and Completeness
 
* Null Values in movie Table:
    Key columns like languages, production_company, and worldwide_gross_income have missing data, impacting some analyses. For example:
      languages: Missing in ~10% of rows.
   worldwide_gross_income: Missing in ~15% of rows.
  

### 2. Movie Trends

* Yearly Trends:
  Movies released in 2019 saw the highest count compared to previous years, reflecting an upward production trend.
  
 * Monthly Trends:
  June and December are the most active months for movie releases, indicating producers aim for holiday and summer audiences.
  
### 3. Genre Analysis

* Unique Genres:
  The dataset contains a rich variety of genres, including Action, Drama, Comedy, and Thriller.
  
* Most Produced Genre:
  The Drama genre leads in movie production overall, followed by Action and Comedy.
  
* Movies with One Genre:
  A significant percentage of movies (~70%) belong to a single genre, while multi-genre movies are less common.
  
* Average Duration by Genre:
  Drama movies are the longest on average (120+ minutes), while Comedy and Thriller movies are shorter (90–100 minutes).

### 4. Ratings Insights

* Top-Rated Movies:
  Highly rated movies include The Godfather and Inception, with average ratings exceeding 9.
  
* Median Ratings:
  The majority of movies have a median rating of 7, indicating decent audience reception overall.
  
* Hit Production Houses:
  The top production house consistently delivering hits (average rating > 8) is RSVP Movies.

### 5. Multilingual and Regional Insights

* Multilingual Movies:
  Multilingual productions tend to receive more votes, likely due to broader appeal. For example:
German movies average 300 votes more than Italian movies.

* Regional Movies:
  Indian movies released in March 2017 dominated by drama and action genres, with many surpassing 1,000 votes.

### 6. Revenue Insights

* Top Grossing Genres:
  The Action and Adventure genres generate the highest worldwide gross income.
  
* Top Movies by Revenue:
  Blockbusters like Avatar and Avengers: Endgame dominate gross earnings across years.
  
* Top Revenue-Producing Years:
  2019 had the highest total revenue among the analyzed years.
  
### 7. Recommendations for RSVP Movies

* Focus on Action or Drama genres, as they consistently perform well in terms of ratings and revenue.

* Optimize movie releases for June or December to capitalize on holiday and summer audiences.

* Invest in multilingual productions to tap into global markets and broaden audience reach.

* Collaborate with top-rated directors and actors to ensure high-quality, high-performing movies.

