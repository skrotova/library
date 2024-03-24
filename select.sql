CREATE TABLE clone_customer LIKE customer;

CREATE INDEX customer_index ON clone_customer(name);

SELECT name, phone, email, passwords
FROM customer
WHERE name = 'xbalpzdomsppzvievpoh';

SELECT name, phone, email, passwords
FROM clone_customer
WHERE name = 'xbalpzdomsppzvievpoh';
