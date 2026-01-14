-- [Chapter 3장 연습문제 15번] 

-- (1) 극장의 수는 몇 개인가? 
SELECT COUNT(*) AS '총_극장수' 
FROM theater_db.극장; 

-- (2) 상영되는 영화의 평균 가격은 얼마인가? 
SELECT AVG(가격) AS '평균_영화가격' 
FROM theater_db.상영관; 

-- (3) 2024년 9월 1일에 영화를 관람한 고객의 수는 얼마인가? 
SELECT COUNT(*) AS '관람_고객수' 
FROM theater_db.예약 
WHERE 날짜 = '2024-09-01'; 

-- [3. 부속질의와 조인] 

-- (1) 'CGV' 극장에서 상영된 영화제목을 나타내시오. 
SELECT s.영화제목 
FROM theater_db.극장 t 
JOIN theater_db.상영관 s ON t.극장번호 = s.극장번호 
WHERE t.극장이름 = 'CGV'; 

-- (2) 'CGV' 극장에서 영화를 본 고객의 이름을 나타내시오. 
SELECT DISTINCT c.이름 
FROM theater_db.극장 t 
JOIN theater_db.예약 r ON t.극장번호 = r.극장번호 
JOIN theater_db.고객 c ON r.고객번호 = c.고객번호 
WHERE t.극장이름 = 'CGV'; 

-- (3) 'CGV' 극장의 전체 수입을 나타내시오. 
SELECT SUM(s.가격) AS '총수입' 
FROM theater_db.극장 t 
JOIN theater_db.상영관 s ON t.극장번호 = s.극장번호 
JOIN theater_db.예약 r ON s.극장번호 = r.극장번호 AND s.상영관번호 = r.상영관번호 
WHERE t.극장이름 = 'CGV'; 

-- [4. 그룹 질의] 

-- (1) 극장 별 상영관 수를 나타내시오. 
SELECT t.극장이름, COUNT(s.상영관번호) AS '상영관수' 
FROM theater_db.극장 t 
LEFT JOIN theater_db.상영관 s ON t.극장번호 = s.극장번호 
GROUP BY t.극장번호, t.극장이름; 

-- (2) '종로'에 있는 극장의 상영관을 나타내시오. 
SELECT t.극장이름, COUNT(s.상영관번호) AS '상영관수' 
FROM theater_db.극장 t 
LEFT JOIN theater_db.상영관 s ON t.극장번호 = s.극장번호 
WHERE t.위치 = '종로' 
GROUP BY t.극장번호, t.극장이름; 

-- (3) 2024년 9월 1일의 극장별 관람 고객 수를 나타내시오. 
SELECT t.극장이름, COUNT(r.고객번호) AS '관람고객수' 
FROM theater_db.극장 t 
JOIN theater_db.예약 r ON t.극장번호 = r.극장번호 
WHERE r.날짜 = '2024-09-01' 
GROUP BY t.극장번호, t.극장이름; 

-- (4) 2024년 9월 1일에 가장 많은 고객이 관람한 영화를 나타내시오. 
SELECT s.영화제목, COUNT(*) AS '관람객수' 
FROM theater_db.상영관 s 
JOIN theater_db.예약 r ON s.극장번호 = r.극장번호 AND s.상영관번호 = r.상영관번호 
WHERE r.날짜 = '2024-09-01' 
GROUP BY s.영화제목 
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*) 
    FROM theater_db.예약 r2 
    JOIN theater_db.상영관 s2 ON r2.극장번호 = s2.극장번호 AND r2.상영관번호 = s2.상영관번호 
    WHERE r2.날짜 = '2024-09-01' 
    GROUP BY s2.영화제목
); 

-- [Chapter 4장 연습문제 14번] 

-- (1) 극장이름과 고객이름을 저장하는 극장-고객 뷰를 생성하시오. 
CREATE VIEW theater_db.극장_고객뷰 AS 
SELECT DISTINCT t.극장이름, c.이름 AS 고객이름 
FROM theater_db.극장 t 
JOIN theater_db.예약 r ON t.극장번호 = r.극장번호 
JOIN theater_db.고객 c ON r.고객번호 = c.고객번호; 

SELECT * FROM theater_db.극장_고객뷰; 

-- (2) '대한' 극장(실습상 '씨네큐브' 등)에 예약한 고객의 수를 날짜별로 저장하는 뷰를 생성하시오. 
CREATE VIEW theater_db.극장_고객수_뷰 AS 
SELECT t.극장이름, 날짜, COUNT(*) AS 고객수 
FROM theater_db.극장 t 
JOIN theater_db.예약 r ON t.극장번호 = r.극장번호 
GROUP BY t.극장이름, 날짜; 

SELECT * FROM theater_db.극장_고객수_뷰; 