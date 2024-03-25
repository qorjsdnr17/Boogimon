--부기몬 제공 명소 정보-- 
-- PLACE table과 PLACE_DETAIL table 정보를 함께 입력 / type : 900~
-- 시퀀스 PLACE : seq_place_id.nextval / PLACE_DETAIL : seq_place_id.currval
-- ex)
-- INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL)
-- VALUES (seq_place_id.nextval, '해운대 미포철길', 900, '부산광역시 해운대 어딘가', 'latitude', 'longitude', 'thumbnail_url');
-- INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
-- VALUES (seq_place_id.currval, '051-701-5648', '해운대 미포철길', '무료', 'example.jpg', 'www.bluelinepark.com', '09:00 AM', '06:00 PM', '주차장');
-- INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL)
-- VALUES (seq_place_id.nextval, '황령산 레포츠공원', 900, '부산광역시 대연동 어딘가', 'latitude', 'longitude', 'thumbnail_url');
--INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
-- VALUES (seq_place_id.currval, '051-605-4128', '황령산 레포츠공원', '무료', 'example.jpg', 'https://www.jsports.or.kr/bbs/content.php?co_id=07_01', '09:00 AM', '06:00 PM', '와이파이, 주차장');
SET ESCAPE ON

--수정 전 데이터 삭제--
-- DELETE FROM PLACE_DETAIL
-- WHERE PLACE_ID IN (SELECT PLACE_ID FROM PLACE WHERE TYPE = '900');
--변경한 데이터(THUMBNAIL -> NULL)--
-------------------------------------------------------------------------2차 수정
--PLACE NAME 중복된 데이터 삭제,밑에 쿼리문은 중복된 데이터 삭제한 쿼리문!!!
-- 변경한 데이터(NULL -> 이미지.png 수정) 

--부기몬 제공 명소 정보-- 
-- PLACE table과 PLACE_DETAIL table 정보를 함께 입력 / type : 900~
-- 시퀀스 PLACE : seq_place_id.nextval / PLACE_DETAIL : seq_place_id.currval
-- ex)
-- INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL)
-- VALUES (seq_place_id.nextval, '해운대 미포철길', 900, '부산광역시 해운대 어딘가', 'latitude', 'longitude', 'thumbnail_url');
-- INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
-- VALUES (seq_place_id.currval, '051-701-5648', '해운대 미포철길', '무료', 'example.jpg', 'www.bluelinepark.com', '09:00 AM', '06:00 PM', '주차장');
-- INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL)
-- VALUES (seq_place_id.nextval, '황령산 레포츠공원', 900, '부산광역시 대연동 어딘가', 'latitude', 'longitude', 'thumbnail_url');
--INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
-- VALUES (seq_place_id.currval, '051-605-4128', '황령산 레포츠공원', '무료', 'example.jpg', 'https://www.jsports.or.kr/bbs/content.php?co_id=07_01', '09:00 AM', '06:00 PM', '와이파이, 주차장');
SET ESCAPE ON

--수정 전 데이터 삭제--
DELETE FROM PLACE_DETAIL
WHERE PLACE_ID IN (SELECT PLACE_ID FROM PLACE WHERE TYPE = '900');
--변경한 데이터(THUMBNAIL -> NULL)--
--place 중복된 데이터 삭제 및 이미지 파일 --

-- 야경 테마 --
INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'해운대 해수욕장','900','부산광역시 해운대구 달맞이길62번길 47','35.15853820529319' ,'129.15931739342994','/boogimon/images/place/Haeundae.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval, '051-701-5648', '해운대 해수욕장', '무료',NULL, 'www.bluelinepark.com', '09:00 AM', '06:00 PM', '공영주차장');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'책마루 전망대','900','부산광역시 동구 성북로 36번길 54', '35.13804831461976','129.05241378784098','/boogimon/images/place/Chaekmaru.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval, '051-440-6411', '책마루 전망대', '무료',NULL,'www.bsdonggu.go.kr/library/index.donggu?menuCd=DOM_000000802017000000','09:00 AM','06:00 PM','공영주차장,화장실');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'황령산 봉수대','900','부산광역시 부산진구 전포동 산50-1', '35.13804831461976','129.05241378784098','/boogimon/images/place/Hwangnyeongsan.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-605-4065','황령산 봉수대','무료',NULL,'www.bisco.or.kr/jungangpark/facil/facil03/facil03_2/','12:00 AM','12:00 PM','공영주차장,화장실');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'이기대 전망대','900','부산광역시 남구 용호동 산1','35.13804831461976','129.05241378784098','/boogimon/images/place/leegidae.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-607-6361','이기대 전망대','무료',NULL,'www.bsnamgu.go.kr','12:00 AM','12:00 PM','공영주차장,화장실');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'호천 마을 생활문화센터','900','부산광역시 부산진구 엄광로495번가길36','35.142699721415006','129.05219872013978','/boogimon/images/place/Hocheon.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'010-8689-0419','호천 마을 생활문화센터','무료',NULL,'fairweathervillage.modoo.at/?link=b938a6z1','09:00 AM','09:00 PM','공영주차장,화장실,카페');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'청학 배수지 전망대','900','부산광역시 영도구 청학제2동 475-6', '35.142699721415006','129.05219872013978','/boogimon/images/place/Cheonghak.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-419-4000','청학 배수지 전망대','무료',NULL,'www.yeongdo.go.kr/tour.web','12:00 AM','12:00 PM','화장실');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'하늘눈 전망대','900','부산광역시 중구 영주동 91-7','35.11438493525174','129.03040644547917','/boogimon/images/place/Haneul.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-600-4000','하늘눈 전망대','무료',NULL,'https://www.bsjunggu.go.kr/tour/index.junggu','12:00 AM','12:00 PM','중앙공원공영주차장');

--골목 테마--
INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'이바구길','900','부산광역시 동구 초량상로 49','35.11683630441849','129.03670509852802 ','/boogimon/images/place/Ibagu.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,+'051-467-0289','이바구길','무료',NULL,'www.2bagu.co.kr/index.bsdonggu','12:00 AM','12:00 PM','공영주차장' );

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'백년송도골목길','900','부산광역시 서구 암남동 149','35.096282114549794','129.00934618866356','/boogimon/images/place/Baegnyeonsongdo.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,' 051-240-4000','백년송도골목길','무료',NULL,'www.bsseogu.go.kr/index.bsseogu?contentsSid=1','12:00 AM','12:00 PM','X');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'망미단길','900','부산광역시 수영구 망미동 403-23','35.172276310309705','129.11011032204564','/boogimon/images/place/Mangmidan.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-761-2855','망미단길','무료',NULL,'www.visitbusan.net/index.do','12:00 AM','12:00 PM','공영주차장,화장실');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'전포공구길','900','부산광역시 부산진구 서전로37번길 18','35.15861739496153','129.06407922744978','/boogimon/images/place/Jeonpogonggu.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-1670-0812','전포공구길','무료',NULL,'www.visitbusan.net/index.do','12:00 AM','12:00 PM','유료주차장' );

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'봉산마을마실길','900','부산광역시 영도구 하나길 788','35.0929735557174','129.051247633423','/boogimon/images/place/Bongsan.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'070-4151-2775','봉산마을마실길','무료',NULL,'www.visitbusan.net/index.do','12:00 AM','12:00 PM','유료주차장');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'40계단 문화관광테마거리','900','부산광역시 중구 대청로 135번길 11','35.10387472177739','129.034586841826','/boogimon/images/place/40gyedan.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-600-4046','40계단 문화관광테마거리','무료',NULL,'www.visitbusan.net/index.do','12:00 AM','12:00 PM','유료주차장');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'유치환의 우체통','900','부산광역시 동구 망양로580번길7-2','35.10387472177739','129.034586841826 ','/boogimon/images/place/Yuchihwan.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-469-9818','유치환의 우체통','무료',NULL,'http://tour.bsdonggu.go.kr','12:00 AM','12:00 PM','옥상 주차장(유료)');


--가을 테마--
INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'승학산','900','부산광역시 사상구 엄궁동 산 19','35.13116746790919','128.98497308086715','/boogimon/images/place/Songhag.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-220-4000','승학산','무료',NULL,'www.saha.go.kr/tour/contents.do?mId=0104000000','12:00 AM','12:00 PM','제석골 산림공원 화장실,동아대학교 낙동주차장');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'화명생태공원','900','부산광역시 북구 금곡동 1511-3','35.225788471606045','129.00356237767429','/boogimon/images/place/Hwamyeong.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-364-4127','화명생태공원','무료',NULL,'www.busan.go.kr/nakdong/hwamyungpark01','12:00 AM','12:00 PM','공영주차장,화장실');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'동백섬','900','부산광역시 해운대구 우동710_1','35.15383054466299','129.15751886919503','/boogimon/images/place/Dongbaeg.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-749-7621','동백섬','무료',NULL,'www.haeundae.go.kr/index.do','12:00 AM','12:00 PM','공영주차장,화장실');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'장산 억세밭','900','부산광역시 해운대구 좌제4동1211','35.19262436821101','129.15218441351615 ','/boogimon/images/place/Jangsan.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'010-5554-0546','장산 억세밭','무료',NULL,'www.haeundae.go.kr','12:00 AM','12:00 PM','대천공원 공영주차장');

INSERT INTO PLACE(PLACE_ID,NAME,TYPE,ADDR,LAT,LON,THUMBNAIL)
VALUES(seq_place_id.nextval,'허브랑야생화','900','부산광역시 금정구 금성동 북문로 73','35.19262436821101','129.15751886919503  ','/boogimon/images/place/Hub.jpg');
INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
VALUES (seq_place_id.currval,'051-515-0130','허브랑야생화','무료',NULL,'https://www.herbrang.kr','11:00 AM','06:30 PM','주차장,화장실');

SET ESCAPE OFF
 
COMMIT;
SET ESCAPE OFF
 
COMMIT;