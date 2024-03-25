ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

--휴지통 비우기
PROMPT 휴지통 비우기
purge recyclebin;

SET TERMOUT ON
PROMPT 테이블 초기화
SET TERMOUT OFF

--인덱스, 시퀀스, 뷰 초기화
DROP index COMMENT_ID;
DROP sequence seq_stampbook_id;
DROP sequence seq_place_id;
DROP sequence seq_comment_id;
DROP VIEW user_ranking;

--테이블 초기화
drop table USER_STAMP_HISTORY;
drop table USER_PICK;
drop table USER_LIKE;
drop table STB_CMT;
drop table PLACE_DETAIL;
drop table STAMP;
drop table PLACE;
drop table STAMPBOOK;
drop table BoogiTrainer;

SET TERMOUT ON
PROMPT 시퀀스 생성
SET TERMOUT OFF

--시퀀스 생성
create sequence seq_stampbook_id
    start with 0
    increment by 1
    minvalue 0
    nocycle
    nocache;

create sequence seq_place_id
    start with 0
    increment by 1
    minvalue 0
    nocycle
    nocache;

create sequence seq_comment_id
    start with 0
    increment by 1
    minvalue 0
    nocycle
    nocache;

SET TERMOUT ON
PROMPT 테이블 생성
SET TERMOUT OFF

--트레이너 정보 테이블 생성
CREATE TABLE BoogiTrainer (
    USER_ID VARCHAR2(30),
    PASSWD VARCHAR(64) CONSTRAINT BoogiTrainer_PASSWD_nn NOT NULL,
    SALT VARCHAR(32) CONSTRAINT BoogiTrainer_SALT_nn NOT NULL,
    NICKNAME VARCHAR2(45) CONSTRAINT BoogiTrainer_NICKNAME_nn NOT NULL,
    REGDATE DATE DEFAULT SYSDATE CONSTRAINT BoogiTrainer_REGDATE_nn NOT NULL,
    EXP NUMBER(7) DEFAULT 0 CONSTRAINT BoogiTrainer_EXP_nn NOT NULL,
    PROFILE_IMG VARCHAR2(100),
    DELETED NUMBER(1) DEFAULT 0 CONSTRAINT BoogiTrainer_DELETED_nn NOT NULL,
    CONSTRAINT BoogiTrainer_USER_ID_pk PRIMARY KEY(USER_ID),
    CONSTRAINT BoogiTrainer_PASSWD_ck CHECK(LENGTH(PASSWD) = 64),
    CONSTRAINT BoogiTrainer_SALT_ck CHECK(LENGTH(SALT) = 32),
    CONSTRAINT BoogiTrainer_NICKNAME_uq UNIQUE(NICKNAME),
    CONSTRAINT BoogiTrainer_NICKNAME_ck CHECK(LENGTH(NICKNAME) BETWEEN 2 AND 15),
    CONSTRAINT BoogiTrainer_EXP_ck CHECK(EXP >= 0),
    CONSTRAINT BoogiTrainer_DELETED_ck CHECK(DELETED IN (0, 1))
);

--스탬프 북 테이블 생성
CREATE TABLE STAMPBOOK (
    STAMPBOOK_ID NUMBER(6),
    TITLE VARCHAR2(60) CONSTRAINT STAMPBOOK_TITLE_nn NOT NULL ,
    DESCRIPTION VARCHAR2(1500) CONSTRAINT STAMPBOOK_DESCRIPTION_nn NOT NULL,
    USER_ID VARCHAR2(30) CONSTRAINT STAMPBOOK_USER_ID_nn NOT NULL,
    STAMPBOOK_REGDATE DATE DEFAULT SYSDATE CONSTRAINT STAMPBOOK_STAMPBOOK_REGDATE_nn NOT NULL,
    LIKECOUNT NUMBER(6) DEFAULT 0 CONSTRAINT STAMPBOOK_LIKECOUNT_nn NOT NULL,
    DELETED NUMBER(1) DEFAULT 0 CONSTRAINT STAMPBOOK_DELETED_nn NOT NULL,
    CONSTRAINT STAMPBOOK_STAMPBOOK_ID_pk PRIMARY KEY(STAMPBOOK_ID),
    CONSTRAINT STAMPBOOK_TITLE_ck CHECK (LENGTH(TITLE) BETWEEN 1 AND 20),
    CONSTRAINT STAMPBOOK_DESCRIPTION_ck CHECK (LENGTH(DESCRIPTION) BETWEEN 1 AND 500),
    CONSTRAINT STAMPBOOK_DELETED_ck CHECK(DELETED IN (0, 1)),
    CONSTRAINT STAMPBOOK_USER_ID_fk FOREIGN KEY (USER_ID) REFERENCES BoogiTrainer(USER_ID)
);

--명소 정보 테이블 생성
CREATE TABLE PLACE (
    PLACE_ID NUMBER(4),
    NAME VARCHAR2(300) CONSTRAINT PLACE_NAME_nn NOT NULL,
    TYPE NUMBER(3) CONSTRAINT PLACE_TYPE_nn NOT NULL,
    ADDR VARCHAR2(600),
    LAT VARCHAR2(20) CONSTRAINT PLACE_LAT_nn NOT NULL,
    LON VARCHAR2(20)CONSTRAINT PLACE_LON_nn NOT NULL,
    THUMBNAIL VARCHAR2(500),
    CONTENTS_ID VARCHAR2(11),
    CONSTRAINT PLACE_PLACE_ID_pk PRIMARY KEY (PLACE_ID)
);

--명소 정보 상세 테이블 생성
CREATE TABLE PLACE_DETAIL (
    PLACE_ID NUMBER(4),
    TEL VARCHAR2(200),
    DETAIL VARCHAR2(1500),
    PAY VARCHAR2(1500),
    TRAFFIC VARCHAR2(1500),
    IMG VARCHAR2(500),
    HOMEPAGE VARCHAR2(500),
    OPEN VARCHAR2(1500),
    CLOSE VARCHAR2(1500),
    FACILITY VARCHAR2(1500),
    constraint PLACE_DETAIL_PLACE_ID_fk FOREIGN KEY (PLACE_ID) REFERENCES PLACE(PLACE_ID)
);

CREATE INDEX PLACE_ID ON PLACE_DETAIL (PLACE_ID);

--스탬프 테이블 생성
CREATE TABLE STAMP (
    STAMPBOOK_ID NUMBER(6),
    STAMPNO NUMBER(3) CONSTRAINT STAMP_STAMPNO_nn NOT NULL,
    PLACE_ID NUMBER(4),
    CONSTRAINT STAMP_STB_ID_fk FOREIGN KEY (STAMPBOOK_ID) REFERENCES STAMPBOOK(STAMPBOOK_ID),
    CONSTRAINT STAMP_STAMPNO_ck CHECK (STAMPNO BETWEEN 1 AND 99),	 
    CONSTRAINT STAMP_PLACE_ID_fk FOREIGN KEY (PLACE_ID) REFERENCES PLACE(PLACE_ID),
    CONSTRAINT STAMP_pk PRIMARY KEY(STAMPBOOK_ID, STAMPNO)
);

--유저 선택 테이블 생성
CREATE TABLE USER_PICK (
    USER_ID VARCHAR2(30),
    STAMPBOOK_ID NUMBER(6),
    PICK_DATE DATE DEFAULT SYSDATE CONSTRAINT USER_PICK_PICK_DATE_nn NOT NULL,
    COMPLETE_DATE DATE,
    CONSTRAINT USERPICK_USER_ID_fk FOREIGN KEY (USER_ID) REFERENCES BoogiTrainer(USER_ID),
    CONSTRAINT USERPICK_STB_ID_fk FOREIGN KEY (STAMPBOOK_ID) REFERENCES STAMPBOOK(STAMPBOOK_ID),
    CONSTRAINT USERPICK_pk PRIMARY KEY (USER_ID, STAMPBOOK_ID)
);

--유저 스탬프 정보 테이블 생성
CREATE TABLE USER_STAMP_HISTORY (
    USER_ID VARCHAR2(30),
    STAMPBOOK_ID NUMBER(6),
    STAMPNO NUMBER(3),
    UPLOAD_IMG VARCHAR2(100) CONSTRAINT USH_UPLOAD_IMG_nn NOT NULL,
    STAMPED_DATE DATE DEFAULT SYSDATE CONSTRAINT USH_STAMPED_DATE_nn NOT NULL,
    CONSTRAINT USH_pk PRIMARY KEY (USER_ID, STAMPBOOK_ID, STAMPNO),
    CONSTRAINT USH_USER_PICK_fk FOREIGN KEY (USER_ID, STAMPBOOK_ID) REFERENCES USER_PICK(USER_ID, STAMPBOOK_ID),
    CONSTRAINT USH_STAMP_fk FOREIGN KEY (STAMPBOOK_ID, STAMPNO) REFERENCES STAMP(STAMPBOOK_ID, STAMPNO)
);

--유저 좋아요 테이블 생성
CREATE TABLE USER_LIKE (
    USER_ID VARCHAR2(30),
    STAMPBOOK_ID NUMBER(6),
    CONSTRAINT USER_LIKE_USER_ID_fk FOREIGN KEY (USER_ID) REFERENCES BoogiTrainer(USER_ID),
    CONSTRAINT USER_LIKE_STAMPBOOK_ID_fk FOREIGN KEY (STAMPBOOK_ID) REFERENCES STAMPBOOK(STAMPBOOK_ID),
    CONSTRAINT USER_LIKE_pk PRIMARY KEY (USER_ID, STAMPBOOK_ID)
);

--스탬프북 댓글 테이블 생성 (ORA-00972: 식별자가 너무 깁니다., STAMP_COMMENT -> STB_CMT)
CREATE TABLE STB_CMT (
    COMMENT_ID NUMBER(7) CONSTRAINT STB_CMT_COMMENT_ID_nn NOT NULL,
    STAMPBOOK_ID NUMBER(6),
    USER_ID VARCHAR2(30) CONSTRAINT STB_CMT_USER_ID_nn NOT NULL,
    BCOMMENT VARCHAR2(750) CONSTRAINT STB_CMT_COMMENT_nn NOT NULL,
    WRITE_DATE DATE DEFAULT SYSDATE CONSTRAINT STB_CMT_WRITE_DATE_nn NOT NULL,
    DELETED NUMBER(1) DEFAULT 0 CONSTRAINT STB_CMT_DELETED_nn NOT NULL,
    CONSTRAINT STB_CMT_STAMPBOOK_ID_fk FOREIGN KEY (STAMPBOOK_ID) REFERENCES STAMPBOOK(STAMPBOOK_ID),
    CONSTRAINT STB_CMT_USER_ID_fk FOREIGN KEY (USER_ID) REFERENCES BoogiTrainer(USER_ID),
    CONSTRAINT STB_CMT_COMMENT_ID_pk PRIMARY KEY(COMMENT_ID),
    CONSTRAINT STB_CMT_DELETED_ck CHECK(DELETED IN (0, 1))
);

CREATE INDEX COMMENT_ID ON STB_CMT(STAMPBOOK_ID);

-- CREATE TABLE RESULTCODE (
--     CODENUM NUMBER(3),
--     CODEMSG VARCHAR2(100) CONSTRAINT RESULTCODE_CODEMSG_nn NOT NULL,
--     CONSTRAINT RESULTCODE_CODENUM_pk PRIMARY KEY(CODENUM)
-- );

-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (0, 'NORMAL_CODE');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (1, 'DB_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (10, 'INVALID_REQUEST_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (11, 'INVALID_REQUEST_PARAMETER_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (12, 'NO_MANDATORY_REQUEST_PARAMETERS_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (20, 'NON_EXISTENT_USER_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (21, 'INVALID_USER_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (22, 'DUPLICATE_USERID_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (23, 'DUPLICATE_NICKNAME_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (30, 'NON_EXISTENT_STAMPBOOK_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (31, 'DELETED_STAMPBOOK_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (32, 'LIKE_PROCESSING_FAILED_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (33, 'UNLIKE_PROCESSING_FAILED_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (34, 'LIKE_COUNT_INCREMENT_FAILED_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (35, 'LIKE_COUNT_DECREMENT_FAILED_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (50, 'NON_EXISTENT_STAMP_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (60, 'NON_EXISTENT_PLACE_ERROR');
-- INSERT INTO RESULTCODE(CODENUM, CODEMSG)
-- VALUES (99, 'UNKNOWN_ERROR');

SET TERMOUT ON
PROMPT 뷰 생성
SET TERMOUT OFF

CREATE VIEW user_ranking
AS
SELECT rnum, user_id, nickname, totalStamp
FROM (
    SELECT rownum rnum, user_id, nickname, totalStamp
    FROM (
        SELECT u.nickname, u.user_id, COUNT(ush.stamped_Date) AS totalStamp
            FROM boogiTrainer u 
            LEFT OUTER JOIN user_stamp_history ush ON u.user_id = ush.user_id
            WHERE u.deleted = 0
            GROUP BY u.nickname, u.user_id, u.regdate
            ORDER BY COUNT(ush.stamped_Date) desc, u.regdate
));

----------------------------------------------------------------------------

SET TERMOUT ON
PROMPT 회원 정보 입력
SET TERMOUT OFF

--트레이너 정보 테이블 더미 데이터 입력

--관리자 더미 데이터
--boogi@boogimon.com / boogi123
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('bijugi@boogimon.com', '330cf0b83e30a9e8ac61211d3a777628ff80a9a12e0659d9a238842230f69320', 'a498b3c99a378d9c11fa8d60cc66b9d5', 'BIJUGI', 100000, '/boogimon/images/upload/user/profile/sakaki.png');
--admin@boogimon.com / admin123
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('admin@boogimon.com', 'a092a0acff62151cc750c450dd3311288497f9dd6ea1579a44ab5d26a51aeb9e', '7b28b8cd2c5723bf414c00e9b0b6f1e3', '운영자', 100000, '/boogimon/images/upload/user/profile/admin.png');
--boogi@boogimon.com / boogi123
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('boogi@boogimon.com', 'b5b522134aa9c7b14519c3df70134e699ae5130f4ad8b88e8788237761da6f65', '6bbf70841c6fbdd6594f993cfd31ea03', '부기몬', 100000, '/boogimon/images/upload/user/profile/boogi.png');

--일반 회원 더미 데이터
--red@google.com / red456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('red@google.com', 'beafc8f778046a24875bde54dd2bcb69bcf0cb64939ad8b507f767a0118dde76', '9c5b5181058248112c853b143ced7c8a', 'RED',0, '/boogimon/images/upload/user/profile/red.png');
--green@google.com / green456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('green@google.com', '58e13f9b98d980900c180abed0d825fd14ed84d94ce169bcc930d51927ac94a4', '1e738ed5bcd340b67001dbc1bcd54464', 'Green',0, '/boogimon/images/upload/user/profile/green.png');
--gold@google.com / gold456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('gold@google.com', '61944619678db869b5a11af3811dd53142b8ba5efc9177fdfdf29ece5904dc43', 'e140b8a5cd8f6111b4ea27d2b8ea42cc', '목호',0, '/boogimon/images/upload/user/profile/wataru.png');
--silver@google.com / silver456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('silver@google.com', '8fcb1de0bdae31d664ed4bd2700c6189b942d476cdeff49533320600d3b980da', '6e4da0173a794d37716b34d2fc2f298c', '성호', 0, '/boogimon/images/upload/user/profile/daigo.png');
--ruby@google.com / ruby456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('ruby@google.com', '0c92634d6969b19b7a00027c98f9569869c19689127004027880aab92ffda238', '1dcf5200ad94ca5a8655a25987690035', '윤진', 0, '/boogimon/images/upload/user/profile/mikuri.png');
--sapphire@google.com / sapphire456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('sapphire@google.com', '3813e1d1b7440bf0839e9a013991b39ecf9ebd1c3e778976fdd441374626c5b7', '811f725bd604fea4b29ea68ed80dbd68', 'Bomi', 0, '/boogimon/images/upload/user/profile/haruka.png');
--diamond@google.com / diamond456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('diamond@google.com', '5c5c418e16d1478195c051714d47121776e257a8a163e489013d0f5535f2162a', '442cb9b9510f8a1f4186fc91bb9f3968', 'Nancheon', 0, '/boogimon/images/upload/user/profile/shirona.png');
--pearl@google.com / pearl456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('pearl@google.com', '4c09232d1d731135b999ab9b4d6301a0b0ff8da594f75e97d1ebb727d58deaa6', '9b37a4bbcc7b5b44ee4a9a4c282bab9c', 'Bichna', 0, '/boogimon/images/upload/user/profile/hikari.png');
--black@google.com / black456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('black@google.com', '9437a79f30be98e795bfd9fd9f4d3bf616eecdd843a8be9212f1058721b20561', 'f205370ea7511812657c6995645132bd', '노간주', 0, '/boogimon/images/upload/user/profile/adeku.png');
--white@google.com / white456
INSERT INTO BoogiTrainer(USER_ID, PASSWD, SALT, NICKNAME, EXP, PROFILE_IMG)
VALUES ('white@google.com', 'a7c55f1b971dbf09460063f827f251fd2e8f420a405ea1e707d67c3369e09b64', '863d8136fee38f2b86e514616c25bec8', 'Iris', 0, '/boogimon/images/upload/user/profile/iris.png');

----------------------------------------------------------------------------

SET TERMOUT ON
PROMPT 명소 데이터 입력
SET TERMOUT OFF

SET ESCAPE ON

--명소 데이터 입력 (공공데이터 API 활용)
--명소
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '흰여울문화마을', 100, '부산광역시 영도구 흰여울길', '35.07885', '129.04402', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191222164810529_thumbL', '255');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '깡깡이 예술마을', 100, '부산시 영도구 대평북로 36 깡깡이 안내센터', '35.092648', '129.03255', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191222171209005_thumbL', '256');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '국립해양박물관', 100, '부산시 영도구 해양로301번길 45', '35.078728', '129.08018', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191222175627506_thumbL', '257');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '태종대 유원지', 100, '부산광역시 영도구 전망로 24', '35.052643', '129.0878', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191222180829962_thumbL', '258');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '죽성성당', 100, '부산광역시 기장군 기장읍 죽성리 134-7', '35.241013', '129.24864', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191222181829937_thumbL', '259');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '아홉산 숲', 100, '부산광역시 기장군 철마면 미동길 37-1', '35.287334', '129.17046', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191222185645736_thumbL', '260');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '해동용궁사', 100, '부산광역시 기장군 기장읍 용궁길 86', '35.188583', '129.22346', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191222190823385_thumbL', '261');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '임랑해수욕장 ', 100, '부산광역시 기장군 장안읍 임랑리', '35.31905', '129.26451', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191224093809621_thumbL', '262');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '문화공감 수정, 초량1941', 100, '문화공감 수정 부산광역시 동구 홍곡로 75
초량1941 부산광역시 동구 망양로 533-5', '35.125793', '129.04265', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191224171115847_thumbL', '264');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '일광해수욕장', 100, '부산광역시 기장군 일광면 삼성3길 17', '35.259953', '129.23373', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225143353231_thumbL', '265');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '구 백제병원', 100, '부산광역시 동구 중앙대로209번길 16', '35.116383', '129.03917', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225145805369_thumbL', '266');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '백산기념관', 100, '부산광역시 중구 백산길 11', '35.101955', '129.03456', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225150331107_thumbL', '267');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '한성1918 부산생활문화센터', 100, '부산광역시 중구 백산길 13', '35.10178', '129.03444', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225150936833_thumbL', '268');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '조선통신사역사관', 100, '부산광역시 동구 자성로99', '35.135754', '129.06203', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225151358656_thumbL', '269');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산해양자연사박물관', 100, '부산광역시 동래구 우장춘로 175', '35.22178', '129.07591', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225151830289_thumbL', '270');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산근대역사관', 100, '부산 중구 대청로 104', '35.10266', '129.03114', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225152803689_thumbL', '271');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '보수동책방골목', 100, '부산광역시 중구 책방골목길 16', '35.103367', '129.02663', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225154726785_thumbL', '272');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '임시수도기념관', 100, '부산광역시 서구 임시수도기념로 45', '35.103527', '129.01735', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225160342484_thumbL', '273');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '동아대학교 석당박물관', 100, '부산광역시 서구 구덕로 225', '35.10497', '129.01926', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225160959194_thumbL', '274');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '국립일제강제동원역사관', 100, '부산광역시 남구 홍곡로320번길 100', '35.124355', '129.09192', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225162953256_thumbL', '275');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산박물관', 100, '부산광역시 남구 유엔평화로 63', '35.12957', '129.09451', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225163741459_thumbL', '276');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '유엔기념공원, 유엔평화기념관', 100, '유엔기념공원 부산광역시 남구 유엔평화로 93 
유엔평화기념관 부산광역시 남구 홍곡로320번길 106', '35.1277', '129.09775', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225164342360_thumbL', '277');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '오륙도', 100, '부산광역시 남구 오륙도로 137', '35.102177', '129.12334', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225164921130_thumbL', '278');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '신선대', 100, '부산광역시 남구 신선대산복로 174', '35.102272', '129.10277', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225165635368_thumbL', '279');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '송정해수욕장, 죽도공원', 100, '부산광역시 해운대구 송정해변로 62', '35.1786', '129.19966', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230630185239164_thumbL', '280');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '아난티코브 타운, 이터널저니', 100, '부산광역시 기장군 기장읍 기장해안로 268-31', '35.197235', '129.22784', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225170855698_thumbL', '281');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '민락수변공원', 100, '부산 수영구 광안해변로 361', '35.155907', '129.13435', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225174730014_thumbL', '285');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '송도해수욕장', 100, '부산광역시 서구 송도해변로 100', '35.07595', '129.01694', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225175459392_thumbL', '286');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '아미산전망대', 100, '부산광역시 사하구 다대낙조2길 77', '35.052727', '128.96075', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191225180243523_thumbL', '287');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '아미동 비석마을', 100, '부산광역시 서구 아미로49', '35.099068', '129.0127', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226093554532_thumbL', '288');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산시립미술관', 100, '부산광역시 해운대구 APEC로 58', '35.16702', '129.1369', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226100545553_thumbL', '289');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '오랑대공원', 100, '부산광역시 기장군 기장읍 기장해안로 340', '35.205246', '129.22583', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226101451768_thumbL', '290');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '국립수산과학관', 100, '부산광역시 기장군 기장읍 기장해안로 216', '35.193687', '129.22423', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226102157667_thumbL', '291');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '요산문학관', 100, '부산광역시 금정구 팔송로 60-6', '35.27258', '129.08571', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226105751809_thumbL', '295');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '박차정의사 생가', 100, '부산광역시 동래구 명륜로98번길 129-10', '35.201904', '129.0904', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226110347271_thumbL', '296');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '우장춘 기념관', 100, '부산광역시 동래구 우장춘로62번길 7', '35.213547', '129.07202', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226110901484_thumbL', '297');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '누리바라기전망대', 100, '부산광역시 서구 남부민동 50-40', '35.09092', '129.02019', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226113720642_thumbL', '298');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '최민식갤러리', 100, '부산광역시 서구 천마산로410-6', '35.09833', '129.01472', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226115628787_thumbL', '299');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '수영사적공원', 100, '부산광역시 수영구 수영성로 43', '35.170967', '129.1143', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226132135171_thumbL', '301');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산기상관측소', 100, '부산광역시 중구 복병산길32번길 5-11', '35.104973', '129.03218', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226132812226_thumbL', '302');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '을숙도', 100, '부산광역시 사하구 낙동남로 1240', '35.107143', '128.94283', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226143325464_thumbL', '304');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산시청자미디어센터', 100, '부산광역시 해운대구 센텀중앙로 42', '35.17255', '129.1302', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226152407686_thumbL', '308');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '구포어린이교통공원', 100, '부산광역시 북구 낙동북로 687', '35.200867', '129.0008', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226182356876_thumbL', '313');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산솔로몬로파크', 100, '부산광역시 북구 낙동북로 755', '35.200798', '129.00198', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226183133502_thumbL', '314');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산어촌민속관', 100, '부산광역시 북구 학사로 128', '35.234074', '129.00859', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191226184130120_thumbL', '315');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '삼락생태공원', 100, '부산광역시 사상구 낙동대로 1231', '35.16884', '128.97397', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230602100722403_thumbL', '325');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '암남공원/송도해안볼레길', 100, '부산 서구 암남공원로 185', '35.058804', '129.01566', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227112720050_thumbL', '326');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '장림포구 (부네치아)', 100, '부산광역시 사하구 장림로93번길 72', '35.080727', '128.95694', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227160751479_thumbL', '333');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '가덕도', 100, '부산광역시 강서구 가덕해안로 21', '35.022896', '128.8172', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227161822663_thumbL', '334');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '렛츠런파크 부산경남', 100, '부산광역시 강서구 가락대로 929', '35.1566', '128.87521', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227163229549_thumbL', '335');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '국립부산과학관', 100, '부산광역시 기장군 기장읍 동부산관광6로 59', '35.20468', '129.2127', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230901132543063_thumbL', '340');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '송상현광장', 100, '부산광역시 부산진구 중앙대로 818', '35.166397', '129.06595', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227175243198_thumbL', '343');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산어린이대공원', 100, '부산광역시 부산진구 새싹로 295', '35.184998', '129.04153', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227180139517_thumbL', '344');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '국립부산립국악원', 100, '부산광역시 부산진구 국악로2', '35.17132', '129.05424', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227181259877_thumbL', '346');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '삼광사', 100, '부산광역시 부산진구 초읍천로43번길 77', '35.175694', '129.04338', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227184611977_thumbL', '347');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '청사포와 미포', 100, '청사포 부산광역시  해운대구 청사포로128번길 25
미포 부산광역시 해운대구 달맞이길62번길', '35.1602', '129.19138', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227190325222_thumbL', '348');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산시민공원', 100, '부산광역시 부산진구 시민공원로 73', '35.16841', '129.05739', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227194942971_thumbL', '354');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '호천마을', 100, '부산광역시 부산진구 엄광로 491', '35.144295', '129.05106', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227202219554_thumbL', '358');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '봉래산', 100, '부산광역시 영도구 신선동3가 산3', '35.08219', '129.05524', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227202829011_thumbL', '359');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '영화의 거리', 100, '부산광역시 해운대구 마린시티1로 91', '35.154633', '129.14278', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227203859552_thumbL', '361');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, 'APEC나루공원', 100, '부산광역시 해운대구 수영강변대로 85', '35.170307', '129.12564', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227204420832_thumbL', '362');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '40계단', 100, '부산광역시 중구 동광길49', '35.104343', '129.03534', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229141716592_thumbL', '364');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '감천문화마을', 100, '부산광역시 사하구 감내2로 203', '35.095787', '129.00926', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229142305006_thumbL', '365');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '다대포 해수욕장', 100, '부산광역시 사하구 몰운대1길 14', '35.04652', '128.96283', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229143230630_thumbL', '366');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산영화체험박물관, 트릭아이뮤지엄부산', 100, '부산광역시 중구 대청로126번길 12', '35.101692', '129.0337', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229144834500_thumbL', '367');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '용두산공원', 100, '부산광역시 중구 용두산길 37-55', '35.100723', '129.03264', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229145728609_thumbL', '368');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '영도대교', 100, '부산광역시 영도구 태종로 46', '35.095295', '129.03656', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229150331682_thumbL', '369');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '중앙공원, 민주공원', 100, '중앙공원 부산광역시 서구 망양로 193번길 187
민주공원 부산광역시시 중구 민주공원길 19', '35.112125', '129.02792', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229150845004_thumbL', '370');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '황령산 전망쉼터', 100, '부산 남구 황령산로 391-39', '35.158115', '129.08269', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229151710512_thumbL', '371');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, 'F1963', 100, '부산 수영구 구락로123번길 20', '35.176933', '129.11496', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229152254942_thumbL', '372');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '해운대', 100, '부산광역시 해운대구 해운대해변로 264', '35.158474', '129.15987', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153530528_thumbL', '373');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '광안리 해수욕장', 100, '부산광역시 수영구 광안해변로 219', '35.15318', '129.11887', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229160529389_thumbL', '377');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '금정산', 100, '부산광역시 금정구 금성동', '35.280136', '129.0512', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230180640227_thumbL', '396');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '금강공원/식물원', 100, '부산 동래구 우장춘로 155', '35.22047', '129.07494', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230181126685_thumbL', '397');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '범어사', 100, '부산광역시 금정구 범어사로 250', '35.283646', '129.06854', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230190101989_thumbL', '402');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '동래읍성', 100, '부산광역시 동래구 명륜, 복천, 칠산, 명장, 안락동 일대', '35.20975', '129.08997', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230194923757_thumbL', '409');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '상해거리', 100, '부산 동구 중앙대로179번길 11', '35.113808', '129.03786', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230203235198_thumbL', '415');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '이중섭문화거리', 100, '부산광역시 동구 증산로 168', '35.14069', '129.05289', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230205059771_thumbL', '418');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '복천박물관, 복천동고분군', 100, '부산광역시 동래구 복천로 63', '35.208885', '129.09116', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230205640434_thumbL', '419');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '벡스코', 100, '부산광역시 해운대구 APEC로 55', '35.169247', '129.13628', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230210019945_thumbL', '420');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '영화의 전당', 100, '부산광역시 해운대구 수영강변대로 120', '35.171055', '129.12703', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230210358362_thumbL', '421');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '장안사', 100, '부산광역시 기장군 장안읍 장안로 482', '35.374046', '129.23288', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231091948765_thumbL', '425');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '백양산', 100, '부산광역시 부산진구 당감동', '35.182827', '129.02196', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231092729834_thumbL', '426');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '성지곡수원지', 100, '부산광역시 부산진구 새싹로 295', '35.187065', '129.04105', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231100856743_thumbL', '430');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '장산', 100, '부산광역시 해운대구 좌동 1390(대천공원)', '35.193577', '129.14497', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231101745599_thumbL', '432');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '석불사', 100, '부산광역시 북구 만덕고개길 143-79', '35.221504', '129.04861', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231102223413_thumbL', '433');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '회동수원지', 100, '부산광역시 금정구 수원지로', '35.259056', '129.11096', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231105906594_thumbL', '436');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '동래향교, 기장향교', 100, '부산광역시 동래구 동래로 103(동래향교)
부산광역시 기장군 기장읍 차성로417번길 35(기장향교)', '35.207752', '129.0841', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231111302355_thumbL', '439');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '가덕도 연대봉', 100, '부산광역시 강서구 천성동', '35.026875', '128.83395', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231180337567_thumbL', '444');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '승학산 억새평원', 100, '부산광역시 사하구 당리동 산 45-1', '35.116604', '128.97968', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231181104098_thumbL', '445');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '대룡마을', 100, '부산광역시 기장군 장안읍 대룡1길 17', '35.371174', '129.26433', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231184354051_thumbL', '450');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '대신공원', 100, '부산광역시 서구 대신공원로 37-18', '35.12181', '129.01564', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231192024538_thumbL', '456');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '화명수목원', 100, '부산광역시 북구 산성로 299', '35.25257', '129.04205', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231192531286_thumbL', '457');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '선암사', 100, '부산광역시 부산진구 백양산로 138', '35.176968', '129.02771', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231193124555_thumbL', '458');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '운수사', 100, '부산광역시 사상구 모라로219번길 173', '35.18432', '129.01346', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231193736138_thumbL', '459');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '스포원파크', 100, '부산광역시 금정구 체육공원로399번길 324', '35.291504', '129.10487', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231201409836_thumbL', '463');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '우암동 소막마을', 100, '부산광역시 남구 우암번영로 19', '35.1256', '129.07018', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200101164518953_thumbL', '483');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '충렬사', 100, '부산광역시 동래구 충렬대로 345', '35.20119', '129.09607', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200102125306322_thumbL', '501');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산커피박물관', 100, '부산광역시 부산진구 동천로 70 2층 207호', '35.15433', '129.06453', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200102141456051_thumbL', '508');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '사상생활사박물관', 100, '부산광역시 사상구 낙동대로1258번길 36', '35.172', '128.97871', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200102142920888_thumbL', '511');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '사직야구장', 100, '부산광역시 동래구 사직로 45', '35.194107', '129.06151', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200110144727057_thumbL', '527');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '황령산 전망쉼터', 100, '', '35.158302', '129.08281', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200206155647762_thumbL', '543');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산타워', 100, '', '35.101364', '129.0325', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200206095452989_thumbL', '550');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '신평소공원', 100, '부산광역시 기장군 일광면 신평리 11-1', '35.29337', '129.26012', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200514115750295_thumbL', '757');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '기장 도예 관광 힐링촌 테마숲', 100, '부산광역시 기장군 장안읍 기룡리 산126', '35.360134', '129.23999', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200706141824447_thumbL', '804');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '강서구 히든 플레이스', 100, '부산광역시 강서구 신호산단1로 140번길 일대', '35.080696', '128.87846', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200703104501764_thumbL', '809');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산신발이야기', 100, '부산광역시 부산진구 백양대로 227(한국신발관)
부산광역시 동구 범곡북로 22-12(누나의길)', '35.141808', '129.0536', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200706134923010_thumbL', '813');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '가덕해양파크휴게소', 100, '부산광역시 강서구 거가대로 2571', '35.023594', '128.80673', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200717114524295_thumbL', '832');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '송도용궁구름다리', 100, '부산광역시 서구 암남동 620-53', '35.06194', '129.02191', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200717114921294_thumbL', '833');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '우암동 소막마을', 100, '부산광역시 남구 우암번영로 40-1', '35.126194', '129.07597', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200722140028489_thumbL', '838');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산치유의 숲', 100, '부산광역시 기장군 철마면 철마천로 101', '35.26948', '129.12955', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200729150013892_thumbL', '848');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '아미동비석마을', 100, '부산광역시 서구 아미로49', '35.09903', '129.0126', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200818133843206_thumbL', '876');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '대항어촌마을, 정거마을', 100, '대항어촌마을
부산광역시 강서구 가덕해안로1207번길 9-2
정거마을
부산광역시 강서구 눌차동', '35.012188', '128.82697', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20201030154341972_thumbL', '1014');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '유엔기념공원, 유엔평화기념관', 100, '유엔기념공원 부산광역시 남구 유엔평화로 93
유엔평화기념관 부산광역시 남구 홍곡로320번길 106', '35.127785', '129.09766', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20201106141515814_thumbL', '1016');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '기장 달음산 자연휴양림', 100, '부산광역시 기장군 일광면 화용길 299-106', '35.30242', '129.18535', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20201201103753100_thumbL', '1024');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산도서관', 100, '부산광역시 사상구 사상로310번길 33', '35.172737', '128.98526', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20201216170753435_thumbL', '1031');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '해운대 수목원', 100, '부산광역시 해운대구 석대동 77', '35.22992', '129.1327', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230202161355598_thumbL', '1142');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '영도 봉산마을', 100, '부산광역시 영도구 하나길 788 3층(봉산마을도시재생현장지원센터)', '35.09309', '129.05125', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20211116151308755_thumbL', '1179');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, 'KT\&G상상마당 부산', 100, '부산광역시 부산진구 서면로 39', '35.15428', '129.05757', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20211123183743098_thumbL', '1185');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '광안종합시장', 100, '부산광역시 수영구 무학로49번길 71', '35.164215', '129.11816', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20220711140504179_thumbL', '1305');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '롯데월드 어드벤처 부산', 100, '부산광역시 기장군 기장읍 동부산관광로 42', '35.19602', '129.2132', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20220901105446739_thumbL', '1310');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '현대 모터스튜디오 부산', 100, '', '35.17674', '129.11513', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20220913120133333_thumbL', '1322');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '송도해상케이블카, 송도해수욕장, 송도구름산책로, 송도용궁구름다리', 100, '부산광역시 서구 송도해변로 171', '35.076286', '129.02365', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230508183214812_thumbL', '1422');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '화명장미원, 화명생태공원', 100, '화명장미원  부산광역시 북구 화명동 2280
화명생태공원  부산광역시 북구 화명동 1718-17', '35.22568', '129.00327', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230519190619574_thumbL', '1434');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, 'CGV DRIVE IN 영도 자동차극장', 100, 'CGV DRIVE IN 영도 : 부산광역시 영도구 동삼동 1009', '35.062366', '129.08342', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230525134753245_thumbL', '1440');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산근현대역사관', 100, '부산광역시 중구 대청로 104', '35.10258', '129.03203', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230602095512309_thumbL', '1444');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '우암동도시숲', 100, '부산광역시 남구 우암동 12', '35.127033', '129.07382', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230531220739285_thumbL', '1449');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '서면미술관', 100, '부산광역시 부산진구 동천로 58, 2층', '35.153927', '129.06252', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230623172451559_thumbL', '1653');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산현대미술관', 100, '부산광역시 사하구 낙동남로 1191', '35.109245', '128.94263', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230707174450394_thumbL', '1671');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '대저생태공원', 100, '부산광역시 강서구 대저1동 2314-11', '35.20406', '128.98305', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230713153840580_thumbL', '1673');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '맥도생태공원', 100, '부산광역시 강서구 대저2동 1200-32', '35.13791', '128.95354', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230713150615959_thumbL', '1674');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '금빛노을브릿지', 100, '부산광역시 북구 구포동', '35.20871', '128.99739', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230720175854890_thumbL', '1676');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '감전야생화단지', 100, '부산광역시 사상구 감전동 873', '35.142826', '128.96594', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230723172025932_thumbL', '1677');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '국제커피박물관, 영도', 100, '부산광역시 동구 중앙대로 380(좌천동, 구.부산진역)', '35.12724', '129.04846', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230818114709553_thumbL', '1696');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '박태준기념관 ', 100, '부산광역시 기장군 장안읍 임랑해안길 1', '35.31857', '129.26276', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230914182558311_thumbL', '1709');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '다대포해변공원 ', 100, '부산광역시 사하구 다대동 1674', '35.048687', '128.96555', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230921171143286_thumbL', '1718');

--축제
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산바다축제', 200, '', '35.151604', '129.11713', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191213191711585_thumbL', '71');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '태종대, 태종사', 200, '부산광역시 영도구 전망로 119', '35.05602', '129.08812', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191222160520749_thumbL', '253');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '센텀맥주축제, 영화의전당', 200, '부산광역시 해운대구 수영강변대로 120', '35.172085', '129.12915', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227114742493_thumbL', '329');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산 금정산성축제', 200, '부산광역시 금정구 장전온천천로 144', '35.23809', '129.08815', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227115551778_thumbL', '330');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '낙동강구포나루축제', 200, '부산광역시 북구 낙동대로1739번길 257 화명생태공원 선착장', '35.22585', '129.00346', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191227120157384_thumbL', '331');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산불꽃축제', 200, '부산 수영구 광안해변로 219', '35.152725', '129.11848', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230180157336_thumbL', '395');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '삼광사 연등축제', 200, '부산광역시 부산진구 초읍천로43번길 77', '35.175694', '129.04338', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230503134701548_thumbL', '403');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산원도심활성화축제', 200, '부산광역시 동구, 영도구 2개구 일원', '35.104343', '129.03537', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230190825680_thumbL', '404');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '해운대모래축제', 200, '해운대해수욕장, 해운대광장(구남로) 일원', '35.158497', '129.15985', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230522152952371_thumbL', '405');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산항축제', 200, '부산항국제여객터미널, 국립해양박물관 일원', '35.117317', '129.04904', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230191940029_thumbL', '406');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '동래읍성 역사축제', 200, '부산광역시 동래구 문화로 80', '35.21127', '129.09091', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230193142955_thumbL', '407');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산자갈치축제', 200, '부산광역시 중구 자갈치해안로 52', '35.096703', '129.03058', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230200521249_thumbL', '411');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산차이나타운특구 문화축제', 200, '부산광역시 동구 대영로243번길 43', '35.11431', '129.03809', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191230202600804_thumbL', '414');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '해운대빛축제', 200, '부산광역시 해운대구 해운대해변로 264', '35.15849', '129.15987', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20221227165437336_thumbL', '440');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '기장미역다시마축제', 200, '부산광역시 기장군 일광면 이동길 43', '35.271782', '129.2447', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231114635471_thumbL', '441');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '광안리어방축제', 200, '부산광역시 수영구 광안해변로 219', '35.153156', '129.11893', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231174925322_thumbL', '442');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '기장멸치축제', 200, '부산광역시 기장군 기장읍 대변항 일원', '35.223377', '129.23056', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20191231175726016_thumbL', '443');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '광복로 겨울빛 트리축제', 200, '부산광역시 중구 광복로 58-2', '35.09927', '129.03131', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20221227174139947_thumbL', '449');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산국제록페스티벌', 200, '부산광역시 사상구 삼락동 29-46 삼락생태공원', '35.168747', '128.97238', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230913151940386_thumbL', '470');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산낙동강유채꽃축제', 200, '부산광역시 강서구 대저생태공원', '35.1993', '128.97278', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200102112319128_thumbL', '496');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '대저토마토축제', 200, '부산광역시 강서구 체육공원로 43(강서체육공원)', '35.20922', '128.97174', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200102115239175_thumbL', '497');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '삼락벚꽃축제', 200, '부산광역시 사상구 삼락생태공원 일원', '35.169815', '128.9716', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200102120811862_thumbL', '499');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '사상강변축제', 200, '부산광역시 사상구 삼락생태공원 럭비구장 일원', '35.168854', '128.97198', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200102124932671_thumbL', '500');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '해운대달맞이온천축제', 200, '부산광역시 해운대구 해운대해변로 264', '35.1588', '129.16136', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200102125938297_thumbL', '502');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '해운대북극곰축제', 200, '부산광역시 해운대구 해운대해변로 264', '35.158566', '129.1598', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200102133625014_thumbL', '503');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '조선통신사축제', 200, '부산광역시 중구 용두산길 37-55 용두산 공원', '35.10072', '129.03273', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200110115509318_thumbL', '523');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산국제영화제', 200, '부산광역시 해운대구 수영강변대로 120(영화의 전당)', '35.171078', '129.12697', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200110131702589_thumbL', '524');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '감천문화마을 골목축제', 200, '부산광역시 사하구 감내2로 203', '35.095776', '129.00931', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200110160422867_thumbL', '531');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '부산푸드필름페스타', 200, '부산광역시 해운대구 수영강변대로 120', '35.17107', '129.12698', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20200701210502556_thumbL', '807');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, 'BOF', 200, '', '35.102146', '129.03737', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20231013131527561_thumbL', '1062');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '송상현광장, 부산시민공원', 200, '송상현광장 부산광역시 부산진구 중앙대로 지하 818
부산시민공원 부산광역시 부산진구 시민공원로 73', '35.166367', '129.06589', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230517141710433_thumbL', '1432');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, 'APEC나루공원', 200, '부산광역시 해운대구 수영강변대로 85', '35.170654', '129.12547', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230703113706201_thumbL', '1668');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '영화의전당', 200, '부산광역시 해운대구 수영강변대로 120', '35.171036', '129.1269', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230821115632607_thumbL', '1694');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '광안대교 ', 200, '부산광역시 수영구 남천동', '35.136974', '129.11887', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230908145725673_thumbL', '1698');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '영화의전당, 유라리광장, 해운대', 200, '부산 전역(홈페이지 참조)', '35.170982', '129.12717', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230828120440993_thumbL', '1699');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '해운대리버크루즈, 영화의전당, 유라리광장, 다대포해수욕장, 화명생태공원, 금빛노을브릿지', 200, '부산광역시 중구, 북구, 사하구, 해운대구 일대', '35.048126', '128.96556', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230824152948887_thumbL', '1705');
INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL, CONTENTS_ID)
VALUES (seq_place_id.nextval, '해운대역(폐역) / 아뜰리에 칙칙폭폭', 200, '부산광역시 해운대구 해운대로 621', '35.16412', '129.15822', 'https://www.visitbusan.net/uploadImgs/files/cntnts/20230825114337423_thumbL', '1706');

----------------------------------------------------------------------------

-- 부기몬 제공 명소 정보 
-- PLACE table과 PLACE_DETAIL table 정보를 함께 입력 / type : 900~
-- 시퀀스 PLACE : seq_place_id.nextval / PLACE_DETAIL : seq_place_id.currval
-- ex)

-- INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL)
-- VALUES (seq_place_id.nextval, '해운대 미포철길', 900, '부산광역시 해운대 어딘가', 'latitude', 'longitude', 'thumbnail_url');
-- INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
-- VALUES (seq_place_id.currval, '051-701-5648', '해운대 미포철길', '무료', 'example.jpg', 'www.bluelinepark.com', '09:00 AM', '06:00 PM', '주차장');

-- INSERT INTO PLACE (PLACE_ID, NAME, TYPE, ADDR, LAT, LON, THUMBNAIL)
-- VALUES (seq_place_id.nextval, '황령산 레포츠공원', 900, '부산광역시 대연동 어딘가', 'latitude', 'longitude', 'thumbnail_url');
-- INSERT INTO PLACE_DETAIL (PLACE_ID, TEL, DETAIL, PAY, IMG, HOMEPAGE, OPEN, CLOSE, FACILITY)
-- VALUES (seq_place_id.currval, '051-605-4128', '황령산 레포츠공원', '무료', 'example.jpg', 'https://www.jsports.or.kr/bbs/content.php?co_id=07_01', '09:00 AM', '06:00 PM', '와이파이, 주차장');

----------------------------------------------------------------------------

--스탬프북 더미 데이터 입력 
--STAMPBOOK과 STAMP를 함께 입력 

SET TERMOUT ON
PROMPT 스탬프북 더미 데이터 입력 
SET TERMOUT OFF

INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID)
VALUES (seq_stampbook_id.nextval, '부산 세븐비치 여행 총정리', '세븐비치이지만 스탬프는 9개임', 'admin@boogimon.com');

INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 1, 71);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 2, 171);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 3, 141);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 4, 63);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 5, 27);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 6, 122);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 7, 24);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 8, 9);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 9, 7);

--스탬프북 작성과 함께 작성자에게 스탬프북을 pick해야함
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('admin@boogimon.com', seq_stampbook_id.currval);


--무작위 더미 스탬프북 
INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID)
VALUES (seq_stampbook_id.nextval, '무작위 더미 스탬프북', '무작위 번호 부여한 스탬프북 삭제된 것', 'admin@boogimon.com');

INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 1, 23);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 2, 45);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 3, 121);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 4, 54);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 5, 99);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 6, 82);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 7, 14);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 8, 6);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 9, 1);

--스탬프북 작성과 함께 작성자에게 스탬프북을 pick해야함
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('admin@boogimon.com', seq_stampbook_id.currval);

--아름다운 부산
INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID)
VALUES (seq_stampbook_id.nextval, '아름다운 부산', '부산에 놀러오세요~~', 'admin@boogimon.com');

INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 1, 3);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 2, 81);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 3, 49);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 4, 36);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 5, 111);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 6, 119);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 7, 56);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 8, 12);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 9, 42);

--스탬프북 작성과 함께 작성자에게 스탬프북을 pick해야함
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('admin@boogimon.com', seq_stampbook_id.currval);


--그린이 운영자가 만든 스탬프북을 긴빠이해서 만듦
INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID)
VALUES (seq_stampbook_id.nextval, '그린이 만든 세븐비치', '내용 긴빠이함', 'green@google.com');

INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 1, 71);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 2, 171);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 3, 141);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 4, 63);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 5, 27);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 6, 122);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 7, 24);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 8, 9);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 9, 7);

--스탬프북 작성과 함께 작성자에게 스탬프북을 pick해야함
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('green@google.com', seq_stampbook_id.currval);

SET ESCAPE OFF

COMMIT;

----------------------------------------------------------------------------

--결과 출력 활성화
SET TERMOUT ON 

--SELECT 문 실행
SELECT * FROM BoogiTrainer;
SELECT * FROM PLACE;
SELECT * FROM PLACE_DETAIL;
SELECT * FROM STAMPBOOK;
SELECT * FROM STAMP;

--예상쿼리 테스트

--레드가 0번 스탬프북을 담음
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('red@google.com', 0);

--레드가 0번 스탬프북 좋아요
INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID)
VALUES ('red@google.com', 0);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 0;

--레드가 0번 스탬프북에 댓글을 담 
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 0, 'red@google.com', '...');

--레드가 0번 스탬프북의 스탬프를 모두 찍음 
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 0, 1, '/boogimon/images/upload/user/stamp/red1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 0, 2, '/boogimon/images/upload/user/stamp/red2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 0, 3, '/boogimon/images/upload/user/stamp/red3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 0, 4, '/boogimon/images/upload/user/stamp/red4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 0, 5, '/boogimon/images/upload/user/stamp/red5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 0, 6, '/boogimon/images/upload/user/stamp/red6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 0, 7, '/boogimon/images/upload/user/stamp/red7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 0, 8, '/boogimon/images/upload/user/stamp/red8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 0, 9, '/boogimon/images/upload/user/stamp/red9.jpg');

--레드가 담은 0번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'red@google.com' AND STAMPBOOK_ID = 0;

--레드가 그린이 만든 3번 스탬프북을 담음
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('red@google.com', 3);

--레드가 3번 스탬프북에 댓글을 담 
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 3, 'red@google.com', '...!');

--레드가 3번 스탬프북 좋아요
INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID)
VALUES ('red@google.com', 3);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 3;

--그린이 0번 스탬프북 좋아요
INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID)
VALUES ('green@google.com', 0);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 0;

--그린이 1번 스탬프북 좋아요
INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID)
VALUES ('green@google.com', 1);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 1;

--레드가 3번 스탬프북의 1, 4, 5번째 스탬프를 찍음
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 3, 1, '/boogimon/images/upload/user/stamp/red10.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 3, 4, '/boogimon/images/upload/user/stamp/red11.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('red@google.com', 3, 5, '/boogimon/images/upload/user/stamp/red12.jpg');

--1번 스탬프북을 삭제처리함
UPDATE stampbook set deleted = 1 where stampbook_id = 1;
--작성자가 삭제했으므로 작성자의 user_pick에서 삭제 
DELETE FROM user_pick WHERE user_id = 'admin@boogimon.com' AND stampbook_id = 1;

-- 레드가 3번 스탬프북에 찍은 스탬프 모두 조회
-- select * from user_stamp_history where user_id = 'red@google.com' and stampbook_id = 3;

-- 레드가 3번 스탬프북에 찍은 스탬프 모두 삭제
-- DELETE FROM user_stamp_history WHERE user_id = 'red@google.com' AND stampbook_id = 3;

-- 레드가 담은 3번 스탬프북 삭제 
-- DELETE FROM user_pick WHERE user_id = 'red@google.com' AND stampbook_id = 3;

-- select * from user_pick where user_id = 'red@google.com';

COMMIT;

SELECT * FROM USER_PICK;
SELECT * FROM USER_LIKE;
SELECT * FROM USER_STAMP_HISTORY;
SELECT * FROM STB_CMT;

--로그인한 유저의 전체 스탬프북 조회 
SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, to_char(stb.stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') as stampbookRegdate, 
stb.likeCount, 
nvl((SELECT 1 FROM user_like ul where ul.user_id = 'red@google.com' AND ul.stampbook_id = stb.stampbook_id), 0) AS isLike
FROM stampbook stb INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id
WHERE stb.deleted = 0;

--비로그인 유저의 전체 스탬프북 조회
SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, to_char(stb.stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') as stampbookRegdate, 
stb.likeCount
FROM stampbook stb INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id
WHERE stb.deleted = 0;

--로그인한 유저의 내가 담은 스탬프북 조회
SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, to_char(stb.stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') as stampbookRegdate, 
stb.likeCount, 
nvl((SELECT 1 FROM user_like ul where ul.user_id = 'red@google.com' AND ul.stampbook_id = stb.stampbook_id), 0) AS isLike
FROM user_pick up INNER JOIN stampbook stb ON up.stampbook_id = stb.stampbook_id INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id
WHERE up.user_id = 'red@google.com';

--특정 스탬프북의 스탬프 목록 조회
SELECT st.stampno, st.place_id, p.name, p.thumbnail
FROM STAMP st
JOIN PLACE p ON st.place_id = p.place_id
WHERE st.stampbook_id = 0
ORDER BY st.stampno;

--사용자가 담은 스탬프북의 스탬프 목록 조회
SELECT st.stampno, st.place_id, p.name, p.thumbnail, ush.user_id, ush.upload_img, to_char(ush.stamped_date, 'YYYY-MM-DD HH24:MI:SS') as stamped_date
FROM STAMP st
JOIN PLACE p ON st.place_id = p.place_id
LEFT OUTER JOIN USER_STAMP_HISTORY ush ON ush.stampbook_id = st.stampbook_id AND ush.stampno = st.stampno AND ush.user_id = 'red@google.com'
WHERE st.stampbook_id = 3
ORDER BY st.stampno;

--좋아요 테이블 중복 및 삭제된 스탬프북인지 체크 
SELECT stb.deleted, ul.user_id FROM stampbook stb
LEFT OUTER JOIN user_like ul ON ul.stampbook_id = stb.stampbook_id AND ul.user_id = 'red@google.com'
WHERE stb.stampbook_id = 3;

--getUser EXP, 모은 부기몬 추가, 받은 좋아요, ranking
SELECT u.nickname, u.profile_img, TO_CHAR(u.regdate, 'YYYY-MM-DD HH24:MI:SS') AS regdate, u.exp, COUNT(ush.stamped_Date) AS totalVisit, nvl(likeCount, 0) as likeCount, ur.rnum as ranking
FROM boogiTrainer u 
left outer JOIN user_stamp_history ush ON u.user_id = ush.user_id
left outer JOIN (SELECT stb.user_id as origin, count(stb.user_id) as likeCount 
from stampbook stb
join user_like ul on ul.stampbook_id = stb.stampbook_id
where stb.user_id = 'red@google.com'
group by stb.user_id) ON origin = u.user_id
join user_ranking ur on ur.user_id = u.user_id
WHERE u.user_id = 'red@google.com'
GROUP BY u.nickname, u.profile_img, regdate, u.exp, likeCount, rnum;

commit;