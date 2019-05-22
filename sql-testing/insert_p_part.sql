INSERT INTO PART_P (
p_part_key , p_name , 
 p_mfgr , 
 p_brand ,
 p_type  , 
 p_size_ ,
 p_container , 
 p_retail_price ,
 p_comment_
) values
( uuid() , "part1" , "mfgr_1" , "brand1" , "type1" , 100 , "ubuntu" , 0.5 , "Satisfactory"),
( uuid() , "part2" , "mfgr_2" , "brand2" , "type2" , 300 , "linux" , 56 , "Good"),
( uuid() , "part3" , "mfgr_3" , "brand3" , "type3" , 400 , "Centos" , 55 , "Awesome"),
( uuid() , "part4" , "mfgr_4" , "brand4" , "type4" , 500 , "Ubuntus" , 46 , "Fine")
;
 
