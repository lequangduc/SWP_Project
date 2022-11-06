create table tablestype(
    tabletype_id int  IDENTITY(1,1) primary key not null,
    tabletype_name nvarchar(30) not null,
    capacity int  check (capacity >0 ),
)

create table tables(
    table_id int IDENTITY(1,1) primary key not null,
	tabletype_id int references tablestype(tabletype_id),
    status nvarchar(30) check (status in ('available','reserved','occupied')), 
)

create table foodtype(
	foodtype_id int IDENTITY(1,1) primary key not null,
	foodtype_name nvarchar(30) not null
)

create table food(
    food_id int IDENTITY(120,1)primary key not null,
    name nvarchar(150) not null,
    price float check (price >0) not null,
    foodtype_id int references foodtype(foodtype_id),
	fooddescription nvarchar(300),
	foodimage nvarchar(300)
)

create table roles(
    role_id int IDENTITY(1,1) primary key, 
    role nvarchar(30) check (role in ('manager','kitchenstaff','cashier','customer')),

)

create table account(
    account_id int IDENTITY(1000,1) primary key not null,
    name nvarchar(30) not null,
    phone nvarchar(10) check (phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    email nvarchar(30) check (email like '%@%.%'),
	username nvarchar(30) not null,
    password nvarchar(30) not null,
	role_id int references roles(role_id)
)

-- đặt bàn
create table reservation(
    reservation_id int IDENTITY(1000,1) primary key not null,
    table_id int references tables(table_id),
    customer_id int references account(account_id),
    dateReservation datetime,
)
create table reservationDetail(
	reservation_id int references reservation(reservation_id),
	food_id int references food(food_id),
	CONSTRAINT PK_Detail PRIMARY KEY (reservation_id,food_id),
	quantity int not null check(quantity >0),
)

create table rating(
	customer_id int references account(account_id),
	point numeric(4,1) not null , 
	comment nvarchar(2000) not null
)

CREATE TABLE data (
 id int NOT NULL IDENTITY(10,1),
 image VARBINARY(MAX) NOT NULL,
 PRIMARY KEY (id)
)

SELECT * from food
select SP.food_id,SP.name,SP.price,SP.foodtype_id,SP.fooddescription,SP.foodimage
from ( select *, ROW_NUMBER() over (order by food_id) as rownumber 
from food) as SP 
where SP.rownumber >= 2 and SP.rownumber <= 3
-----------------------------------------------------------------------------------
select * from tablestype

insert into tablestype(tabletype_name, capacity) values ('T4', 8);
insert into tablestype(tabletype_name, capacity) values ('T6', 8);
insert into tablestype(tabletype_name, capacity) values ('T8', 8);



-----------------------------------------------------------------------------------
select * from tables

insert into tables(tabletype_id, status) values (1, 'available');
insert into tables(tabletype_id, status) values (1, 'available');
insert into tables(tabletype_id, status) values (1, 'available');
insert into tables(tabletype_id, status) values (1, 'reserved');
insert into tables(tabletype_id, status) values (1, 'occupied');
insert into tables(tabletype_id, status) values (1, 'occupied');
insert into tables(tabletype_id, status) values (1, 'reserved');
insert into tables(tabletype_id, status) values (1, 'available');

insert into tables(tabletype_id, status) values (02, 'reserved');
insert into tables(tabletype_id, status) values (02, 'available');
insert into tables(tabletype_id, status) values (02, 'available');
insert into tables(tabletype_id, status) values (02, 'occupied');
insert into tables(tabletype_id, status) values (02, 'reserved');
insert into tables(tabletype_id, status) values (02, 'occupied');
insert into tables(tabletype_id, status) values (02, 'available');
insert into tables(tabletype_id, status) values (02, 'available');

insert into tables(tabletype_id, status) values (03, 'occupied');
insert into tables(tabletype_id, status) values (03, 'available');
insert into tables(tabletype_id, status) values (03, 'available');
insert into tables(tabletype_id, status) values (03, 'occupied');
insert into tables(tabletype_id, status) values (03, 'available');
insert into tables(tabletype_id, status) values (03, 'reserved');
insert into tables(tabletype_id, status) values (03, 'occupied');
insert into tables(tabletype_id, status) values (03, 'available');



-----------------------------------------------------------------------------------
select * from foodtype

insert into foodtype(foodtype_name) values ('appetizer');
insert into foodtype(foodtype_name) values ('main dish');
insert into foodtype(foodtype_name) values ('dessert');
insert into foodtype(foodtype_name) values ('drink');



-----------------------------------------------------------------------------------
select * from food 

insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Easy Big Mac Bites', 50000, 1, 'Easy Big Mac Bites are appetizers that taste like your favorite fast-food burger! All the flavors of a Big Mac but in a fun bite-sized portion that’s perfect for parties!',
'https://drive.google.com/file/d/1SbIH7r_hZCXm3dCGlRANY5t14r14-L7K/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Cheesy Meatball Bites', 50000, 1, 'Cheesy Meatball Bites made with crescent dough, frozen meatballs, marinara sauce and lots of cheese! Easy meatball appetizer recipe perfect for parties & game day.', 
'https://drive.google.com/file/d/1lXFYLrcYctgWr5CzM27ELNljLkXIMwQK/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Meatloaf cupcakes', 50000, 1, 'Meatloaf cupcakes recipe made with a fantastic blend of ground beef, sausage & savory seasonings, made into mini meatloaves, topped with mashed potatoes!', 
'https://drive.google.com/file/d/1MurMYQlX8bUZUXmZ2xmGHg_mpqUIP8EJ/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Cheesy Biscuit Wreath', 60000, 1, 'Turn your canned biscuits into an incredible appetizer with this cheesy biscuit wreath. Made with Grands flaky biscuits, cheese, seasonings, and butter, this is an easy & festive way to serve rolls!', 
'https://drive.google.com/file/d/1opVQJtMDeGtmw8CzF4DE2uJOYi_gE43M/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Peaches and Cream Fruit Dip ', 60000, 1, 'Peaches and Cream Fruit Dip is a sweet cream cheese fruit dip perfect for any occasion! This 5 ingredient peaches and cream recipe is easy, delicious, and perfect served with fresh fruit. ', 
'https://drive.google.com/file/d/14a8EddTFBjipMxrGkCnpTdBe14JvHDZl/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Cranberry Salsa Dip', 80000, 1, 'Cranberry Salsa Dip is made with cranberries, sugar and spices, and then poured over cream cheese to make a delicious holiday appetizer recipe. This simple dip recipe is perfect for parties and goes well with chips and crackers.', 
'https://drive.google.com/file/d/1RooSNy1W6_5H0a4vxx2fkBzlphHPkVOL/view?usp=sharing');

insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Candied-Canuck-Burger', 100000, 2, 'Steak sauce is not a huge stretch for a burger. It’s designed for beef and the grill, but it’s a flavour that can overpower the taste buds.', 
'https://drive.google.com/file/d/1TOM8GxXh5elpIh9O6Rup7J0sOkiF7cFP/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Hawaiian Pulled Pork Sandwich', 130000, 2, 'Rich pineapple flavors create a sweet and savory slow-cooked sandwich featuring Hy-Vee Midwest pork.', 
'https://drive.google.com/file/d/194vyHFzd9HpR7Q5GjZ0hK04c0QG9O2Xd/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Reuben Sandwich', 150000, 2, 'A reuben is one of the best all time sandwiches. We believe it belongs up there on the sandwich Mt. Rushmore along with the BLT, Banh Mi and Meatball Hero.', 
'https://drive.google.com/file/d/10X3oT-eBuKmgvBJycYQe6kpyyqvB1tl5/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Chow Mein', 200000, 2, 'Chow mein is one our go-to for all types of meals, not just for its incredible flavor but its major customizability. We love this variation with tender, flavorful chicken but you can add whatever you like from kimchi to bacon to jalapeños!', 
'https://drive.google.com/file/d/1k4S_PDxJWr1HH4jzGN-qn0RXKxzS51uc/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Spaghetti Bolognese', 200000, 2, 'Spaghetti bolognese consists of spaghetti (long strings of pasta) with an Italian ragù (meat sauce) made with minced beef, bacon and tomatoes, served with Parmesan cheese.', 
'https://drive.google.com/file/d/1qgMtLP1rIFSsCpY7tLlJOeEdPY8Eh1nD/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Spaghetti Arrabbiata', 200000, 2, 'Spaghetti Arrabbiata is the perfect pasta dish for those who love a little heat.  This garlicky marinara is given a kick with the addition of spicy cherry peppers and crushed red pepper flakes.', 
'https://drive.google.com/file/d/10HyPz5YZhjjQcht1o_4qYc39WEPQaf_L/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Chicken Parm Pasta', 250000, 2, 'The salty goodness of crisped pork belly transfers over to the leaner white meat. Toasting our panko in that same pan leads to an even more flavorful bread-crumb topping, complete with a slightly spicy.', 
'https://drive.google.com/file/d/1kFqe_Ju_jAVe6BLVVnPgxLX9ZOFj3RYw/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Parmesan Chicken Cutlets', 250000, 2, 'When we want an extra-crispy coating, we almost always go for panko breadcrumbs. Here, we mix them with some Parmesan, lemon zest, and a pinch of cayenne for extra flavor.', 
'https://drive.google.com/file/d/1sKYY8h8s6i8IwfTIojzsfsxSswZJ9tmZ/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Coconut Milk Chicken', 300000, 2, 'Coconut Milk Chicken recipe comes together in one pan, with a creamy sauce that’s out of this world.', 
'https://drive.google.com/file/d/1d2tlIDMpCK7WDX3dHQLqnvuhYcswVzPP/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Spatchcocked Smoked Turkey', 350000, 2, 'Sweet, tangy, and succulent thanks to Rodney Scott’s smoky dry rub and spicy mopping sauce, this turkey is easy to tackle on a kamado-style cooker.', 
'https://drive.google.com/file/d/1kgrTpn2w8XB5qIuFXM8dXYQYL00Vv3QQ/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Smoked Pork Ribs', 350000, 2, 'Tender meat, a perfect sized bone to impart delicious flavor and juiciness, and that perfect level of smokiness.', 
'https://drive.google.com/file/d/1-Iz6FCEazeSGIP0TL-zaH34mUnnwzdM0/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Smoked Baby Back Ribs', 350000, 2, 'Few things in life compare to the sweet and tangy taste sensation of slow-smoked, baby back ribs, whether you like them competition-style or falling off the bone.', 
'https://drive.google.com/file/d/18EK_O1FS_7bsfdPY0A4QaNrdUooYeg7T/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Smoked Chicken Breast', 400000, 2, 'This smoked chicken breast is so easy to make and full of flavor from the homemade seasoning mix and smoke infused into it.', 
'https://drive.google.com/file/d/1JRK2a1w5UlYO442AGSTDNgSqClV5CQ9o/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Smoked BBQ Brisket', 400000, 2, 'Packed with flavor smoked beef brisket with an incredible bark - one of the best meats to smoke in your backyard.', 
'https://drive.google.com/file/d/1mAoNzZNH5rouOtVVy_DxF3P63oqCUeO2/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Smoked BBQ Brisket Burnt Ends', 400000, 2, 'These burnt ends are made from the point-end of a brisket.', 
'https://drive.google.com/file/d/1lrJnS6H4ujTaKD5N347Pg8WVqmK3D4ZC/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Smoked BBQ Spatchcock Chicken', 475000, 2, 'Spatchcocking is a great BBQ option, you get more surface which means more rub, and cook time is a lot faster.', 
'https://drive.google.com/file/d/1v8KWVTpEAKRRYjczppP2YurUDBs2-eKb/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Smoked Beef Ribs', 475000, 2, 'Delicious, incredibly rich, tasty, and delightful, smoked beef ribs are a hot item these days, but they are hard to find on most BBQ joint menus due to high cost.', 
'https://drive.google.com/file/d/1cLofs9_lRoNHlXJ5lV8wnJZP4F2mcEmE/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Grilled Beef Steak', 500000, 2, 'Enjoy these grilled beef steaks sprinkled with salt and pepper that’s ready in just 20 minutes – perfect for a dinner.', 
'https://drive.google.com/file/d/1kzm-07wuLv8tmJp7KtO6MBl1zssuGz0-/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Smoked Meatloaf', 500000, 2, 'Our version is cooked on a pellet grill and slathered with a sweet BBQ sauce. Plus our tips to keep your meatloaf moist and tender whilst maximizing the smoky flavor.', 
'https://drive.google.com/file/d/1GOiQ9DRJ_Bx0nWBsH5_wM3Izy3aO9yrz/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Grilled Balsamic and Soy Marinated Flank Steak', 500000, 2, 'Flank steak is a perfect grilling meat. It’s marbleized with fat that melts while grilling and fills the meat with the flavor of natural juices.', 
'https://drive.google.com/file/d/19woxDNhrAYry9vjmL4iCqYUXzrxtfgBw/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Butter Chicken', 500000, 2, 'To make this delicious preparation, the chicken is first marinated in yogurt, then browned in a pan before being drenched in a tomato gravy thick with spices like turmeric and garam masala.', 
'https://drive.google.com/file/d/1UEdZyn-Q16S-7xIXRDOWTuKWZRhqCgXG/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('SOiF', 600000, 2, 'The Foie Gras at SOiF is a borderline inappropriately fat slab of seared foie topped with glistening beads of salmon roe, nori shreds and bonito flakes and perched atop Japanese miso sticky rice.', 
'https://drive.google.com/file/d/1GbfS7G9xoJ7H0LlezW5qnnU-8TWtcJxL/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Coquille Beef Wellington', 600000, 2, 'Coquille’s Beef Wellington is the motherload, the pièce de résistance, the ultimate in all things indulgent, and it’s worth every damn kuai.', 
'https://drive.google.com/file/d/1080DF56CbO3tVgbpGvzQOgAlu5rpmdjw/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Meat-lover BBQ Grilled Buffet', 800000, 2, 'For the meat-lover we have selected a blend of some of the best meat dishes using the best quality of local pork ribs, local chicken and imported Australian beef steak.', 
'https://drive.google.com/file/d/1KTr1iV9vurGBT37B0FBEIGM3OsUu7epM/view?usp=sharing');

insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Lemon and Yoghurt Syrup Cake', 60000, 3, 'Create these tasty Lemon and yoghurt syrup cake that incorporates healthier options of coconut sugar, spelt flour and low-fat Greek yoghurt.',
'https://drive.google.com/file/d/1_p0pQ5m9R69sfyEHXmyMCOvOotoDvQga/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Gooey Peanut butter and Chocolate fridge bar', 80000, 3, 'This nutty vegan treat does not require any baking!', 
'https://drive.google.com/file/d/1t31UC_O4i_-Mi17yeN8Otym_4Ta1wXH6/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Chia and Coconut Pudding', 80000, 3, 'Indulge in a taste of tropical paradise with this mouth-watering coconuty dessert containing healthy chia seeds.', 
'https://drive.google.com/file/d/1OK_dN2qlmQPsxbcU-SNaojvzJIgO-_1d/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Lemon Panna Cotta with Vodka Blueberry Syrup', 90000, 3, 'This lemon panna cotta is very creamy but it is low in fat!', 
'https://drive.google.com/file/d/1CTsUOjOoYf3zk0Nkk_GRhmh3rDlsEst8/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Strawberry Frozen Yoghurt', 100000, 3, 'Your kids will love this health-right snack of strawberry frozen yoghurt.', 
'https://drive.google.com/file/d/1bYjaxR7i29p8Hm9r1n6un19HtAqjkVaJ/view?usp=sharing');

insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Aquafina', 15000, 4, 'Bottle of Mineral Water', 
'https://drive.google.com/file/d/1EuBscEQ_CrpR-b40yl5HTgkdGWX1P0Ld/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Coke', 20000, 4, 'Can of Cocacola with original taste', 
'https://drive.google.com/file/d/1bQ1dxlU0YsmualgduDp7DlKo-f7sPVol/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('7Up', 20000, 4, 'Can of 7Up', 
'https://drive.google.com/file/d/14co4TrUdGTfpWckBFJ2OebOwhNni9vuk/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Pepsi', 20000, 4, 'Can of Pepsi', 
'https://drive.google.com/file/d/1T6oj5XbFqqiGICT0Is3dYyqQNIRtzSfX/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Huda', 40000, 4, 'Can or Bottle of Huda beer', 
'https://drive.google.com/file/d/1bwa22qot3zvB8qfd1AIf086oWrPqCyT6/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Larue', 40000, 4, 'Can of Larue beer', 
'https://drive.google.com/file/d/1BPyi1VTuWlega4XDksLOLXTGQW2AdvpU/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Tiger', 50000, 4, 'Can of Tiger beer', 
'https://drive.google.com/file/d/1RFjTgTMr_L1ibx9CrFQAoSUWOeLmN3fN/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Soju', 50000, 4, 'bottle of Korean wine', 
'https://drive.google.com/file/d/1oUzm1YipIuuvpSKXB56rgLfp6BZMIrTl/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Margarita', 80000, 4, 'The classic Margarita has been one of the most popular cocktails in America for years and still remains on top.', 
'https://drive.google.com/file/d/1z0ts7t3oRqk7i-fdM2C1fFCm_FgRPwHE/view?usp=sharing');
insert into food(name, price, foodtype_id, fooddescription, foodimage) values
('Old Fashioned', 80000, 4, 'With an air of class and sophistication, the Old Fashioned cocktail is a classic that remains just as popular now as it did over 200 years ago.', 
'https://drive.google.com/file/d/1UyMxPhjeVauIVqTLpKChPCUhKqU0p3Qm/view?usp=sharing');


-----------------------------------------------------------------------------------
select * from roles

insert into roles(role) values ('manager');
insert into roles(role) values ('cashier');
insert into roles(role) values ('customer');
insert into roles(role) values ('kitchenstaff');

-----------------------------------------------------------------------------------
select * from account

insert into account(name, phone, email, username, password, role_id) values
('Lee AAA1', '0123456789', 'admin1@gmail.com', 'admin1', '123', 1); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA2', '0984563214', 'admin2@gmail.com', 'admin2', '123', 1); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA3', '0856444222', 'ks1@gmail.com', 'ks1', '123', 4); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA4', '0856000111', 'ks2@gmail.com', 'ks2', '123', 4); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA5', '0981111444', 'csh1@gmail.com', 'csh1', '123', 2); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA6', '0981114444', 'csh2@gmail.com', 'csh2', '123', 2); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA7', '0984441111', 'cus1@gmail.com', 'cus1', '000', 3); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA8', '0985666111', 'cus2@gmail.com', 'cus2', '000', 3); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA9', '0987778888', 'cus3@gmail.com', 'cus3', '000', 3); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA10', '0911122233', 'cus4@gmail.com', 'cus4', '000', 3); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA11', '0856444333', 'cus5@gmail.com', 'cus5', '000', 3); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA12', '0856332244', 'cus6@gmail.com', 'cus6', '000', 3); 
insert into account(name, phone, email, username, password, role_id) values
('Lee AAA13', '0856995566', 'cus7@gmail.com', 'cus7', '000', 3); 



-----------------------------------------------------------------------------------
select * from reservation

insert into reservation(table_id, customer_id, dateReservation) values
(4, 1006, '2022-10-05 13:30:00');
insert into reservation(table_id, customer_id, dateReservation) values
(7, 1007, '2022-10-05 13:30:00');
insert into reservation(table_id, customer_id, dateReservation) values
(9, 1008, '2022-10-05 15:30:00');
insert into reservation(table_id, customer_id, dateReservation) values
(13, 1009, '2022-10-05 15:45:00');
insert into reservation(table_id, customer_id, dateReservation) values
(22, 1010, '2022-10-05 18:00:00');


-----------------------------------------------------------------------------------

select * from reservationDetail

insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 120, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 121, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 126, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 128, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 130, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 135, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 136, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 138, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 142, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 150, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 155, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 156, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1000, 160, 4);

insert into reservationDetail(reservation_id, food_id, quantity) values
(1001, 121, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1001, 123, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1001, 126, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1001, 128, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1001, 133, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1001, 154, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1001, 156, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1001, 158, 2);

insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 123, 6);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 125, 6);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 129, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 130, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 135, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 139, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 140, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 141, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 152, 6);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 156, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1002, 157, 3);

insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 122, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 124, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 126, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 127, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 129, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 132, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 135, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 139, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 142, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 145, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 147, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 150, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 151, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 159, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 162, 10);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1003, 164, 4);

insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 122, 5);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 123, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 124, 5);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 128, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 129, 5);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 133, 4);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 135, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 137, 5);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 139, 8);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 142, 2);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 145, 5);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 149, 1);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 152, 5);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 153, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 155, 8);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 158, 5);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 160, 3);
insert into reservationDetail(reservation_id, food_id, quantity) values
(1004, 164, 8);


-----------------------------------------------------------------------------------

select * from rating

insert into rating(customer_id, point, comment) values
(1006, 100, 'The food is really good.');
insert into rating(customer_id, point, comment) values
(1007, 100, 'The food is really good.');
insert into rating(customer_id, point, comment) values
(1008, 100, 'The food is really good.');
insert into rating(customer_id, point, comment) values
(1009, 100, 'The food is really good.');
insert into rating(customer_id, point, comment) values
(1010, 100, 'The food is really good.');
