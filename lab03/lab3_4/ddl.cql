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
