-- day13

--------------------------------------------------------
-- 오라클의 특별한 컬럼 2가지
-- : 사용자가 만든 적 없어도 자동으로 제동되는 컬럼

-- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값
--            물리적 위치이므로 한 행당 반드시 유일한 값일 수 밖에 없음.
--            ORDER BY 절에 의해 변경되지 않는 값

-- 2. ROWNUM : 조회된 결과의 첫번째 행부터 1로 증가하는 값
----------------------------------------------------------

-- 예) emp 테이블의 'SMITH' 를 조회
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
-- ROWID 를 같이 조회
SELECT e.rowid
     , e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
--ROWID,                EMPNO,  ENAME
--AAAR9ZAAHAAAACWAAA	7369	SMITH


-- ROWNUM
SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
--ROWNUM,   EMPNO,  ENAME
-- 1	    7369	SMITH

--------------------------------
-- ORDER BY 절에 의해 ROWNUM 이 변경되는 결과 확인
-- (1) ORDER BY 가 없을 떄의 ROWNUM
SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
;
/*
ROWNUM, EMPNO, ENAME
1	7777	JJ
2	8888	J_JAMES
3	7369	SMITH
4	7499	ALLEN
5	7521	WARD
6	7566	JONES
7	7654	MARTIN
8	7698	BLAKE
9	7782	CLARK
10	7839	KING
11	7844	TURNER
12	7900	JAMES
13	7902	FORD
14	7934	MILLER
*/
-- (2) ename 순으로 오름차순 정렬 후 ROWNUM 값 확인
SELECT rownum
     , e.empno
     , e.ename
  FROM emp e
 ORDER BY e.ename
;
/*
ROWNUM, EMPNO, ENAME
4	7499	ALLEN
8	7698	BLAKE
9	7782	CLARK
13	7902	FORD
12	7900	JAMES
1	7777	JJ
6	7566	JONES
2	8888	J_JAMES
10	7839	KING
7	7654	MARTIN
14	7934	MILLER
3	7369	SMITH
11	7844	TURNER
5	7521	WARD
*/
-- ==> ROWNUM이 ORDER BY 결과에 영향을 받지 않는 것처럼 보일 수 있음.
--     SUB_QUERY 로 사용할 때 영향을 받음.

-- (3) SUB_QUERY 를 썼을 때 ROWNUM 의 값 확인
SELECT rownum
     , a.empno
     , a.ename
     , a.numrow
  FROM (SELECT rownum as numrow
             , e.empno
             , e.ename
          FROM emp e
        ORDER BY e.ename) a
;
/*
ROWNUM, EMPNO, ENAME, NUMROW
---------------------------
1	7499	ALLEN	4
2	7698	BLAKE	8
3	7782	CLARK	9
4	7902	FORD	13
5	7900	JAMES	12
6	7777	JJ	    1
7	7566	JONES	6
8	8888	J_JAMES	2
9	7839	KING	10
10	7654	MARTIN	7
11	7934	MILLER	14
12	7369	SMITH	3
13	7844	TURNER	11
14	7521	WARD	5
*/

-- 이름에 A가 들어가는 사람들을 조회 (ORDER BY 없이)
SELECT rownum
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
;
/*
1	J_JAMES
2	ALLEN
3	WARD
4	MARTIN
5	BLAKE
6	CLARK
7	JAMES
*/

-- 이름에 A가 들어가는 사람을 이름순으로 정렬하여 조회
SELECT rownum
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
 ORDER BY e.ename
;
/*
2	ALLEN
5	BLAKE
6	CLARK
7	JAMES
1	J_JAMES
4	MARTIN
3	WARD
*/

-- 이름에 S가 들어가는 사람들을 조회
-- 이때, ROWNUM, ROWID를 확인
SELECT rownum
     , e.rowid
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%S%'
 ORDER BY e.ename
;
/*
4	AAAR9ZAAHAAAACWAAJ	JAMES
3	AAAR9ZAAHAAAACWAAD	JONES
1	AAAR9ZAAHAAAACTAAB	J_JAMES
2	AAAR9ZAAHAAAACWAAA	SMITH
*/
-- 이름에 S가 들어가는 사람들의 조회 결과를
-- SUB_QUERY 로 감쌌을 떄의 ROWNUM, ROWID 확인
SELECT ROWNUM
     , a.rowid
     , a.ename
  FROM(SELECT e.rowid
            , e.ename
         FROM emp e
        WHERE e.ename LIKE '%S%'
        ORDER BY e.ename) a
;
/*
ROWNUM, ROWID,          ENAME
-------------------------
1	AAAR9ZAAHAAAACWAAJ	JAMES
2	AAAR9ZAAHAAAACWAAD	JONES
3	AAAR9ZAAHAAAACTAAB	J_JAMES
4	AAAR9ZAAHAAAACWAAA	SMITH
*/



-----------------------------------------------
-- DML : 데이터 조작어
-----------------------------------------------
-- 1) INSERT : 테이블에 데이터 행(row)을 추가하는 명령

-- MEMBER 테이블에 데이터 추가 진행
DROP TABLE member;
CREATE TABLE member
 (  member_id    VARCHAR2(4)    
  , member_name  VARCHAR2(15)    NOT NULL
  , phone        VARCHAR2(4)     
  , reg_date     DATE            DEFAULT sysdate
  , dadress      VARCHAR2(30)
  , major        VARCHAR2(50)
  , birth_month  NUMBER(2)
  , gender       VARCHAR2(1)     
  , CONSTRAINT pk_member            PRIMARY KEY (member_id)
  , CONSTRAINT ck_member_gender     CHECK       (gender IN ('M', 'F'))
  , CONSTRAINT CK_BRITH             CHECK       (birth_month BETWEEN 1 AND 12)
 );

-- 1. INTO 구문에 컬럼이름 생략시 데이터 추가
--   : VALUES 절에 반드시 전체 컬럼의 데이터를 순서대로 모두 나열


INSERT INTO MEMBER 
VALUES ('M001', '박성협', '9155', sysdate, '수원시', '행정', 3, 'M')
;
INSERT INTO MEMBER
VALUES ('M002', '오진오', '1418', sysdate, '군포시', NULL, NULL, 'M')
;
INSERT INTO MEMBER 
VALUES ('M003', '이병현', '0186', sysdate, 'NULL', NULL, 3, 'M')
;
INSERT INTO MEMBER 
VALUES ('M004', '김문정', NULL, sysdate, '청주시', '일어', 3, 'F')
;
INSERT INTO MEMBER 
VALUES ('M005', '송지환', '0322', sysdate, '안양시', '제약', 3, NULL)
;
COMMIT;
/*
1 행 이(가) 삽입되었습니다.
1 행 이(가) 삽입되었습니다.
1 행 이(가) 삽입되었습니다.
1 행 이(가) 삽입되었습니다.
1 행 이(가) 삽입되었습니다.
커밋 완료.
*/
/*
INSERT INTO MEMBER
VALUES ('M002', '오진오', '1418', sysdate, '군포시', 'M');
 위처럼 VALUES 절에 나열된 값의 개수가 전체 컬럼 수와 일치하지 않으면 
 아래와 같은 오류가 발생하므로, NULL 입력을 해서라도
 값의 개수를 맞추어야 한다.
SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다
00947. 00000 -  "not enough values"
*/

-- PK 제약조건에 위배되는 데이터 추가 시도 : M005 이미 존재
INSERT INTO MEMBER 
VALUES ('M005', '홍길동', '0001', sysdate, '율도국', '도술', 3, NULL)
;
--ORA-00001: 무결성 제약 조건(SCOTT.PK_MEMBER)에 위배됩니다

-- GENDER 컬럼에 CHECK 제약조건을 위배하는 데이터 추가 시도
-- GENDER 컬럼에, 'F', 'M', NULL 외의 값을 추가하면
INSERT INTO MEMBER 
VALUES ('M006', '홍길동', '0001', sysdate, '율도국', '도술', 3, 'G')
;
--ORA-02290: 체크 제약조건(SCOTT.CK_MEMBER_GENDER)이 위배되었습니다

-- BIRTH_MONTH 컬럼에 1 ~ 12 외의 숫자값 입력 시도
INSERT INTO MEMBER 
VALUES ('M006', '홍길동', '0001', sysdate, '율도국', '도술', 13, 'M')
;
--ORA-02290: 체크 제약조건(SCOTT.CK_BRITH)이 위배되었습니다

-- MEMBER_NAME 에 NULL 입력 시도
INSERT INTO MEMBER 
VALUES ('M007', NULL, '0001', sysdate, '율도국', '도술', 6, 'M')
;
--ORA-01400: NULL을 ("SCOTT"."MEMBER"."MEMBER_NAME") 안에 삽입할 수 없습니다

INSERT INTO MEMBER 
VALUES ('M006', '홍길동', '0001', sysdate, '율도국', '도술', 5, 'M')
;
COMMIT;

--- 2. INTO 절에 컬럼 이름을 명시한 경우의 데이터 추가
--     : VALUES 절에 INTO 의 순서대로
--       값의 타입, 갯구를 맞추어서 작성
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007', '김지원')
;
COMMIT;
/*
1 행 이(가) 삽입되었습니다.
커밋 완료.
*/
INSERT INTO MEMBER (member_id, member_name, gender)
VALUES ('M008', '김지우', 'M');
COMMIT;
/*
1 행 이(가) 삽입되었습니다.
커밋 완료.

: 결과로 member_id, member_name, reg_date, gender
  컬럼들에 값이 들어간 것 확인
*/

-- 테이블 정의 순서와 상관없이 INTO 절에 컬럼을 나열할 수 있다.
INSERT INTO MEMBER (birth_month, member_name, member_id)
VALUES (7, '유현동', 'M009');
COMMIT;
/*
1 행 이(가) 삽입되었습니다.
커밋 완료.
*/

-- INTO절의 컬럼 갯수와 VALUES 절의 값의 개수 불일치
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M010', '허균', 'M');
/*
SQL 오류: ORA-00913: 값의 수가 너무 많습니다
00913. 00000 -  "too many values"
*/
INSERT INTO MEMBER (member_id, member_name, gender)
VALUES ('M010', '허균');
/*
SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다
00947. 00000 -  "not enough values"
*/

-- INTO 절과 VALUES 절의 갯수는 같으나
-- 값의 타입이 일치하지 않을 때
INSERT INTO MEMBER (member_id, member_name, birth_month)
VALUES ('M010', '허균', '한양');
/*
오류 보고 -
ORA-01722: 수치가 부적합합니다
*/

-- 필수 입력 컬럼을 나열하지 않을 때
-- member_id : PK, member_name : NOT NULL
INSERT INTO MEMBER (birth_month, dadress, gender)
VALUES (12, '서귀포시', 'F')
;
--ORA-01400:
--NULL을 ("SCOTT"."MEMBER"."MEMBER_ID") 안에 삽입할 수 없습니다

-------------------------------------------
-- 다중 행 입력 : SUB_QUERY 를 사용하여 가능

-- 구문구조
INSERT INTO 테이블이름
SELECT 문장; -- 서브쿼리

/*
CREATE TABLE 테이블이름
AS
SELECT
;

 : 서브쿼리의 데이터를 복사하며서 새 테이블을 생성
 
 vs
INSERT INTO 테이블이름
SELECT 문장; -- 서브쿼리
 : 이미 만들어진 테이블에 데이터만 복사해서 추가
 
*/

--new_member 삭제
DROP TABLE new_member;

-- memeber 복사해서 테이블 생성
CREATE TABLE new_member
AS
SELECT m.*
  FROM member m
 WHERE 1=2
;
--Table NEW_MEMBER이(가) 생성되었습니다.


-- 다중 행 입력 서브쿼리로 new_member 테이블에 데이터 입력
-- 이름 가운데 글자가 '지'인 사람들의 정보를 추가
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.member_name LIKE '_지_'
;
--3개 행 이(가) 삽입되었습니다.

-- 컬럼을 명시한 다중행 입력
INSERT INTO new_member
SELECT m.member_id
     , m.member_name
     , m.phone
  FROM member m
 WHERE m.member
;

-- new_member 에 추가된 행 모두 삭제
DELETE new_member;
COMMIT;

--맴버들의 출생 월 데이터 수정
UPDATE "SCOTT"."MEMBER"
  SET BIRTH_MONTH = '1'
 WHERE MEMBER_ID = 'M002'
;
UPDATE "SCOTT"."MEMBER"
  SET BIRTH_MONTH = '3'
 WHERE MEMBER_ID = 'M032'
;
UPDATE "SCOTT"."MEMBER"
  SET BIRTH_MONTH = '1'
 WHERE MEMBER_ID = 'M008'
;
COMMIT;

-------

-- 문제) new_member 테이블에
--      member 테이블로부터 데이터를 복사하여 다중행 입력을 하시오
--      단, member 테이블의 데이터에서 birth_month 가
--      홀수달인 사람들만 조회하여 입력하시오
DROP TABLE new_member;
INSERT INTO TABLE new_member
SELECT m.*
  FROM member m
 WHERE MOD(m.birth_month, 2) = 1
;

-------------------------

-- 2) UPDATE : 테이블의 행(레코드)을 수정
--            WHERE 조건절의 조합에 따라서
--            1행만 수정하거나 다중 행 수정이 가능
--            다중 행이 수정되는 경우는 매우 주의가 필요!!

-- UPDATE 구문 구조
UPDATE 테이블이름
   SET 컬럼1 = 값1
     [,컬럼2 = 값2
     [,컬럼3 = 값3]
     ...
     [,컬럼n = 값n]
 [WHERE 조건]
;

-- 예) 홍길동의 이름을 수정시도
UPDATE member m -- 테이블 별칭
   SET m.member_name = '길동이'
 WHERE m.member_id = 'M006' -- PK로 찾아야 정확히 홍길동 행을 찾아갈 수 있음
;
COMMIT;
/*
1 행 이(가) 업데이트되었습니다.
커밋 완료.
*/

-- 예)
-- 김문정 맴버의 전화번호 뒷자리 업데이트
-- 초기에 INSERT 시 NULL 로 데이터로 받지 않은 경우
-- 후에 데이터 수정이 발생할 수 있다.
-- 이런 경우 UPDATE 구문으로 처리.
UPDATE member m
   SET m.phone = '1392'
 WHERE m.member_id = 'M004'
;
COMMIT;
/*
1 행 이(가) 업데이트되었습니다.
커밋 완료.
*/

-- 예) 유현동(M007) 멤버의 전공을 수정
-- 역문컨
UPDATE member m
   SET m.major = '역문컨'
-- WHERE m.member_id = 'M009' -- 실수로 WHERE 누락
;

/*
9개 행 이(가) 업데이트되었습니다.
 : WHERE 조건절 누락때문에 모든 행에 대해서
   major 컬럼이 모두 서정이 일어난 결과
   
   ==> DML 작업 실수,
       주의점 : 그러나 UPDATE 구문 오류는 아니라는 점.
*/

-- 직전 COMMIT 작업 까지 되돌리는 ROLLBACK 명령으로 잘못된 업데이트 되돌리기
ROLLBACK;
-- 롤백 완료.
-- M004 멤버의 전화번호를 업데이트 한 것이 마지막 커밋이므로 그 상태의 데이터로 복원

UPDATE member m
   SET m.major = '역문컨'
 WHERE m.member_id = 'M009'
;

--1 행 이(가) 업데이트되었습니다.
COMMIT;
--커밋 완료.


-- 다중 컬럼 업네이트(2개 이상의 컬럼 한번에 업데이트)
-- 예) 김지우(M008) 멤버의 전화번호, 주소, 전공을 한번에 업데이트
-- SET 절에 업데이트 할 컬럼과 값을 나열
UPDATE member m
   SET m.phone = '4119'
     , m.dadress = '아산'
     , m.major = '일어'
 WHERE m.member_id = 'M008'
;
--1 행 이(가) 업데이트되었습니다.
COMMIT;
--커밋 완료.

-- 예'안양시'에 사는 '송지환' 멤버의 GENDER 값을 수정
--  WHERE 조건에 주소를 비교하는 구문을 쓰는 경우
UPDATE member m
   SET m.gender = 'M'
 WHERE m.dadress = '안양시'
;
-- WHERE 조건절 누락(x), WHERE 조건절 문법 오류(x)
--1 행 이(가) 업데이트되었습니다.
ROLLBACK;
--롤백 완료.
-- 위의 실행결과는 얼핏 정상작동한 것 처럼 보이지만
-- 데이터가 다양해지면 오작동의 여지가 있는 구문이다.
-- 따라서 UPDATE 작성시에는 WHERE 조건절 작성시
-- 주의를 기울여야 함.

-- 1행을 수정하는 목정이라면 반드시 PK 컬럼을 비교해야 한다.
-- PK 컬럼은 전체 행애서 유일하고 NOT NULL 이 보장되는 컬럼이므로
-- 반드시 그 행을 찾을 수 있는 값이기 때문에, PK 사용이 권장됨.

-- UPDATE 구문에 SELECT 서브쿼리를 사용
-- 예) 김지우(M008) 멤버의 major 를
--     오진오(M002) 멤버의 major 로 수정
-- 1) M008 의 major 를 구하는 SELECT
SELECT m.major
  FROM member m
 WHERE m.member_id = 'M008'
;
--2) M002 맴버의 major 를 수정하는 UPDATE 구문 작성
UPDATE member m
   SET m.major = ?
 WHERE m.member_id = 'M002'
;
--3) 1)의 결과를 (2) UPDATE 구문에 적용
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m
                   WHERE m.member_id = 'M008')
 WHERE m.member_id = 'M002'
;
COMMIT;
--커밋 완료.

-- 만약 SET 절에 사용하는 서브쿼리의 결과가
-- 정황하게 1행 1열의 1개의 값이 아닌경우 구문 오류
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m)
 WHERE m.member_id = 'M002'
;
/*
오류 보고 -
ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
*/
UPDATE member m
   SET m.major = (SELECT m.member_id
                       , m.major
                    FROM member m
                   WHERE m.member_id = 'M008')
 WHERE m.member_id = 'M002'
;
-- SQL 오류: ORA-00913: 값의 수가 너무 많습니다

-- UPDATE 시 제약조건 위반하는 경우
-- 예) M001 의 member_id 수정을 시도
--      : PK 컬럼 수정을 시도하는 경우
UPDATE member m
   SET m.member_id = 'M002'
 WHERE m.member_id = 'M001'
 ;
 --ORA-00001: 무결성 제약 조건(SCOTT.PK_MEMBER)에 위배됩니다
 
 --예) NOT NULL 인 member_name 에 NULL 데이터로
 --     업데이트를 시도하는 경우
 UPDATE member m
    SET m.member_name = NULL
 WHERE m.member_id = 'M001'
 ;
 --ORA-01407: NULL로 ("SCOTT"."MEMBER"."MEMBER_NAME")을 업데이트할 수 없습니다
 
 -- 예) M001 데이터에 대해서 
 --     brith_month 를 -1로 수정시도
 UPDATE member m
    SET m.birth_month = -1
  WHERE m.member_id = 'M001'
;
--ORA-02290: 체크 제약조건(SCOTT.CK_BRITH)이 위배되었습니다

-----------------------------------------------------
-- 수업중 실습

-- 1) PHONE 컬럼이 NULL 인 사람들 일괄적으로 '0000'으로 업데이트 하시오 (PK로 걸 필요없는 구문)
UPDATE member m
   SET m.phone = 
;
-- 2) M001 멤버의 전공을 NULL값으로 업데이트
UPDATE member m
   SET m.major = NULL
 WHERE m.member_id = 'M001'
;
-- 3)ADDRESS 컬럼이 NULL 인 사람 일괄적으로 '아산시'로 업데이트 (PK로 걸필요 없는 구문)
UPDATE member m
   SET m.dadress = '아산시'
 WHERE m.dadress = NULL
;
-- 4) M009 멤버의 NULL 데이터를 모두 업데이트
 --  PHONE : 3581   ADDESS : 천안시    GENDER : M
UPDATE member m
   SET m.phone = 3581
     , m.dadress = '천안시'
     , m.gender = 'M'
 WHERE m.member_id = 'M009'
 ;