
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

-- 1. ���̺��� Ư�� ��( column ) �����ϱ�
select empno, ename, sal
    from emp;
    
-- 2. ���̺��� ��� ��( column ) ����ϱ�
select * from emp;

    -- *ǥ�ø� ������� �ʾ�����
    select empno, ename, job, mgr, hiredate, sal, comm, deptno
        from emp;
    -- Ư�� �÷��� �ѹ� �� ����ؾ� �ϴ� ��� 
    select dept.*, deptno from dept;  -- *�տ� '���̺��.'�� �ٿ��ش�.
    select dept.* from dept;
    
-- 3. �÷� ��Ī�� ����Ͽ� ��µǴ� �÷��� �����ϱ�
select empno as "��� ��ȣ", ename as "��� �̸�", sal as "Salary"
    from emp;
    
    /* ""�� �ٿ��� �Ҷ� */
      -- 1.��ҹ��ڸ� �����ؾ� �Ҷ�
      -- 2.���鹮�ڸ� ����Ҷ�
          ex) select empno as ��� ��ȣ, ename as "��� �̸�", sal as "Salary"
                from emp;       -- �˸��ƽ��� "" �� ������ ����� �����߻�     
                
              select empno as "��� ��ȣ", ename as "��� �̸�", sal as "Salary"
                from emp;       -- ""�� �־� ���� ��µ�
      -- 3.Ư�����ڸ� ����Ҷ�
         ex) select empno as ���?��ȣ, ename as "��� �̸�", sal as "Salary"
                from emp;       -- ""���� ?�� ��� ����
                
             select empno as "���?��ȣ", ename as "��� �̸�", sal as "Salary"
                from emp;       -- �˸��ƽ� ���� ��µ�
    
    /* note */
        select ename, sal * (12 + 3000)
            from emp;
            
        -- ������ ����Ҷ��� as ��� ����
        select ename, sal * (12 + 3000) as ����
            from emp;
            
        -- order by���� �Բ� ����Ҷ� ����
        select ename, sal *(12 + 3000) as ����
            from emp
            order by ���� desc;
            
-- 4. ���� ������ ����ϱ�
select ename || sal
    from emp;
    
    /* ���� 4-2 */
    select ename || '�� ������ ' || sal || '�Դϴ�.' as ��������
        from emp;
        
    /* ���� 4-3 */
    select ename || '�� ������ ' || job || '�Դϴ�.' as ��������
        from emp;
        
-- 5. �ߺ��� �����͸� �����ؼ� ����ϱ�( distinct )
select distinct job
    from emp;
    
    /* unique�� ��� ��� */
    select unique job
        from emp;
        
-- 6. �����͸� �����ؼ� ����ϱ�( order by )
select ename, sal
    from emp
    order by sal asc;
    
    /* ASC: ��������, DESC: �������� */
    /* ���� 6-3 */
    select ename, deptno, sal
        from emp
        order by deptno asc, sal desc;  -- order by ������ �÷��� ������ �ۼ��� �� �ִ�.
    
    /* ���� 6-4 */
    select ename, deptno, sal
        from emp
        order by 2 asc, 3 desc; -- ���⼭ 2, 3�� select�� �÷��� ������ ����.( 2: deptno, 3: sal )

-- 7. where �� ���� �� ( ���� ������ �˻� )
select ename, sal, job
    from emp
    where sal = 3000;
    
    /* ���� 7-2 */ 
    select ename as �̸�, sal as ����
        from emp
        where sal > = 3000;     -- ������ 3000 �̻��� ������� �����͸� ���
        
-- 8. where �� ���� �� ( ���ڿ� ��¥ �˻� )
select ename, sal, job, hiredate, deptno
    from emp
    where ename = 'SCOTT';
    
    /* ����8-2 */
    select ename, hiredate
        from emp
        where hiredate = '81/11/17';    -- hiredate(�����)�� '81/11/17' �� ����� �̸��� ������� ����ϴ� ����
        
    /* ���� 8-3 */
    select * from NLS_SESSION_PARAMETERS
        where parameter = 'NLS_DATE_FORMAT';
        
-- 9. ��� ������ ���� ( *, /, +, - )
select ename, sal * 12 as ����
    from emp
    where sal * 12 >= 36000;    -- ������ 36000 �̻��� ������� �̸��� ���� ���
    
    /* ���� 9-2 */
    select ename, sal, comm, sal + comm 
        from emp
        where deptno = 10;      -- �μ���ȣ�� 10���� ������� �̸� ,����, Ŀ�̼�, ���� + Ŀ�̼��� ���
        /* 
            �� + null �� ��� => null �� ��µȴ�.
        */
        
    select ename, sal, comm, sal + nvl(comm, 0) as "sal + comm"
        from emp
        where deptno = 10;  -- nvl()�Լ��� �Ἥ comm�� null�� ��� 0���� ġȯ�ؼ� ���� ��� �Ҽ� ����.
        
-- 10. �� ������ ���� �� ( >, <, >=, <=, =, !=, <>, ^= )
select ename, sal, job, deptno
    from emp
    where sal <= 1200;      -- ������ 1200 ������ ������� �̸�, ����, �μ���ȣ ���

-- 11. �� ������ ���� �� ( between and )
select ename, sal 
    from emp
    where sal between 1000 and 3000;

select ename, sal 
    from emp
    where sal >= 1000 and sal <= 3000;
/* ��, �Ʒ� ������ ���� �ǹ�: ������ 1000 �̻� 3000 ������ ����� �̸�, ������ ��� */

    /* ���� 11-3 */ 
    select ename, sal
        from emp
        where sal not between 1000 and 3000;
    
    select ename, sal
        from emp
        where sal < 1000 or sal > 3000;
    /* ��, �Ʒ� ������ ���� �ǹ�: ������ 1000 �̻� 3000 ���ϰ� �ƴ� ����� �̸�, ������ ��� */
        
    /* ���� 11-5 */ 
    -- between ~ and �����ڸ� ����ϴ°��� �������� ����
    select ename, hiredate 
        from emp
        where hiredate between '1982/01/01' and '1982/12/31';
    
-- 12. �� ������ ���� �� ( like )
select ename, sal
    from emp
    where ename like 'S%';
/* 
    %�� ���ϵ� ī��: ��� ö�ڰ� �͵� ������� ö���� ������ �� ���� �ǵ� ������ٴ� �� 
    �� ���������� S ���� ��� ö�ڰ� �͵� ������ٴ� ��.
*/
    /* ���� 12-2 */
    select ename 
        from emp
        where ename like '_L%';     
    /*
        �ι�° ö�ڰ� M ���� ��� ö�ڰ� �͵� �������, 
        _�� ��� ö�ڰ� �͵� ��������� �ڸ����� �� �ڸ����� �ȴٶ�� �ǹ�
        �� ���������� �ǹ̴� ù��° �ڸ��� ������ ���ڸ�, �� ���� L, �� ������ ö�� ���� �������.
    */
    
    select ename 
        from emp
        where ename like '%L%';   
    -- �� ���������� �տ� % �� �پ �ڸ� ���� ������� ������ ���͵� �ȸ�, ���� ö�� ���� ���� L�� �ٴ°� �� ����Ѵ�.
    
    /* ���� 12-3 */ 
    select ename
        from emp
        where ename like '%T';   -- ���ڸ��� T�� ������� �̸� ���
    
    /* ���� 12-4 */
    select ename
        from emp
        where ename like '%A%';  -- �̸��� A�� �����ϰ� �ִ� ������� �̸� ���
        
-- 13. �� ������ ���� �� ( is NULL )
select ename, comm
    from emp
    where comm is null;     -- Ŀ�̼� comm�� null�� ����� �̸�, Ŀ�̼� ���
 
    -- null�� �Ҵ���� ���� ���̱� ������ �Ʒ��� ���� =�� ���� �� ����.
    select ename, comm
        from emp
        where comm = null;
    
-- 14. �� ������ ���� �� ( IN )
select ename, sal, job
    from emp
    where job in('SALESMAN', 'ANALYST', 'MANAGER');     -- ������ 'SALESMAN', 'ANALYST', 'MANAGER' �� ������� �̸�, ����, ���� ���
    
-- 15. �� ������ ����( AND, OR, NOT )
select ename, sal, job
    from emp
    where job = 'SALESMAN' and sal >= 1200;     -- ������ 'SALESMAN', ������ 1200�̻��� ������� �̸�, ����, ���� ���
    
-- 16. ��ҹ��� ��ȯ �Լ� ����( UPPER, LOWER, INITCAP )
select upper(ename), lower(ename), initcap(ename)
    from emp;       -- upper�Լ��� �빮�ڷ�, lower�Լ��� �ҹ��ڷ�, initcap�Լ��� ù ���ڸ� �빮�ڷ� ������ش�.
    
    /* ���� 16-2 */ 
    select ename, sal
        from emp
        where lower(ename) = 'scott';       -- �빮�ڷ� ����Ǿ� �ִ� 'SCOTT'�� lower�Լ��� ���� �ҹ��ڷ� ��ȯ�߱� ������ where ���� 'scott' �� �˻��ص� ����� �� �ִ�.
     
    select ename, sal
        from emp
        where ename = 'scott';      -- lower �Լ��� ���� ������ ���̺� ����Ǿ� �ִ� ename�� �빮���̱� ������ �˻��� ���� �ʴ´�.
        
-- 17. ���ڿ��� Ư�� ö�� �����ϱ�( substr )
select substr('SMITH', 1, 3)
    from dual;      -- ù��° ö�ڿ��� 3�� ���� ���
    
-- 18. ���ڿ��� ���̸� ����ϱ�( length )
select ename, length(ename) 
    from emp;       -- �̸�, �̸��� ���̸� ���
    
    /* ���� 18-2 */
    select length('�ȳ��ϼ���') from dual;       -- �ѱ��� ���̵� ��µȴ�.
    
    /* ���� 18-3 */
    select lengthb('�ȳ��ϼ���') from dual;       -- lengthb �� �ش� ������ ����Ʈ�� ���̸� ����Ѵ�.
    select lengthb('a') from dual;              
    select lengthb('ab') from dual;
    select lengthb('��') from dual;
    select lengthb('��') from dual;              -- �����ڴ� 1 byte, �ѱ��� 3 byte���� �� �� �ִ�.
    
-- 19. ���ڿ��� Ư�� ö���� ��ġ ����ϱ�( instr )
select instr('SMITH', 'M')
    from dual;
    
    /* ���� 19-2 */
    select instr('abcdefg@naver.com', '@')
        from dual;      -- instr�� @�� ��ġ�� ���
        
    select substr('abcdefg@naver.com', instr('abcdefg@naver.com', '@') + 1)
        from dual;      -- �ñ������� substr('abcdefg@naver.com', 9)�� �� => naver.com�� ��µȴ�.
        
-- 20. Ư�� ö�ڸ� �ٸ� ö�ڷ� �����ϱ�( replace )
select ename, replace(sal, 0, '*') as ������
    from emp;   -- replace()�Լ��� Ư�� ö�ڸ� �ٸ� ö�ڷ� �����ϴ� ���� �Լ�. �� ������ 0�� *�� �ٲ� ����Ѵ�.
    
    /* ���� 20-2 */
    select ename, regexp_replace(sal, '[0-3]', '*') as Salary
        from emp;   --  regexp_replace()�Լ��� ����ǥ���� �Լ�, �� ���������� 0~3��� ���� * �� �ٲ� ����Ѵ�.
    
    /* ���� 20-3 */   
    CREATE TABLE TEST_ENAME
    (ENAME   VARCHAR2(10));
    
    INSERT INTO TEST_ENAME VALUES('����ȣ');
    INSERT INTO TEST_ENAME VALUES('�Ȼ��');
    INSERT INTO TEST_ENAME VALUES('�ֿ���');
    COMMIT;
    
    select replace(ename, substr(ename, 2, 1), '*') as "������_�̸�"
        from test_ename;
    /* 
        substr �Լ��� 2��° ��ġ�� ���ڿ��� ����
        -> replae �Լ��� ������ ���ڿ��� '*' �� ����
    */
    
-- 21. Ư�� ö�ڸ� N�� ��ŭ ä��� ( LPAD, RPAD )
select ename, lpad(sal, 10, '*') as salary1, rpad(sal, 10, '*') as salary2
    from emp;
/*
    lpad�� sal�� ���ʺ���
    rpad�� sal�� ���ʺ��� ä���.
    ������ ����� *�� ä���.
*/
    /* ���� 21-2 */
    select ename, sal, lpad('��', round(sal / 100), '��') as bar_chart
        from emp;  
        
-- 22. Ư�� ö�� �߶󳻱�( trim, rtrim, ltrim )
select 'smith', ltrim('smith', 's'), rtrim('smith', 'h'), trim('s' from 'smith')
    from dual;
    
    /* ���� 22-2 */
    insert into emp(empno,ename,sal,job,deptno) values(8291, 'JACK  ', 3000, 'SALESMAN', 30);
    commit;
    
    select ename, sal
        from emp
        where ename = 'JACK';       -- �� INSERT ������ ename�� �������� �߱� ������, �����Ͱ� ��µ��� �ʴ´�
    
    select ename, sal
        from emp
        where rtrim(ename) = 'JACK';     -- rtrim�Լ��� �˻��ϸ� ������ �����ֱ� ������ �����Ͱ� ���� ��µȴ�.
        
-- 23. �ݿø��ؼ� ����ϱ�( round )
select '876.567' as ����, round(876.567, 1)
    from dual;  
    
    /* ���� */
    select round(876.567, 2) from dual;
    select round(876.567, -1) from dual;
    select round(876.567, -2) from dual;
    select round(876.567, 0) from dual;
    
-- 24. ���ڸ� ������ ����ϱ�( trunc )
select '876.567' as ����, trunc(876.567, 1)
    from dual;
    
     /* ���� */
     select '876.567' as ����, trunc(876.567, 2) from dual;
     select '876.567' as ����, trunc(876.567, -1) from dual;
     select '876.567' as ����, trunc(876.567, -2) from dual;
     select '876.567' as ����, trunc(876.567, 0) from dual;
     
-- 25. ���� ������ �� ����ϱ�( MOD )
select mod(10, 3) from dual;    -- �ڹٷ� ġ�� 10 % 3�� ����

    /* ���� 25-2 */
    select empno, mod(empno, 2) from emp; 
    
    /* ���� 25-3 */
    select empno, ename
        from emp
        where mod(empno, 2) = 0;    -- empno�� ¦���� ������� �̸��� ���
    
    /* ���� 25-3 */
    select floor(10 / 3) from dual;     -- 10�� 3���� ���� ����� �ּ� ������ ���

-- 26. ��¥ �� ���� �� ����ϱ�
select ename, months_between(sysdate, hiredate) from emp;   --������ ���

    /* ���� 26-2 */
    select to_date('2019-06-01', 'RRRR-MM-DD') - to_date('2018-10-01', 'RRRR-MM-DD') as �ϼ�
        from dual;      -- �ϼ� ���
    
    /* ���� 26-3 */
    select round((to_date('2019-06-01', 'RRRR-MM-DD') - to_date('2018-10-01', 'RRRR-MM-DD')) / 7 ) as "�� �ּ�"
        from dual;      -- �� ���� ���

-- 27. ���� �� ���� ��¥ ����ϱ�( add_months )
select add_months(to_date('2019-05-01', 'RRRR-MM-DD'), 100) as "date"
    from dual;      -- 2019�� 5�� 1�Ͽ� 100������ ���� ��¥�� ���
    
    /* ���� 27-2 */
    select to_date('2019-05-01', 'RRRR-MM-DD') + 100 as "date"
        from dual;      -- '2019-05-01' �� 100���� ���� ��¥�� ���
   
    /* ���� 27-3 */
    select to_date('2019-05-01', 'RRRR-MM-DD') + interval '100' month as "date"
        from dual;      -- interval �Լ��� �̿��ϸ� '30��', '31��' ����� �˾Ƽ� ���ش� ( ���� add_months�Լ��� �̿��������� ����� ����. )
    
    /* ���� 27-4 */
    select to_date('2019-05-01', 'RRRR-MM-DD') + interval '1-3' year to month as "date"
        from dual;      -- 1�� 3���� �� ��¥ ����ϴ� ����
                        -- ��ó�� year�� 1�� ~ 9��ó�� ���ڸ��� ���� �׳� interval '1' year �� ���൵ ����
        
    select to_date('2019-05-01', 'RRRR-MM-DD') + interval '10-3' year(2) to month + interval '1' day as "date"
        from dual;      -- 10�� 3���� 1�� �� ��¥ ����ϴ� ����                     
                        -- �ش� ����ó�� 10�� 100�� �̸� => interval '10' year(2), interval '100' year(3) �⵵�� �ڸ����� ǥ������� �Ѵ�.
    
    /* ���� 27-5 */
    select to_date('2019-05-01', 'RRRR-MM-DD') +interval '3' year
        from dual;      -- 3�� �� ��¥ ��� ����
    
    /* ���� 27-6 */
    select to_date('2019-05-01', 'RRRR-MM-DD') + to_yminterval('03-05') as ��¥
        from dual;      -- 3�� 5���� �� ��¥ ��� ����
                        -- to_yminterval �Լ� ���
                
-- 28. Ư�� ��¥ �ڿ� ���� ���� ��¥ ���( Next_Day )
select '2021-02-21' as ��¥, next_day('2021-02-21', '������')
    from dual;
    
    /* ���� 28-2 */
    select sysdate as "���� ��¥"
        from dual;      -- ���� ��¥ �����ִ� sysdate �Լ�
        
    /* ���� 28-3 */
    select next_day(sysdate, 'ȭ����') as "���� ��¥"
        from dual; 
    
    /* ���� 28-4 */
    select next_day(add_months('2019-05-22', 100), 'ȭ����') as "���� ��¥"
        from dual;      -- 100�� �ڿ� ���ƿ��� ȭ���� ��¥ ���
    
    /* ���� 28-5 */
    select next_day(add_months(sysdate, 100), '������') as "���� ��¥"
        from dual;      -- ���� ��¥���� 100�� �ڿ� ���ƿ��� ������ ��¥ ���
        
-- 29. Ư�� ��¥�� �ִ� ���� ������ ��¥ ����ϱ�( LAST_DAY )
select '2019/05/22' as ��¥, last_day('2019/05/22') as "������ ��¥"
    from dual;      -- 5���� 5�� 31�ϱ��� ������ �װ��� ��µ�

-- 30. ���������� ������ ���� ��ȯ�ϱ�( TO_CHAR )
select ename, to_char(hiredate, 'day') as ����, to_char(sal, '999,999') as ����
    from emp
    where ename = 'SCOTT';     
    /* 
        - scott�� �̸�, �Ի���(���Ϸ�), ���� ���
        - to_char�� ���ڿ��� �ٲ��ִ� �Լ�
            ������ => YYYY,RRRR,YY,RR
            �� => MM,MON
            �� => DD
            ���� => DAY,DY
            �� => WW,IW,W
            �ð� => HH, HH24
            �� => MI
            �� => SS
            
            to_char(sal, '999,999')���� '999,999'�� ���� �ڸ����̰� 0~9���� � ���ڰ� �͵� ������ٴ� �ǹ�, ( , )��ǥ�� õ ������ ǥ��
    */
    
    /* ���� 30-2 */
    select hiredate as ���ó�¥, 
            to_char(hiredate, 'RRRR') as ����, 
            to_char(hiredate,'MM') as ��,
            to_char(hiredate, 'DD') as ��,
            to_char(hiredate, 'day') as ����
        from emp
        where ename = 'KING';   -- king�� �Ի糯¥�� ����, ��, ��, ���� �� ǥ��
    
    /* ���� 30-3 */
    select ename, hiredate
        from emp
        where to_char(hiredate, 'rrrr') = '1981'; -- 1981�⿡ �Ի��� ������� ���
    
    /* ���� 30-4 */
    select ename as �̸�, 
            extract(year from hiredate) as ����,
            extract(month from hiredate) as ��,
            extract(day from hiredate) as ����
        from emp
        where extract(year from hiredate) = '1981';     -- extract�Լ��ε� ��� �����ϴ�.
    
    /* ���� 30-6 */
    select ename as �̸�, to_char(sal * 200, '999,999,999') as ����
        from emp;
        
    /* ���� 30-7 */
    select ename as �̸�, to_char(sal * 200, 'L999,999,999') as ����
        from emp;       -- ��ȭ�� ǥ�� �����ϴ�.
        
-- 31. ��¥������ ������ ���� ��ȯ�ϱ� (TO_DATE)
select ename, hiredate
    from emp
    where hiredate = to_date('1981/11/17', 'rr/mm/dd');
    
    /* ���� 31-2 */
    select * from nls_session_parameters where parameter = 'NLS_DATE_FORMAT';
    
    /* ���� 31-3 */
    select ename, hiredate
        from emp
        where hiredate = '1981-11-17';
    
    /* ���� 31-4 */
    alter session set nls_date_format = 'rr/mm/dd';     -- ���� ��¥ ������ DD/MM/RR �������� �ٲ��ش�.
    
    select ename, hiredate
        from emp
        where hiredate = '17/11/81';
        
    /* ���� 31-5 */
    select ename, hiredate
        from emp
        where hiredate = to_date('81/11/17', 'rr/mm/dd');   -- ���ǿ� ���Ŀ� ������� to_date �Լ��� ����Ͽ� �⵵ = rr, �� = mm,�� = dd�� �˻��� �� �ִ�. 
        
-- 32. �Ͻ��� �� ��ȯ �����ϱ�
select ename, sal
    from emp
    where sal = '3000';     
    /* 
        sal�� �����ε� ���� '3000'���ε� ��ȸ�� ���������� �Ǵ°��� �� �� �ִ�.
        ����Ŭ�� �������� �������� ���� ��� => �������� ���������� ����ȯ �Ѵ�.
    */
    
    /* ���� 32-2 */
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
    
-- 33. NULL�� ��� �ٸ� ������ ����ϱ�( NVL, NVL2 )
select ename, comm, nvl(comm, 0) from emp;      -- nvl()�Լ��� null�� ������ �ٸ� ������ ������ش�.

    /* ���� 33-2 */
    select ename, sal, comm, sal + comm
        from emp
        where job in('SALESMAN', 'ANALYST');    
    
    /*  
        NULL + SAL = NULL�� ��µ��� �� �� �ִ�.
        �̷� ��� ���� + Ŀ�̼��� ������ ��Ȯ�� �� �� ����.
        ���� ���� ó�� NVL�Լ��� ����Ͽ� ��Ȯ�� ����� �� �� �ִ�.
    */     
    
    /* ���� 33-3 */
    select ename, sal, comm, nvl(comm, 0), sal + nvl(comm, 0) as �Ѿ�
        from emp
        where job in('SALESMAN', 'ANALYST');
    
    /* ���� 33-3 */
    select ename, sal, comm, nvl2(comm, sal + comm, sal) as �Ѿ�
        from emp
        where job in('SALESMAN', 'ANALYST');   
        /*
             nvl2�Լ��� nvl2(x, y, z) �� ��� x�� ���� null �ƴ� ��� y�� ��ȯ, null�� ��� z�� ��ȯ�ϴ� �Լ��̴�.
             �� ���������� Ŀ�̼��� null�� �ƴ� ��� ����+Ŀ�̼� ���� ��ȯ�ϰ�
             null�� ��� ���޸� ��ȯ�ϵ��� �ϴ� �����̴�.
        */

-- 34. if���� sql�� �����ϱ��
select ename, deptno, decode(deptno, 10, 300, 20, 400, 0) as ���ʽ�
    from emp;   -- �μ���ȣ�� 10�̸� 300, 20�̸� 400, 10,20 ��� �ƴϸ� 0�� ���, decode�Լ��� ������ 0�� default��
    
    /* ���� 34-2 */
    select empno, mod(empno, 2), decode(mod(empno, 2), 0, '¦��', 1, 'Ȧ��') as ���ʽ�
        from emp;   
    /*
        decode�Լ��� ����Ͽ� mod(�����ȣ, 2) �� 0�̸� ¦��, 1�̸� Ȧ���� ��µǰ� ���� ����
        default ���� ���� �����ϴ�.
    */
    
    /* ���� 34-3 */
    select ename, job, decode(job, 'SALESMAN', 5000, 2000) as ���ʽ�
        from emp;   -- decode �Լ��� ����Ͽ� job�� salesman�̸� ���ʽ� 5000, �ƴϸ� 2000�� ����ϵ��� �ϴ� ����
        
-- 35. if���� sql�� �����ϱ��
select ename, job, sal, case when sal >= 3000 then 500
                             when sal >= 2000 then 300
                             when sal >= 1000 then 200
                             else 0 end as bonus
    from emp 
    where job in('SALESMAN', 'ANALYST');   
    /*
        ������ �����ϴ� then�� ���
        decode�� �ٸ���
            - decode�� ��ȣ( = )�� �� ����
            - case�� ��ȣ, �ε�ȣ �� �� �� ����
    */
    
    /* ���� 35-2 */
    select ename, job, comm, case when comm is null then 500
                                  else 0 end as bonus
        from emp
        where job in('SALESMAN', 'ANALYST');    -- Ŀ�̼��� null�̸� 500, �ƴϸ� 0�� ���
    
    /* ���� 35-3 */
    select ename, job, case when job in('SALESMAN', 'ANALYST') then 500
                            when job in('CLERK', 'MANAGER') then 400
                       else 0 end as ���ʽ�
        from emp;
        
-- 36. �ִ밪 ����ϱ�( MAX )
select max(sal) from emp;
    
    /* ���� 36-2 */
    select max(sal)
        from emp
        where job= 'SALESMAN';  -- job�� salesman�� ������ �ִ밪�� ���
    
    /* ���� 36-3 */
    select job, max(sal)
        from emp
        where job = 'SALESMAN';    
    /*
         - ������ ���� ����
            job�� �������� ��µǷ��� �ϴµ� sal�� max�Լ��� ���� 1���� ��µǹǷ� ������ �߻��Ѵ�.
    */
        
    /* ���� 36-4 */
    select job, max(sal)
        from emp
        where job = 'SALESMAN'
        group by job;       -- group by�� ���ָ� ������µȴ�.
        
    /* ���� 36-5 */
    select deptno, max(sal)
        from emp
        group by deptno;    -- �μ���ȣ �� �ִ� ������ ���
        
-- 37. �ּҰ� ����ϱ�( MIN )
select min(sal)
    from emp
    where job = 'SALESMAN';
    
     /* ���� 37-2 */
     select job, min(sal) �ּҰ�
        from emp
        group by job
        order by �ּҰ� desc;
        
     /* ���� 37-3 */
     select min(sal)
        from emp
        where 1 = 2;    -- �׷��Լ��� where ������ �����̶� ���� ����ȴ�. ( null�� ��µȴ�. )
     
     /* ���� 37-4 */
     select nvl(min(sal), 0)
        from emp
        where 1=2;
    
    /* ���� 37-5 */
    select job, min(sal) as "���޺� �ּ� �޿�"
        from emp
        where job != 'SALESMAN'
        group by job
        order by min(sal) desc;
        
-- 38. ��հ� ����ϱ� ( AVG )
select avg(comm) from emp;  -- emp���̺��� ��� comm( Ŀ�̼� ) ���
    /*
        �׷��Լ��� null���� �����Ѵ�.
        �� Ŀ���� 1400,300,0,500 �� ��հ����� ����Ѵ�.( null�� ���� ) 
    */
    
    /* ���� 38-2 */
    select round(avg(nvl(comm, 0))) from emp;
    /*
        nvl�Լ��� null���� 0���� ġȯ�ߴ�
        ��� �������� null���� �����ؼ� (��ü �ջ� / 4) �����ſ� ���� => (��ü�ջ� / 15) �� �Ǿ� ��հ��� 147�� �Ǿ���.
    */

-- 39. ��Ż�� ����ϱ� ( SUM )
select deptno, sum(sal)
    from emp
    group by deptno;    -- �μ���ȣ �� �ջ� �޿�
    
    /* ���� 39-2 */
    select job, sum(sal)    
        from emp
        group by job
        order by sum(sal) desc;     -- ���� �� �ջ� �޿��� ������������
    
    /* ���� 39-3 */
    select job, sum(sal)
        from emp       
        where sum(sal) >= 4000
        group by job;       -- where���� �׷� �Լ��� ����� ������ �ָ� �㰡���� �ʴ´ٰ� �����߻�
        
    /* ���� 39-4 */
    select job, sum(sal)
        from emp
        group by job
        having sum(sal) >= 4000
        order by sum(sal) desc;     -- having���� ����ؼ� ������ �ָ� ���� ó���ȴ�.
        
    /* ���� 39-5 */
    select job, sum(sal) as "�� ����"
        from emp
        where job != 'SALESMAN'
        group by job
        having sum(sal) >= 4000;         -- 'SALESMAN' ���� ������ ������ ���� �� �� �޿�(4000 �̻�)
        
    
    select job, sum(sal) as "�� ����"
        from emp
        group by job
        having sum(sal) >= 4000 and job != 'SALESMAN';     -- �̷��� �ص� �ǳ�?
        
-- 40. �Ǽ� ����ϱ�( COUNT )
select count(empno) from emp;   -- emp���̺� ��ü ����� ���
select count(*) from emp;       -- ���� ����� ����.
    /*
        count(empno)�� empno�÷��� ī��Ʈ, count(*) �� ��ü �÷��� ī��Ʈ
    */
    
    /* ���� 40-2 */
    select count(comm) from emp;    -- �׷��Լ��� null���� �����ϱ� ������ ��ü ������ null�� ������ 4�� ��µȴ�.

-- 41. ������ �м� �Լ��� ���� ����ϱ� �� ( RANK )
select ename, job, sal, rank() over (order by sal desc) ����
    from emp
    where job in('ANALYST', 'MANAGER');     -- ���� ���� ǥ��( 'ANALYST', 'MANAGER'�� )
                                            -- rank() over(): over ��ȣ �ȿ� ����ϰ� ���� ������ ������ �����Ϳ� ���� ���� ���
                                            -- �ߺ��� ������ ���� ������ ǥ�õȴ�( ex)���� 1���� ������ ���� ������ 3�� )
    
    /* ���� 41-2 */
    select ename, sal, job, rank() over(partition by job order by sal desc) as ����
        from emp;       -- partition by job => �������� ��� ���� �ο�

-- 42. ������ �м� �Լ��� ���� ����ϱ� �� ( DENSE RANK )
select ename, job, sal, rank() over(order by sal desc) as rank, dense_rank() over(order by sal desc) as dense_rank
    from emp
    where job in('ANALYST', 'MANAGER');     -- rank() over() �Լ��� dense_rank() over() �Լ��� ���̸� ��
    
    /* ���� 42-2 */
    select job, ename, sal, dense_rank() over(partition by job order by sal desc) ����
        from emp
        where hiredate between to_date('1981/01/01', 'rrrr/mm/dd') and
                               to_date('1981/12/31', 'rrrr/mm/dd'); 
    /* 
        1981�⿡ �Ի��� ������� ����, �̸�, �޿��� �������� ���� �ӱ� ������ ǥ��. 
    */
    
    /* ���� 42-3 */
    select dense_rank(2975) within group(order by sal desc) ����
        from emp;   -- �޿��� 2975�� ����� ���� ������ ���
                    -- dense_rank��ȣ ���� �����Ͱ� ������ ��ü���� ������ ��� �Ǵ��� ���
                    -- within group�� ��� �׷� ������ ������ ��� �Ǵ��� ���
                
     /* ���� 42-4 */
     select dense_rank('81-11-17') within group(order by hiredate asc) ���� from emp;
        -- �Ի����� 1981�� 11�� 17���� ����� ��ü ����� �� ��°�� �Ի��ߴ��� ������ ǥ��
        
-- 43. ������ �м� �Լ��� ��� ����ϱ�( NTILE )
select ename, job, sal, ntile(4) over (order by sal desc nulls last) ���
    from emp
    where job in('ANALYST', 'MANAGER', 'CLERK');    -- ������ ���� ������� 4����Ͽ� ��� ǥ��.
                                                    -- nulls last�� null�� ������ null�� �� �Ʒ��� ����ϰڴٴ� �ǹ�
                                                    
    /* ���� 43-2 */
    select ename, comm 
        from emp
        where deptno = 30
        order by comm desc;
        
    select ename, comm 
        from emp
        where deptno = 30
        order by comm desc nulls last;      -- nulls last�� �ְ� ������ ����
        
-- 44. ������ �м� �Լ��� ������ ���� ����ϱ� ( CUME_DIST )
select ename, sal, rank() over(order by sal desc) as rank,
        dense_rank() over(order by sal desc) as dense_rank,
        cume_dist() over(order by sal desc) as cum_dist
    from emp;
    
    /* ���� 44-2 */ 
    select job, ename, sal, rank() over(partition by job order by sal desc) as rank,
                                   cume_dist() over(partition by job order by sal desc) as cum_dist
        from emp;
        
-- 45. ������ �м� �Լ��� �����͸� ���η� ����ϱ�( LISTAGG )
select deptno, listagg(ename, ' , ') within group(order by ename) as employee
    from emp
    group by deptno;        -- listagg() �Լ��� �����͸� ���η� ����ϴ� �Լ�
                            -- order by ename�� employee �÷��� a,b,c ... ó�� ���ĺ� ������� ��µǰԱ� �Ѵ�.
                    
    /* ����45-2 */
    select job, listagg(ename, ',') within group(order by ename) as employee
        from emp
        group by job;   -- ������ �� ������ ���� ������� �̸��� ���
        
    /* ����45-3 */
    select job,
           listagg(ename || '(' || sal || ')', ',') within group (order by ename) as employee
        from emp
        group by job;   -- �� ������ + �̸� ���� �޿��� ���
        
-- 46. ������ �м� �Լ��� �ٷ� �� ��� ���� �� ����ϱ�( LAG, LEAD )
select empno, ename, sal, lag(sal, 1) over(order by sal asc) "�� ��",
                          lead(sal, 1) over(order by sal asc) "���� ��"
    from emp
    where job in('ANALYST', 'MANAGER');     -- leg()�Լ��� �ٷ� �� ��, lead()�Լ��� ���� ���� �����͸� ���
                                            -- lag(), lead() �Լ��� �� �ι�° �Ű����� �ڸ��� �� ��° ��, ���� �����͸� ������� ����
                                            
    /* ���� 46-2 */
    select empno, ename, hiredate, lag(hiredate, 1) over(order by hiredate asc) "�� ��",
                                   lead(hiredate, 1) over(order by hiredate asc) "���� ��"
        from emp
        where job in('ANALYST', 'MANAGER');     -- ������ 'ANALYST', 'MANAGER' �� ����� �� �����ȣ, �̸�, �Ի���, 
                                                -- �ٷ� ���� �Ի��� ����� �Ի���, �ٷ� ������ �Ի��� ����� �Ի�����
                                                
    /* ���� 46-3 */
    select deptno, empno, ename, hiredate, lag(hiredate, 1) over(partition by deptno order by hiredate asc) "�� ��",
                                           lead(hiredate, 1) over(partition by deptno order by hiredate asc) "���� ��"
        from emp;      -- deptno�� �������� partition���� ��, ���� �׷��� �������� �ٷ� ���� �Ի��� ����� �Ի���, �ٷ� ������ �Ի��� ����� �Ի����� ���
        
-- 47. COLUMN�� ROW�� ����ϱ�� ( SUM + DECODE )
select sum(decode(deptno, 10, sal)) as "10",
       sum(decode(deptno, 20, sal)) as "20",
       sum(decode(deptno, 30, sal)) as "30"       
    from emp;   -- �μ���ȣ�� �� �޿�
    
    /* ���� 47-2 */
    select deptno, decode(deptno, 10, sal) as "10"
        from emp;   -- �μ���ȣ�� 10�̸� �μ���ȣ�� �޿��� ���( �μ���ȣ�� 10�� �ƴϸ� �޿��� null ��� )
        
    /* ���� 47-5 */
    select sum(decode(job, 'ANALYST', sal)) as "ANALYST",
           sum(decode(job, 'CLERK', sal)) as "CLERK",
           sum(decode(job, 'MANAGER', sal)) as "MANAGER",
           sum(decode(job, 'SALESMAN', sal)) as "SALESMAN"
        from emp;   -- ������ ��Ż �޿��� ���
        
    /* ���� 47-6 */
    select deptno, sum(decode(job, 'ANALYST', sal)) as "ANALYST",
           sum(decode(job, 'CLERK', sal)) as "CLERK",
           sum(decode(job, 'MANAGER', sal)) as "MANAGER",
           sum(decode(job, 'SALESMAN', sal)) as "SALESMAN"
        from emp
        group by deptno;    -- �� �������� deptno�� �߰�
        
-- 48. COLUMN�� ROW�� ����ϱ�� ( PIVOT )
select * from (select deptno, sal from emp)
         pivot(sum(sal) for deptno in (10, 20, 30));    -- �μ��� �� �޿� ( 47���� sum + decode�� ����� ����� ���� ), pivot()�Լ��� ǥ��
         
    /* ���� 48-2 */
    select * from(select job, sal from emp)
             pivot(sum(sal) for job in('ANALYST', 'CLERK', 'MANAGER', 'SALESMAN'));
    
     /* ���� 48-3 */
    select * from(select job, sal from emp)
             pivot(sum(sal) for job in('ANALYST' as "ANALYST", 'CLERK' as "CLERK", 'MANAGER' as "MANAGER", 'SALESMAN' as "SALESMAN"));
             
-- 49. ROW�� COLUMN���� ����ϱ� ( UNPIVOT )
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
         unpivot(�Ǽ� for ������ in(BICYCLE, CAMERA, NOTEBOOK));
         
    /* ���� 49-2 */ 
    select * from order2
         unpivot(�Ǽ� for ������ in(BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));
         
    update order2 set NOTEBOOK = null where ename = 'SMITH';    -- null�� ���ԵǾ������� unpivot ����� ���Ե��� �ʴ´�.
                                                                -- smith�� notebook�� null�� update �� �� �ٽ� unpivot �غ��� smith�� ��Ʈ���� ��µ��� �ʴ°��� Ȯ���� �� �ִ�.
                                                                
    /* ���� 49-3 */
    select * from order2
         unpivot include nulls(�Ǽ� for ������ in(BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));
    -- unpivot include nulls�� �ϸ� null���� unpivot �Ҷ� ���� ��µ��� Ȯ���� �� �ִ�.

-- 50. ������ �м� �Լ��� ���� ������ ����ϱ�( SUM OVER )
select empno, ename, job, sal, sum(sal) over(order by empno rows between unbounded preceding and current row) ����ġ
    from emp
    where job in('ANALYST', 'MANAGER');     -- ������ analyst, manager�� ������� �����ȣ, ��å, �̸�, �޿�, �޿��� ����ġ�� ���
    
-- 51. ������ �м� �Լ��� ���� ����ϱ�( RATIO_TO_REPORT )
select empno, deptno, ename, sal, ratio_to_report(sal) over() as ����
    from emp
    where deptno = 20;      -- �μ���ȣ�� 20���� ������� �����ȣ, �μ���ȣ, �̸�, �޿�, 20�� �μ� �������� �޿� ������ ���

select sum(sal) as �հ�
    from emp
    where deptno = 20;      -- �μ���ȣ 20���� �� �޿�
    
-- 52. ������ �м� �Լ��� ���� ��� ����ϱ��( ROLLUP )
select job, sum(sal)
    from emp
    group by rollup(job);   -- ���޺� ��Ż �޿� ��� �� �� �Ʒ��ʿ� ��ü �޿��� �߰�
                            -- rollup�� ����ϸ� �� �Ʒ� ��Ż �޿��� ��µǰ� job �÷��� �����͵� ������������ ���ĵǾ� ���
                
    /* ���� 52-2 */
    select deptno, job, sum(sal)
        from emp
        group by rollup(deptno, job);
        
-- 53. ������ �м� �Լ��� ���� ��� ����ϱ�� ( CUBE )
select job, sum(sal) 
    from emp
    group by cube(job);     
    
select deptno, sum(sal) 
    from emp
    group by cube(deptno);      -- cube�� ����ϸ� �� ���ʿ� ��Ż �޿��� �߰�, �μ� ��ȣ�� ������������ ����
    
    /* ���� 53-2 */
    select deptno, job, sum(sal) 
        from emp
        group by cube(deptno, job);     -- group by rollup�� ���ؼ� => job ��Ż�� ���� ���谡 �߰���
        
-- 54. ������ �м� �Լ��� ���� ��� ����ϱ� �� ( GROUPING SETS )
select deptno, job, sum(sal) 
    from emp
    group by grouping sets((deptno), (job), ());    -- �μ���ȣ��, ������, ��ü ����
                                                    -- group by rollup ���� ����� �����ϱ� �� ����.
                                                    
-- 55. ������ �м� �Լ��� ��� ��� �ѹ��� �ϱ�(ROW_NUMBER)
select empno, ename, sal, rank() over(order by sal desc) rank,
                          dense_rank() over(order by sal desc) dense_rank,
                          row_number() over(order by sal desc) ��ȣ
    from emp
    where deptno = 20;
    
    /* ���� 55-3 */
    select deptno, ename, sal, row_number() over(partition by deptno order by sal desc) ��ȣ
        from emp
        where deptno in(10, 20);
        
-- 56. ��µǴ� �� �����ϱ� �� (ROWNUM)
select rownum, empno, ename, job, sal
    from emp
    where rownum <= 5;
    
-- 57. ��µǴ� �� �����ϱ� �� ( Simple TOP-n Queries )
select empno, ename, job, sal
    from emp
    order by sal desc 
    FETCH FIRST 4 ROWS ONLY;        -- 11g������ �ȵ� -.-;
    
-- 58. ���� ���̺��� �����͸� �����ؼ� ����ϱ� �� ( EQUI JOIN )
select ename, loc
    from emp, dept
    where emp.deptno = dept.deptno;
    
    /* ���� 58-4 */
    select ename, loc, job 
        from emp,dept
        where emp.deptno = dept.deptno and emp.job = 'ANALYST';
    
    /* ���� 58-5 */
    select ename, loc, job, deptno
        from emp, dept
        where emp.deptno = dept.deptno and emp.job = 'ANALYST';
        
    /* ���� 58-6 */
    select ename, loc, job, emp.deptno
        from emp, dept
        where emp.deptno = dept.deptno and emp.job = 'ANALYST';

    /* ���� 58-7 */
    select emp.ename, dept.loc, emp.job, emp.deptno
        from emp, dept
        where emp.deptno = dept.deptno and emp.job = 'ANALYST';    -- ���� ����
    
    /* ���� 58-8 */
    select e.ename, d.loc, e.job, e.deptno
        from emp e, dept d
        where e.deptno = d.deptno and e.job = 'ANALYST';    -- �˸��ƽ��� �ٿ��� �� �ִ�.
        
-- 59. ���� ���̺��� �����͸� �����ؼ� ����ϱ� ��( NON-EQUI JOIN )
select e.ename, e.sal, s.grade
    from emp e, salgrade s 
    where e.sal between s.losal and s.hisal;

-- 60. ���� ���̺��� �����͸� �����ؼ� ����ϱ� ��( OUTER JOIN )
select e.ename, d.loc
    from emp e, dept d
    where e.deptno(+) = d.deptno;
    
-- 61. ���� ���̺��� �����͸� �����ؼ� ����ϱ� ��( SELF JOIN )
select e.ename as ����̸�,e.empno as �����ȣ, e.job as �μ�, m.ename as ������, m.empno as �����ȣ, m.job as �μ�
    from emp e, emp m
    where e.mgr = m.empno and e.job = 'SALESMAN';
    
-- 62. ���� ���̺��� �����͸� �����ؼ� ����ϱ� ��( ON�� )
select e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    from emp e join dept d
    on (e.deptno = d.deptno)
    where e.job = 'SALESMAN';
    
-- 63. ���� ���̺��� �����͸� �����ؼ� ����ϱ� ��( USING�� )
select e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    from emp e join dept d
    using (deptno)  -- �˸��ƽ� ���� ��������. �÷��� ��ü�� �Է��ؾ� �ȴ�.
    where e.job = 'SALESMAN';
    
-- 64. ���� ���̺��� �����͸� �����ؼ� ����ϱ� ��( NATURAL JOIN )
select e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    from emp e natural join dept d
    where e.job = 'SALESMAN';
    
-- 65. ���� ���̺��� �����͸� �����ؼ� ����ϱ� ��( LEFT/RIGHT OUTER JOIN )
select e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    from emp e right outer join dept d
    on (e.deptno = d.deptno);
    
    -- left outerjoin�� ���� �����۾�
    insert into emp(empno, ename, sal , job, deptno) values(8282, 'JACK', 3000, 'ANALYST', 50);

select e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� ��ġ"
    from emp e left outer join dept d
    on (e.deptno = d.deptno);
    
-- 66. ���� ���̺��� �����͸� �����ؼ� ����ϱ� ��( FULL OUTER JOIN )
select e.ename as �̸�, e.job as ����, e.sal as ����, d.loc as "�μ� �̸�"
    from emp e full outer join dept d
    on(e.deptno = d.deptno);
    
-- 67. ���� �����ڷ� �����͸� ���Ʒ��� �����ϱ� ��( UNION ALL )
select deptno, sum(sal) as �հ�
    from emp
    group by deptno
union all
select to_number(null) as deptno, sum(sal)
    from emp
    order by �հ� asc;    -- order by�� sum(sal) �÷����� ���ָ� ���� �߻� => Ȯ�� ���
    
    
    

    
    
    
    


    
    


    

    




    
    
   
    

        
                                                    
                                                    
                                    
                    

        
    
        
    
    





