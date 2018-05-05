
#* 1a. Display the first and last names of all actors from the table `actor`. 

#* 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`. 

#* 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
  	
#* 2b. Find all actors whose last name contain the letters `GEN`:
  	
#* 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

#* 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:

#3a. Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. Hint: you will need to specify the data type.
  	
#3b. You realize that some of these actors have tremendously long last names. Change the data type of the `middle_name` column to `blobs`.

#3c. Now delete the `middle_name` column.

#4a. List the last names of actors, as well as how many actors have that last name.
  	
#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
  	
#4c. Oh, no! The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
  	
#4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`. Otherwise, change the first name to `MUCHO GROUCHO`, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO `MUCHO GROUCHO`, HOWEVER! (Hint: update the record using a unique identifier.)

#5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it? 

  #* Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)

#6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:

#6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`. 
  	
#6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
  	
#6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?

#6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:

  #```
  #	![Total amount paid](Images/total_payment.png)
  #```

# 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English. 

#7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
   
#7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

#7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
#7e. Display the most frequently rented movies in descending order.
  	
#7f. Write a query to display how much business, in dollars, each store brought in.

#7g. Write a query to display for each store its store ID, city, and country.
  	
#7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
  	
#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
  	
#8b. How would you display the view that you created in 8a?

#8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.

use sakila
#1a Display the first and last names of all actors from the table `actor`. 

select first_name, last_name
from actor

#1b Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`. 

SELECT CONCAT_WS(" ", `first_name`, `last_name`) AS `Actor Name` FROM `actor`

#2a You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
  	

select *
from actor
where first_name = 'Joe'

#2b Find all actors whose last name contain the letters `GEN`:

select *
from actor
where last_name like '%gen%'

#2c Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
 
 select * from actor 
 where last_name like '%li%'
 order by last_name, first_name ASC;
 
 #2d Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
 
 select country_id, country from country 
 where country in ('Afghanistan', 'Bangladesh', 'China');
 
 #3a Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. Hint: you will need to specify the data type.
 
 ALTER TABLE actor
 drop column middle_name;
 drop view if exists mid_table;
 
 
 alter table actor
 add middle_name varchar(30);
 create view mid_table
 as
 select first_name, middle_name, last_name from actor;
 select * from mid_table;
 
 #3b Now delete the `middle_name` column.
 
alter table actor
modify middle_name blob;
select * from mid_table

#3c You realize that some of these actors have tremendously long last names. Change the data type of the `middle_name` column to `blobs`.

alter table actor
drop column middle_name;
select * from actor;
 
 #4a
 
select distinct last_name, count(last_name) as dupe_cnt
from actor
group by last_name
order by count(last_name) desc;
#4b

SELECT   last_name, COUNT(last_name) AS dupe_cnt
FROM actor
GROUP BY last_name
HAVING   COUNT(last_name) > 1
ORDER BY COUNT(last_name) DESC;

#4c

UPDATE actor 
SET first_name= 'HARPO'
WHERE first_name='GROUCHO' AND last_name='WILLIAMS';

#4d

update actor set first_name = 'MUCHO GROUCHO' where first_name = 'HARPO'  and last_name = 'WILLIAMS'

#5. 
DESCRIBE sakila.address

#6a.
 select s.first_name, s.last_name, a.address
 from staff s inner join address a on s.address_id = a.address_id;
 
 #6b.
 
 select s.first_name, s.last_name, sum(p.amount) as 'Total'
 from staff s inner join payment p on s.staff_id = p.staff_id
 group by s.first_name, s.last_name;
 
 #6c.
 
 select f.title, count(a.actor_id) as 'Total Appearances'
 from film f inner join film_actor a on f.film_id = a.film_id
 group by f.title;
 
 #6d. 
 select f.title, count(a.actor_id) as 'Total Appearances'
 from film f inner join film_actor a on f.film_id = a.film_id
  where f.title = 'HUNCHBACK IMPOSSIBLE'
 group by f.title;
 #2 appearances
 
 #6e. 
 
 select c.first_name, c.last_name, sum(p.amount) as 'Total'
 from customer c inner join payment p on c.customer_id = p.customer_id
 group by c.first_name, c.last_name
 order by c.last_name;
 
 #7a. 
 
 select title from film
 where 
 (
	title like 'K%' or title like 'Q%'
	)
 and language_id = 
 (
	select language_id from language where name = 'English'
	);
 
 #7b. 
 
 select first_name, last_name
 from actor
 where actor_id in
(
	select actor_id
    from film_actor
    where film_id in
    (
		select film_id
        from film
        where title = 'ALONE TRIP'
	)
);

#7c. 

select first_name, last_name, email
from customer c
join address a on
(
	c.address_id = a.address_id
)
join city ci on 
(
	a.city_id = ci.city_id
)
join country co on
(
	ci.country_id = co.country_id
)

#7d. 

select title, rating from film f
join film_category fcat on (f.film_id=fcat.film_id)
join category c on (fcat.category_id=c.category_id)
where rating = 'G' or rating = 'PG'
order by rating;

#7e. 

select title, count(f.film_id) as 'Number of Times Rented'
from film f 
join inventory i on
(
	f.film_id = i.film_id
)
join rental r on
(
	i.inventory_id = r.inventory_id
)
group by title
order by count('Number of Times Rented') desc;

#7f. 

select s.store_id, sum(p.amount)
from payment p
join staff s on
(
	p.staff_id = s.staff_id
)
group by store_id;

#7g.


select store_id, city, country 
from store s
join address a on 
(
s.address_id=a.address_id
)
join city c on 
(
a.city_id=c.city_id
)
join country co on 
(
c.country_id=co.country_id
);

#7h.

select c.name as 'Top_Films', sum(p.amount) as 'Gross_Revenue'
from category c
join film_category fc on
(
	c.category_id = fc.category_id
)
join inventory i on
(
	fc.film_id = i.film_id
)
join rental r on
(
	i.inventory_id = r.inventory_id
)
join payment p on 
(
	r.rental_id = p.rental_id
)
group by c.name
order by Gross_Revenue limit 5;

#8a. 
create view films_rev
as 
select c.name as 'Top_Films', sum(p.amount) as 'Gross_Revenue'
from category c
join film_category fc on
(
	c.category_id = fc.category_id
)
join inventory i on
(
	fc.film_id = i.film_id
)
join rental r on
(
	i.inventory_id = r.inventory_id
)
join payment p on 
(
	r.rental_id = p.rental_id
)
group by c.name
order by Gross_Revenue limit 5;
select * from films_rev;

#8b. 

select * from films_rev;

#8c. 
drop view if exists films_rev;