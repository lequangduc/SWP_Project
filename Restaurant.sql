create table tables(
    table_id int primary key not null,
    status nvarchar(30) check (status in ('available','reserved','occupied')),
    capacity int  check (capacity >0 ),
	)
create table food(
    food_id int primary key not null,
    name nvarchar(30) not null,
    price int check (price >0),
    food_type nvarchar(30) not null
)
create table roles(
    role_id int primary key, 
    role nvarchar(30) check (role in ('manager','kitchenstaff','cashier','customer')),
)
create table account(
    account_id int primary key not null,
    name nvarchar(30) not null,
    phone nvarchar(10) check (phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    email nvarchar(30) check (email like '%@%.%'),
	username nvarchar(30) not null,
    password nvarchar(30) not null,
	role_id int references roles(role_id)
)

-- đặt bàn
create table reservation(
    reservation_id int primary key not null,
    table_id int references tables(table_id),
    customer_id int references account(account_id),
    food_id_list nvarchar(30), --bỏ food id vào 1 string cách nhau bởi dấu ','
    dateReservation datetime,
)
create table reservationDetail(
	reservation_id int references reservation(reservation_id),
	food_id int references food(food_id),
	quantity int not null check(quantity >0),
)

create table rating(
	customer_id int references account(account_id),
	point numeric(4,1) not null , 
	comment nvarchar(2000) not null
)
