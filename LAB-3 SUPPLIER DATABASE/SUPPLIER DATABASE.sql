create database SUPPLIER;
use SUPPLIER;
create table SUPPLIERS(sid BIGINT(5) primary key, sname
varchar(20), city varchar(20));
insert into SUPPLIERS values(10001,'Acme Widget','Bangalore');
insert into SUPPLIERS values(10002,'Johns ','Kolkata');
insert into SUPPLIERS values(10003,'Vimal','Mumbai');
insert into SUPPLIERS values(10004,'Reliance ','Delhi');
select * from SUPPLIERS;
create table PARTS(pid BIGINT(5) primary key, pname varchar(20),
color varchar(10));
insert into PARTS values(20001,'Book','RED');
insert into PARTS values(20002,'Pen','RED');
insert into PARTS values(20003,'Pencil','Green');
insert into PARTS values(20004,'Mobile ','Green');
insert into PARTS values(20005,'Charger','Black');
select * from PARTS;
create table CATALOG(sid BIGINT(5), pid BIGINT(5), foreign key(sid)
references SUPPLIERS(sid), foreign key(pid) references PARTS(pid),
cost float(6), primary key(sid, pid));
insert into CATALOG values(10001,20001,10);
insert into CATALOG values(10001,20002,10);
insert into CATALOG values(10001,20003,30);
insert into CATALOG values(10001,20004,10);
insert into CATALOG values(10001,20005,10);
insert into CATALOG values(10002,20001,10);
insert into CATALOG values(10002,20002,20);
insert into CATALOG values(10003,20003,30);
insert into CATALOG values(10004,20003,40);
select * from CATALOG;
/* 1 */
SELECT DISTINCT P.pname
 FROM Parts P, Catalog C
 WHERE P.pid = C.pid;
 
-- Query 2
select S.sname from SUPPLIERS S where not exists (select P.pid from
PARTS P where not exists (select C.sid from CATALOG C where C.sid =
S.sid and C.pid = P.pid));
-- Query 3
select S.sname from SUPPLIERS S where not exists (select P.pid from
PARTS P where P.color = 'Red' and (not exists (select C.sid from
CATALOG C where C.sid = S.sid and C.pid = P.pid)));
-- Query 4
select P.pname from PARTS P, CATALOG C, SUPPLIERS S where P.pid
= C.pid and C.sid = S.sid and S.sname = 'Acme Widget' and not exists
(select * from CATALOG C1, SUPPLIERS S1 where P.pid = C1.pid and
C1.sid = S1.sid and S1.sname <> 'Acme Widget');
-- Query 5
SELECT DISTINCT C.sid FROM Catalog C
WHERE C.cost > ( SELECT AVG (C1.cost)
FROM Catalog C1
WHERE C1.pid = C.pid );
-- Query 6
SELECT P.pid, S.sname
FROM Parts P, Suppliers S, Catalog C
WHERE C.pid = P.pid
AND C.sid = S.sid
AND C.cost = (SELECT MAX(C1.cost)
FROM Catalog C1
WHERE C1.pid = P.pid);
