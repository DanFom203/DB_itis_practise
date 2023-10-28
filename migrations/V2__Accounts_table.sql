ALTER TABLE accounts
    ADD COLUMN patronymic varchar(50),
    ADD COLUMN profession varchar(100) NOT NULL default '-' ,
    ADD COLUMN nationality varchar(50),
    ADD COLUMN date_of_birth date,
    ADD CONSTRAINT email unique (email),
    ADD CHECK (LENGTH(first_name) >= 2),
    ADD CHECK (LENGTH(last_name) >= 2),
    ADD CHECK (LENGTH(patronymic) >= 2);
