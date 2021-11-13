--Task 1:
--Large objects (photos, videos, CAD files, etc.) are stored as a large object:
--      * blob: binary large object -- object is a large collection of uninterpreted binary data
--   (whose interpretation is left to an application outside of the database system)
--      * clob: character large object -- object is a large collection of character data
--
--When a query returns a large object, a pointer is returned rather than the large object itself.

--Task 2:
--    Privilege is types of authorizations (Read,Insert,Update,Delete)
--    A role is  a way to distinguish among various users as far as what
-- these users can access/update in the database.
--    User is a role with the LOGIN attribute.

--1)
create role accountant;
grant update,select on accounts to accountant;
grant insert,select on transactions to accountant;

create role administrator;
grant select,insert,update,delete on customers,accounts to administrator;
grant select on transactions to administrator;

create role support;
grant select,insert,update,delete on accounts,customers to support;

--2)
create user first_accountant;
grant accountant to first_accountant;

create user first_admin;
grant administrator to first_admin;

create user one_support;
grant support to one_support;

--3)
alter user first_admin createrole;

--4)
revoke delete,insert from one_support;

--Task 3:
--2)
alter table transactions alter column src_account set not null;
alter table transactions alter column dst_account set not null;

--Task 5:
create unique index index1 on accounts (customer_id,currency);

create index index2 on accounts (currency,balance);

--Task 6:
alter table accounts add  constraint name_constraint check ( balance>=0 );

do $$
begin ;
create view vista as select id,src_account,dst_account,amount from transactions where status='init';
update accounts set balance=balance+(select amount from vista where account_id=dst_account)
    where account_id=(select dst_account from vista);
update accounts set balance=balance-(select amount from vista where account_id=src_account)
    where account_id=(select src_account from vista);
select * from accounts;
exception when others then
    update transactions set status = 'rollback' where transactions.id=(select id from vista);
    rollback;

update transactions set status = 'committed' where transactions.id=(select id from vista);
commit;
end;
$$