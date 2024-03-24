-- SELECT = with non-correlated subqueries result
SELECT name
FROM customer
WHERE passwords = (SELECT MAX(passwords) FROM customer);

-- UPDATE
UPDATE loan
SET due_date = DATE_ADD(due_date, INTERVAL 7 DAY)
WHERE return_date IS NULL AND id > 0;

-- DELETE
DELETE FROM loan
WHERE customer_id = (
    SELECT id
    FROM customer
    WHERE name = 'Michael Johnson');



-- SELECT IN with non-correlated subqueries result
SELECT name
FROM customer
WHERE id IN (SELECT customer_id FROM loan WHERE return_date IS NULL);

-- UPDATE
UPDATE customer
SET address = 'New Address'
WHERE id IN (SELECT customer_id FROM loan WHERE due_date > CURDATE());

-- DELETE
DELETE FROM loan
WHERE book_id IN (
    SELECT id
    FROM book
    WHERE edition > 1);



-- NOT IN with non-correlated subqueries result
SELECT name
FROM customer
WHERE passwords NOT IN (SELECT passwords FROM customer WHERE phone LIKE '555%');

-- UPDATE
UPDATE customer
SET address = 'New Address'
WHERE id NOT IN (SELECT customer_id FROM loan WHERE due_date > CURDATE());

-- DELETE
DELETE FROM loan
WHERE book_id NOT IN (
    SELECT id
    FROM book
    WHERE edition > 1);



-- EXISTS with non-correlated subqueries result
SELECT name
FROM customer
WHERE EXISTS (
    SELECT 1
    FROM loan
    WHERE loan.customer_id = customer.id
    AND loan.return_date IS NULL);

-- UPDATE
UPDATE loan
SET due_date = DATE_ADD(due_date, INTERVAL 7 DAY)
WHERE EXISTS (
    SELECT 1
    FROM customer
    WHERE customer.id = loan.customer_id
    AND customer.name = 'Emma Brown');

-- DELETE
DELETE FROM loan
WHERE EXISTS (
    SELECT 1
    FROM customer
    WHERE customer.id = loan.customer_id
    AND customer.address = '789 Maple Avenue, Anytown, USA');



-- NOT EXISTS with non-correlated subqueries result
SELECT c.id, c.name, c.address, c.phone, c.email, c.passwords
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = c.id
    AND l.return_date IS NULL);

-- UPDATE
UPDATE loan
SET due_date = DATE_ADD(due_date, INTERVAL 7 DAY)
WHERE NOT EXISTS (
    SELECT 1
    FROM customer
    WHERE customer.id = loan.customer_id
    AND email LIKE '%@gmail.com');

-- DELETE
DELETE FROM loan
WHERE NOT EXISTS (
    SELECT 1
    FROM customer
    WHERE customer.id = loan.customer_id
    AND customer.address = '789 Maple Avenue, Anytown, USA');



-- = with correlated subqueries result
SELECT name
FROM customer c1
WHERE passwords = (SELECT passwords FROM customer c2 WHERE c2.name = 'Emma Brown');

-- UPDATE
UPDATE loan AS l
JOIN (
    SELECT l1.customer_id, MIN(l2.loan_date) AS min_loan_date
    FROM loan AS l1
    JOIN loan AS l2 ON l1.customer_id = l2.customer_id
    GROUP BY l1.customer_id
) AS subquery ON l.customer_id = subquery.customer_id AND l.loan_date = subquery.min_loan_date
SET l.due_date = DATE_ADD(l.due_date, INTERVAL 7 DAY);

-- DELETE



-- IN with correlated subqueries result
SELECT name
FROM customer c1
WHERE passwords IN (SELECT passwords FROM customer c2 WHERE c2.email LIKE '%@gmail.com');

-- UPDATE
UPDATE loan AS l1
JOIN (
    SELECT l2.due_date, DATE_ADD(l2.due_date, INTERVAL 7 DAY) AS new_due_date
    FROM loan AS l2
    WHERE l2.return_date IS NULL
) AS subquery ON l1.due_date = subquery.due_date
SET l1.due_date = subquery.new_due_date;

-- DELETE
DELETE FROM loan
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM (
        SELECT customer_id
        FROM loan
        WHERE loan_date < '2023-01-20'
    ) AS subquery);




-- NOT IN with correlated subqueries result
SELECT name
FROM customer c1
WHERE passwords NOT IN (SELECT passwords FROM customer c2 WHERE c2.phone LIKE '555%');

-- UPDATE
UPDATE loan AS l1
INNER JOIN (
    SELECT DISTINCT l2.id
    FROM loan AS l2
) AS subquery ON l1.id = subquery.id
SET l1.due_date = DATE_ADD(l1.due_date, INTERVAL 7 DAY);

-- DELETE
DELETE l
FROM loan l
LEFT JOIN (
    SELECT DISTINCT l2.return_date
    FROM loan l2
) AS subquery ON l.return_date = subquery.return_date
WHERE subquery.return_date IS NULL;



-- EXISTS with correlated subqueries result
SELECT name
FROM customer c1
WHERE EXISTS (SELECT * FROM loan l WHERE l.customer_id = c1.id AND l.return_date IS NULL);

-- UPDATE
UPDATE customer c1
SET passwords = passwords + 100
WHERE EXISTS (
    SELECT 1
    FROM loan
    WHERE customer_id = c1.id
    AND return_date IS NULL);

-- DELETE
DELETE FROM loan
WHERE EXISTS (
    SELECT 1
    FROM customer
    WHERE customer.id = loan.customer_id
    AND loan.loan_date < '2023-01-30');



-- NOT EXISTS with correlated subqueries result
SELECT name
FROM customer c1
WHERE NOT EXISTS (SELECT * FROM loan l WHERE l.customer_id = c1.id AND l.return_date IS NULL);

-- UPDATE
UPDATE loan
SET due_date = DATE_ADD(due_date, INTERVAL 7 DAY)
WHERE NOT EXISTS (
    SELECT 1
    FROM customer
    WHERE customer.id = loan.customer_id
    AND customer.name = 'Emma Brown');

-- DELETE
DELETE FROM loan
WHERE NOT EXISTS (
    SELECT 1
    FROM customer
    WHERE customer.id = loan.customer_id
    AND loan.loan_date < '2023-01-30');

