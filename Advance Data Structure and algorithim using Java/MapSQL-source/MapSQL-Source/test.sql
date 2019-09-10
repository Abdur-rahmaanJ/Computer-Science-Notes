CREATE TABLE contacts(id INT AUTO_INCREMENT, name CHAR(30) NOT NULL, email CHAR(30));

INSERT INTO contacts(name, email) VALUES('Rem', 'Rem.collier@ucd.ie');

SELECT * FROM contacts WHERE id < 2;
