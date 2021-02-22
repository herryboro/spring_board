
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
        
    


    





