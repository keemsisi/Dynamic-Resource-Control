CREATE TABLE REGION (
	r_region_key varchar(36) primary key unique not null ,
	r_name varchar(25),
	r_comment varchar(152)
);

insert into REGION (r_region_key , r_name , r_comment ) values
(uuid() , "us-east-1" , "United State East One"),
(uuid() , "us-east-2" , "United State East One"),
(uuid() , "us-east-3" , "United State East One"),
(uuid() , "us-east-4" , "United State East One"),
(uuid() , "uk-east-5" , "United Kingdom State"),
(uuid() , "us-east-6" , "United State East One")

