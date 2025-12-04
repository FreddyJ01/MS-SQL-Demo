-- The use command specifies which database we are currently manipulating.
USE DemoDB
GO

-- Creating a new table.
CREATE TABLE EMPLOYEES_TEST
(
    SSN VARCHAR(11),
    EMP_ID INT,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50)
);

-- Inserting into a table.
INSERT INTO EMPLOYEES_TEST (SSN, EMP_ID, FIRST_NAME, LAST_NAME) VALUES ('751-03-1503', 1, 'Andrew', 'Rivers');
INSERT INTO EMPLOYEES_TEST (SSN, EMP_ID, FIRST_NAME, LAST_NAME) VALUES ('039-54-4183', 2, 'Vera', 'Hill');
INSERT INTO EMPLOYEES_TEST (SSN, EMP_ID, FIRST_NAME, LAST_NAME) VALUES ('520-05-0425', 3, 'Ben', 'Jones');
INSERT INTO EMPLOYEES_TEST (SSN, EMP_ID, FIRST_NAME, LAST_NAME) VALUES ('662-10-5060', 4, 'Ben', 'Jones');
INSERT INTO EMPLOYEES_TEST (SSN, EMP_ID, FIRST_NAME, LAST_NAME) VALUES ('257-34-8033', 5, 'Chelsea', 'Walsh');

-- Selecting Specific Columns From A A Table
SELECT SSN, EMP_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES_TEST;

-- Use and asterisk symbol (*) to select all columns
SELECT *
FROM EMPLOYEES_TEST;

-- Update records
UPDATE EMPLOYEES_TEST
SET LAST_NAME = 'Miller'
WHERE EMP_ID = 5;

-- Delete a record (row)
DELETE FROM EMPLOYEES_TEST
WHERE EMP_ID = 1;

-- INSERT, SELECT, UPDATE and DELETE are examples of Data Manipulation Language (DML)
-- CREATE TABLE and DROP TABLE are examples of Data Definition Language (DDL)

-- This command will allow us to make changes to the table, then later either rollback to undo changes or commit to save the changes.
BEGIN TRANSACTION;

INSERT INTO EMPLOYEES_TEST (SSN, EMP_ID, FIRST_NAME, LAST_NAME) VALUES ('257-35-8088', 6, 'Nigel', 'Williams');

-- Undo transactional changes
ROLLBACK;

-- Commit transactional changes
COMMIT TRANSACTION;

-- Delete a whole table
DROP TABLE EMPLOYEES_TEST;