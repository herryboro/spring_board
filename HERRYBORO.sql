
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

-- 1. 테이블에서 특정 열( column ) 선택하기
select empno, ename, sal
    from emp;
    
-- 2. 테이블에서 모든 열( column ) 출력하기
select * from emp;

    -- *표시를 사용하지 않았을때
    select empno, ename, job, mgr, hiredate, sal, comm, deptno
        from emp;
    -- 특정 컬럼을 한번 더 출력해야 하는 경우 
    select dept.*, deptno from dept;  -- *앞에 '테이블명.'을 붙여준다.
    select dept.* from dept;
    
-- 3. 컬럼 별칭을 사용하여 출력되는 컬럼명 변경하기
select empno as "사원 번호", ename as "사원 이름", sal as "Salary"
    from emp;
    
    /* ""를 붙여야 할때 */
      -- 1.대소문자를 구별해야 할때
      -- 2.공백문자를 출력할때
          ex) select empno as 사원 번호, ename as "사원 이름", sal as "Salary"
                from emp;       -- 알리아스에 "" 가 없으면 공백시 에러발생     
                
              select empno as "사원 번호", ename as "사원 이름", sal as "Salary"
                from emp;       -- ""가 있어 정상 출력됨
      -- 3.특수문자를 출력할때
         ex) select empno as 사원?번호, ename as "사원 이름", sal as "Salary"
                from emp;       -- ""없이 ?를 출력 못함
                
             select empno as "사원?번호", ename as "사원 이름", sal as "Salary"
                from emp;       -- 알리아스 정상 출력됨
    
    /* note */
        select ename, sal * (12 + 3000)
            from emp;
            
        -- 수식을 사용할때도 as 사용 가능
        select ename, sal * (12 + 3000) as 월급
            from emp;
            
        -- order by절과 함께 사용할때 유용
        select ename, sal *(12 + 3000) as 월급
            from emp
            order by 월급 desc;
            
-- 4. 연결 연산자 사용하기
select ename || sal
    from emp;
    
    /* 예제 4-2 */
    select ename || '의 월급은 ' || sal || '입니다.' as 월급정보
        from emp;
        
    /* 예제 4-3 */
    select ename || '의 직업은 ' || job || '입니다.' as 직업정보
        from emp;
        
-- 5. 중복된 데이터를 제거해서 출력하기( distinct )
select distinct job
    from emp;
    
    /* unique를 대신 사용 */
    select unique job
        from emp;
        
-- 6. 데이터를 정렬해서 출력하기( order by )
select ename, sal
    from emp
    order by sal asc;
    
    /* ASC: 오름차순, DESC: 내림차순 */
    /* 예제 6-3 */
    select ename, deptno, sal
        from emp
        order by deptno asc, sal desc;  -- order by 절에는 컬럼을 여러게 작성할 수 있다.
    
    /* 예제 6-4 */
    select ename, deptno, sal
        from emp
        order by 2 asc, 3 desc; -- 여기서 2, 3은 select절 컬럼의 순서와 같다.( 2: deptno, 3: sal )

-- 7. where 절 배우기 ① ( 숫자 데이터 검색 )
select ename, sal, job
    from emp
    where sal = 3000;
    
    /* 예제 7-2 */ 
    select ename as 이름, sal as 월급
        from emp
        where sal > = 3000;     -- 월급이 3000 이상인 사원들의 데이터만 출력
        
-- 8. where 절 배우기 ② ( 문자와 날짜 검색 )
select ename, sal, job, hiredate, deptno
    from emp
    where ename = 'SCOTT';
    
    /* 예제8-2 */
    select ename, hiredate
        from emp
        where hiredate = '81/11/17';    -- hiredate(고용일)이 '81/11/17' 인 사람의 이름과 고용일을 출력하는 쿼리
        
    /* 예제 8-3 */
    select * from NLS_SESSION_PARAMETERS
        where parameter = 'NLS_DATE_FORMAT';
        
-- 9. 산술 연산자 배우기 ( *, /, +, - )
select ename, sal * 12 as 연봉
    from emp
    where sal * 12 >= 36000;    -- 연봉이 36000 이상인 사원들의 이름과 연봉 출력
    
    /* 예제 9-2 */
    select ename, sal, comm, sal + comm 
        from emp
        where deptno = 10;      -- 부서번호가 10번인 사원들의 이름 ,월급, 커미션, 월급 + 커미션을 출력
        /* 
            값 + null 일 경우 => null 이 출력된다.
        */
        
    select ename, sal, comm, sal + nvl(comm, 0) as "sal + comm"
        from emp
        where deptno = 10;  -- nvl()함수를 써서 comm이 null일 경우 0으로 치환해서 정상 출력 할수 있음.
        
-- 10. 비교 연산자 배우기 ① ( >, <, >=, <=, =, !=, <>, ^= )
select ename, sal, job, deptno
    from emp
    where sal <= 1200;      -- 월급이 1200 이하인 사원들의 이름, 월급, 부서번호 출력

-- 11. 비교 연산자 배우기 ② ( between and )
select ename, sal 
    from emp
    where sal between 1000 and 3000;

select ename, sal 
    from emp
    where sal >= 1000 and sal <= 3000;
/* 위, 아래 쿼리는 같은 의미: 월급이 1000 이상 3000 이하인 사원의 이름, 월급을 출력 */

    /* 예제 11-3 */ 
    select ename, sal
        from emp
        where sal not between 1000 and 3000;
    
    select ename, sal
        from emp
        where sal < 1000 or sal > 3000;
    /* 위, 아래 쿼리는 같은 의미: 월급이 1000 이상 3000 이하가 아닌 사원의 이름, 월급을 출력 */
        
    /* 예제 11-5 */ 
    -- between ~ and 연산자를 사용하는것이 가독성이 좋다
    select ename, hiredate 
        from emp
        where hiredate between '1982/01/01' and '1982/12/31';
    
-- 12. 비교 연산자 배우기 ③ ( like )
select ename, sal
    from emp
    where ename like 'S%';
/* 
    %는 와일드 카드: 어떠한 철자가 와도 상관없고 철자의 개수가 몇 개가 되든 관계없다는 뜻 
    이 쿼리에서는 S 다음 어떠한 철자가 와도 상관없다는 뜻.
*/
    /* 예제 12-2 */
    select ename 
        from emp
        where ename like '_L%';     
    /*
        두번째 철자가 M 다음 어떠한 철자가 와도 상관없다, 
        _는 어떠한 철자가 와도 상관없으나 자리수는 한 자릴여야 된다라는 의미
        이 쿼리에서의 의미는 첫번째 자리는 무조건 한자리, 그 다음 L, 그 다음은 철자 갯수 상관없다.
    */
    
    select ename 
        from emp
        where ename like '%L%';   
    -- 이 쿼리에서는 앞에 % 가 붙어서 자리 개수 상관없이 여러개 나와도 된며, 여러 철자 나온 다음 L이 붙는건 다 출력한다.
    
    /* 예제 12-3 */ 
    select ename
        from emp
        where ename like '%T';   -- 끝자리가 T인 사원들의 이름 출력
    
    /* 예제 12-4 */
    select ename
        from emp
        where ename like '%A%';  -- 이름에 A를 포함하고 있는 사원들의 이름 출력
        
-- 13. 비교 연산자 배우기 ④ ( is NULL )
select ename, comm
    from emp
    where comm is null;     -- 커미션 comm이 null인 사원의 이름, 커미션 출력
 
    -- null은 할당되지 않은 값이기 때문에 아래와 같이 =로 비교할 수 없다.
    select ename, comm
        from emp
        where comm = null;
    
-- 14. 비교 연산자 배우기 ⑤ ( IN )
select ename, sal, job
    from emp
    where job in('SALESMAN', 'ANALYST', 'MANAGER');     -- 직업이 'SALESMAN', 'ANALYST', 'MANAGER' 인 사원들의 이름, 월급, 직업 출력
    
-- 15. 논리 연산자 배우기( AND, OR, NOT )
select ename, sal, job
    from emp
    where job = 'SALESMAN' and sal >= 1200;     -- 직업이 'SALESMAN', 월급이 1200이상인 사원들의 이름, 월급, 직업 출력
    
-- 16. 대소문자 변환 함수 배우기( UPPER, LOWER, INITCAP )
select upper(ename), lower(ename), initcap(ename)
    from emp;       -- upper함수는 대문자로, lower함수는 소문자로, initcap함수는 첫 글자만 대문자로 출력해준다.
    
    /* 예제 16-2 */ 
    select ename, sal
        from emp
        where lower(ename) = 'scott';       -- 대문자로 저장되어 있는 'SCOTT'를 lower함수를 통해 소문자로 변환했기 때문에 where 절로 'scott' 로 검색해도 출력할 수 있다.
     
    select ename, sal
        from emp
        where ename = 'scott';      -- lower 함수를 쓰지 않으면 테이블에 저장되어 있는 ename이 대문자이기 때문에 검색이 되지 않는다.
        
-- 17. 문자에서 특정 철자 추출하기( substr )
select substr('SMITH', 1, 3)
    from dual;      -- 첫번째 철자에서 3개 까지 출력
    
-- 18. 문자열의 길이를 출력하기( length )
select ename, length(ename) 
    from emp;       -- 이름, 이름의 길이를 출력
    
    /* 예제 18-2 */
    select length('안녕하세요') from dual;       -- 한글의 길이도 출력된다.
    
    /* 예제 18-3 */
    select lengthb('안녕하세요') from dual;       -- lengthb 는 해당 문자의 바이트의 길이를 출력한다.
    select lengthb('a') from dual;              
    select lengthb('ab') from dual;
    select lengthb('ㄱ') from dual;
    select lengthb('갈') from dual;              -- 영문자는 1 byte, 한글은 3 byte임을 알 수 있다.
    
-- 19. 문자에서 특정 철자의 위치 출력하기( instr )
select instr('SMITH', 'M')
    from dual;
    
    /* 예제 19-2 */
    select instr('abcdefg@naver.com', '@')
        from dual;      -- instr로 @의 위치를 출력
        
    select substr('abcdefg@naver.com', instr('abcdefg@naver.com', '@') + 1)
        from dual;      -- 궁극적으로 substr('abcdefg@naver.com', 9)가 됨 => naver.com이 출력된다.
        
-- 20. 특정 철자를 다른 철자로 변경하기( replace )
select ename, replace(sal, 0, '*') as 리네임
    from emp;   -- replace()함수는 특정 철자를 다른 철자로 변경하는 문자 함수. 이 쿼리는 0을 *로 바꿔 출력한다.
    
    /* 예제 20-2 */
    select ename, regexp_replace(sal, '[0-3]', '*') as Salary
        from emp;   --  regexp_replace()함수는 정규표현식 함수, 이 쿼리에서는 0~3모든 수를 * 로 바꿔 출력한다.
    
    /* 예제 20-3 */   
    CREATE TABLE TEST_ENAME
    (ENAME   VARCHAR2(10));
    
    INSERT INTO TEST_ENAME VALUES('김인호');
    INSERT INTO TEST_ENAME VALUES('안상수');
    INSERT INTO TEST_ENAME VALUES('최영희');
    COMMIT;
    
    select replace(ename, substr(ename, 2, 1), '*') as "전광판_이름"
        from test_ename;
    /* 
        substr 함수로 2번째 위치의 문자열을 추출
        -> replae 함수로 추출한 문자열을 '*' 로 변경
    */
    
-- 21. 특정 철자를 N개 만큼 채우기 ( LPAD, RPAD )
select ename, lpad(sal, 10, '*') as salary1, rpad(sal, 10, '*') as salary2
    from emp;
/*
    lpad는 sal을 뒷쪽부터
    rpad는 sal을 앞쪽부터 채운다.
    나머지 빈곳은 *로 채운다.
*/
    /* 예제 21-2 */
    select ename, sal, lpad('■', round(sal / 100), '■') as bar_chart
        from emp;  
        
-- 22. 특정 철자 잘라내기( trim, rtrim, ltrim )
select 'smith', ltrim('smith', 's'), rtrim('smith', 'h'), trim('s' from 'smith')
    from dual;
    
    /* 예제 22-2 */
    insert into emp(empno,ename,sal,job,deptno) values(8291, 'JACK  ', 3000, 'SALESMAN', 30);
    commit;
    
    select ename, sal
        from emp
        where ename = 'JACK';       -- 위 INSERT 문에서 ename을 공백으로 했기 때문에, 데이터가 출력되지 않는다
    
    select ename, sal
        from emp
        where rtrim(ename) = 'JACK';     -- rtrim함수로 검색하면 공백을 없애주기 때문에 데이터가 정상 출력된다.
        
-- 23. 반올림해서 출력하기( round )
select '876.567' as 숫자, round(876.567, 1)
    from dual;  
    
    /* 예제 */
    select round(876.567, 2) from dual;
    select round(876.567, -1) from dual;
    select round(876.567, -2) from dual;
    select round(876.567, 0) from dual;
    
-- 24. 숫자를 버리고 출력하기( trunc )
select '876.567' as 숫자, trunc(876.567, 1)
    from dual;
    
     /* 예제 */
     select '876.567' as 숫자, trunc(876.567, 2) from dual;
     select '876.567' as 숫자, trunc(876.567, -1) from dual;
     select '876.567' as 숫자, trunc(876.567, -2) from dual;
     select '876.567' as 숫자, trunc(876.567, 0) from dual;
     
-- 25. 나눈 나머지 값 출력하기( MOD )
select mod(10, 3) from dual;    -- 자바로 치면 10 % 3과 동일

    /* 예제 25-2 */
    select empno, mod(empno, 2) from emp; 
    
    /* 예제 25-3 */
    select empno, ename
        from emp
        where mod(empno, 2) = 0;    -- empno가 짝수인 사원들의 이름을 출력
    
    /* 예제 25-3 */
    select floor(10 / 3) from dual;     -- 10을 3으로 나눈 결과의 최소 정수를 출력

-- 26. 날짜 간 개월 수 출력하기
select ename, months_between(sysdate, hiredate) from emp;   --개월수 계산

    /* 예제 26-2 */
    select to_date('2019-06-01', 'RRRR-MM-DD') - to_date('2018-10-01', 'RRRR-MM-DD') as 일수
        from dual;      -- 일수 계산
    
    /* 예제 26-3 */
    select round((to_date('2019-06-01', 'RRRR-MM-DD') - to_date('2018-10-01', 'RRRR-MM-DD')) / 7 ) as "총 주수"
        from dual;      -- 총 주일 계산

-- 27. 개월 수 더한 날짜 출력하기( add_months )
select add_months(to_date('2019-05-01', 'RRRR-MM-DD'), 100) as "date"
    from dual;      -- 2019년 5월 1일에 100개월을 더한 날짜를 출력
    
    /* 예제 27-2 */
    select to_date('2019-05-01', 'RRRR-MM-DD') + 100 as "date"
        from dual;      -- '2019-05-01' 에 100일을 더한 날짜를 출력
   
    /* 예제 27-3 */
    select to_date('2019-05-01', 'RRRR-MM-DD') + interval '100' month as "date"
        from dual;      -- interval 함수를 이용하면 '30일', '31일' 계산을 알아서 해준다 ( 위의 add_months함수를 이용했을때와 결과가 같다. )
    
    /* 예제 27-4 */
    select to_date('2019-05-01', 'RRRR-MM-DD') + interval '1-3' year to month as "date"
        from dual;      -- 1년 3개월 후 날짜 계산하는 쿼리
                        -- 이처럼 year가 1년 ~ 9년처럼 한자리인 경우는 그냥 interval '1' year 라 써줘도 무방
        
    select to_date('2019-05-01', 'RRRR-MM-DD') + interval '10-3' year(2) to month + interval '1' day as "date"
        from dual;      -- 10년 3개월 1일 후 날짜 계산하는 쿼리                     
                        -- 해당 쿼리처럼 10년 100년 이면 => interval '10' year(2), interval '100' year(3) 년도의 자릿수를 표시해줘야 한다.
    
    /* 예제 27-5 */
    select to_date('2019-05-01', 'RRRR-MM-DD') +interval '3' year
        from dual;      -- 3년 후 날짜 계산 쿼리
    
    /* 예제 27-6 */
    select to_date('2019-05-01', 'RRRR-MM-DD') + to_yminterval('03-05') as 날짜
        from dual;      -- 3년 5개월 후 날짜 출력 쿼리
                        -- to_yminterval 함수 사용
                
-- 28. 특정 날짜 뒤에 오는 요일 날짜 출력( Next_Day )
select '2021-02-21' as 날짜, next_day('2021-02-21', '월요일')
    from dual;
    
    /* 예제 28-2 */
    select sysdate as "오늘 날짜"
        from dual;      -- 오늘 날짜 구해주는 sysdate 함수
        
    /* 예제 28-3 */
    select next_day(sysdate, '화요일') as "다음 날짜"
        from dual; 
    
    /* 예제 28-4 */
    select next_day(add_months('2019-05-22', 100), '화요일') as "다음 날짜"
        from dual;      -- 100달 뒤에 돌아오는 화요일 날짜 계산
    
    /* 예제 28-5 */
    select next_day(add_months(sysdate, 100), '월요일') as "다음 날짜"
        from dual;      -- 오늘 날짜부터 100달 뒤에 돌아오는 월요일 날짜 계산
        
-- 29. 특정 날짜가 있는 달의 마지막 날짜 출력하기( LAST_DAY )
select '2019/05/22' as 날짜, last_day('2019/05/22') as "마지막 날짜"
    from dual;      -- 5월은 5월 31일까지 있으니 그것이 출력됨

-- 30. 문자형으로 데이터 유형 변환하기( TO_CHAR )
select ename, to_char(hiredate, 'day') as 요일, to_char(sal, '999,999') as 월급
    from emp
    where ename = 'SCOTT';     
    /* 
        - scott의 이름, 입사일(요일로), 월급 출력
        - to_char은 문자열로 바꿔주는 함수
            연도는 => YYYY,RRRR,YY,RR
            월 => MM,MON
            일 => DD
            요일 => DAY,DY
            주 => WW,IW,W
            시간 => HH, HH24
            분 => MI
            초 => SS
            
            to_char(sal, '999,999')에서 '999,999'는 숫자 자릿수이고 0~9까지 어떤 숫자가 와도 상관없다는 의미, ( , )쉼표는 천 단위를 표시
    */
    
    /* 예제 30-2 */
    select hiredate as 오늘날짜, 
            to_char(hiredate, 'RRRR') as 연도, 
            to_char(hiredate,'MM') as 달,
            to_char(hiredate, 'DD') as 일,
            to_char(hiredate, 'day') as 요일
        from emp
        where ename = 'KING';   -- king의 입사날짜를 연도, 달, 일, 요일 로 표시
    
    /* 예제 30-3 */
    select ename, hiredate
        from emp
        where to_char(hiredate, 'rrrr') = '1981'; -- 1981년에 입사한 사람들을 출력
    
    /* 예제 30-4 */
    select ename as 이름, 
            extract(year from hiredate) as 연도,
            extract(month from hiredate) as 달,
            extract(day from hiredate) as 요일
        from emp
        where extract(year from hiredate) = '1981';     -- extract함수로도 계산 가능하다.
    
    /* 예제 30-6 */
    select ename as 이름, to_char(sal * 200, '999,999,999') as 월급
        from emp;
        
    /* 예제 30-7 */
    select ename as 이름, to_char(sal * 200, 'L999,999,999') as 월급
        from emp;       -- 원화로 표시 가능하다.
        
-- 31. 날짜형으로 데이터 유형 변환하기 (TO_DATE)
select ename, hiredate
    from emp
    where hiredate = to_date('1981/11/17', 'rr/mm/dd');
    
    /* 예제 31-2 */
    select * from nls_session_parameters where parameter = 'NLS_DATE_FORMAT';
    
    /* 예제 31-3 */
    select ename, hiredate
        from emp
        where hiredate = '1981-11-17';
    
    /* 예제 31-4 */
    alter session set nls_date_format = 'rr/mm/dd';     -- 세션 날짜 포맷을 DD/MM/RR 형식으로 바꿔준다.
    
    select ename, hiredate
        from emp
        where hiredate = '17/11/81';
        
    /* 예제 31-5 */
    select ename, hiredate
        from emp
        where hiredate = to_date('81/11/17', 'rr/mm/dd');   -- 세션에 형식에 상관없이 to_date 함수를 사용하여 년도 = rr, 월 = mm,일 = dd로 검색할 수 있다. 
        
-- 32. 암시적 형 변환 이해하기
select ename, sal
    from emp
    where sal = '3000';     
    /* 
        sal은 숫자인데 문자 '3000'으로도 조회가 정삭적으로 되는것을 알 수 있다.
        오라클은 문자형과 숫자형을 비교할 경우 => 문자형을 숫자형으로 형변환 한다.
    */
    
    /* 예제 32-2 */
    create table emp32 (
        ename varchar2(10),
        sal varchar2(10)
    );
    
    insert into emp32 values('SCOTT', '3000');
    insert into emp32 values('SMITH', '1200');
    commit;   
    
    select * from emp32;
    
    set autot on
    select * from emp32 where sal ='3000';
    select * from emp32 where sal =3000;
    
-- 33. NULL값 대신 다른 데이터 출력하기( NVL, NVL2 )
select ename, comm, nvl(comm, 0) from emp;      -- nvl()함수는 null을 지정한 다른 값으로 출력해준다.

    /* 예제 33-2 */
    select ename, sal, comm, sal + comm
        from emp
        where job in('SALESMAN', 'ANALYST');    
    
    /*  
        NULL + SAL = NULL로 출력됨을 알 수 있다.
        이럴 경우 봉급 + 커미션이 얼마인지 정확히 알 수 없다.
        다음 예제 처럼 NVL함수를 사용하여 정확한 계산을 할 수 있다.
    */     
    
    /* 예제 33-3 */
    select ename, sal, comm, nvl(comm, 0), sal + nvl(comm, 0) as 총액
        from emp
        where job in('SALESMAN', 'ANALYST');
    
    /* 예제 33-3 */
    select ename, sal, comm, nvl2(comm, sal + comm, sal) as 총액
        from emp
        where job in('SALESMAN', 'ANALYST');   
        /*
             nvl2함수는 nvl2(x, y, z) 일 경우 x의 값이 null 아닐 경우 y를 반환, null일 경우 z를 반환하는 함수이다.
             이 쿼리에서는 커미션이 null이 아닐 경우 봉급+커미션 값을 반환하고
             null일 경우 봉급만 반환하도록 하는 쿼리이다.
        */

-- 34. if문을 sql로 구현하기①
select ename, deptno, decode(deptno, 10, 300, 20, 400, 0) as 보너스
    from emp;   -- 부서번호가 10이면 300, 20이면 400, 10,20 모두 아니면 0이 출력, decode함수의 마지막 0은 default값
    
    /* 예제 34-2 */
    select empno, mod(empno, 2), decode(mod(empno, 2), 0, '짝수', 1, '홀수') as 보너스
        from emp;   
    /*
        decode함수를 사용하여 mod(사원번호, 2) 가 0이면 짝수, 1이면 홀수가 출력되게 만든 쿼리
        default 값은 생략 가능하다.
    */
    
    /* 예제 34-3 */
    select ename, job, decode(job, 'SALESMAN', 5000, 2000) as 보너스
        from emp;   -- decode 함수를 사용하여 job이 salesman이면 보너스 5000, 아니면 2000을 출력하도록 하는 쿼리
        
-- 35. if문을 sql로 구현하기②
select ename, job, sal, case when sal >= 3000 then 500
                             when sal >= 2000 then 300
                             when sal >= 1000 then 200
                             else 0 end as bonus
    from emp 
    where job in('SALESMAN', 'ANALYST');   
    /*
        조건을 만족하는 then을 출력
        decode와 다른점
            - decode는 등호( = )만 비교 가능
            - case는 등호, 부등호 둘 다 비교 가능
    */
    
    /* 예제 35-2 */
    select ename, job, comm, case when comm is null then 500
                                  else 0 end as bonus
        from emp
        where job in('SALESMAN', 'ANALYST');    -- 커미션이 null이면 500, 아니면 0을 출력
    
    /* 예제 35-3 */
    select ename, job, case when job in('SALESMAN', 'ANALYST') then 500
                            when job in('CLERK', 'MANAGER') then 400
                       else 0 end as 보너스
        from emp;
        
-- 36. 최대값 출력하기( MAX )
select max(sal) from emp;
    
    /* 예제 36-2 */
    select max(sal)
        from emp
        where job= 'SALESMAN';  -- job이 salesman중 봉급이 최대값을 출력
    
    /* 예제 36-3 */
    select job, max(sal)
        from emp
        where job = 'SALESMAN';    
    /*
         - 에러가 나는 이유
            job은 여러행이 출력되려고 하는데 sal은 max함수로 인해 1개만 출력되므로 에러가 발생한다.
    */
        
    /* 예제 36-4 */
    select job, max(sal)
        from emp
        where job = 'SALESMAN'
        group by job;       -- group by를 해주면 정상출력된다.
        
    /* 예제 36-5 */
    select deptno, max(sal)
        from emp
        group by deptno;    -- 부서번호 중 최대 봉급을 출력
        
-- 37. 최소값 출력하기( MIN )
select min(sal)
    from emp
    where job = 'SALESMAN';
    
     /* 예제 37-2 */
     select job, min(sal) 최소값
        from emp
        group by job
        order by 최소값 desc;
        
     /* 예제 37-3 */
     select min(sal)
        from emp
        where 1 = 2;    -- 그룹함수는 where 조건이 거짓이라도 정상 실행된다. ( null로 출력된다. )
     
     /* 예제 37-4 */
     select nvl(min(sal), 0)
        from emp
        where 1=2;
    
    /* 예제 37-5 */
    select job, min(sal) as "직급별 최소 급여"
        from emp
        where job != 'SALESMAN'
        group by job
        order by min(sal) desc;
        
-- 38. 평균값 출력하기 ( AVG )
select avg(comm) from emp;  -- emp테이블의 모든 comm( 커미션 ) 평균
    /*
        그룹함수는 null값을 무시한다.
        위 커리는 1400,300,0,500 만 평균값으로 계산한다.( null은 무시 ) 
    */
    
    /* 예제 38-2 */
    select round(avg(nvl(comm, 0))) from emp;
    /*
        nvl함수로 null값을 0으로 치환했다
        고로 이전에는 null값을 무시해서 (전체 합산 / 4) 였던거에 반해 => (전체합산 / 15) 가 되어 평균값이 147이 되었다.
    */

-- 39. 토탈값 출력하기 ( SUM )
select deptno, sum(sal)
    from emp
    group by deptno;    -- 부서번호 별 합산 급여
    
    /* 예제 39-2 */
    select job, sum(sal)    
        from emp
        group by job
        order by sum(sal) desc;     -- 직급 별 합산 급여를 내림차순으로
    
    /* 예제 39-3 */
    select job, sum(sal)
        from emp       
        where sum(sal) >= 4000
        group by job;       -- where절에 그룹 함수를 사용해 조건을 주면 허가되지 않는다고 에러발생
        
    /* 예제 39-4 */
    select job, sum(sal)
        from emp
        group by job
        having sum(sal) >= 4000
        order by sum(sal) desc;     -- having절을 사용해서 조건을 주면 정상 처리된다.
        
    /* 예제 39-5 */
    select job, sum(sal) as "총 월급"
        from emp
        where job != 'SALESMAN'
        group by job
        having sum(sal) >= 4000;         -- 'SALESMAN' 영업 제외한 나머지 직급 별 총 급여(4000 이상만)
        
    
    select job, sum(sal) as "총 월급"
        from emp
        group by job
        having sum(sal) >= 4000 and job != 'SALESMAN';     -- 이렇게 해도 되네?
        
-- 40. 건수 출력하기( COUNT )
select count(empno) from emp;   -- emp테이블 전체 사원수 출력
select count(*) from emp;       -- 위와 결과가 같다.
    /*
        count(empno)는 empno컬럼만 카운트, count(*) 은 전체 컬럼을 카운트
    */
    
    /* 예제 40-2 */
    select count(comm) from emp;    -- 그룹함수는 null값을 무시하기 때문에 전체 개수가 null을 제외한 4가 출력된다.

-- 41. 데이터 분석 함수로 순위 출력하기 ① ( RANK )
select ename, job, sal, rank() over (order by sal desc) 순위
    from emp
    where job in('ANALYST', 'MANAGER');     -- 봉급 순위 표시( 'ANALYST', 'MANAGER'만 )
                                            -- rank() over(): over 괄호 안에 출력하고 싶은 데이터 넣으면 데이터에 따른 순위 출력
                                            -- 중복이 있으면 다음 순위로 표시된다( ex)공동 1위가 있으면 다음 순위는 3위 )
    
    /* 예제 41-2 */
    select ename, sal, job, rank() over(partition by job order by sal desc) as 순위
        from emp;       -- partition by job => 직업별로 묶어서 순위 부여

-- 42. 데이터 분석 함수로 순위 출력하기 ② ( DENSE RANK )
select ename, job, sal, rank() over(order by sal desc) as rank, dense_rank() over(order by sal desc) as dense_rank
    from emp
    where job in('ANALYST', 'MANAGER');     -- rank() over() 함수와 dense_rank() over() 함수의 차이를 비교
    
    /* 예제 42-2 */
    select job, ename, sal, dense_rank() over(partition by job order by sal desc) 순위
        from emp
        where hiredate between to_date('1981/01/01', 'rrrr/mm/dd') and
                               to_date('1981/12/31', 'rrrr/mm/dd'); 
    /* 
        1981년에 입사한 사원들의 직종, 이름, 급여를 직종별로 묶어 임금 순위를 표시. 
    */
    
    /* 예제 42-3 */
    select dense_rank(2975) within group(order by sal desc) 순위
        from emp;   -- 급여가 2975인 사원의 월급 순위를 출력
                    -- dense_rank괄호 안의 데이터가 데이터 전체에서 순위가 어떻게 되는지 출력
                    -- within group은 어느 그룹 내에서 순위가 어떻게 되는지 출력
                
     /* 예제 42-4 */
     select dense_rank('81-11-17') within group(order by hiredate asc) 순위 from emp;
        -- 입사일이 1981년 11월 17일인 사원이 전체 사원중 몇 번째로 입사했는지 순위를 표시
        
-- 43. 데이터 분석 함수로 등급 출력하기( NTILE )
select ename, job, sal, ntile(4) over (order by sal desc nulls last) 등급
    from emp
    where job in('ANALYST', 'MANAGER', 'CLERK');    -- 월급이 높은 순서대로 4등분하여 등급 표시.
                                                    -- nulls last는 null이 있으면 null을 맨 아래에 출력하겠다는 의미
                                                    
    /* 예제 43-2 */
    select ename, comm 
        from emp
        where deptno = 30
        order by comm desc;
        
    select ename, comm 
        from emp
        where deptno = 30
        order by comm desc nulls last;      -- nulls last가 있고 없고의 차이
        
-- 44. 데이터 분석 함수로 순위의 비율 출력하기 ( CUME_DIST )
select ename, sal, rank() over(order by sal desc) as rank,
        dense_rank() over(order by sal desc) as dense_rank,
        cume_dist() over(order by sal desc) as cum_dist
    from emp;
    
    /* 예제 44-2 */ 
    select job, ename, sal, rank() over(partition by job order by sal desc) as rank,
                                   cume_dist() over(partition by job order by sal desc) as cum_dist
        from emp;
        
-- 45. 데이터 분석 함수로 데이터를 가로로 출력하기( LISTAGG )
select deptno, listagg(ename, ' , ') within group(order by ename) as employee
    from emp
    group by deptno;        -- listagg() 함수는 데이터를 가로로 출력하는 함수
                            -- order by ename은 employee 컬럼에 a,b,c ... 처럼 알파벳 순서대로 출력되게금 한다.
                    
    /* 예제45-2 */
    select job, listagg(ename, ',') within group(order by ename) as employee
        from emp
        group by job;   -- 직업과 그 직업에 속한 사원들의 이름을 출력
        
    /* 예제45-3 */
    select job,
           listagg(ename || '(' || sal || ')', ',') within group (order by ename) as employee
        from emp
        group by job;   -- 위 예제에 + 이름 옆에 급여도 출력
        
-- 46. 데이터 분석 함수로 바로 전 행과 다음 행 출력하기( LAG, LEAD )
select empno, ename, sal, lag(sal, 1) over(order by sal asc) "전 행",
                          lead(sal, 1) over(order by sal asc) "다음 행"
    from emp
    where job in('ANALYST', 'MANAGER');     -- leg()함수는 바로 전 행, lead()함수는 다음 행의 데이터를 출력
                                            -- lag(), lead() 함수의 각 두번째 매개변수 자리는 몇 번째 전, 후의 데이터를 출력할지 지정
                                            
    /* 예제 46-2 */
    select empno, ename, hiredate, lag(hiredate, 1) over(order by hiredate asc) "전 행",
                                   lead(hiredate, 1) over(order by hiredate asc) "다음 행"
        from emp
        where job in('ANALYST', 'MANAGER');     -- 직업이 'ANALYST', 'MANAGER' 인 사람들 중 사원번호, 이름, 입사일, 
                                                -- 바로 전에 입사한 사원의 입사일, 바로 다음에 입사한 사원의 입사일을
                                                
    /* 예제 46-3 */
    select deptno, empno, ename, hiredate, lag(hiredate, 1) over(partition by deptno order by hiredate asc) "전 행",
                                           lead(hiredate, 1) over(partition by deptno order by hiredate asc) "다음 행"
        from emp;      -- deptno을 기준으로 partition으로 후, 묶인 그룹을 기준으로 바로 전에 입사한 사원의 입사일, 바로 다음에 입사한 사원의 입사일을 출력
        
-- 47. COLUMN을 ROW로 출력하기① ( SUM + DECODE )
select sum(decode(deptno, 10, sal)) as "10",
       sum(decode(deptno, 20, sal)) as "20",
       sum(decode(deptno, 30, sal)) as "30"       
    from emp;   -- 부서번호별 총 급여
    
    /* 예제 47-2 */
    select deptno, decode(deptno, 10, sal) as "10"
        from emp;   -- 부서번호가 10이면 부서번호와 급여가 출력( 부서번호가 10이 아니면 급여가 null 출력 )
        
    /* 예제 47-5 */
    select sum(decode(job, 'ANALYST', sal)) as "ANALYST",
           sum(decode(job, 'CLERK', sal)) as "CLERK",
           sum(decode(job, 'MANAGER', sal)) as "MANAGER",
           sum(decode(job, 'SALESMAN', sal)) as "SALESMAN"
        from emp;   -- 직업별 토탈 급여를 출력
        
    /* 예제 47-6 */
    select deptno, sum(decode(job, 'ANALYST', sal)) as "ANALYST",
           sum(decode(job, 'CLERK', sal)) as "CLERK",
           sum(decode(job, 'MANAGER', sal)) as "MANAGER",
           sum(decode(job, 'SALESMAN', sal)) as "SALESMAN"
        from emp
        group by deptno;    -- 위 예제에서 deptno를 추가
        
-- 48. COLUMN을 ROW로 출력하기② ( PIVOT )
select * from (select deptno, sal from emp)
         pivot(sum(sal) for deptno in (10, 20, 30));    -- 부서별 총 급여 ( 47번의 sum + decode를 사용한 결과와 동일 ), pivot()함수로 표현
         
    /* 예제 48-2 */
    select * from(select job, sal from emp)
             pivot(sum(sal) for job in('ANALYST', 'CLERK', 'MANAGER', 'SALESMAN'));
    
     /* 예제 48-3 */
    select * from(select job, sal from emp)
             pivot(sum(sal) for job in('ANALYST' as "ANALYST", 'CLERK' as "CLERK", 'MANAGER' as "MANAGER", 'SALESMAN' as "SALESMAN"));
             
-- 49. ROW를 COLUMN으로 출력하기 ( UNPIVOT )
/*
create table order2
( ename  varchar2(10),
  bicycle  number(10),
  camera   number(10),
  notebook  number(10) );

insert  into  order2  values('SMITH', 2,3,1);
insert  into  order2  values('ALLEN',1,2,3 );
insert  into  order2  values('KING',3,2,2 );

commit;*/
select * from order2;

select * from order2
         unpivot(건수 for 아이템 in(BICYCLE, CAMERA, NOTEBOOK));
         
    /* 예제 49-2 */ 
    select * from order2
         unpivot(건수 for 아이템 in(BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));
         
    update order2 set NOTEBOOK = null where ename = 'SMITH';    -- null이 포함되어있으면 unpivot 결과에 포함되지 않는다.
                                                                -- smith의 notebook을 null로 update 한 후 다시 unpivot 해보면 smith의 노트북이 출력되지 않는것을 확인할 수 있다.
                                                                
    /* 예제 49-3 */
    select * from order2
         unpivot include nulls(건수 for 아이템 in(BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));
    -- unpivot include nulls을 하면 null값도 unpivot 할때 정상 출력됨을 확인할 수 있다.

-- 50. 데이터 분석 함수로 누적 데이터 출력하기( SUM OVER )
select empno, ename, job, sal, sum(sal) over(order by empno rows between unbounded preceding and current row) 누적치
    from emp
    where job in('ANALYST', 'MANAGER');     -- 직업이 analyst, manager인 사원들의 사원번호, 직책, 이름, 급여, 급여의 누적치를 출력
    
-- 51. 데이터 분석 함수로 비율 출력하기( RATIO_TO_REPORT )
select empno, deptno, ename, sal, ratio_to_report(sal) over() as 비율
    from emp
    where deptno = 20;      -- 부서번호가 20번인 사원들의 사원번호, 부서번호, 이름, 급여, 20번 부서 내에서의 급여 비율을 출력

select sum(sal) as 합계
    from emp
    where deptno = 20;      -- 부서번호 20번의 총 급여
    
-- 52. 데이터 분석 함수로 집계 결과 출력하기①( ROLLUP )
select job, sum(sal)
    from emp
    group by rollup(job);   -- 직급별 토탈 급여 출력 및 맨 아래쪽에 전체 급여를 추가
                            -- rollup을 사용하면 맨 아래 토탈 급여도 출력되고 job 컬럼의 데이터도 오름차순으로 정렬되어 출력
                
    /* 예제 52-2 */
    select deptno, job, sum(sal)
        from emp
        group by rollup(deptno, job);
        
-- 53. 데이터 분석 함수로 집계 결과 출력하기② ( CUBE )
select job, sum(sal) 
    from emp
    group by cube(job);     
    
select deptno, sum(sal) 
    from emp
    group by cube(deptno);      -- cube를 사용하면 맨 위쪽에 토탈 급여가 추가, 부서 번호도 오름차순으로 정렬
    
    /* 예제 53-2 */
    select deptno, job, sum(sal) 
        from emp
        group by cube(deptno, job);     -- group by rollup과 비교해서 => job 토탈에 대한 집계가 추가됨
        
-- 54. 데이터 분석 함수로 집계 결과 출력하기 ③ ( GROUPING SETS )
select deptno, job, sum(sal) 
    from emp
    group by grouping sets((deptno), (job), ());    -- 부선번호별, 직업별, 전체 집계
                                                    -- group by rollup 보다 결과를 예측하기 더 쉽다.
                                                    
-- 55. 데이터 분석 함수로 출력 결과 넘버링 하기(ROW_NUMBER)
select empno, ename, sal, rank() over(order by sal desc) rank,
                          dense_rank() over(order by sal desc) dense_rank,
                          row_number() over(order by sal desc) 번호
    from emp
    where deptno = 20;
    
    /* 예제 55-3 */
    select deptno, ename, sal, row_number() over(partition by deptno order by sal desc) 번호
        from emp
        where deptno in(10, 20);
        
-- 56. 출력되는 행 제한하기 ① (ROWNUM)
select rownum, empno, ename, job, sal
    from emp
    where rownum <= 5;
    
-- 57. 출력되는 행 제한하기 ② ( Simple TOP-n Queries )
select empno, ename, job, sal
    from emp
    order by sal desc 
    FETCH FIRST 4 ROWS ONLY;        -- 11g에서는 안됨 -.-;
    
-- 58. 여러 테이블의 데이터를 조인해서 출력하기 ① ( EQUI JOIN )
select ename, loc
    from emp, dept
    where emp.deptno = dept.deptno;
    
    /* 예제 58-4 */
    select ename, loc, job 
        from emp,dept
        where emp.deptno = dept.deptno and emp.job = 'ANALYST';
    
    /* 예제 58-5 */
    select ename, loc, job, deptno
        from emp, dept
        where emp.deptno = dept.deptno and emp.job = 'ANALYST';
        
    /* 예제 58-6 */
    select ename, loc, job, emp.deptno
        from emp, dept
        where emp.deptno = dept.deptno and emp.job = 'ANALYST';

    /* 예제 58-7 */
    select emp.ename, dept.loc, emp.job, emp.deptno
        from emp, dept
        where emp.deptno = dept.deptno and emp.job = 'ANALYST';    -- 권장 사항
    
    /* 예제 58-8 */
    select e.ename, d.loc, e.job, e.deptno
        from emp e, dept d
        where e.deptno = d.deptno and e.job = 'ANALYST';    -- 알리아스로 줄여쓸 수 있다.
        
-- 59. 여러 테이블의 데이터를 조인해서 출력하기 ②( NON-EQUI JOIN )
select e.ename, e.sal, s.grade
    from emp e, salgrade s 
    where e.sal between s.losal and s.hisal;

-- 60. 여러 테이블의 데이터를 조인해서 출력하기 ③( OUTER JOIN )
select e.ename, d.loc
    from emp e, dept d
    where e.deptno(+) = d.deptno;
    
-- 61. 여러 테이블의 데이터를 조인해서 출력하기 ④( SELF JOIN )
select e.ename as 사원이름,e.empno as 사원번호, e.job as 부서, m.ename as 관리자, m.empno as 사원번호, m.job as 부서
    from emp e, emp m
    where e.mgr = m.empno and e.job = 'SALESMAN';
    
-- 62. 여러 테이블의 데이터를 조인해서 출력하기 ⑤( ON절 )
select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    from emp e join dept d
    on (e.deptno = d.deptno)
    where e.job = 'SALESMAN';
    
-- 63. 여러 테이블의 데이터를 조인해서 출력하기 ⑤( USING절 )
select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    from emp e join dept d
    using (deptno)  -- 알리아스 쓰면 에러난다. 컬럼명 자체를 입력해야 된다.
    where e.job = 'SALESMAN';
    
-- 64. 여러 테이블의 데이터를 조인해서 출력하기 ⑥( NATURAL JOIN )
select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    from emp e natural join dept d
    where e.job = 'SALESMAN';
    
-- 65. 여러 테이블의 데이터를 조인해서 출력하기 ⑦( LEFT/RIGHT OUTER JOIN )
select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    from emp e right outer join dept d
    on (e.deptno = d.deptno);
    
    -- left outerjoin을 위한 사전작업
    insert into emp(empno, ename, sal , job, deptno) values(8282, 'JACK', 3000, 'ANALYST', 50);

select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
    from emp e left outer join dept d
    on (e.deptno = d.deptno);
    
-- 66. 여러 테이블의 데이터를 조인해서 출력하기 ⑧( FULL OUTER JOIN )
select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 이름"
    from emp e full outer join dept d
    on(e.deptno = d.deptno);
    
-- 67. 집합 연산자로 데이터를 위아래로 연결하기 ①( UNION ALL )
select deptno, sum(sal) as 합계
    from emp
    group by deptno
union all
select to_number(null) as deptno, sum(sal)
    from emp
    order by 합계 asc;    -- order by에 sum(sal) 컬럼명을 써주면 에러 발생 => 확인 요망
    
    
    

    
    
    
    


    
    


    

    




    
    
   
    

        
                                                    
                                                    
                                    
                    

        
    
        
    
    





