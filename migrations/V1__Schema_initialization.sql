create table cities (
    id serial primary key,
    isDeliveryPointExist boolean NOT NULL ,
    city_name varchar(50) NOT NULL ,
    isOverMillionPeopleLiveHere boolean NOT NULL ,
    country varchar(50) NOT NULL
);

create table accounts (
    id bigserial primary key,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    city_id int NOT NULL,
    phone_num varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    tag varchar(50) NOT NULL check (tag = 'producer' or tag = 'user'),
    foreign key (city_id) references cities(id)
);

create table products(
    id bigserial primary key,
    name varchar(255) NOT NULL ,
    artikul varchar(255) NOT NULL ,
    price varchar(255) NOT NULL ,
    img varchar(250) NOT NULL
);

create table product_attributes(
    id bigserial primary key,
    name varchar(255) NOT NULL
);

create table products_attributes_values(
  id bigserial primary key,
  product_id bigserial NOT NULL ,
  attribute_id bigserial NOT NULL ,
  value varchar(255) NOT NULL ,
  foreign key (product_id) references products,
  foreign key (attribute_id) references product_attributes
);


create table products_in_stock(
    id serial primary key,
    producer_id bigserial NOT NULL,
    product_id int NOT NULL ,
    count integer NOT NULL ,
    foreign key (product_id) references products(id),
    foreign key (producer_id) references accounts(id)
);


create table reviews(
    review_id serial primary key,
    comment varchar(10000),
    star int,
    product_in_stock_id int,
    user_id bigserial,
    foreign key (product_in_stock_id) references products_in_stock(id),
    foreign key (user_id) references accounts(id)
);