USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT *
FROM store; 

SELECT * 
FROM address;

SELECT *
FROM city;

SELECT *
FROM country;

SELECT s.store_id, city, country
FROM store s
JOIN address a 
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country co
ON c.country_id = co.country_id
GROUP BY s.store_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT *
FROM store;

SELECT *
FROM payment;

SELECT *
FROM staff;

SELECT sto.store_id, SUM(p.amount) AS "Total Revenue"
FROM store sto
JOIN staff sta
ON sto.store_id = sta.store_id
JOIN payment p
ON p.staff_id = sta.staff_id
GROUP BY sto.store_id;

-- 3. Which film categories are longest?

-- We take the AVG lenght of all the films of each category to determine the longest category. 

SELECT *
FROM film;

SELECT * 
FROM film_category;

SELECT *
FROM category;

SELECT c.name, AVG(f.length)
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON  c.category_id = fc.category_id
GROUP BY c.category_id
ORDER BY f.length DESC;

-- 4. Display the most frequently rented movies in descending order.

SELECT *
FROM inventory;

SELECT *
FROM rental;

SELECT *
FROM film;

SELECT COUNT(r.inventory_id) AS "number of rents", f.title AS "Film Name"
FROM inventory i
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN film f
ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY COUNT(r.inventory_id) DESC;

-- 5. List the top five genres in gross revenue in descending order.

SELECT *
FROM payment;

SELECT *
FROM rental;

SELECT * 
FROM category;

SELECT *
FROM film_category;

SELECT *
FROM inventory;

SELECT c.name, SUM(p.amount) AS "Gross Revenue"
FROM payment p
JOIN rental r 
ON p.rental_id = r.rental_id
JOIN inventory i
ON i.inventory_id = r.inventory_id
JOIN film_category fc
ON i.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
GROUP BY c.category_id
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?

SELECT *
FROM inventory;

SELECT * 
FROM store;

SELECT *
FROM film;

SELECT f.title AS "Film Title", s.store_id AS "Store"
FROM inventory i
JOIN store s
ON i.store_id = s.store_id
JOIN film f
ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
GROUP BY f.film_id;

-- 7. Get all pairs of actors that worked together.

SELECT *
FROM film_actor;

SELECT *
FROM film_actor as fa1
JOIN film_actor as fa2
ON (fa1.film_id = fa2.film_id) AND (fa1.actor_id > fa2.actor_id)
ORDER BY fa1.film_id ASC;

-- In the option below I think we get actually the same result but with a better visualization of which actors have worked together displayed by the names. 

SELECT CONCAT(a1.first_name,' ', a1.last_name) AS actor_1,
    CONCAT(a2.first_name,' ', a2.last_name) AS actor_2,
    f.title
FROM
    film_actor AS fa1
        JOIN
    film_actor AS fa2 ON (fa1.film_id = fa2.film_id)
        AND (fa1.actor_id > fa2.actor_id)
        JOIN
    actor a1 ON (fa1.actor_id = a1.actor_id)
        JOIN
    actor a2 ON (fa2.actor_id = a2.actor_id)
    join film f on (fa1.film_id = f.film_id)
ORDER BY fa1.film_id ASC;


-- 8. Get all pairs of customers that have rented the same film more than 3 times.



-- 9. For each film, list actor that has acted in more films.