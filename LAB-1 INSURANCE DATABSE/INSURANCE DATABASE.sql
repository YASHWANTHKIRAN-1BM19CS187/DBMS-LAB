PERSON
create database Insurance;
use Insurance;
create table Insurance.person(driver_id varchar(10),name varchar(10),address varchar(10),primary
key(driver_id));
desc Insurance.person;
insert into Insurance.person values('&driver_id','&name','&address');
insert into Insurance.person values('A01','MSD','Banglore');
insert into Insurance.person values('A02','VK','CHENNAI');
insert into Insurance.person values('A03','RS','KERALA');
insert into Insurance.person values('A04','SR','UP');
insert into Insurance.person values('A05','KP','ENG');
commit;
select * from Insurance.person;
CAR :
create table Insurance.car(regno varchar(10),model varchar(10),year int,primary key(regno));
desc Insurance.car;
insert into Insurance.car values('&reg_num','&model','1');
insert into Insurance.car values('KA031181','Lancer', 1957);
insert into Insurance.car values('KA095477','TOYOTA', 1998);
insert into Insurance.car values('KA052250','INDICA', 1990);
insert into Insurance.car values('KA053408','HONDA', 2008);
insert into Insurance.car values('KA041702','AUDI', 2005);
commit;
select * from Insurance.car;
ACCIDENT
create table Insurance.accident(report_number int,accident_date date,location varchar(15),primary
key(report_number));
desc Insurance.accident;
insert into Insurance.accident values('11', STR_TO_DATE('01-01-2003', '%m-%d-%Y'),'MysoreRoad');
insert into Insurance.accident values('12', STR_TO_DATE('02-02-2004', '%m-%d-%Y'),'Southend');
insert into Insurance.accident values('13', STR_TO_DATE('06-01-2003', '%m-%d-%Y'),'Bulltemple');
insert into Insurance.accident values('14', STR_TO_DATE('05-02-2008', '%m-%d-%Y'),'Mysore');
insert into Insurance.accident values('15', STR_TO_DATE('04-03-2005', '%m-%d-%Y'),'Kanakpura');
commit;
select * from Insurance.accident;
OWNS
create table Insurance.owns(driver_id varchar(10),regno varchar(10),primary
key(driver_id,regno),foreign key(driver_id) references person(driver_id),foreign key(regno)
references car(regno));
desc Insurance.owns;
insert into Insurance.owns values ('&driver_id','&reg_num');
insert into Insurance.owns values ('A01','KA052250');
insert into Insurance.owns values ('A02','KA053408');
insert into Insurance.owns values ('A04','KA031181');
insert into Insurance.owns values ('A03','KA095477');
insert into Insurance.owns values ('A05','KA041702');
commit;
select * from Insurance.owns;
PARTICIPANTS
create table Insurance.participated(driver_id varchar(10),regno varchar(10),report_number
int,damage_amount int,primary key(driver_id,regno,report_number),foreign key(driver_id)
references person(driver_id),foreign key(regno) references car(regno),foreign key(report_number)
references accident(report_number));
desc Insurance.participated;
insert into Insurance.participated values('A01','KA052250',11,10000);
insert into Insurance.participated values('A02','KA053408',12,50000);
insert into Insurance.participated values('A03' , 'KA095477' , '13' , '25000');
insert into Insurance.participated values('A04', 'KA031181', '14' , '3000');
insert into Insurance.participated values('A05', 'KA041702', '15','5000');
select * from Insurance.participated;
/* 3a */
update Insurance.participated
set damage_amount=25000
where report_number=12 and regno='A02';
/* 3b */
insert into Insurance.accident values('16', '2007-03-21','MysoreRoad');
insert into Insurance.participated values('A05', 'KA041702','16','5000');
/*4*/
select count(distinct o.driver_id) as People from Insurance.owns o,Insurance.participated
p,Insurance.accident a where a.accd_date like
'2008%' and o.regno=p.regno and p.report_number=a.report_number;
/*5*/
use Insurance;
select count(*) as Totalcars from car c,participated p where c.regno=p.regno and c.model='TOYOTA';


