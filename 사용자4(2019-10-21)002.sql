commit;

UPDATE tbl_books SET b_price = ROUND(DBMS_RANDOM.VALUE(10000, 50000));

SELECT * FROM tbl_books;

COMMIT;