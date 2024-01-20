USE biblioteca;


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