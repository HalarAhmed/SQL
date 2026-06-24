CREATE TABLE PO_ITEMS ( 
 PO_NO INTEGER, 
 ITEM_NO INTEGER, 
 PRODUCT_NO INTEGER, 
 QTY INTEGER, 
 NET_PRICE NUMERIC,
 -- DEFINING A PRIMARY KEY ALONGWITH NAMING IT'S CONSTRAINT
 CONSTRAINT PO_PK PRIMARY KEY(PO_NO,ITEM_NO) 
);
CREATE TABLE PRODUCT ( 
 PRODUCT_NO INTEGER, 
 DESCRIPTION TEXT, 
 PRODUCTION_COST NUMERIC 
); 
-- ADDING A PRIMARY KEY:
ALTER TABLE PRODUCT ADD PRIMARY KEY(PRODUCT_NO);

CREATE TABLE vendors (name VARCHAR(255));
INSERT INTO vendors (NAME) VALUES ('Microsoft'), ('IBM'), ('Apple'), ('Samsung'); 
-- ADDING A AUTO-INCREMENTING PK
ALTER TABLE vendors ADD COLUMN ID SERIAL PRIMARY KEY; 
-- DROPING THE PRIMARY KEY:
ALTER TABLE vendors DROP CONSTRAINT vendors_pkey;

CREATE TABLE customers (
   customer_id INT,
   customer_name VARCHAR(255) NOT NULL,
   email VARCHAR(255) UNIQUE,
   phone VARCHAR(20),
   PRIMARY KEY(customer_id)
);
CREATE TABLE contacts(
   contact_id INT,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   CONSTRAINT contact_pk PRIMARY KEY(contact_id),
   -- ON DELETE CASCADE: If you delete a customer, all their contacts are deleted too, but the foreign key relationship still exists for future rows.
   CONSTRAINT contacts_fk FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE -- WE CAN ALSO WRITE 'ON DELETE SET DEFAULT/NULL'
);
-- Insert customers
INSERT INTO customers (customer_id, customer_name, email, phone)
VALUES
(1, 'Alice Johnson', 'alice@example.com', '123-456-7890'),
(2, 'Bob Smith', 'bob@example.com', '987-654-3210'),
(3, 'Charlie Brown', 'charlie@example.com', '555-555-5555');

-- Insert contacts linked to customers
INSERT INTO contacts (contact_id, customer_id, contact_name)
VALUES (101, 1, 'Eve Adams'),(102, 1, 'Frank Miller'),(103, 2, 'Grace Lee'),
(104, 3, 'Hank Green'),(105, 3, 'Ivy White');
INSERT INTO contacts (contact_id,customer_id,contact_name) VALUES(106,3,'JOHN MILLER');

DELETE FROM CUSTOMERS WHERE customer_id=1; -- DELETES FROM BOTH PARENT+CHILD TABLE:
SELECT *FROM CUSTOMERS;
SELECT *FROM CONTACTS;
CREATE TABLE orders (
   order_id INT,
   customer_id INT,
   order_date DATE,
   amount DECIMAL(10,2),
   contact_id INT,
   CONSTRAINT orders_pk PRIMARY KEY(order_id),
   CONSTRAINT orders_fk FOREIGN KEY(contact_id) REFERENCES contacts(contact_id) ON DELETE SET NULL
);
ALTER TABLE orders ADD CONSTRAINT order_fk1 FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
ON DELETE CASCADE;
SELECT *FROM ORDERS;
ALTER TABLE orders ADD COLUMN PRICE INT CHECK(PRICE>100.00);
ALTER TABLE orders DROP COLUMN PRICE;
ALTER TABLE orders ADD COLUMN DISCOUNT DECIMAL(10,3);
ALTER TABLE orders ADD CONSTRAINT discount_check CHECK(AMOUNT>0 AND DISCOUNT>0 AND AMOUNT>DISCOUNT);
ALTER TABLE orders





