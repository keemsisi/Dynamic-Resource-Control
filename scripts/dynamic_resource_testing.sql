
DROP DATABASE IF EXISTS dynamic_resource_testing ;

create DATABASE dynamic_resource_testing;
use dynamic_resource_testing ; /**Use this database*/



/**CREATING TABLES***/
create table PART_P (
	p_part_key varchar(36) primary key unique not null ,
	p_name varchar(250) NOT NULL ,
	p_mfgr varchar(10) not null,
	p_brand varchar(2500) not null ,
	p_type varchar(25) not null,
	p_size_ integer,
	p_container varchar(10),
	p_retail_price decimal ,
	p_comment_ varchar(23)
);




CREATE TABLE REGION (
	r_region_key varchar(36) primary key unique not null ,
	r_name varchar(25),
	r_comment varchar(152)
);


CREATE TABLE NATION (
	n_nation_key varchar(36) primary key not null unique,
    	n_name varchar(25) ,
    	n_region_key varchar(36) unique not null,
    	n_comment varchar(152),
	CONSTRAINT  nation_const FOREIGN KEY (n_region_key) REFERENCES  REGION(r_region_key)
);


CREATE TABLE SUPPLIER (

    supplier_key varchar(36) primary key unique not null unique ,
    s_name varchar(250) not null, 
    s_address varchar(250) not null,
    s_nation_key varchar(36) not null unique,
    s_phone_number varchar(15),
    s_account_ballance decimal,
    s_comment varchar(101),
    
    
    CONSTRAINT suppier_const
    FOREIGN KEY (s_nation_key)
    REFERENCES  NATION(n_nation_key)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
    
	
);



CREATE TABLE PARTSUPP (
	part_key varchar(36) primary key unique not null ,
	supp_key varchar(36) unique not null ,
	availqty integer ,
	ps_supp_cost decimal ,
	ps_comment varchar(199),

	CONSTRAINT part_p_constraint
	FOREIGN KEY (supp_key) REFERENCES SUPPLIER(supplier_key)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
)ENGINE=INNODB;




CREATE TABLE CUSTOMER (
    c_customer_key varchar(36) primary key unique not null unique ,
    c_name varchar(25) not null ,
    c_address varchar(250) ,
    c_phone varchar(15) ,
    c_account_bal decimal,
    c_mkt_segment varchar(10) ,
    c_comment varchar(117)
    
);


CREATE TABLE ORDERS (
	o_order_key varchar(36) primary key unique not null ,
	o_custom_key varchar(36) unique not null ,
	o_status varchar(1) ,
	o_total_price decimal ,
	o_date DATE,
    	o_order_priority varchar(15),
    	o_clerk varchar(15),
    	o_ship_priority integer ,
    o_comment varchar(79),
    
	CONSTRAINT order_const
	FOREIGN KEY (o_custom_key)
	REFERENCES CUSTOMER(c_customer_key)
	ON UPDATE CASCADE
	ON DELETE RESTRICT

);



CREATE TABLE LINE_ITEMS (
/**compound primary key */
	l_order_key varchar(36) unique not null  , 
	l_line_number_key integer unique not null ,
    
/**compound foreign keys*/
    p_part_key varchar(36)  unique not null ,
	s_sub_key varchar(36) unique  not null ,
	o_order_key varchar(36) unique not null ,

    
    l_quantity decimal,
    l_extended_price decimal ,
    l_discount decimal ,
    l_task  decimal ,
    l_return_flag varchar(1),
    l_line_status varchar(1),
    l_ship_date DATE ,
    l_commit_date DATE ,
    l_receipt_date DATE ,
    l_ship_instruct varchar(25),
    l_ship_mode varchar(10),
    l_comment varchar(44),
    
    
	o_status varchar(1) ,
	o_total_price decimal ,
	o_date DATE,
    o_order_priority varchar(15),
    o_clerk varchar(15),
    o_ship_priority integer ,
    o_comment varchar(79),
    

CONSTRAINT line_items_const_1
	PRIMARY KEY (l_order_key , l_line_number_key ) ,

    CONSTRAINT line_items_const_1
	FOREIGN KEY (p_part_key)
	REFERENCES PART_P(p_part_key)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
    
    
    CONSTRAINT line_items_const_2
	FOREIGN KEY (s_sub_key)
	REFERENCES SUPPLIER(supplier_key)
	ON UPDATE CASCADE
	ON DELETE RESTRICT,
    
    
    CONSTRAINT line_items_const
	FOREIGN KEY (o_order_key)
	REFERENCES ORDERS(o_order_key)
	ON UPDATE CASCADE
	ON DELETE RESTRICT

);






















