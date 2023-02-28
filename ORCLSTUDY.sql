DROP TABLE ORDERS;
DROP TABLE BOOK;
DROP TABLE CUSTOMER;
DROP TABLE IMPORTED_BOOK;

CREATE TABLE BOOK(
  BOOKID      NUMBER(2) PRIMARY KEY,
  BOOKNAME    VARCHAR2(40),
  PUBLISHER   VARCHAR2(40),
  PRICE       NUMBER(8) 
);

CREATE TABLE CUSTOMER(
  CUSTID      NUMBER(2) PRIMARY KEY,  
  NAME        VARCHAR2(40),
  ADDRESS     VARCHAR2(50),
  PHONE       VARCHAR2(20)
);

CREATE TABLE ORDERS(
  ORDERID NUMBER(2) PRIMARY KEY,
  CUSTID  NUMBER(2) REFERENCES CUSTOMER(CUSTID),
  BOOKID  NUMBER(2) REFERENCES BOOK(BOOKID),
  SALEPRICE NUMBER(8) ,
  ORDERDATE DATE
);
-- BOOK, CUSTOMER, ORDERS 데이터 생성
INSERT INTO BOOK VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO BOOK VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO BOOK VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO BOOK VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO BOOK VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO BOOK VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO BOOK VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO BOOK VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO BOOK VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO BOOK VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO CUSTOMER VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO CUSTOMER VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO CUSTOMER VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO CUSTOMER VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO CUSTOMER VALUES (5, '박세리', '대한민국 대전',  NULL);

-- 주문(ORDERS) 테이블의 책값은 할인 판매를 가정함
INSERT INTO ORDERS VALUES (1, 1, 1, 6000, TO_DATE('2014-07-01','yyyy-mm-dd')); 
INSERT INTO ORDERS VALUES (2, 1, 3, 21000, TO_DATE('2014-07-03','yyyy-mm-dd'));
INSERT INTO ORDERS VALUES (3, 2, 5, 8000, TO_DATE('2014-07-03','yyyy-mm-dd')); 
INSERT INTO ORDERS VALUES (4, 3, 6, 6000, TO_DATE('2014-07-04','yyyy-mm-dd')); 
INSERT INTO ORDERS VALUES (5, 4, 7, 20000, TO_DATE('2014-07-05','yyyy-mm-dd'));
INSERT INTO ORDERS VALUES (6, 1, 2, 12000, TO_DATE('2014-07-07','yyyy-mm-dd'));
INSERT INTO ORDERS VALUES (7, 4, 8, 13000, TO_DATE( '2014-07-07','yyyy-mm-dd'));
INSERT INTO ORDERS VALUES (8, 3, 10, 12000, TO_DATE('2014-07-08','yyyy-mm-dd')); 
INSERT INTO ORDERS VALUES (9, 2, 10, 7000, TO_DATE('2014-07-09','yyyy-mm-dd')); 
INSERT INTO ORDERS VALUES (10, 3, 8, 13000, TO_DATE('2014-07-10','yyyy-mm-dd'));

-- 여기는 3장에서 사용되는 IMPORTED_BOOK 테이블

CREATE TABLE IMPORTED_BOOK (
  BOOKID      NUMBER ,
  BOOKNAME    VARCHAR(40),
  PUBLISHER   VARCHAR(40),
  PRICE       NUMBER(8) 
);
INSERT INTO IMPORTED_BOOK VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO IMPORTED_BOOK VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

COMMIT;

SELECT BOOKNAME FROM BOOK
WHERE BOOKID = 1;

SELECT * FROM BOOK
WHERE PRICE >= 20000;

SELECT SUM(SALEPRICE)
FROM ORDERS NATURAL JOIN CUSTOMER
WHERE NAME = '박지성';

SELECT SUM(SALEPRICE)
FROM ORDERS JOIN CUSTOMER USING (CUSTID)
WHERE NAME = '박지성';

SELECT SUM(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND NAME = '박지성'; 

SELECT SUM(SALEPRICE) FROM ORDERS
WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');

SELECT COUNT(*) FROM BOOK;

SELECT COUNT (DISTINCT PUBLISHER) FROM BOOK;

SELECT ORDERID FROM ORDERS
WHERE ORDERDATE BETWEEN '2014,07,04' AND '2014,07,07';

SELECT * FROM CUSTOMER
WHERE NAME LIKE '김%';

SELECT DISTINCT PUBLISHER FROM BOOK NATURAL JOIN ORDERS NATURAL JOIN CUSTOMER
WHERE NAME = '박지성';

SELECT DISTINCT B.PUBLISHER FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID
AND O.CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');

SELECT DISTINCT PUBLISHER
FROM BOOK JOIN ORDERS USING (BOOKID) JOIN CUSTOMER USING (CUSTID)
WHERE NAME = '박지성';

SELECT * FROM CUSTOMER
WHERE NAME LIKE '%아';

SELECT NAME, SUM(SALEPRICE)
FROM ORDERS JOIN CUSTOMER USING (CUSTID)
GROUP BY NAME;

--박지성이 산 책과 같은 출판사에서 만든 책을 산 고객 구하기
SELECT DISTINCT NAME
FROM CUSTOMER NATURAL JOIN ORDERS NATURAL JOIN BOOK
WHERE PUBLISHER IN (SELECT DISTINCT PUBLISHER
    FROM BOOK NATURAL JOIN ORDERS NATURAL JOIN CUSTOMER
    WHERE NAME = '박지성')
AND NAME <> '박지성';

SELECT * FROM BOOK;

INSERT INTO BOOK
VALUES (11, '스포츠 세계', '대한미디어', 10000);

DELETE FROM BOOK
WHERE PUBLISHER = '삼성당';

DELETE FROM BOOK
WHERE PUBLISHER = '이상미디어';

UPDATE BOOK
SET PUBLISHER = '대한출판사'
WHERE PUBLISHER = '대한미디어';

ROLLBACK;

--제약조건 조회
SELECT * FROM ALL_CONSTRAINTS
WHERE TABLE_NAME = 'ORDERS';

SELECT * FROM USER_INDEXES;

