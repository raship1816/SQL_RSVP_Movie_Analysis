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
