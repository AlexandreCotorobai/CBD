DROP KEYSPACE IF EXISTS Biblioteca;
CREATE KEYSPACE IF NOT EXISTS Biblioteca WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE biblioteca;

CREATE TABLE books (
    book_id int,
    title text,
    author text,
    genre text,
    publication_year int,
    tags set<text>,
    available_copies int,
    PRIMARY KEY (book_id, publication_year)
) WITH CLUSTERING ORDER BY (publication_year DESC);

CREATE TABLE readers (
    reader_id int PRIMARY KEY,
    name text,
    email text,
    phone int,
    membership_status text,
    borrowed_books list<int>
);

CREATE TABLE loans (
    loan_id int,
    book_id int,
    reader_id int,
    loan_date timestamp,
    return_date timestamp,
    status text,
    PRIMARY KEY (reader_id, loan_date)
);

CREATE TABLE reservations (
    reservation_id int,
    book_id int,
    reader_id int,
    reservation_date timestamp,
    status text,
    PRIMARY KEY (reader_id, reservation_date)
);

CREATE TABLE physical_conditions (
    condition_id int PRIMARY KEY,
    book_id int,
    reader_id int,
    condition_details map<text, text>,
    date timestamp
);

CREATE INDEX ON books (genre);
CREATE INDEX ON books (author);
CREATE INDEX ON books (tags);
CREATE INDEX ON loans (status); 

INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (1, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951, {'classic', 'coming-of-age'}, 2);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (2, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, {'classic', 'romance'}, 1);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (3, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813, {'classic', 'love story'}, 1);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (4, 'One Hundred Years of Solitude', 'Gabriel García Márquez', 'Magical Realism', 1967, {'magical realism', 'family saga'}, 1);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (5, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 1937, {'fantasy', 'adventure'}, 1);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (6, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 1954, {'fantasy', 'epic'}, 1);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (7, 'Harry Potter and the Sorcerers Stone', 'J.K. Rowling', 'Fantasy', 1997, {'fantasy', 'magic'}, 1);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (8, 'The Shining', 'Stephen King', 'Horror', 1977, {'horror', 'psychological thriller'}, 1);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (9, 'The Da Vinci Code', 'Dan Brown', 'Mystery', 2003, {'mystery', 'conspiracy'}, 1);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (10, 'The Hitchhikers Guide to the Galaxy', 'Douglas Adams', 'Science Fiction', 1979, {'science fiction', 'humor'}, 6);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (11, 'The Chronicles of Narnia', 'C.S. Lewis', 'Fantasy', 1950, {'fantasy', 'childrens literature'}, 7);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (12, 'The Catcher in the Rye teste', 'J.D. Salinger', 'Fiction', 1952, {'classic', 'coming-of-age'}, 2);
INSERT INTO books (book_id, title, author, genre, publication_year, tags, available_copies) VALUES (13, 'The Catcher in the Rye teste2', 'J.D. Salinger', 'Fiction', 2007, {'classic', 'coming-of-age'}, 2);


INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (1, 'Cristiano Ronaldo', 'cristiano@email.com', 123456789, 'active', [1,6]);
INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (2, 'Sara Sampaio', 'sara@email.com', 987654321, 'active', [3,4]);
INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (3, 'José Mourinho', 'jose@email.com', 111222333, 'active', [5,2,7]);
INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (4, 'Daniela Ruah', 'daniela@email.com', 333444555, 'active', [8,5,7]);
INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (5, 'Nani', 'nani@email.com', 555666777, 'active', [9,11]);
INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (6, 'Mariza', 'mariza@email.com', 777888999, 'active', [10]);
INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (7, 'João Félix', 'joao@email.com', 999000111, 'active', [11]);
INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (8, 'Catarina Furtado', 'catarina@email.com', 222333444, 'active', [11, 10]);
INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (9, 'Ricardo Pereira', 'ricardo@email.com', 444555666, 'active', [10, 11]);
INSERT INTO readers (reader_id, name, email, phone, membership_status, borrowed_books) VALUES (10, 'Regina Duarte', 'regina@email.com', 666777888, 'active', [11]);

INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (1, 6, 1, '2023-04-06', '2023-04-20', 'returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (2, 7, 3, '2023-04-07', '2023-04-21', 'not_returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (3, 8, 3, '2023-04-08', '2023-04-22', 'returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (4, 9, 3, '2023-04-09', '2023-04-23', 'returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (5, 10, 2, '2023-04-10', '2023-04-24', 'returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (6, 11, 1, '2023-04-11', '2023-04-25', 'not_returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (7, 1, 5, '2023-04-12', '2023-04-26', 'not_returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (8, 2, 11, '2023-04-13', '2023-04-27', 'returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (9, 3, 9, '2023-04-14', '2023-04-28', 'returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (10, 4, 8, '2023-04-15', '2023-04-29', 'returned');
INSERT INTO loans (loan_id, book_id, reader_id, loan_date, return_date, status) VALUES (11, 5, 8, '2023-04-16', '2023-04-30', 'not_returned');

-- Se um livro não estiver disponível, o leitor pode reservá-lo.
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (1, 1, 3, '2023-02-10', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (2, 3, 1, '2023-03-05', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (3, 2, 2, '2023-04-15', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (4, 4, 4, '2023-04-20', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (5, 5, 5, '2023-04-25', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (6, 6, 6, '2023-05-01', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (7, 7, 7, '2023-05-05', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (8, 8, 8, '2023-05-10', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (9, 9, 9, '2023-05-15', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (10, 10, 10, '2023-05-20', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (11, 11, 1, '2023-05-25', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (12, 1, 2, '2023-06-01', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (13, 2, 3, '2023-06-05', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (14, 3, 4, '2023-06-10', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (15, 4, 5, '2023-06-15', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (16, 5, 6, '2023-06-20', 'active');
INSERT INTO reservations (reservation_id, book_id, reader_id, reservation_date, status) VALUES (17, 6, 7, '2023-06-25', 'active');

INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (1, 1, 1, {'status': 'good', 'notes': 'no visible damage'}, '2023-01-05');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (2, 2, 2, {'status': 'fair', 'notes': 'slight wear on cover'}, '2023-02-10');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (3, 3, 3, {'status': 'excellent', 'notes': 'like new'}, '2023-03-15');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (4, 4, 4, {'status': 'good', 'notes': 'minor creases on cover'}, '2023-04-20');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (5, 5, 5, {'status': 'fair', 'notes': 'visible wear on spine'}, '2023-04-25');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (6, 6, 6, {'status': 'excellent', 'notes': 'like new'}, '2023-05-01');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (7, 7, 7, {'status': 'good', 'notes': 'slight bending on pages'}, '2023-05-05');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (8, 8, 8, {'status': 'fair', 'notes': 'dog-eared corners'}, '2023-05-10');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (9, 9, 9, {'status': 'excellent', 'notes': 'no visible damage'}, '2023-05-15');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (10, 10, 10, {'status': 'good', 'notes': 'minor scratches on cover'}, '2023-05-20');
INSERT INTO physical_conditions (condition_id, book_id, reader_id, condition_details, date) VALUES (11, 11, 1, {'status': 'fair', 'notes': 'visible wear on pages'}, '2023-05-25');



UPDATE reservations SET status = 'cancelled' WHERE reader_id = 1 AND reservation_date = '2023-03-05';
UPDATE readers SET phone = 987654321 WHERE reader_id = 1;
-- update set
UPDATE books SET tags = tags + {'new_tag'} WHERE book_id = 1 AND publication_year = 1951;
-- update list
UPDATE readers SET borrowed_books = borrowed_books + [10] WHERE reader_id = 3;
-- update map
UPDATE physical_conditions
SET condition_details['status'] = 'poor', condition_details['notes'] = 'heavy damage on cover'
WHERE condition_id = 1;

-- testing if the updates worked
SELECT * FROM reservations WHERE reader_id = 1;
SELECT * FROM readers WHERE reader_id = 1;
SELECT * FROM books WHERE book_id = 1;
SELECT * FROM readers WHERE reader_id = 3;
SELECT * FROM physical_conditions WHERE condition_id = 1;


-- Delete a reservation
DELETE FROM reservations
WHERE reader_id = 2 AND reservation_date = '2023-04-15';

-- DELETE a tag from a book
UPDATE books
SET tags = tags - {'romance'}
WHERE book_id = 2 and publication_year = 1925;

-- Remove a book from the borrowed_books list of a reader
UPDATE readers
SET borrowed_books = borrowed_books - [3]
WHERE reader_id = 2;

-- Delete a physical condition record
DELETE FROM physical_conditions
WHERE condition_id = 11;


-- QUERY 1
SELECT * FROM books WHERE genre = 'Fantasy';

-- QUERY 2
SELECT * FROM books WHERE author = 'J.D. Salinger' LIMIT 2;

-- QUERY 3
SELECT * FROM books WHERE tags CONTAINS 'classic';

-- QUERY 4
SELECT COUNT(*) FROM books WHERE genre = 'Fiction';

-- QUERY 5
SELECT * FROM reservations WHERE reader_id = 1 ORDER BY reservation_date ASC;

-- QUERY 6
SELECT reader_id, COUNT(*) FROM loans GROUP BY reader_id;

-- QUERY 7
SELECT reader_id, COUNT(*) FROM loans WHERE status = 'not_returned' GROUP BY reader_id;

-- QUERY 8
SELECT * FROM books WHERE publication_year > 2000 ALLOW FILTERING;

-- QUERY 9
SELECT AVG(publication_year) AS average_year FROM books;

-- QUERY 10
SELECT * FROM books WHERE publication_year = 1951 AND book_id = 1;