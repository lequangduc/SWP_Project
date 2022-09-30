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
    name nvarchar(30) not null,
    price float check (price >0) not null,
    foodtype_id int references foodtype(foodtype_id),
	fooddescription nvarchar(3000),
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
SELECT * from food
select SP.food_id,SP.name,SP.price,SP.foodtype_id,SP.fooddescription,SP.foodimage
from ( select *, ROW_NUMBER() over (order by food_id) as rownumber 
from food) as SP 
where SP.rownumber >= 2 and SP.rownumber <= 3