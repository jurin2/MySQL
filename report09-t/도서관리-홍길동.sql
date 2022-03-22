drop database if exists 도서관리_DB;
drop user if exists admin_book@localhost;
create database if not exists 도서관리_DB;
create user admin_book@localhost identified with mysql_native_password by 'qwer1234!';
grant all privileges on 도서관리_DB.* to admin_book@localhost with grant option;
show databases;

use 도서관리_DB;
show tables;

create table 회원정보(
	회원번호 varchar(5) not null,
    회원이름 varchar(20) not null,
    회원주소 varchar(50) not null,
    전화번호 varchar(20) not null unique,
    primary key(회원번호)
);
desc 회원정보;

create table 주문회원(
	주문번호 varchar(11) not null,
    주문날짜 date,
    회원번호 varchar(5) not null,
    primary key(주문번호),
    foreign key(회원번호) references 회원정보(회원번호)
);
desc 주문회원;

create table 도서정보(
	도서시리얼넘버 varchar(8) not null,
    도서명 varchar(50) not null unique,
    primary key(도서시리얼넘버)
);
desc 도서정보;

create table 판매내역(
	주문번호 varchar(11) not null,
    회원번호 varchar(5) not null,
    도서시리얼넘버 varchar(8) not null,
	수량 int,
    단가 int,
    primary key(주문번호),
	foreign key(주문번호) references 주문회원(주문번호),
    foreign key(회원번호) references 회원정보(회원번호),
    foreign key(도서시리얼넘버) references 도서정보(도서시리얼넘버)
);
desc 판매내역;

-- 삽입
insert into 회원정보 values('10001','홍길동','경기도','010-111-1111');
insert into 회원정보 values('10002','이몽룡','인천','010-222-2222');
insert into 회원정보 values('10003','성춘향','서울','010-333-3333');
insert into 회원정보 values('10004','월매','서울','010-444-4444');
insert into 회원정보 values('10005','변사또','부산','010-555-5555');
select * from 회원정보;

insert into 도서정보 values('12345678','HTML1');
insert into 도서정보 values('23456789','HTML2');
insert into 도서정보 values('34567890','HTML3');
insert into 도서정보 values('45678901','HTML4');
insert into 도서정보 values('56789012','HTML5');
insert into 도서정보 values('67890123','HTML6');
insert into 도서정보 values('78901234','HTML7');
insert into 도서정보 values('89012345','HTML8');
insert into 도서정보 values('90123456','HTML9');
insert into 도서정보 values('01234567','HTML10');
select * from 도서정보;

insert into 주문회원 values('20220301001','2022-03-01','10003');
insert into 주문회원 values('20220301002','2022-03-01','10005');
insert into 주문회원 values('20220301003','2022-03-01','10001');
insert into 주문회원 values('20220301004','2022-03-01','10002');
insert into 주문회원 values('20220301005','2022-03-01','10003');
insert into 주문회원 values('20220302001','2022-03-02','10002');
insert into 주문회원 values('20220302002','2022-03-02','10004');
insert into 주문회원 values('20220302003','2022-03-02','10001');
select * from 주문회원;

insert into 판매내역 values('20220301002','10002','12345678',5,25000);
insert into 판매내역 values('20220301001','10004','23456789',2,20000);
insert into 판매내역 values('20220301003','10005','34567890',1,23000);
insert into 판매내역 values('20220302001','10005','45678901',1,26000);
insert into 판매내역 values('20220302002','10002','56789012',2,22000);
select * from 판매내역;

-- 자료조회
select * from 회원정보 join 판매내역 on 회원정보.회원번호 = 판매내역.회원번호;


-- 변경
select * from 판매내역;
update 판매내역 set 단가=30000 where 도서시리얼넘버='12345678';
select * from 판매내역;

-- 삭제
select * from 판매내역;
delete from 판매내역 where 수량 = 0 or 단가 = 0 or 수량 is null or 단가 is null;
select * from 판매내역;