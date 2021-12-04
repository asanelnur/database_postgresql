--Laboratory work 8

--Task 1:

--a) Increments given values by 1 and returns it:
create function inc(val integer) returns integer as $$
    begin
        return val+1;
    end;
$$
language plpgsql;

select inc(9);

--b) Returns sum of 2 numbers:
create function get_sum(a numeric,b numeric)
returns numeric as $$
    begin
        return a+b;
    end;
$$
language plpgsql;

select get_sum(3,4);

--c) Returns true or false if numbers are divisible by 2:
create or replace function is_divisible_by_2(val integer) returns boolean as $$
    begin
        if(val%2=0) then return true;
        else return false;
        end if;
    end;
$$
language plpgsql;

select is_divisible_by_2(14);

--d)Checks some password for validity:
create or replace function check_password(password varchar)
returns boolean as $$
    begin
        if(length(password)>6) then return  true;
        else return false;
        end if;
    end;
$$
language plpgsql;

select check_password('abcd');
select check_password('abcdabcde');

--e Returns two outputs, but has one input:
create or replace function fun(
    x integer,
    out a integer,
    out sqr integer)
as $$
    begin
        a=x*x;
        sqr=sqrt(x);
    end;
$$ language plpgsql;

select fun(9);

--Task 2:
--a)Return timestamp of the occured action within the database:
create function

--b)Computes the age of a person when persons’ date of birth is inserted:
--c)Adds 12% tax on the price of the inserted item:
--d)Prevents deletion of any row from only one table:
--e)Launches functions  1.d and 1.e:

--Task 3:
--What is the difference between procedure and function?

--Task 4:
--a)Increases salary by 10% for every 2 years of work experience
-- and provides 10% discount and after 5 years adds 1% to the discount:

--b)After reaching 40 years, increase salary by 15%. If work experience is
-- more than 8 years, increase salary for 15% of the already
--increased value for work experience and provide a constant 20% discount: