DROP VIEW IF EXISTS view_database, view_contacts;
DROP TABLE IF EXISTS items, contact_categories, contact_types, contacts;

CREATE TABLE IF NOT EXISTS contact_categories (
    id SERIAL PRIMARY KEY,
    contact_category VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS contact_types (
    id SERIAL PRIMARY KEY,
    contact_type VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS contacts (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    title VARCHAR(60),
    organization VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS items (
    contact VARCHAR(40) NOT NULL,
    contact_id INTEGER REFERENCES contacts(id),
    contact_type_id INTEGER REFERENCES contact_types(id),
    contact_category_id INTEGER REFERENCES contact_categories(id)
);

INSERT INTO contacts(first_name, last_name, title, organization) VALUES 
    ('Erik', 'Eriksson', 'Teacher', 'Utbildning AB'),
    ('Anna', 'Sundh', null, null),
    ('Goran', 'Bregovic', 'Coach', 'Dalens IK'),
    ('Ann-Marie', 'Bergqvist', 'Cousin', null),
    ('Herman', 'Appelkvist', null, null)
;

INSERT INTO contact_types(contact_type) VALUES
    ('Email'),
    ('Phone'),
    ('Skype'),
    ('Instagram')
;

INSERT INTO contact_categories(contact_category) VALUES
    ('Home'),
    ('Work'),
    ('Fax')
;

INSERT INTO items(contact, contact_id, contact_type_id, contact_category_id) VALUES
    ('011-12 33 45', 3, 2, 1),
    ('goran@infoab.se', 3, 1, 2),
    ('010-88 55 44', 4, 2, 2),
    ('erik57@hotmail.com', 1, 1, 1),
    ('@annapanna99', 2, 4, 1),
    ('077-563578', 2, 2, 1),
    ('070-156 22 78', 3, 2, 2)
;

INSERT INTO contacts(first_name, last_name, title, organization) VALUES 
    ('Tiril Marie Pedersen', 'Løken', 'Programmer', 'Academic Work')
;

INSERT INTO items(contact, contact_id, contact_type_id, contact_category_id) VALUES
    ('tiril_loken@brightstraining.com', 6, 1, 2)
;

SELECT contact_type FROM contact_types
WHERE id NOT IN
	(SELECT DISTINCT contact_type_id FROM items);

CREATE VIEW view_contacts AS
SELECT c.first_name, c.last_name, i.contact, ct.contact_type, cc.contact_category FROM items i
JOIN contacts c ON i.contact_id = c.id
JOIN contact_types ct ON i.contact_type_id = ct.id
JOIN contact_categories cc ON i.contact_category_id = cc.id
ORDER BY c.last_name, c.first_name;

SELECT * FROM view_contacts;

CREATE VIEW view_database AS
SELECT c.first_name, c.last_name, c.title, c.organization, i.contact, i.contact_id, i.contact_type_id, i.contact_category_id, ct.contact_type, cc.contact_category FROM items i
RIGHT JOIN contacts c ON i.contact_id = c.id
RIGHT JOIN contact_types ct ON i.contact_type_id = ct.id
RIGHT JOIN contact_categories cc ON i.contact_category_id = cc.id
ORDER BY c.last_name, c.first_name;

SELECT * FROM view_database;

-- FIKS DATABASE TING

-- Alternative solution
-- As you can see in the results, i am making duplicates of contact due to the fact that there are multiple contact types.
-- To fix this, making a proper contact table where different contact types are in the same table atleast. Instaed of having seperate phones and emails and so on, keep it in one table with references to what media it is
-- Too exhausted to think atm.

