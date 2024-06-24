CREATE database restaurants;
USE restaurants;

select * from 
restaurant_cuisines;

-- List all distinct cuisines preferred by consumers.
SELECT DISTINCT Preferred_Cuisine 
FROM consumer_preferences;

ALTER TABLE consumers
CHANGE COLUMN ï»¿Consumer_ID Consumer_ID VARCHAR(255);


ALTER TABLE ratings
CHANGE COLUMN ï»¿Consumer_ID Consumer_ID VARCHAR(255);


ALTER TABLE consumer_preferences 
CHANGE COLUMN ï»¿Consumer_ID Consumer_ID VARCHAR(255);

ALTER TABLE restaurant_cuisines
CHANGE COLUMN ï»¿Restaurant_ID Restaurant_ID VARCHAR(255);

ALTER TABLE restaurants_data
CHANGE COLUMN ï»¿Restaurant_ID Restaurant_ID VARCHAR(255);


ALTER TABLE consumer_preferences 
CHANGE COLUMN ï»¿Consumer_ID Consumer_ID VARCHAR(255);

ALTER TABLE ratings
CHANGE COLUMN ï»¿Consumer_ID Consumer_ID VARCHAR(255);

-- Find the number of consumers who prefer Mexican cuisine.
SELECT COUNT(DISTINCT Consumer_ID) AS Mexican_Preferrers
FROM consumer_preferences
WHERE Preferred_Cuisine = 'Mexican';




-- List all restaurants located in 'San Luis Potosi'.
SELECT name
FROM restaurants_data
WHERE City = 'San Luis Potosi';

-- Find the average overall rating for all restaurants.
SELECT AVG(Overall_Rating) AS Average_Overall_Rating 
FROM ratings;


-- Find the most preferred cuisine by consumers.
SELECT Preferred_Cuisine, COUNT(*) AS Preference_Count
FROM consumer_preferences
GROUP BY Preferred_Cuisine
ORDER BY Preference_Count DESC
LIMIT 1;


-- List the top 5 highest-rated restaurants along with their average food rating.
SELECT Restaurant_ID, AVG(Food_Rating) AS Average_Food_Rating
FROM ratings
GROUP BY Restaurant_ID
ORDER BY Average_Food_Rating DESC
LIMIT 5;

-- Find the consumer who has rated the most restaurants and list how many ratings they have given.
SELECT Consumer_ID, COUNT(*) AS Rating_Count
FROM ratings
GROUP BY Consumer_ID
ORDER BY Rating_Count DESC
LIMIT 1;



-- List the names of all restaurants along with their cuisines
SELECT rd.Name AS Restaurant_Name, rc.Cuisine
FROM restaurants_data rd
JOIN restaurant_cuisines rc ON rd.Restaurant_ID = rc.Restaurant_ID;


-- Find the city and state for each restaurant along with the name of the restaurant and its cuisine.
SELECT r.Name AS Restaurant_Name, r.City, r.State, rc.Cuisine
FROM restaurants_data r
JOIN restaurant_cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID;


-- Find the average service rating for each type of cuisine offered by restaurants.
SELECT rc.Cuisine, AVG(r.Service_Rating) AS Average_Service_Rating
FROM ratings r
JOIN restaurant_cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
GROUP BY rc.Cuisine;


-- List the average rating for each restaurant by each consumer who has rated them, along with the consumer's city and state.
SELECT c.Consumer_ID, c.City, c.State, r.Restaurant_ID, rr.Name AS Restaurant_Name, 
       AVG(r.Overall_Rating) AS Avg_Overall_Rating, 
       AVG(r.Food_Rating) AS Avg_Food_Rating, 
       AVG(r.Service_Rating) AS Avg_Service_Rating
FROM consumers c
JOIN ratings r ON c.Consumer_ID = r.Consumer_ID
JOIN restaurants_data rr ON r.Restaurant_ID = rr.Restaurant_ID
GROUP BY c.Consumer_ID, c.City, c.State, r.Restaurant_ID, rr.Name;

-- Find the top 3 consumers who have rated the most number of different restaurants
-- and list their ID, and the count of different restaurants they have rated.
SELECT c.Consumer_ID, COUNT(DISTINCT r.Restaurant_ID) AS Restaurant_Count
FROM consumers c
JOIN ratings r ON c.Consumer_ID = r.Consumer_ID
GROUP BY c.Consumer_ID
ORDER BY Restaurant_Count DESC
LIMIT 3;




