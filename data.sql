CREATE DATABASE mypgsqldb;

CREATE TABLE inventory (
	id serial PRIMARY KEY, 
	name VARCHAR(50), 
	quantity INTEGER
);

INSERT INTO inventory (id, name, quantity) VALUES (1, 'banana', 150); 
INSERT INTO inventory (id, name, quantity) VALUES (2, 'orange', 154);
INSERT INTO inventory (id, name, quantity) VALUES (3, 'apple', 160);
INSERT INTO inventory (id, name, quantity) VALUES (4, 'lemon', 155);
INSERT INTO inventory (id, name, quantity) VALUES (5, 'peach', 160);
INSERT INTO inventory (id, name, quantity) VALUES (6, 'melon', 161);
