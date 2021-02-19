
CREATE TABLE HERRYBORO_FRIENDS(
    SEQ NUMBER(5),
    NAME VARCHAR(30),
    POSITION VARCHAR(100),
    FINAL_YN VARCHAR(1)
);

SELECT * FROM HERRYBORO_FRIENDS; 
INSERT INTO HERRYBORO_FRIENDS VALUES(1, '론위즐리', '그리핀도르','M');

-- ------------------------------------------------------------------------------------ --

CREATE TABLE IDOL_GROUP (	
    "COMPANY" VARCHAR2(300 BYTE) NOT NULL ENABLE, 
	"GROUP_NAME" VARCHAR2(300 BYTE) NOT NULL ENABLE, 
	"DEBUT_YEAR" VARCHAR2(4 BYTE), 
	"DEBUT_ALBUM" VARCHAR2(300 BYTE), 
	"GENDER" VARCHAR2(10 BYTE)
);

CREATE TABLE IDOL_MEMBER(	
    "GROUP_NAME" VARCHAR2(300 BYTE) NOT NULL ENABLE, 
	"MEMBER_NAME" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"REAL_NAME" VARCHAR2(100 BYTE), 
	"BIRTHDAY" VARCHAR2(8 BYTE), 
	"SNS_INFO" VARCHAR2(100 BYTE)
);

SELECT * FROM IDOL_GROUP;
SELECT * FROM IDOL_GROUP WHERE DEBUT_YEAR < '2015' AND GENDER='boy' ORDER BY DEBUT_YEAR DESC;

-- dd --
select company from idol_group;

-- 중복 제거 --
select distinct company from idol_group;

-- group by (특정 컬럼을 기준으로 집계) --
select company, count(*) from idol_group group by company;
select distinct company, count(*) from idol_group group by company having count(*) = 2;

select * from idol_group where group_name = '아스트로';

-- insert (전체 입력)--
insert into idol_group values('jyp 엔터테이먼트', 'ITZY', '2019', 'ITz Differnt', 'girl');
-- 특정 컬럼만 입력 --
insert into idol_group(company, group_name) values('테스트 소속사', '예비 아이돌 그룹'); 

SELECT * FROM IDOL_MEMBER;
-- order by ( 너무 많은 order by는 sort부하로 인해 성능이 저하될 수 있다. 꼭 필요할때만 사용 지향 )--

-- asc(오름차순) --
SELECT * FROM IDOL_MEMBER order by birthday asc;

-- desc( 내림차순 )
SELECT * FROM IDOL_MEMBER order by real_name desc;
SELECT * FROM IDOL_MEMBER order by real_name desc nulls last;
SELECT * FROM IDOL_MEMBER order by real_name nulls first;
-- 두 컬럼 order by --
SELECT * FROM IDOL_MEMBER order by real_name desc, birthday desc;

SELECT * FROM idol_group;
SELECT * FROM IDOL_MEMBER;
-- join --

-- inner join --
--  join on을 써서 join --
select * from idol_group g
join idol_member m
on g.group_name = m.group_name;
-- where 절만 써서 join --
select * from idol_group g, idol_member m where g.group_name = m.group_name;
-- 보고 싶은 컬럼만 --
select g.company, g.group_name, m.member_name, m.real_name from idol_group g, idol_member m where g.group_name = m.group_name;
-- group by --
select g.company, g.group_name, count(m.member_name) count
    from idol_group g, idol_member m where g.group_name = m.group_name group by g.company, g.group_name;
    
-- outer join --
select * from idol_group g, idol_member m where g.group_name = m.group_name; -- 일반적인 inner join --
select * from idol_group g, idol_member m where g.group_name = m.group_name(+); -- outer join --
select * from idol_group g left outer join idol_member m on g.group_name = m.group_name; -- left outer join (위 outer join과 같다.) 단 (요 방법을 더 추천)--
select * from idol_group g right outer join idol_member m on g.group_name = m.group_name; -- right outer join

SELECT * FROM idol_group;
SELECT * FROM IDOL_MEMBER;
-- update --
update idol_member set real_name = '조미연' where member_name = '미연';
update idol_member set member_name = '슈화', real_name = '예슈화', sns_info = 'V Live, 인스타그램' where member_name = '수화'; 
commit;

-- delete --
create table idol_group_copy as select * from idol_group; -- idol_group 테이블을 복사해서 idol_group_copy 테이블을 생성하는 쿼리
create table idol_group_copy2 as select * from idol_group where 1 = 2; -- idol_group 테이블의 구조만 복사해서 idol_group_copy2 테이블을 생성( 구조만 같은 빈테이블 생성 ), 내용은 복사X --
delete from idol_group_copy;
select * from idol_group_copy;
rollback;
delete from idol_group_copy where group_name = 'Wanna One';
delete from idol_group_copy where company = 'SM 엔터테인먼트' and gender = 'boy';

-- null 관련 함수 --
select 
    member_name, 
    real_name,
    nvl (real_name, member_name) name1, -- real_name 컬럼이 null이 아니면 real_name 값을 name1에 입력, null이면 member_name을 name1 컬럼에 입력 --
    nullif(member_name, '수진') name2, --  member_name과 '수진' 이 같으면 name2 컬럼에 null을 입력, 아니면 member_name을 입력 --
    coalesce(null, real_name, member_name) name3 -- coalesce함수의 매개변수에 지정된 컬럼 중 null이 아닌 첫번째 값을 name3 컬럼에 입력 --
from idol_member where group_name = '(여자)아이들';

-- ntile 함수 --
select * from exam_score;
select 
    이름,
    ntile(8) over(order by 국어 desc) 국어등급,
    국어
    from exam_score;
    


COMMENT ON COLUMN IDOL_GROUP.GROUP_NAME IS '그룹명';
COMMENT ON COLUMN IDOL_GROUP.DEBUT_YEAR IS '데뷔년도';
COMMENT ON COLUMN IDOL_GROUP.DEBUT_ALBUM IS '데뷔앨범';
COMMENT ON COLUMN IDOL_GROUP.GENDER IS '성별';

INSERT INTO IDOL_GROUP VALUES ('빅히트 엔터테인먼트', 'BTS', '2013', '2 COOL 4 SCHOOL', 'boy');
INSERT INTO IDOL_GROUP VALUES ('JYP 엔터테인먼트', '트와이스', '2015', 'THE STORY BEGINS', 'girl');
INSERT INTO IDOL_GROUP VALUES ('YG 엔터테인먼트', '블랙핑크', '2016', 'SQUARE ONE', 'girl');
INSERT INTO IDOL_GROUP VALUES ('판타지오', '아스트로', '2016', 'SPRING UP', 'boy');
INSERT INTO IDOL_GROUP VALUES ('울림 엔터테인먼트', '러블리즈', '2014', 'Girls Invasion', 'girl');
INSERT INTO IDOL_GROUP VALUES ('스타쉽 엔터테인먼트', '우주소녀', '2016', 'Would You Like', 'girl');
INSERT INTO IDOL_GROUP VALUES ('스윙 엔터테인먼트', 'Wanna One', '2017', '1X1=1', 'boy');
INSERT INTO IDOL_GROUP VALUES ('큐브 엔터테인먼트', '(여자)아이들', '2018', 'I am', 'girl');
INSERT INTO IDOL_GROUP VALUES ('SM 엔터테인먼트', '레드벨벳', '2014', '행복', 'girl');
INSERT INTO IDOL_GROUP VALUES ('SM 엔터테인먼트', 'EXO', '2012', '마마', 'boy');
INSERT INTO IDOL_GROUP VALUES ('JYP 엔터테인먼트', '갓세븐', '2014', 'Got it?', 'boy');
INSERT INTO IDOL_GROUP VALUES ('오프더레코드 엔터테인먼트', '아이즈원', '2018', '컬러라이즈', 'girl');
INSERT INTO IDOL_GROUP VALUES ('플랜에이 엔터테인먼트', '에이핑크', '2011', 'Seven Springs of Apink', 'girl');
INSERT INTO IDOL_GROUP VALUES ('큐브 엔터테인먼트', '비투비', '2012', '비밀', 'boy');
INSERT INTO IDOL_GROUP VALUES ('쏘스뮤직', '여자친구', '2015', 'Season of Glass', 'girl');
INSERT INTO IDOL_GROUP VALUES ('YG 엔터테인먼트', '위너', '2014', '2014 S/S', 'boy');
INSERT INTO IDOL_GROUP VALUES ('스타쉽 엔터테인먼트', '몬스타엑스', '2015', 'TRESPASS', 'boy');
INSERT INTO IDOL_GROUP VALUES ('WM 엔터테인먼트', '오마이걸', '2015', 'OH MY GIRL', 'girl');
INSERT INTO IDOL_GROUP VALUES ('DSP미디어', '에이프릴', '2015', 'Dreaming', 'girl');
INSERT INTO IDOL_GROUP VALUES ('젤리피쉬 엔터테인먼트', '구구단', '2016', 'The Little Mermaid', 'girl');

INSERT INTO IDOL_MEMBER VALUES ('BTS','RM','김남준','19940912','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','슈가','민윤기','19930309','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','진','김석진','19921204','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','제이홉','장호석','19940218','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','지민','박지민','19951013','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','정국','전정국','19970901','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('트와이스','나연','임나연','19950922','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('트와이스','정연','유정연','19961101','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('트와이스','모모','히라이 모모','19961109','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('트와이스','사나','미나토자키 사나','19961229','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('트와이스','지효','박지효','19970201','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('트와이스','미나','묘이 미나','19970324','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('트와이스','다현','김다현','19980528','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('트와이스','채영','손채영','19990423','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('트와이스','쯔위','저우 쯔위','19990614','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('아스트로','차은우','이동민','19970330','인스타그램');
INSERT INTO IDOL_MEMBER VALUES ('아스트로','문빈','문빈','19980126','인스타그램');
INSERT INTO IDOL_MEMBER VALUES ('아스트로','MJ','김명준','19940305','인스타그램');
INSERT INTO IDOL_MEMBER VALUES ('아스트로','진진','박진우','19960315','인스타그램');
INSERT INTO IDOL_MEMBER VALUES ('아스트로','라키','박민혁','19990225','인스타그램');
INSERT INTO IDOL_MEMBER VALUES ('아스트로','윤산하','윤산하','20000321','인스타그램');
INSERT INTO IDOL_MEMBER VALUES ('(여자)아이들','미연','','19970131','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(여자)아이들','민니','','19971023','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(여자)아이들','수진','','19980309','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(여자)아이들','소연','','19980826','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(여자)아이들','우기','','19990923','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(여자)아이들','수화','','20000106','V LIVE');

-- selct 강의 예제 --
CREATE TABLE BILLBOARD_CHARTS (
	RANKING	NUMBER(3) NOT NULL,
	TITLE VARCHAR(500) NOT NULL,
	SINGER VARCHAR(100),
	UPDOWN NUMBER(3),
	COUNTRY VARCHAR(50)
);

select * from BILLBOARD_CHARTS;

-- 대문자 M으로 시작하는 모든 title select --
select * from billboard_charts where title like 'M%';

-- 중간에 M이 있는 모든 title select --
select * from billboard_charts where title like '%M%';

-- group by로 billboard_chart 테이블 country, singer컬럼의 count(*) 갯수 출력 --
select country from billboard_charts;
select country, singer, count(*) from billboard_charts group by country, singer having country = 'Korea';

-- ranking컬럼을 기준으로 desc(내림차순) --
select * from BILLBOARD_CHARTS order by ranking desc;

select * from exam_score;
-- ntile 함수 --
select 
    이름, 
    ntile(8) over(order by 국어 desc) 국어등급,
    ntile(8) over(order by 영어 desc) 영어등급,
    ntile(8) over(order by 수학 desc) 수학등급,
    국어,
    영어,
    수학
from exam_score;

       









INSERT INTO BILLBOARD_CHARTS VALUES (1,'MAP OF THE SOUL : 7', 'BTS', 0, 'Korea'); 
INSERT INTO BILLBOARD_CHARTS VALUES (2,'Still Flexin, Still Steppin','YoungBoy Never Broke Again',0, 'America'); 
INSERT INTO BILLBOARD_CHARTS VALUES (3,'Ordinary Man', 'Ozzy Osbourne', 0, 'England');
INSERT INTO BILLBOARD_CHARTS VALUES (4,'Changes', 'Justin Bieber', -3 ,'Canada');
INSERT INTO BILLBOARD_CHARTS VALUES (5,'Please Excuse Me For Being Antisocial','Roddy Ricch', -1, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (6,'Artist 2.0', 'A Boogie Wit da Hoodie', -4, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (7,'Hollywoods Bleeding', 'Post Malone', -1, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (8,'Meet The Woo, V.2', 'Pop Smoke', 0, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (9,'A Love Letter To You 4', 'Trippie Redd', 27 ,'America');
INSERT INTO BILLBOARD_CHARTS VALUES (10,'When We All Fall Asleep, Where Do We Go?', 'Billie Eilish', -3, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (11,'Music To Be Murdered By', 'Eminem', -2, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (12,'Frozen II', 'Soundtrack', -1, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (13,'Fine Line', 'Harry Styles', 0, 'England');
INSERT INTO BILLBOARD_CHARTS VALUES (14,'KIRK', 'Dababy', -2, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (15,'Manic', 'Halsey', -5, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (16,'Lover', 'Taylor Swift', -2, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (17,'The Slow Rush', 'Tame Impala', -14, 'Australia');
INSERT INTO BILLBOARD_CHARTS VALUES (18,'What You See Is What You Get', 'Luke Combs', -2, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (19,'JACKBOYS', 'JACKBOYS', -2, 'America');
INSERT INTO BILLBOARD_CHARTS VALUES (20,'Over It', 'Summer Walker', -2, 'America');

CREATE TABLE EXAM_SCORE (
	이름		VARCHAR(20),
	국어		NUMBER,
	영어		NUMBER,
	수학		NUMBER
);

INSERT INTO EXAM_SCORE VALUES ('김수현', 116, 77, 75);
INSERT INTO EXAM_SCORE VALUES ('박보검', 101, 69, 80);
INSERT INTO EXAM_SCORE VALUES ('아이유', 118, 62, 60);
INSERT INTO EXAM_SCORE VALUES ('김하늘', 96, 72, 70);
INSERT INTO EXAM_SCORE VALUES ('이효리', 103, 77, 55);
INSERT INTO EXAM_SCORE VALUES ('유재석', 78, 66, 61);
INSERT INTO EXAM_SCORE VALUES ('신동엽', 85, 72, 75);
INSERT INTO EXAM_SCORE VALUES ('서장훈', 99, 70, 53);
INSERT INTO EXAM_SCORE VALUES ('한혜진', 105, 75, 69);
INSERT INTO EXAM_SCORE VALUES ('김동률', 117, 68, 73);
commit;


-- 테이블이 있으면 제거한다.
DROP TABLE board;
-- 시퀀스 제거
DROP SEQUENCE board_seq;

-- 테이블 작성
CREATE TABLE board(
 no NUMBER PRIMARY KEY,   -- 번호
 title VARCHAR2(300) NOT NULL,   -- 제목
 content VARCHAR2(2000) NOT NULL,   -- 내용
 writer VARCHAR2(30) NOT NULL,   -- 작성자
 writeDate DATE DEFAULT sysdate,   -- 작성일
 hit NUMBER DEFAULT 0,   -- 조회수
 pw VARCHAR2(50)  NOT NULL  -- 비밀번호
);

-- 시퀀스 작성
CREATE SEQUENCE board_seq;
commit;

select * from board;

select * from (
			select rownum rnum, no, title, writer, writeDate, hit
			from (
				select no, title, writer, writeDate, hit
				from board
                where ( 2 = 1 or title like '2')
				order by no desc
			)
            order by rnum asc
		)
		where rnum between 1 and 10;
        
select no, title, content, writer,
		writeDate, hit
		from board;
		where no = '3';

insert into board values(1, '야 잇츠유 ㅡㅡ', '테스트', '이승현', sysdate, 0, 111);
insert into board values(3, '야 잇츠유 ㅡㅡ', '테스트', '이승현', sysdate, 0, 111);
insert into board values(4, '야 팽수 ㅡㅡ', '테스트', '조세진', sysdate, 0, 111); 
insert into board values(5, '야 이광훈 ㅡㅡ', '테스트', '조세진', sysdate, 0, 111);
insert into board values(6, '야 홍유찬 ㅡㅡ', '테스트', '조세진', sysdate, 0, 111);
insert into board values(7, '야 조제형 ㅡㅡ', '테스트', '잇츠유', sysdate, 0, 111);
insert into board values(8, '야 박환주 ㅡㅡ', '테스트', '마정한', sysdate, 0, 111);
insert into board values(9, '야 최승연 ㅡㅡ', '테스트', '백경찬', sysdate, 0, 111);
insert into board values(10, '야 박수정 ㅡㅡ ', '테스트', '백경찬', sysdate, 0, 111);
insert into board values(11, '야 노지원', '테스트', '마정한', sysdate, 0, 111);
insert into board values(12, '야', '테스트', 'herryboro', sysdate, 0, 111);
insert into board values(13, '야', '테스트', 'herryboro', sysdate, 0, 111);


commit;





-------------------------------------------------------------------------------------
-- sql 200제

alter session set nls_date_format='RR/MM/DD';

drop table emp;
drop table dept;

CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-11',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);

commit;

drop  table  salgrade;

create table salgrade
( grade   number(10),
  losal   number(10),
  hisal   number(10) );

insert into salgrade  values(1,700,1200);
insert into salgrade  values(2,1201,1400);
insert into salgrade  values(3,1401,2000);
insert into salgrade  values(4,2001,3000);
insert into salgrade  values(5,3001,9999);

commit;

select * from emp;

select empno, ename, sal
    from emp;

