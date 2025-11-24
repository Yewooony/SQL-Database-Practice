-- 극장 데이터베이스 생성
CREATE DATABASE theater_db;
USE theater_db;

-- 극장 테이블 생성
CREATE TABLE 극장 (
    극장번호 INT PRIMARY KEY,
    극장이름 VARCHAR(50),
    위치 VARCHAR(50)
);

CREATE TABLE 상영관 (
    극장번호 INT,
    상영관번호 INT,
    영화제목 VARCHAR(50),
    가격 INT,
    좌석수 INT,
    PRIMARY KEY (극장번호, 상영관번호),
    FOREIGN KEY (극장번호) REFERENCES 극장(극장번호),
    CHECK (가격 <= 20000),
    CHECK (상영관번호 >= 1 AND 상영관번호 <= 10)
);

CREATE TABLE 고객 (
    고객번호 INT PRIMARY KEY,
    이름 VARCHAR(50),
    주소 VARCHAR(50)
);

CREATE TABLE 예약 (
    극장번호 INT,
    상영관번호 INT,
    고객번호 INT,
    좌석번호 INT,
    날짜 DATE,
    FOREIGN KEY (극장번호, 상영관번호) REFERENCES 상영관(극장번호, 상영관번호),
    FOREIGN KEY (고객번호) REFERENCES 고객(고객번호),
    PRIMARY KEY (극장번호, 상영관번호, 고객번호, 좌석번호, 날짜)
);

-- 새로운 데이터 삽입
-- 극장 데이터
INSERT INTO 극장 VALUES
(1, 'CGV', '서초'),
(2, '메가박스', '송파'),
(3, '씨네큐브', '종로');

-- 상영관 데이터
INSERT INTO 상영관 VALUES
(1, 1, '인셉션', 12000, 50),
(3, 1, '매트릭스', 8500, 100),
(3, 2, '타이타닉', 9000, 90);

-- 고객 데이터
INSERT INTO 고객 VALUES
(3, '이민수', '서초'),
(4, '정다운', '종로'),
(9, '최유진', '송파');

-- 예약 데이터
INSERT INTO 예약 VALUES
(3, 2, 3, 12, '2024-09-01'),
(3, 1, 4, 25, '2024-09-01'),
(1, 1, 9, 33, '2024-09-01');

-- 영화 가격 10% 인상
UPDATE 상영관
SET 가격 = 가격 * 1.1;


-- 사원 데이터베이스 생성
DROP DATABASE IF EXISTS employee_db;
CREATE DATABASE employee_db;
USE employee_db;

-- 부서(Department) 테이블 생성
CREATE TABLE Dept (
    deptno INTEGER(2) PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR(13)
);

-- 사원(Employee) 테이블 생성
CREATE TABLE Emp (
    empno INTEGER(4) PRIMARY KEY,
    ename VARCHAR(10),
    job VARCHAR(9),
    mgr INTEGER(4),
    hiredate DATE,
    sal DECIMAL(7,2),
    comm DECIMAL(7,2),
    deptno INTEGER(2),
    FOREIGN KEY (deptno) REFERENCES Dept(deptno)
);

-- 부서 데이터 삽입
INSERT INTO Dept VALUES
(10, '개발부', '서울'),
(20, '영업부', '부산'),
(30, '기획부', '대구'),
(40, '인사부', '인천');

USE employee_db;

-- 기존 테이블에 팀장이름 컬럼 추가
ALTER TABLE Emp
ADD mgrname VARCHAR(10);

-- 컬럼 순서를 명시적으로 지정하여 팀장이름 포함된 데이터 삽입
INSERT INTO Emp (empno, ename, job, mgr, mgrname, hiredate, sal, comm, deptno) VALUES
(7369, '김철수', '사원', 7902, '나과장', '2023-01-20', 3000.00, NULL, 20),
(7499, '이영희', '영업사원', 7698, '최부장', '2023-02-15', 4500.00, 300.00, 30),
(7521, '박민수', '영업사원', 7698, '최부장', '2023-03-01', 4000.00, 500.00, 30),
(7566, '정대리', '매니저', 7839, '윤사장', '2023-04-02', 5000.00, NULL, 20),
(7654, '송지은', '영업사원', 7698, '최부장', '2023-05-15', 4800.00, 1500.00, 30),
(7698, '최부장', '매니저', 7839, '윤사장', '2023-06-01', 5600.00, NULL, 30),
(7782, '강과장', '매니저', 7839, '윤사장', '2023-07-09', 5400.00, NULL, 10),
(7788, '오사원', '분석가', 7566, '정대리', '2023-08-11', 4000.00, NULL, 20),
(7839, '윤사장', '대표', NULL, NULL, '2023-09-10', 8000.00, NULL, 10),
(7844, '조사원', '영업사원', 7698, '최부장', '2023-10-08', 3500.00, 0.00, 30),
(7876, '황신입', '사원', 7788, '오사원', '2023-11-12', 2800.00, NULL, 20),
(7900, '임대리', '사원', 7698, '최부장', '2023-12-03', 3300.00, NULL, 30),
(7902, '나과장', '분석가', 7566, '정대리', '2024-01-15', 4500.00, NULL, 20),
(7934, '유사원', '사원', 7782, '강과장', '2024-02-20', 3200.00, NULL, 10);


