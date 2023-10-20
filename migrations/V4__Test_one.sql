create table dish_ingredient_connection (
    idOfConnection serial primary key ,
    dishID serial NOT NULL,
    ingredientID serial NOT NULL
);

create table dishes (
    id serial primary key ,
    timeToCookInMinutes serial NOT NULL ,
    foreign key (id) references dish_ingredient_connection(idOfConnection)
);

create table ingredients (
    id serial primary key,
    nameOfIngredient varchar NOT NULL ,
    countOfIngredient serial NOT NULL ,
    foreign key (id) references dish_ingredient_connection(idOfConnection)
);

create table menu (
    idOfTheDish serial primary key,
    nameOfTheDish varchar(50) unique NOT NULL ,
    descriptionOfTheDish varchar(150) NOT NULL ,
    price serial NOT NULL ,
    foreign key (idOfTheDish) references dishes(id)
);

create table orders (
    id serial primary key,
    dateOfTheOrder date NOT NULL ,
    timeOfTheOrder time NOT NULL ,
    dishID serial NOT NULL ,
    countOfDishes serial NOT NULL ,
    foreign key (dishID) references menu(idOfTheDish)
);

INSERT INTO dish_ingredient_connection (idOfConnection, dishID, ingredientID)
VALUES (1, 1, 10);

INSERT INTO dish_ingredient_connection (idOfConnection, dishID, ingredientID)
VALUES (2, 1, 11);

INSERT INTO dish_ingredient_connection (idOfConnection, dishID, ingredientID)
VALUES (3, 1, 12);

INSERT INTO dish_ingredient_connection (idOfConnection, dishID, ingredientID)
VALUES (4, 1, 13);

INSERT INTO dishes (id, timeToCookInMinutes)
VALUES (1, 15),
       (2, 15),
       (3, 25);

INSERT INTO ingredients (id, nameOfIngredient, countOfIngredient)
VALUES (4, 'Сливочный соус', 100);

INSERT INTO ingredients (id, nameOfIngredient, countOfIngredient)
VALUES (1, 'Спагетти', 250);

INSERT INTO ingredients (id, nameOfIngredient, countOfIngredient)
VALUES (2, 'Бекон', 100);

INSERT INTO ingredients (id, nameOfIngredient, countOfIngredient)
VALUES (3, 'Яйцо', 1);

INSERT INTO menu(idOfTheDish, nameOfTheDish, descriptionOfTheDish, price)
VALUES(1,'Паста карбонара', 'Паста', 250);

INSERT INTO orders (id, dateOfTheOrder, timeOfTheOrder, dishID, countOfDishes)
VALUES (110, current_date, current_time, 1, 1),
       (99, '2023-09-27', '11:20:00', 1, 2),
       (50, '2022-07-07', '11:20:00', 1, 1),
       (10, '2022-07-07', '18:20:00', 1, 4),
       (100, '2023-09-27', '15:20:00', 1, 3),
       (15, '2021-09-07', '11:15:00', 1, 1),
       (115, current_date, '12:20:00', 1, 2);

SELECT * FROM ingredients LIMIT 3;
SELECT * FROM orders WHERE timeOfTheOrder = current_time;
SELECT sum(countOfDishes) AS countOfDishesTotal, dateOfTheOrder FROM orders GROUP BY dateOfTheOrder;
