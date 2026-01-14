-- [Chapter 3장 연습문제 18번] 

-- (1) 사원의 이름과 직위를 출력하시오. (머리글: '사원이름', '사원직위') 
SELECT ename AS '사원이름', job AS '사원직위' 
FROM Emp; 

-- (2) 30번 부서에 근무하는 모든 사원의 이름과 급여를 출력하시오. 
SELECT ename, sal 
FROM Emp 
WHERE deptno = 30; 

-- (3) 사원번호순으로 사원번호, 이름, 현재 급여, 증가액(10%), 인상된 급여 출력 
SELECT empno, ename, sal AS '현재급여', 
       sal * 0.1 AS '증가액', 
       sal * 1.1 AS '인상된 급여' 
FROM Emp 
ORDER BY empno; 

-- (4) '김'으로 시작하는 모든 사원이름과 부서번호를 출력하시오. 
SELECT ename, deptno 
FROM Emp 
WHERE ename LIKE '김%'; 

-- (5) 모든 사원의 최대/최소/합계/평균 급여를 정수로 출력하시오. 
SELECT MAX(sal) AS 'MAX', MIN(sal) AS 'MIN', 
       ROUND(SUM(sal)) AS 'SUM', 
       ROUND(AVG(sal)) AS 'AVG' 
FROM Emp; 

-- (6) 업무별 사원 수를 출력하시오. 
SELECT job AS '업무', COUNT(*) AS '업무별 사원수' 
FROM Emp 
GROUP BY job; 

-- (7) 사원의 최대 급여와 최소 급여의 차액을 출력하시오. 
SELECT MAX(sal) - MIN(sal) AS '급여차액' 
FROM Emp; 

-- (8) 30번 부서의 구성원 수, 급여 합계 및 평균을 출력하시오. 
SELECT COUNT(*) AS '사원수', SUM(sal) AS '급여합계', AVG(sal) AS '평균급여' 
FROM Emp 
WHERE deptno = 30; 

-- (9) 평균 급여가 가장 높은 부서의 번호를 출력하시오. 
SELECT deptno 
FROM Emp 
GROUP BY deptno 
HAVING AVG(sal) >= ALL (
    SELECT AVG(sal) 
    FROM Emp 
    GROUP BY deptno
); 

-- (10) 영업사원 제외, 업무별 평균 급여가 3,000 이상인 업무명과 평균 급여(내림차순) 
SELECT job AS '업무명', AVG(sal) AS '평균급여' 
FROM Emp 
WHERE job != '영업사원' 
GROUP BY job 
HAVING AVG(sal) >= 3000 
ORDER BY AVG(sal) DESC; 

-- (11) 전체 사원 가운데 팀장이름(mgrname)이 있는 사원의 수를 출력하시오. 
SELECT COUNT(*) AS '팀장있는 사원수' 
FROM Emp 
WHERE mgrname IS NOT NULL; 

-- (12) 커미션이 NULL이 아닌 사원의 이름, 급여, 커미션, 총액(sal+comm)을 총액순(내림차순) 출력 [cite: 561]
SELECT ename, sal, comm, (sal + comm) AS '총액' 
FROM Emp 
WHERE comm IS NOT NULL 
ORDER BY (sal + comm) DESC; 

-- (13) 부서별 업무별 인원수를 부서번호순으로 출력하시오. 
SELECT deptno, job, COUNT(*) AS '인원수' 
FROM Emp 
GROUP BY deptno, job 
ORDER BY deptno; 

-- (14) 사원이 한 명도 없는 부서의 이름을 출력하시오. 
SELECT d.dname 
FROM Dept d 
LEFT JOIN Emp e ON d.deptno = e.deptno 
WHERE e.empno IS NULL; 

-- (15) 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하시오. 
SELECT job, COUNT(*) AS '인원수' 
FROM Emp 
GROUP BY job 
HAVING COUNT(*) >= 4; 

-- (16) 사원번호가 7400 이상 7600 이하인 사원의 이름을 출력하시오. 
SELECT ename 
FROM Emp 
WHERE empno BETWEEN 7400 AND 7600; 

-- (17) 사원의 이름과 사원의 부서명을 출력하시오. 
SELECT e.ename, d.dname 
FROM Emp e 
JOIN Dept d ON e.deptno = d.deptno; 

-- (18) 사원의 이름과 팀장(mgrname)의 이름을 출력하시오. 
SELECT e.ename AS '사람이름', e.mgrname AS '팀장이름' 
FROM Emp e 
WHERE e.mgrname IS NOT NULL; 

-- (19) 사원 '유사원'보다 급여를 많이 받는 사람의 이름을 출력하시오. 
SELECT ename 
FROM Emp 
WHERE sal > (
    SELECT sal 
    FROM Emp 
    WHERE ename = '유사원'
); 

-- (20) 사원 '유사원' 혹은 '조사원'의 부서번호를 출력하시오. 
SELECT DISTINCT deptno 
FROM Emp 
WHERE ename = '유사원' 
UNION 
SELECT deptno 
FROM Emp 
WHERE ename = '조사원'; 