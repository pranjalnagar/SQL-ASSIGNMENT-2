-- SQL ASSIGNMENT 2
use mavenmovies;

-- Retrieve the total number of rentals made 
select count(rental_id) from rental;

-- Find the average rental duration (in days) of movies rented 
select avg(rental_duration) from film;

-- Display the first name and last name of customers in uppercase. 
select upper(first_name) as first_name , upper(last_name) as last_name from customer;

-- Extract the month from the rental date and display it alongside the rental ID. 
select rental_id , month(rental_date) from rental;

-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals). 
select customer_id , count(rental_id) as rentals from rental group by customer_id ;

-- Find the total revenue generated by each store. 
select sum(amount) from payment group by customer_id;

-- Display the title of the movie, customer s first name, and last name who rented it.
select * from customer; -- name , 
select * from film; -- film_id
select * from rental; -- rental _id , inventory_id , customer_id
select * from inventory; -- inventory_id , film_id 
SELECT 
    first_name, last_name, title
FROM
    customer
        INNER JOIN
    rental ON rental.customer_id = customer.customer_id
        INNER JOIN
    inventory ON inventory.inventory_id = rental.inventory_id
        INNER JOIN
    film ON inventory.film_id = film.film_id;
    
    -- Retrieve the names of all actors who have appeared in the film "Gone with the Wind.
    select *  from film; -- film_id
    select * from film_actor; -- actor_id , film_id
    select * from actor; -- actor_id , name
   SELECT 
    first_name, last_name
FROM
    actor
        INNER JOIN
    film_actor ON film_actor.actor_id = actor.actor_id
        INNER JOIN
    film ON film.film_id = film_actor.film_id
WHERE
    film.title = 'gone_with_the_wind';

-- Determine the total number of rentals for each category of movies. 
SELECT 
    category_id, COUNT(rental_id) AS total_rentals
FROM
    film_category
        JOIN
    film ON film.film_id = film_category.film_id
        JOIN
    inventory ON inventory.film_id = film.film_id
        JOIN
    rental ON rental.inventory_id = inventory.inventory_id
GROUP BY category_id;

-- Find the average rental rate of movies in each language
select avg(rental_rate) , language.language_id from film join language on film.language_id = language.language_id group by language.language_id;

-- Retrieve the customer names along with the total amount they've spent on rentals. 
select * from payment; -- payment id , rental id , customer id
SELECT 
    SUM(amount), CONCAT(first_name, ' ', last_name) AS name
FROM
    payment
        JOIN
    customer ON customer.customer_id = payment.customer_id
        JOIN
    rental ON rental.rental_id = payment.rental_id
GROUP BY customer.customer_id;

-- List the titles of movies rented by each customer in a particular city (e.g., 'London')
SELECT 
    customer.customer_id, title
FROM
    customer
        JOIN
    address ON customer.address_id = address.address_id
        JOIN
    city ON city.city_id = address.city_id
        JOIN
    rental ON rental.customer_id = customer.customer_id
        JOIN
    inventory ON inventory.inventory_id = rental.inventory_id
        JOIN
    film ON film.film_id = inventory.film_id
WHERE
    city = 'london';
    
    -- Display the top 5 rented movies along with the number of times they've been rented. 
    select title , count(rental_id) from film join inventory on film.film_id = inventory.film_id join rental on rental.inventory_id = inventory.inventory_id group by film.title limit 5;
    
    -- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 
SELECT 
    title, CONCAT(first_name, ' ', last_name) AS name
FROM
    customer
        JOIN
    rental ON customer.customer_id = rental.customer_id
        JOIN
    inventory ON inventory.inventory_id = rental.inventory_id
        JOIN
    film ON film.film_id = inventory.film_id
WHERE
    customer.store_id = 1
        AND customer.store_id = 2;
	




