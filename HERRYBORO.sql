
CREATE TABLE HERRYBORO_FRIENDS(
    SEQ NUMBER(5),
    NAME VARCHAR(30),
    POSITION VARCHAR(100),
    FINAL_YN VARCHAR(1)
);

SELECT * FROM HERRYBORO_FRIENDS; 
INSERT INTO HERRYBORO_FRIENDS VALUES(1, '������', '�׸��ɵ���','M');

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

-- �ߺ� ���� --
select distinct company from idol_group;

-- group by (Ư�� �÷��� �������� ����) --
select company, count(*) from idol_group group by company;
select distinct company, count(*) from idol_group group by company having count(*) = 2;

select * from idol_group where group_name = '�ƽ�Ʈ��';

-- insert (��ü �Է�)--
insert into idol_group values('jyp �������̸�Ʈ', 'ITZY', '2019', 'ITz Differnt', 'girl');
-- Ư�� �÷��� �Է� --
insert into idol_group(company, group_name) values('�׽�Ʈ �Ҽӻ�', '���� ���̵� �׷�'); 

SELECT * FROM IDOL_MEMBER;
-- order by ( �ʹ� ���� order by�� sort���Ϸ� ���� ������ ���ϵ� �� �ִ�. �� �ʿ��Ҷ��� ��� ���� )--

-- asc(��������) --
SELECT * FROM IDOL_MEMBER order by birthday asc;

-- desc( �������� )
SELECT * FROM IDOL_MEMBER order by real_name desc;
SELECT * FROM IDOL_MEMBER order by real_name desc nulls last;
SELECT * FROM IDOL_MEMBER order by real_name nulls first;
-- �� �÷� order by --
SELECT * FROM IDOL_MEMBER order by real_name desc, birthday desc;

SELECT * FROM idol_group;
SELECT * FROM IDOL_MEMBER;
-- join --

-- inner join --
--  join on�� �Ἥ join --
select * from idol_group g
join idol_member m
on g.group_name = m.group_name;
-- where ���� �Ἥ join --
select * from idol_group g, idol_member m where g.group_name = m.group_name;
-- ���� ���� �÷��� --
select g.company, g.group_name, m.member_name, m.real_name from idol_group g, idol_member m where g.group_name = m.group_name;
-- group by --
select g.company, g.group_name, count(m.member_name) count
    from idol_group g, idol_member m where g.group_name = m.group_name group by g.company, g.group_name;
    
-- outer join --
select * from idol_group g, idol_member m where g.group_name = m.group_name; -- �Ϲ����� inner join --
select * from idol_group g, idol_member m where g.group_name = m.group_name(+); -- outer join --
select * from idol_group g left outer join idol_member m on g.group_name = m.group_name; -- left outer join (�� outer join�� ����.) �� (�� ����� �� ��õ)--
select * from idol_group g right outer join idol_member m on g.group_name = m.group_name; -- right outer join

SELECT * FROM idol_group;
SELECT * FROM IDOL_MEMBER;
-- update --
update idol_member set real_name = '���̿�' where member_name = '�̿�';
update idol_member set member_name = '��ȭ', real_name = '����ȭ', sns_info = 'V Live, �ν�Ÿ�׷�' where member_name = '��ȭ'; 
commit;

-- delete --
create table idol_group_copy as select * from idol_group; -- idol_group ���̺��� �����ؼ� idol_group_copy ���̺��� �����ϴ� ����
create table idol_group_copy2 as select * from idol_group where 1 = 2; -- idol_group ���̺��� ������ �����ؼ� idol_group_copy2 ���̺��� ����( ������ ���� �����̺� ���� ), ������ ����X --
delete from idol_group_copy;
select * from idol_group_copy;
rollback;
delete from idol_group_copy where group_name = 'Wanna One';
delete from idol_group_copy where company = 'SM �������θ�Ʈ' and gender = 'boy';

-- null ���� �Լ� --
select 
    member_name, 
    real_name,
    nvl (real_name, member_name) name1, -- real_name �÷��� null�� �ƴϸ� real_name ���� name1�� �Է�, null�̸� member_name�� name1 �÷��� �Է� --
    nullif(member_name, '����') name2, --  member_name�� '����' �� ������ name2 �÷��� null�� �Է�, �ƴϸ� member_name�� �Է� --
    coalesce(null, real_name, member_name) name3 -- coalesce�Լ��� �Ű������� ������ �÷� �� null�� �ƴ� ù��° ���� name3 �÷��� �Է� --
from idol_member where group_name = '(����)���̵�';

-- ntile �Լ� --
select * from exam_score;
select 
    �̸�,
    ntile(8) over(order by ���� desc) ������,
    ����
    from exam_score;
    


COMMENT ON COLUMN IDOL_GROUP.GROUP_NAME IS '�׷��';
COMMENT ON COLUMN IDOL_GROUP.DEBUT_YEAR IS '���߳⵵';
COMMENT ON COLUMN IDOL_GROUP.DEBUT_ALBUM IS '���߾ٹ�';
COMMENT ON COLUMN IDOL_GROUP.GENDER IS '����';

INSERT INTO IDOL_GROUP VALUES ('����Ʈ �������θ�Ʈ', 'BTS', '2013', '2 COOL 4 SCHOOL', 'boy');
INSERT INTO IDOL_GROUP VALUES ('JYP �������θ�Ʈ', 'Ʈ���̽�', '2015', 'THE STORY BEGINS', 'girl');
INSERT INTO IDOL_GROUP VALUES ('YG �������θ�Ʈ', '����ũ', '2016', 'SQUARE ONE', 'girl');
INSERT INTO IDOL_GROUP VALUES ('��Ÿ����', '�ƽ�Ʈ��', '2016', 'SPRING UP', 'boy');
INSERT INTO IDOL_GROUP VALUES ('�︲ �������θ�Ʈ', '������', '2014', 'Girls Invasion', 'girl');
INSERT INTO IDOL_GROUP VALUES ('��Ÿ�� �������θ�Ʈ', '���ּҳ�', '2016', 'Would You Like', 'girl');
INSERT INTO IDOL_GROUP VALUES ('���� �������θ�Ʈ', 'Wanna One', '2017', '1X1=1', 'boy');
INSERT INTO IDOL_GROUP VALUES ('ť�� �������θ�Ʈ', '(����)���̵�', '2018', 'I am', 'girl');
INSERT INTO IDOL_GROUP VALUES ('SM �������θ�Ʈ', '���座��', '2014', '�ູ', 'girl');
INSERT INTO IDOL_GROUP VALUES ('SM �������θ�Ʈ', 'EXO', '2012', '����', 'boy');
INSERT INTO IDOL_GROUP VALUES ('JYP �������θ�Ʈ', '������', '2014', 'Got it?', 'boy');
INSERT INTO IDOL_GROUP VALUES ('���������ڵ� �������θ�Ʈ', '�������', '2018', '�÷�������', 'girl');
INSERT INTO IDOL_GROUP VALUES ('�÷����� �������θ�Ʈ', '������ũ', '2011', 'Seven Springs of Apink', 'girl');
INSERT INTO IDOL_GROUP VALUES ('ť�� �������θ�Ʈ', '������', '2012', '���', 'boy');
INSERT INTO IDOL_GROUP VALUES ('�����', '����ģ��', '2015', 'Season of Glass', 'girl');
INSERT INTO IDOL_GROUP VALUES ('YG �������θ�Ʈ', '����', '2014', '2014 S/S', 'boy');
INSERT INTO IDOL_GROUP VALUES ('��Ÿ�� �������θ�Ʈ', '��Ÿ����', '2015', 'TRESPASS', 'boy');
INSERT INTO IDOL_GROUP VALUES ('WM �������θ�Ʈ', '�����̰�', '2015', 'OH MY GIRL', 'girl');
INSERT INTO IDOL_GROUP VALUES ('DSP�̵��', '��������', '2015', 'Dreaming', 'girl');
INSERT INTO IDOL_GROUP VALUES ('�����ǽ� �������θ�Ʈ', '������', '2016', 'The Little Mermaid', 'girl');

INSERT INTO IDOL_MEMBER VALUES ('BTS','RM','�賲��','19940912','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','����','������','19930309','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','��','�輮��','19921204','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','����ȩ','��ȣ��','19940218','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','����','������','19951013','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('BTS','����','������','19970901','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('Ʈ���̽�','����','�ӳ���','19950922','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('Ʈ���̽�','����','������','19961101','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('Ʈ���̽�','���','������ ���','19961109','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('Ʈ���̽�','�糪','�̳�����Ű �糪','19961229','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('Ʈ���̽�','��ȿ','����ȿ','19970201','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('Ʈ���̽�','�̳�','���� �̳�','19970324','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('Ʈ���̽�','����','�����','19980528','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('Ʈ���̽�','ä��','��ä��','19990423','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('Ʈ���̽�','����','���� ����','19990614','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('�ƽ�Ʈ��','������','�̵���','19970330','�ν�Ÿ�׷�');
INSERT INTO IDOL_MEMBER VALUES ('�ƽ�Ʈ��','����','����','19980126','�ν�Ÿ�׷�');
INSERT INTO IDOL_MEMBER VALUES ('�ƽ�Ʈ��','MJ','�����','19940305','�ν�Ÿ�׷�');
INSERT INTO IDOL_MEMBER VALUES ('�ƽ�Ʈ��','����','������','19960315','�ν�Ÿ�׷�');
INSERT INTO IDOL_MEMBER VALUES ('�ƽ�Ʈ��','��Ű','�ڹ���','19990225','�ν�Ÿ�׷�');
INSERT INTO IDOL_MEMBER VALUES ('�ƽ�Ʈ��','������','������','20000321','�ν�Ÿ�׷�');
INSERT INTO IDOL_MEMBER VALUES ('(����)���̵�','�̿�','','19970131','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(����)���̵�','�δ�','','19971023','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(����)���̵�','����','','19980309','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(����)���̵�','�ҿ�','','19980826','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(����)���̵�','���','','19990923','V LIVE');
INSERT INTO IDOL_MEMBER VALUES ('(����)���̵�','��ȭ','','20000106','V LIVE');

-- selct ���� ���� --
CREATE TABLE BILLBOARD_CHARTS (
	RANKING	NUMBER(3) NOT NULL,
	TITLE VARCHAR(500) NOT NULL,
	SINGER VARCHAR(100),
	UPDOWN NUMBER(3),
	COUNTRY VARCHAR(50)
);

select * from BILLBOARD_CHARTS;

-- �빮�� M���� �����ϴ� ��� title select --
select * from billboard_charts where title like 'M%';

-- �߰��� M�� �ִ� ��� title select --
select * from billboard_charts where title like '%M%';

-- group by�� billboard_chart ���̺� country, singer�÷��� count(*) ���� ��� --
select country from billboard_charts;
select country, singer, count(*) from billboard_charts group by country, singer having country = 'Korea';

-- ranking�÷��� �������� desc(��������) --
select * from BILLBOARD_CHARTS order by ranking desc;

select * from exam_score;
-- ntile �Լ� --
select 
    �̸�, 
    ntile(8) over(order by ���� desc) ������,
    ntile(8) over(order by ���� desc) ������,
    ntile(8) over(order by ���� desc) ���е��,
    ����,
    ����,
    ����
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
	�̸�		VARCHAR(20),
	����		NUMBER,
	����		NUMBER,
	����		NUMBER
);

INSERT INTO EXAM_SCORE VALUES ('�����', 116, 77, 75);
INSERT INTO EXAM_SCORE VALUES ('�ں���', 101, 69, 80);
INSERT INTO EXAM_SCORE VALUES ('������', 118, 62, 60);
INSERT INTO EXAM_SCORE VALUES ('���ϴ�', 96, 72, 70);
INSERT INTO EXAM_SCORE VALUES ('��ȿ��', 103, 77, 55);
INSERT INTO EXAM_SCORE VALUES ('���缮', 78, 66, 61);
INSERT INTO EXAM_SCORE VALUES ('�ŵ���', 85, 72, 75);
INSERT INTO EXAM_SCORE VALUES ('������', 99, 70, 53);
INSERT INTO EXAM_SCORE VALUES ('������', 105, 75, 69);
INSERT INTO EXAM_SCORE VALUES ('�赿��', 117, 68, 73);
commit;


-- ���̺��� ������ �����Ѵ�.
DROP TABLE board;
-- ������ ����
DROP SEQUENCE board_seq;

-- ���̺� �ۼ�
CREATE TABLE board(
 no NUMBER PRIMARY KEY,   -- ��ȣ
 title VARCHAR2(300) NOT NULL,   -- ����
 content VARCHAR2(2000) NOT NULL,   -- ����
 writer VARCHAR2(30) NOT NULL,   -- �ۼ���
 writeDate DATE DEFAULT sysdate,   -- �ۼ���
 hit NUMBER DEFAULT 0,   -- ��ȸ��
 pw VARCHAR2(50)  NOT NULL  -- ��й�ȣ
);

-- ������ �ۼ�
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

insert into board values(1, '�� ������ �Ѥ�', '�׽�Ʈ', '�̽���', sysdate, 0, 111);
insert into board values(3, '�� ������ �Ѥ�', '�׽�Ʈ', '�̽���', sysdate, 0, 111);
insert into board values(4, '�� �ؼ� �Ѥ�', '�׽�Ʈ', '������', sysdate, 0, 111); 
insert into board values(5, '�� �̱��� �Ѥ�', '�׽�Ʈ', '������', sysdate, 0, 111);
insert into board values(6, '�� ȫ���� �Ѥ�', '�׽�Ʈ', '������', sysdate, 0, 111);
insert into board values(7, '�� ������ �Ѥ�', '�׽�Ʈ', '������', sysdate, 0, 111);
insert into board values(8, '�� ��ȯ�� �Ѥ�', '�׽�Ʈ', '������', sysdate, 0, 111);
insert into board values(9, '�� �ֽ¿� �Ѥ�', '�׽�Ʈ', '�����', sysdate, 0, 111);
insert into board values(10, '�� �ڼ��� �Ѥ� ', '�׽�Ʈ', '�����', sysdate, 0, 111);
insert into board values(11, '�� ������', '�׽�Ʈ', '������', sysdate, 0, 111);
insert into board values(12, '��', '�׽�Ʈ', 'herryboro', sysdate, 0, 111);
insert into board values(13, '��', '�׽�Ʈ', 'herryboro', sysdate, 0, 111);


commit;





-------------------------------------------------------------------------------------
-- sql 200��

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

