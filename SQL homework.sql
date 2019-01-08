USE SAKILA;

-- 1A.
SELECT first_name, last_name FROM actor;
-- 1B.
SELECT CONCAT (first_name, ' ', last_name) AS 'Actor_Name' FROM actor;

-- 2A.
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "JOE";
-- 2B.
SELECT first_name, last_name FROM actor
WHERE last_name LIKE "%GEN%";
-- 2C.
SELECT last_name, first_name FROM actor
WHERE last_name LIKE "%LI%";
-- 2D.
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3A.
ALTER TABLE actor
ADD description BLOB;
-- 3B.
ALTER TABLE actor
DROP COLUMN description;
-- 4A.
SELECT last_name
FROM actor;
-- 4B.

-- 4C.
UPDATE actor 
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" and last_name = "WILLIAMS";
SET SQL_SAFE_UPDATES = 0;
-- 4D.
UPDATE actor 
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";
SET SQL_SAFE_UPDATES = 0;

-- 5A.
SHOW CREATE TABLE address;

-- 6A.
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON
staff.address_id = address.address_id;
--  6B.
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS "Total Amount, August 2005"
FROM staff
INNER JOIN payment ON
staff.staff_id=payment.staff_id
WHERE payment.payment_date LIKE "2005-08%"
GROUP BY staff.first_name, staff.last_name;
-- 6C.
SELECT film.title, COUNT(film_actor.actor_id) AS "Number of Actors"
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film_actor.film_id;
-- 6D.
SELECT title, (SELECT COUNT(*) FROM inventory WHERE film.film_id = inventory.film_id ) AS 'Number of Copies'
FROM film
WHERE film.title = "HUNCHBACK IMPOSSIBLE";
-- 6E.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS "Total Amount Paid"
FROM customer
LEFT JOIN  payment ON customer.customer_id = payment.customer_id
GROUP BY customer.last_name, customer.first_name  ORDER by customer.last_name;

-- 7A.
SELECT title
FROM film
WHERE title LIKE "K%" OR title LIKE "Q%" AND language_id IN
(

  SELECT language_id
  FROM language
  WHERE name="English"
);
-- 7B. 
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
   (
    SELECT film_id
    FROM film
    WHERE title = 'ALONE TRIP'
   )
);
-- 7C.
SELECT first_name, last_name, email
FROM customer 
WHERE address_id 
IN (
  SELECT address_id
  FROM address
  WHERE city_id
   IN (
    SELECT city_id 
    FROM city
    WHERE country_id
     IN (
	  SELECT country_id
      FROM country
      WHERE Country = "Canada"
		)
	   ) 
      ); 	
-- 7D.
SELECT title
FROM film
WHERE film_id
IN (
  SELECT film_id
  FROM film_category
  WHERE category_id
 IN (
   SELECT category_id
   FROM category
   WHERE name = "Family"
    )
  );  
-- 7E. most frequently rented movies in descending order.
SELECT title
FROM film
WHERE film_id 
IN (
   SELECT film_id
   FROM inventory
   WHERE inventory_id
   IN (
      SELECT inventory_id
      FROM rental


-- 7F. how much business, in dollars, each store brought in
SELECT store_id AS "Store"
FROM store
WHERE store_id
IN (
  SELECT store_id
  FROM staff
  WHERE staff_id
   IN (
    SELECT staff_id
    FROM payment
    SUM(amount)
	)
   );
   
-- 7G. display  each store's store ID, city, and country.
SELECT store_id AS "StoreID" FROM store;


SELECT city AS cities
FROM city
WHERE city_id
IN (
    SELECT city_id 
    FROM address
    WHERE address_id
    IN (
        SELECT address_id 
        FROM store
        WHERE store_id = "1" or "2"
        )
	);
    
SELECT country AS countries
FROM country
WHERE country_id 
IN (
SELECT country_id 
FROM city
WHERE city_id
IN (
    SELECT city_id 
    FROM address
    WHERE address_id
    IN (
        SELECT address_id 
        FROM store
        WHERE store_id = "1" or "2"
        )
	)
);

CREATE VIEW Stores
AS SELECT StoreID, cities, countries;
SELECT * FROM Stores;


















