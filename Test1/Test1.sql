SELECT * FROM ingredients LIMIT 3;
SELECT * FROM orders WHERE timeOfTheOrder = current_time;
SELECT sum(countOfDishes) AS countOfDishesTotal, dateOfTheOrder FROM orders GROUP BY dateOfTheOrder;