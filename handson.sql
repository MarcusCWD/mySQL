-- go into the mysql root first
mysql -u root

-- create the database
create database hr_database;

-- select the tageted database for usage
use hr_database;

-- <name of column> <data type> <options>
create table customer(
    customer_id int unsigned auto_increment primary key,
    name varchar(100),
    address varchar(100),
    country varchar(50),
    email varchar(100) not null,
    phone varchar(20),
    status varchar(20)
)engine = innodb;

-- <name of column> <data type> <options>
create table orders(
    order_no int unsigned auto_increment primary key,
    order_date date,
    delivery_date date,
    delivery_address varchar(200),
    ship_mode varchar(25),
    status varchar(20)
)engine = innodb;

-- add in FK (forign key)
-- step 1: create the column for the forign key
alter table orders add column customer_customer_id int unsigned;
-- step 2: setup the forign key
-- parent_id in the the students table will be refered to the parent_id in the parent table 

alter table orders add constraint fk_orders_customers
    foreign key (customer_customer_id) references customer(customer_id);


-- <name of column> <data type> <options>
create table invoice(
    invoice_no int unsigned auto_increment primary key,
    order_date date,
    payment_terms varchar(300),
    tax float,
    status varchar(20)
)engine = innodb;

alter table invoice add column order_order_no int unsigned;

alter table invoice add constraint fk_invoice_orders
    foreign key (order_order_no) references orders(order_no);

-- <name of column> <data type> <options>
create table invoice_item(
    invoice_item_no int unsigned auto_increment primary key,
    item_no int unsigned,
    quality float,
    status varchar(20)
)engine = innodb;

alter table invoice_item add column order_order_no int unsigned;
alter table invoice_item add column product_product_id int unsigned;

alter table invoice_item add constraint fk_invoice_item_order
    foreign key (order_order_no) references invoice(invoice_no);

-- do product first
alter table invoice_item add constraint fk_invoice_item_product
    foreign key (product_product_id) references product(product_id);

create table product(
    product_id int unsigned auto_increment primary key,
    description varchar(50),
    unit_price float,
    stock float,
    uom varchar(5),
    status varchar(20)
)engine = innodb;

create table order_item(
    order_item_no int unsigned auto_increment primary key,
    quality float,
    status varchar(20)
)engine = innodb;

alter table order_item add column order_order_no int unsigned;
alter table order_item add column product_product_id int unsigned;

alter table order_item add constraint fk_order_item_order
    foreign key (order_order_no) references orders(order_no);

alter table order_item add constraint fk_order_item_product
    foreign key (product_product_id) references product(product_id);

-- insert to customer
insert into customer (name,address,country,email,phone,status) values ('Xiao Ming', '5 queenstown road','singapore','xiaoming@gmail.com','99922245','active' ),
('Jonny Sins', ' 68 Orchard road','singapore','sinsJonny@gmail.com','96879029','active' );

-- insert to product
insert into product (description,unit_price,stock,uom,status) values ('apple', 5.50, 996,'unit','active' ),
('pear', 6.60, 628,'unit','active'  ), ('mango', 10.20, 245,'unit','active'  );

-- insert to order
insert into orders (order_date,delivery_date,delivery_address,ship_mode,status, customer_customer_id) values ('2021-09-10','2021-09-15','46 sembawang street 67','air', 'active', 1 ),
('2021-10-25','2021-10-28','46 pond street, New York City','land', 'active', 2);

-- insert to invoice
insert into invoice (order_date,payment_terms,tax,status,order_order_no) values ('2021-09-10','VISA',0.07, 'fulfilled', 3),
('2021-10-25','AMEX',0.1, 'fulfilled', 4);

-- insert to order_item
insert into order_item (order_order_no,product_product_id,quality,status)) values (4,1,18, 'pending'),
(5,2,150, 'on-the-way');

-- to unpair the forign key and remove the col
ALTER TABLE invoice_item DROP FOREIGN KEY fk_invoice_item_invoice;
ALTER TABLE invoice_item DROP COLUMN invoice_invoice_no;