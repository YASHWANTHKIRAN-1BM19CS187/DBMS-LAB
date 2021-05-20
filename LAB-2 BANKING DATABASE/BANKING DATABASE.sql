create database banking;
use banking;
create table BRANCH(branch_name varchar(20),branch_city varchar(10),assets real,primary
key(branch_name));
insert into BRANCH values('SBI_Chamrajpet','Bangalore',50000);
insert into BRANCH values('SBI_Residency road','Bangalore',10000);
insert into BRANCH values('SBI_shivajiroad','Bombay',20000);
insert into BRANCH values('SBI_parlimentroad','Delhi',10000);
insert into BRANCH values('SBI_jantarmantar','Delhi',20000);
commit;
select * from BRANCH;
create table ACCOUNTS(accno integer,branch_name varchar(20),balance real,primary
key(accno),foreign key(branch_name) references BRANCH(branch_name));
insert into ACCOUNTS values('1','SBI_Chamrajpet','2000');
insert into ACCOUNTS values('2','SBI_Residency road','5000');
insert into ACCOUNTS values('3','SBI_shivajiroad','6000');
insert into ACCOUNTS values('4','SBI_parlimentroad','9000');
insert into ACCOUNTS values('5','SBI_jantarmantar','8000');
insert into ACCOUNTS values('6','SBI_shivajiroad','4000');
insert into ACCOUNTS values('8','SBI_Residency road','4000');
insert into ACCOUNTS values('9','SBI_parlimentroad','3000');
insert into ACCOUNTS values('10','SBI_Residency road','5000');
insert into ACCOUNTS values('11','SBI_jantarmantar','2000');
commit;
select * from ACCOUNTS;
create table BANKCUST(customername varchar(20),customerstreet varchar(30),customercity
varchar(30),primary key(customername));
insert into BANKCUST values('AVINASH','Bulltemple','Bangalore');
insert into BANKCUST values('dinesh','banerghata','Bangalore');
insert into BANKCUST values('mohan','mgroad','Bangalore');
insert into BANKCUST values('nikhil','churchstreeet','Delhi');
insert into BANKCUST values('ravi','akbarroad','Delhi');
commit;
select * from BANKCUST;
create table DEPOSIT(customername varchar(20),accno integer,primary
key(accno,customername),foreign key(accno) references ACCOUNTS(accno),foreign
key(customername) references BANKCUST(customername));
insert into DEPOSIT values('AVINASH',1);
insert into DEPOSIT values('dinesh',2);
insert into DEPOSIT values('nikhil',4);
insert into DEPOSIT values('ravi',5);
insert into DEPOSIT values('AVINASH',8);
insert into DEPOSIT values('nikhil',9);
insert into DEPOSIT values('dinesh',10);
insert into DEPOSIT values('nikhil',11);
commit;
select * from DEPOSIT;
CREATE TABLE LOAN(loanno int,branch_name varchar(20),amt real,primary key(loanno),foreign
key(branch_name) references BRANCH(branch_name));
insert into LOAN values(1,'SBI_Chamrajpet',1000);
insert into LOAN values(2,'SBI_Residency road',2000);
insert into LOAN values(3,'SBI_shivajiroad',3000);
insert into LOAN values(4,'SBI_parlimentroad',4000);
insert into LOAN values(5,'SBI_jantarmantar',5000);
commit;
select * from LOAN;
/*Find all the customers who have at least two accounts at the Main branch (ex.
SBI_ResidencyRoad).
iv. Find all the customers who have an account at all the branches located in a
specific city (Ex. Delhi).
v. Demonstrate how you delete all account tuples at every branch located in
a specific city (Ex. Bombay). */
/*3*/
select customername from DEPOSIT d,ACCOUNTS a
where d.accno=a.accno
group by customername
having count(d.customername) >=2;
/*5*/
delete from ACCOUNTS
where branch_name IN(SELECT branch_name FROM branch WHERE branch_city='Bombay');
Select * from ACCOUNTS;
/*4*/
select d.customername from DEPOSIT d,BRANCH b,ACCOUNTS a
where b.branch_name=a.branch_name
AND a.accno=d.accno
and branch_city='Delhi'
group by d.customername
HAVING COUNT(distinct b.branch_name)=(
 SELECT COUNT(branch_name)
 FROM branch
 WHERE branch_city='Delhi');



