CREATE DATABASE library;
USE library;

CREATE  TABLE book(
	id INT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
    author_id INT,
    genre_id INT,
	isbn VARCHAR(255),
    edition INT NOT NULL,
    years INT NOT NULL,
    price DOUBLE NOT NULL,

    FOREIGN KEY (author_id) REFERENCES author(id),
    FOREIGN KEY (genre_id) REFERENCES genre(id)
);

CREATE  TABLE author(
	id INT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
    birthday DATE NOT NULL,
    nationality VARCHAR(255) NOT NULL,
    biography TEXT
);

CREATE  TABLE publisher(
	name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    website VARCHAR(255)
);

CREATE  TABLE genre(
	id INT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
    description VARCHAR(255)
);

CREATE  TABLE customer(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    passwords INT NOT NULL
);

CREATE  TABLE loan(
	id INT PRIMARY KEY,
	customer VARCHAR(255),
	customer_id int,
    book_id INT,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,

    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (book_id) REFERENCES book(id)
);

CREATE TABLE book2author (
	book_id INTEGER,
    author_id INTEGER,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (author_id) REFERENCES author(id)
);

CREATE TABLE book2genre (
	book_id INTEGER,
    genre_id INTEGER,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (genre_id) REFERENCES genre(id)
);

CREATE TABLE book2loan (
    book_id INTEGER,
    loan_id INTEGER,
    PRIMARY KEY (book_id, loan_id),
    FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (loan_id) REFERENCES loan(id)
);
