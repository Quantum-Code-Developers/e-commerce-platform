-- Create the database
CREATE DATABASE e_commerce;
USE e_commerce;

-- Users table
CREATE TABLE users_table (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL
);

-- Category table
CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

-- Product table
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    price_description TEXT,
    stock_quantity INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    user_id INT,
    status TEXT,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users_table(user_id)
);

-- Order Item table
CREATE TABLE order_item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Payment table
CREATE TABLE payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Shipping table
CREATE TABLE shipping (
    shipment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    shipping_address VARCHAR(255) NOT NULL,
    shipping_date DATE NOT NULL,
    tracking_number VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


select u.user_id, u.user_name, u.email, u.phone, p.product_id, p.product_name, p.price, p.price_description, p.stock_quantity
from users_table as u
inner join product  as p on
users_table.user_id = product.user_id;

select p.product_id,  p.product_name, p.price, p.price_description, p.stock_quantity, c.category_id, c.categoey_name
from product as p
inner join category as c
on product.product_id = category.product_id;

select o.order_id, o.order_date, o.status, o.total_amount, pm.payment_method, pm.payment_date, pm.amount
from orders as o 
join payment as pm 
on orders.order_id = payment.order_id;

select p.product_id,  p.product_name, p.price, p.price_description, p.stock_quantity, o.order_id, o.order_date, o.status, o.total_amount
from product as p
inner join orders as o on 
product.product_id = orders.product_id;

select  u.user_id, u.user_name, u.email, u.phone, o.order_id, o.order_date, o.status, o.total_amount
from users_table as u 
join orders as o
on users_table.user_id = orders.user_id;

select oi.order_item_id, 
    o.order_id, 
    p.product_name, 
    oi.quantity, 
    oi.price_at_purchase
FROM 
    order_item as oi
INNER JOIN 
    orders as o ON oi.order_id = o.order_id
INNER JOIN 
    product as p ON oi.product_id = p.product_id;
    
    
select  o.order_id, o.order_date, s.shipping_address, s.shipping_date,s.tracking_number
from orders as o
inner join shipping as s on 
o.order_id = s.order_id;
