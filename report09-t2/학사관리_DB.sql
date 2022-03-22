-- ---------------------------------------------------------------------------------------
--  학사관리DB 데이터베이스 생성
-- ---------------------------------------------------------------------------------------
drop database if exists 학사관리DB;
create database if not exists 학사관리DB;

-- ---------------------------------------------------------------------------------------
--  학사관리DB 관리자 설정
-- ---------------------------------------------------------------------------------------
drop user if exists ad_col@localhost;
create user if not exists ad_col@localhost identified with mysql_native_password by 'qwer1234!';
grant all privileges on 학사관리DB.* to ad_col@localhost with grant option;
-- show databases;
use 학사관리DB;

-- ---------------------------------------------------------------------------------------
--  테이블 생성 (참조무결성때문에 학과가 맨위로 올라와야한다)
-- ---------------------------------------------------------------------------------------
create table 학과(
	학과번호 varchar(10),
	학과명 varchar(45) not null unique,
    학과전화번호 varchar(14) not null unique,
    primary key(학과번호)
);
-- desc 학과;

create table 학생(
	학생번호 varchar(10),
	학생이름 varchar(20) not null,
    학생주민번호 varchar(14) not null unique,
    학생주소 varchar(100) not null,
    학생전화번호 varchar(14) not null,
    학생이메일 varchar(45) not null unique,
    학과번호 varchar(10) not null,
	primary key(학생번호),
    foreign key(학과번호) references 학과(학과번호)
);
-- desc 학생;

create table 교수(
	교수번호 varchar(10),
	교수이름 varchar(20) not null,
    교수주민번호 varchar(14) not null unique,
    교수주소 varchar(100) not null,
    교수전화번호 varchar(14) not null,
    교수이메일 varchar(45) not null unique,
    학과번호 varchar(10) not null,
    primary key(교수번호),
	foreign key(학과번호) references 학과(학과번호)
);
-- desc 교수;

create table 강좌(
	강좌번호 varchar(10),
	교수번호 varchar(10),
    강좌명 varchar(45) not null,
    취득학점 int not null,
    강의시간 int not null,
    강의실정보 varchar(45) not null,
    primary key(강좌번호,교수번호),
    foreign key(교수번호) references 교수(교수번호)
);
-- desc 강좌;

create table 수강내역(
	학생번호 varchar(10),
	강좌번호 varchar(10),
	교수번호 varchar(10),
    출석점수 int not null,
    중간고사점수 int not null,
    기말고사점수 int not null,
    기타점수 int not null,
    총점 int not null,
    평점 varchar(2),
    primary key(학생번호,강좌번호,교수번호),
    foreign key(학생번호) references 학생(학생번호),
    foreign key(강좌번호,교수번호) references 강좌(강좌번호,교수번호)
);
-- desc 수강내역;

create table 담당(
	학생번호 varchar(10),
	교수번호 varchar(10),
    학년_학기 varchar(3),
    primary key(학생번호,교수번호),
	foreign key(학생번호) references 학생(학생번호),
    foreign key(교수번호) references 교수(교수번호)
);
-- desc 담당;

/*
 select * from information_schema.table_constraints where table_name='학생';
 set foreign_key_checks=1;
 select * from information_schema.table_constraints where table_name='학생';
 */
 

-- ---------------------------------------------------------------------------------------
--  테이블 자료 삽입 (참조무결성때문에 학과 자료가 먼저 입력되어야 한다)
-- ---------------------------------------------------------------------------------------
-- 학과 자료
insert into 학과 values('0001','컴퓨터학과','032-0001-0001');
insert into 학과 values('0002','물리학과','032-0002-0002');
insert into 학과 values('0003','통계학과','032-0003-0003');
insert into 학과 values('0004','화학과','032-0004-0004');
insert into 학과 values('0005','수학과','032-0005-0005');
insert into 학과 values('0006','사자학과','032-0006-0006');
insert into 학과 values('0007','만화과','032-0007-0007');
insert into 학과 values('0008','국어과','032-0008-0008');
insert into 학과 values('0009','사학과','032-0009-0009');
insert into 학과 values('0010','철학과','032-0010-0010');

-- 학생 자료
insert into 학생 values('0001','홍길동','000000-0000001','인천광역시 서구','010-0001-0001','qwe01@naver.com','0001');
insert into 학생 values('0002','이몽룡','000000-0000002','인천광역시 중구','010-0002-0002','qwe02@naver.com','0001');
insert into 학생 values('0003','성춘향','000000-0000003','인천광역시 남구','010-0003-0003','qwe03@naver.com','0002');
insert into 학생 values('0004','월매','000000-0000004','인천광역시 동구','010-0004-0004','qwe04@naver.com','0003');
insert into 학생 values('0005','변사또','000000-0000005','인천광역시 서구','010-0005-0005','qwe05@naver.com','0005');
insert into 학생 values('0006','강감찬','000000-0000006','인천광역시 북구','010-0006-0006','qwe06@naver.com','0002');
insert into 학생 values('0007','을지문덕','000000-0000007','인천광역시 북구','010-0007-0007','qwe07@naver.com','0003');
insert into 학생 values('0008','세종대왕','000000-0000008','인천광역시 중구','010-0008-0008','qwe08@naver.com','0004');
insert into 학생 values('0009','광개토','000000-0000009','인천광역시 서구','010-0009-0009','qwe09@naver.com','0004');
insert into 학생 values('0010','의자','000000-0000010','충청남도 사비','010-0010-0010','qwe10@naver.com','0006');

-- 교수 자료
insert into 교수 values('0001','김교수','100000-0000001','인천광역시 서구','011-0001-0001','asd01@naver.com','0010');
insert into 교수 values('0002','이교수','100000-0000002','인천광역시 중구','011-0002-0002','asd02@naver.com','0001');
insert into 교수 values('0003','박교수','100000-0000003','인천광역시 서구','011-0003-0003','asd03@naver.com','0002');
insert into 교수 values('0004','정교수','100000-0000004','인천광역시 남구','011-0004-0004','asd04@naver.com','0005');
insert into 교수 values('0005','최교수','100000-0000005','인천광역시 미추홀구','011-0005-0005','asd05@naver.com','0007');

-- 담당 자료
insert into 담당 values('0001','0001','1/1');
insert into 담당 values('0002','0001','1/1');
insert into 담당 values('0003','0002','1/1');
insert into 담당 values('0004','0002','1/1');
insert into 담당 values('0005','0002','1/1');
insert into 담당 values('0006','0003','1/1');
insert into 담당 values('0007','0004','1/1');
insert into 담당 values('0008','0005','1/1');
insert into 담당 values('0009','0004','1/1');
insert into 담당 values('0010','0004','1/1');

-- 강좌 자료
insert into 강좌 values('0001','0001','정보화 사회',4,32,'인문관 401호');
insert into 강좌 values('0001','0002','정보화 사회',4,32,'인문관 402호');
insert into 강좌 values('0003','0003','사회윤리학',2,24,'철학관 202호');
insert into 강좌 values('0001','0005','정보화 사회',4,32,'철학관 302호');
insert into 강좌 values('0005','0003','포스트 코로나',3,28,'인문관 203호');

-- 수강내역 자료
insert into 수강내역 values('0001','0001','0005',10,30,30,30,0,'F');
insert into 수강내역 values('0001','0003','0003',10,30,30,30,0,'F');
insert into 수강내역 values('0002','0001','0001',10,30,30,30,0,'F');
insert into 수강내역 values('0002','0003','0003',10,30,30,30,0,'F');
insert into 수강내역 values('0002','0005','0003',10,30,30,30,0,'F');
insert into 수강내역 values('0008','0003','0003',10,30,30,30,0,'F');
insert into 수강내역 values('0009','0001','0002',10,30,30,30,0,'F');
insert into 수강내역 values('0002','0001','0002',10,30,30,30,0,'F');
insert into 수강내역 values('0010','0003','0003',10,30,30,30,0,'F');
insert into 수강내역 values('0010','0005','0003',10,30,30,30,0,'F');


-- 자료 조회
select * from 학생;
select * from 교수;
select * from 학과;
select * from 담당;
select * from 강좌;
select * from 수강내역;


-- 수강하지 않은 학생 명단 출력
select 학생번호 as 학번, 학생이름 as 성명
from 학생
where 학생번호 not in (select 학생번호 from 수강내역);

/*
-- JOIN으로 하는 방법
select distinct 학생.학생번호 as 학번, 학생.학생이름 as 성명
from 학생 join 수강내역 on 학생.학생번호 not in (select 학생번호 from 수강내역);
*/


-- 교수별 담당학생 명단 출력
select 교수.교수번호 as 교번, 교수.교수이름 as 교수자명, 학생.학생번호 as 학번, 학생.학생이름 as 학생명
from 교수 join 담당 on 교수.교수번호 = 담당.교수번호 join 학생 on 학생.학생번호 = 담당.학생번호;


-- 컴퓨터학과 자료의 학과번호 학과명 변경
SET foreign_key_checks = 0;    # 외래키 체크 설정 해제
update 학생 set 학생.학과번호='0111' where 학생.학과번호 in(select 학과.학과번호 from 학과 where 학과명='컴퓨터학과');
update 교수 set 교수.학과번호='0111' where 교수.학과번호 in(select 학과.학과번호 from 학과 where 학과명='컴퓨터학과');
update 학과 set 학과명='컴퓨터공학과', 학과.학과번호='0111' where 학과명='컴퓨터학과';
SET foreign_key_checks = 1;    # 외래키 체크 설정

select * from 학생;
select * from 교수;
select * from 학과;


-- 강좌 진행하지 않는 교수 관련 자료 삭제
delete from 담당 
where 교수번호 in(
	select 교수번호
	from 교수
	where 교수번호 not in (select 교수번호 from 강좌)
);

delete from 교수
where 교수번호 not in(select 교수번호 from 강좌);

select * from 담당;
select * from 교수;


