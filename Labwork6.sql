--Task 1:

--a:
select * from dealer,client;

--b:
select s.dealer_id,c.name as client_name,city,priority as grade,s.id as sell_number,date,amount from client c
    inner join sell s on c.id = s.client_id ;

--c:
select dr.name,c.name,c.city from dealer dr
    inner join client c on dr.id = c.dealer_id
    where dr.location=c.city;

--d:
select s.id as sell_id,amount,c.name as client_name,city from sell s
    inner join client c on c.id = s.client_id
    where amount between 100 and 500;

--e:
select * from dealer left join client c on dealer.id = c.dealer_id

--f:
select c.name as client_name,city,dr.name as dealer_name,charge as commission
from dealer dr inner join client c on dr.id = c.dealer_id;

--g:
select c.name as client_name,city,dr.name,dr.charge as dealer_name from client c
    inner join dealer dr on dr.id = c.dealer_id
    where dr.charge>0.12;

--h:
select c.name as client_name,city,s.id as sell_id,date,amount,dr.name as dealer_name,charge
from client c left join sell s on c.id = s.client_id left join dealer dr on c.dealer_id = dr.id;

--i:
select c.name as client_name,priority,dr.name as dealer_name,s.id as sell_id,amount
from client c inner join dealer dr on dr.id = c.dealer_id left join sell s on c.id = s.client_id
    where  amount>2000 and priority is not null or amount is null;


--Task 2:

--a:
create view vista_a as
    select s.date,count(distinct s.client_id),avg(amount),sum(amount)
    from client c inner join sell s on c.id = s.client_id
    group by date;
select * from vista_a;

--b:
create view vista_b as
    select date,sum(amount)
    from sell group by date
    order by sum(amount) desc limit 5;

select * from vista_b;

--c:
create view vista_c as
    select dealer_id,count(id),sum(amount),avg(amount)
    from sell group by dealer_id;

select * from vista_c;

--d:
create view vista_d as
    select location,sum(amount*charge) as earned_money
    from dealer dr inner join sell s on dr.id = s.dealer_id
    group by location;

select * from vista_d;

--e:
create view vista_e as
    select location,count(s.id),avg(amount),sum(amount)
    from dealer dr inner join sell s on dr.id = s.dealer_id
    group by location;

select * from vista_e;

--f:
create view vista_f as
    select city,count(s.id),avg(amount),sum(amount)
    from client c inner join sell s on c.id = s.client_id
    group by city;

select * from vista_f;

--g:
create view vista_loc as
    select location,sum(amount) as location_sum
    from dealer dr inner join sell s on dr.id = s.dealer_id
    group by location;
create view vista_city as
    select city,sum(amount) as city_sum
    from client c inner join sell s on c.id = s.client_id
    group by city;
select city from vista_loc
    inner join vista_city on location=city
    where location_sum<city_sum;