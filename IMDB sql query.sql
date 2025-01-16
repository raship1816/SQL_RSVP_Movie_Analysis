USE imdb;

-- Segment 1:


-- Q1. Find the total number of rows in each table of the schema?
select count(*) as movie_row_count from movie ;
select count(*) as director_row_count from director_mapping ;
select count(*) as genre_row_count from genre ;
select count(*) as names_row_count from names ;
select count(*) as ratings_row_count from ratings ;
select count(*) as role_row_count from role_mapping ;


-- Q2. Which columns in the movie table have null values?
select count(case when title  is null then id end ) as title_null_count ,
count(case when year  is null then id end ) as year_null_count,
count(case when date_published  is null then id end ) as date_null_count,
count(case when duration  is null then id end ) as duration_null_count,
count(case when country  is null then id end ) as country_null_count,
count(case when worlwide_gross_income  is null then id end ) as income_null_count,
count(case when languages  is null then id end ) as language_null_count,
count(case when production_company  is null then id end ) as production_company_null_count
from movie ; 


-- Q3. Find the total number of movies released each year? How does the trend look month wise? 

select year , count(*) as movie_count from movie group by year ;

select  month (date_published) as month , 
count(*) as movie_count 
from movie
group by month 
order by month ;


-- Q4. How many movies were produced in the USA or India in the year 2019??
Select COUNT(*) AS number_of_movies
From movie
WHERE year=2019 AND (LOWER(country) LIKE '%usa%' OR LOWER(country) LIKE '%india%');


-- Q5. Find the unique list of the genres present in the data set?
select distinct genre from genre ;


-- Q6.Which genre had the highest number of movies produced overall?
select g.genre , 
count(m.id) as movie_count  
 from 
	genre g join movie m 
    on g.movie_id = m.id 
group by g.genre 
order by count(m.id) desc; 



-- Q7. How many movies belong to only one genre?
select  count(*) as movie_count from (
select movie_id from genre group by movie_id 
having count(genre) = 1 ) as a ;



-- Q8.What is the average duration of movies in each genre? 

select g.genre , avg(m.duration) as avg_duration
from movie m join genre g 
on m.id = g.movie_id 
group by genre 
;


-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 

select g.genre , 
count(m.id) as movie_count  , rank() over (order by count(m.id) desc) as movie_rank
 from 
	genre g join movie m 
    on g.movie_id = m.id 
group by g.genre 
; 


-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?

select min(avg_rating) as min_avg_rating ,
max(avg_rating) as max_avg_rating , 
min(total_votes) as min_total_votes,
max(total_votes) as max_total_votes ,
min(median_rating) as min_median_rating , 
max(median_rating) as max_median_rating 
from ratings ;


-- Q11. Which are the top 10 movies based on average rating?

select m.title , r.avg_rating ,
row_number() over (order by avg_rating desc ) as movie_rank
from movie m join ratings r 
on m.id = r.movie_id 
limit 10 ;
    

-- Q12. Summarise the ratings table based on the movie counts by median ratings.

select median_rating , count(movie_id) as movie_count 
from ratings 
group by median_rating 
order by median_rating  ;


-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??

select production_company , count(id) as movie_count ,
row_number() over (order by count(id) desc) as prod_company_rank 
from movie m join ratings r 
on m.id = r.movie_id 
where production_company <> ' '
and r.avg_rating > 8 
group by production_company 
limit 1  ;

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?

select g.genre , count( m.id) as movie_count 
from genre g join movie m 
on g.movie_id = m.id 
join ratings r 
on r.movie_id = g.movie_id 
where month(m.date_published) = 3 
and m.year = 2017 
and upper(m.country) like '%USA%' 
and r.total_votes > 1000 
group by g.genre 
order by movie_count desc ;


-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?

select m.title  , r.avg_rating , g.genre
from genre g join movie m 
on g.movie_id = m.id 
join ratings r 
on r.movie_id = g.movie_id 
where m.title like'The%' 
and r.avg_rating > 8 
order by genre , r.avg_rating desc; 


-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?

select count(m.id) as movie_count 
from movie m join ratings r
on m.id =r.movie_id 
where m.date_published between '2018-04-01' and '2019-04-01'
and r.median_rating = 8 ;


-- Q17. Do German movies get more votes than Italian movies? 

WITH votes_summary AS
(
SELECT 
	COUNT(CASE WHEN LOWER(m.languages) LIKE '%german%' THEN m.id END) AS german_movie_count,
	COUNT(CASE WHEN LOWER(m.languages) LIKE '%italian%' THEN m.id END) AS italian_movie_count,
	SUM(CASE WHEN LOWER(m.languages) LIKE '%german%' THEN r.total_votes END) AS german_movie_votes,
	SUM(CASE WHEN LOWER(m.languages) LIKE '%italian%' THEN r.total_votes END) AS italian_movie_votes
FROM
    movie AS m 
	    INNER JOIN
	ratings AS r 
		ON m.id = r.movie_id
)
SELECT 
    ROUND(german_movie_votes / german_movie_count, 2) AS german_votes_per_movie,
    ROUND(italian_movie_votes / italian_movie_count, 2) AS italian_votes_per_movie
FROM
    votes_summary;

-- Answer is Yes



-- Segment 3:



-- Q18. Which columns in the names table have null values??

select 
sum(case when name is null then 1 else 0 end ) as name_nulls ,
sum(case when height is null then 1 else 0 end ) as height_nulls ,
sum(case when date_of_birth is null then 1 else 0 end ) as date_of_birth_nulls ,
sum(case when known_for_movies is null then 1 else 0 end ) as known_for_movies_nulls 
from names ;


-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?

WITH top_rated_genres AS
(
SELECT 
    genre,
    COUNT(m.id) AS movie_count,
	RANK () OVER (ORDER BY COUNT(m.id) DESC) AS genre_rank
FROM
    genre AS g
        LEFT JOIN
    movie AS m 
		ON g.movie_id = m.id
			INNER JOIN
		ratings AS r
			ON m.id=r.movie_id
WHERE avg_rating>8
GROUP BY genre
)
SELECT 
	n.name as director_name,
	COUNT(m.id) AS movie_count
FROM
	names AS n
		INNER JOIN
	director_mapping AS d
		ON n.id=d.name_id
			INNER JOIN
        movie AS m
			ON d.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
					INNER JOIN
						genre AS g
					ON g.movie_id = m.id
WHERE g.genre IN (SELECT DISTINCT genre FROM top_rated_genres WHERE genre_rank<=3)
		AND avg_rating>8
GROUP BY name
ORDER BY movie_count DESC
LIMIT 3;

-- Q20. Who are the top two actors whose movies have a median rating >= 8?

select n.name , count(r.movie_id) as movie_count 
from role_mapping rm join names n 
on rm.name_id = n.id 
join ratings r on r.movie_id = rm.movie_id 
where r.median_rating >= 8 and rm.category = 'Actor'
group by n.name 
order by movie_count desc 
limit 2;


-- Q21. Which are the top three production houses based on the number of votes received by their movies?

select m.production_company , sum(r.total_votes) as vote_count ,
row_number() over (order by sum(r.total_votes) desc) as prod_comp_rank
from movie m join ratings r on m.id = r.movie_id 
where m.production_company <> ' '
group by m.production_company 
limit 3  ;



-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?

select n.name as actor_name , sum(r.total_votes) as vote_count , count(r.movie_id) as movie_count ,
round(sum(r.avg_rating * r.total_votes) / sum(r.total_votes),2) as actor_avg_rating ,
row_number() over ( order by round(sum(r.avg_rating * r.total_votes) / sum(r.total_votes),2) desc , sum(r.total_votes) desc ) as actor_rank 
from names n inner join role_mapping rm 
on n.id = rm.name_id 
inner join ratings r 
on rm.movie_id = r.movie_id 
join movie m on m.id = r.movie_id 
where rm.category = 'actor' and rm.category <> ' ' 
and lower(m.country) like '%india%'
group by n.name  
having count(r.movie_id) >= 5 ;

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 

select n.name as actress_name , sum(r.total_votes) as vote_count , count(r.movie_id) as movie_count ,
round(sum(r.avg_rating * r.total_votes) / sum(r.total_votes),2) as actor_avg_rating ,
row_number() over ( order by round(sum(r.avg_rating * r.total_votes) / sum(r.total_votes),2) desc , sum(r.total_votes) desc ) as actor_rank 
from names n inner join role_mapping rm 
on n.id = rm.name_id 
inner join ratings r 
on rm.movie_id = r.movie_id 
join movie m on m.id = r.movie_id 
where rm.category = 'actress' and rm.category <> ' ' 
and LOWER(m.languages) like '%hindi%'
group by n.name  
having count(r.movie_id) >= 3
limit 5 ;


-- Q24. Select thriller movies as per avg rating and classify them in the following category: 

select distinct m.title ,
case when r.avg_rating > 8 then 'Superhit' 
	when r.avg_rating between 7 and 8 then 'Hit' 
    when r.avg_rating between 5 and 7 then 'One time watch'
    when r.avg_rating < 5 then 'Flop'
    end as category 
from genre g join ratings r 
on g.movie_id = r.movie_id 
join movie m on m.id = r.movie_id 
where g.genre = 'Thriller' ;



-- Segment 4:



-- Q25. What is the genre-wise running total and moving average of the average movie duration? 

select g.genre , 
ROUND(AVG(duration),2) as avg_duration , 
sum(ROUND(AVG(duration),2)) over ( order by genre rows unbounded preceding ) as running_total_duration ,
avg(ROUND(AVG(duration),2)) over ( order by genre rows unbounded preceding ) as moving_avg_duration 
from genre g
left join movie m on m.id = g.movie_id 
group by genre ;


-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 


WITH top_genres AS
(
SELECT 
    genre,
    COUNT(m.id) AS movie_count,
	RANK () OVER (ORDER BY COUNT(m.id) DESC) AS genre_rank
FROM
    genre AS g
        LEFT JOIN
    movie AS m 
		ON g.movie_id = m.id
GROUP BY genre
)
,
top_grossing AS
(
SELECT 
    g.genre,
	year,
	m.title as movie_name,
    worlwide_gross_income,
    RANK() OVER (PARTITION BY g.genre, year
					ORDER BY CONVERT(REPLACE(TRIM(worlwide_gross_income), "$ ",""), UNSIGNED INT) DESC) AS movie_rank
FROM
movie AS m
	INNER JOIN
genre AS g
	ON g.movie_id = m.id
WHERE g.genre IN (SELECT DISTINCT genre FROM top_genres WHERE genre_rank<=3)
)
SELECT * 
FROM
	top_grossing
WHERE movie_rank<=5;


-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?

select m.production_company , count(m.id) as movie_count , 
rank () over (order by count(r.total_votes) desc ) as prod_company_rank
from movie m join ratings r 
on m.id = r.movie_id 
where r.median_rating >= 8 and m.production_company <> ' ' and POSITION(',' IN languages)>0 
group by  m.production_company
limit 2
 ;

-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
select n.name as actress_name , sum(r.total_votes) as total_votes ,
count(m.id) as movie_count , ROUND(SUM(r.avg_rating*r.total_votes)/SUM(r.total_votes),2)  as actress_avg_rating , 
row_number() over ( order by ROUND(SUM(r.avg_rating*r.total_votes)/SUM(r.total_votes),2) desc ,  sum(r.total_votes) desc ) as actress_rank
from movie m join ratings r on m.id = r.movie_id 
join genre g on g.movie_id = m.id
join role_mapping rm on rm.movie_id = m.id
join names n on n.id = rm.name_id 
where r.avg_rating > 8 and lower(g.genre) = 'drama' 
and rm.category = 'Actress' 
group by n.name 
limit 3 
;

-- Q29. Get the following details for top 9 directors (based on number of movies)

select dm.name_id as director_id , n.name , count(DISTINCT m.id) as number_of_movies,
datediff(lead(m.date_published) over ( partition by n.id order by m.date_published ),m.date_published ) as avg_inter_movie_days ,
ROUND(SUM(r.avg_rating*r.total_votes)/SUM(r.total_votes),2) as avg_rating ,
sum(r.total_votes) as total_votes ,
min(r.avg_rating) as min_rating , max(r.avg_rating) as max_rating ,
sum(m.duration) as total_duration 
from movie m join ratings r 
on m.id = r.movie_id 
join director_mapping dm 
on dm.movie_id = m.id
join names n 
on n.id = dm.name_id
group by dm.name_id 
ORDER BY number_of_movies DESC, avg_rating DESC
limit 9;

