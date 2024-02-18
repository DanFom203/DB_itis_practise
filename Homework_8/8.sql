
BEGIN;
\set t_n random(5432000284, 5435999873)
\set f_i random(2, 214867)
\set new_amount random(1000, 1000000)
\set new_p_i_p1 random(1000, 9999)
\set new_p_i_p2 random(100000, 999999)
\set f_c random(0, 1)
\set b_r random(1048576, 16777215)
\set t_a random(5000, 1000000)

select book_ref, passenger_name, contact_data, ticket_no
from tickets
where ticket_no = '000' || :t_n::text;
--оператор :: используется для каста числа в строчный тип

select * from boarding_passes
where ticket_no = '000' || :t_n::text and flight_id = :f_i;

-- сколько билетов куплено и общая сумма + информация
select t.passenger_name, count(t.ticket_no), b.total_amount, tf.fare_conditions, b.book_date
from bookings b
    join tickets t on b.book_ref = t.book_ref
    join ticket_flights tf on t.ticket_no = tf.ticket_no
where (CASE WHEN :f_c = 1 THEN tf.fare_conditions = 'Business' ELSE tf.fare_conditions = 'Economy' END)
group by t.passenger_name, b.total_amount, tf.fare_conditions, b.book_date
order by b.total_amount desc;

-- select t.passenger_name, tf.amount, tf.fare_conditions, b.book_ref, b.book_date from bookings b
-- join tickets t on b.book_ref = t.book_ref
-- join ticket_flights tf on t.ticket_no = tf.ticket_no
-- where (CASE WHEN :f_c = 1 THEN tf.fare_conditions = 'Business' ELSE tf.fare_conditions = 'Economy' END)
-- order by b.total_amount desc;

-- самый дорогой билет бизнес-класса/эконом-класса + общее кол-во билетов
select fare_conditions, max(amount), min(amount), count(ticket_no) from ticket_flights
where flight_id = :f_i
group by fare_conditions;

-- пассажир + аэропорт вылета
select t.passenger_name, ad.airport_name ->> 'ru' as departure_airport_name
from tickets t
    join ticket_flights tf on t.ticket_no = tf.ticket_no
    join flights f on tf.flight_id = f.flight_id
    join airports_data ad on f.departure_airport = ad.airport_code
where t.ticket_no = '000' || :t_n::text
order by passenger_name;

UPDATE tickets
SET passenger_id = :new_p_i_p1::text || ' ' || :new_p_i_p2::text
WHERE ticket_no = '000' || :t_n::text;

WITH max_amount_cte AS (
    SELECT
        fare_conditions,
        MAX(amount) AS max_amount
    FROM
        ticket_flights
    WHERE
        fare_conditions = CASE WHEN :f_c = 1 THEN 'Business' ELSE 'Economy' END
    GROUP BY
        fare_conditions
)
UPDATE ticket_flights tf
SET amount = :new_amount
FROM max_amount_cte
WHERE
    tf.fare_conditions = max_amount_cte.fare_conditions
    AND tf.amount = max_amount_cte.max_amount;

-- WITH max_amount_cte AS (
--     SELECT
--         fare_conditions,
--         MAX(amount) AS max_amount
--     FROM
--         ticket_flights
--     WHERE
--         fare_conditions = CASE WHEN :f_c = 1 THEN 'Business' ELSE 'Economy' END
--     GROUP BY
--         fare_conditions
-- )
-- SELECT *
-- FROM ticket_flights tf, max_amount_cte
-- WHERE tf.amount = max_amount_cte.max_amount;

INSERT INTO bookings (book_ref, book_date, total_amount)
VALUES (to_hex(:b_r::int)::text, current_timestamp, :t_a::int);

DELETE FROM bookings WHERE book_ref = to_hex(:b_r::int)::text;

END;