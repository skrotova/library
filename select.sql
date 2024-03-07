SELECT title, years, edition FROM book WHERE edition >= 2;
SELECT count(edition) FROM book WHERE edition >= 2;
SELECT title, edition FROM book order by edition, title;

SELECT customer, book_id, due_date, return_date
FROM loan
HAVING return_date > due_date
ORDER BY customer;

SELECT customer.id, customer.name, book.id, book.title, loan.loan_date, loan.due_date, loan.return_date
FROM loan
JOIN customer ON loan.customer_id = customer.id
JOIN book ON loan.book_id = book.id
JOIN author ON book.author_id = author.id;

SELECT author.id, author.name
FROM author
JOIN book ON author.id = book.author_id
JOIN loan ON book.id = loan.book_id
WHERE loan.return_date IS NULL
ORDER BY author.id;

SELECT customer.id, customer.name, book.id AS book_id, book.title AS book_title, loan.loan_date, loan.due_date, loan.return_date
FROM loan
JOIN customer ON loan.customer_id = customer.id
JOIN book2loan ON loan.book_id = book2loan.book_id
JOIN book ON book2loan.book_id = book.id
WHERE loan.return_date > loan.due_date;





SELECT author.id AS author_id, author.name AS author_name, book.title AS book_title
FROM author
JOIN book2author ON author.id = book2author.author_id
JOIN book ON book2author.book_id = book.id
JOIN book2loan ON book.id = book2loan.book_id
JOIN loan ON book2loan.loan_id = loan.id
WHERE loan.return_date IS NULL
GROUP BY author.id, book.id;

SELECT book.title AS Book_Title, GROUP_CONCAT(genre.name SEPARATOR ", ") AS Genres
FROM book2genre
JOIN book ON book2genre.book_id = book.id
JOIN genre ON book2genre.genre_id = genre.id
GROUP BY book.title
HAVING COUNT(book2genre.genre_id) > 1;
