--gold
INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID)
VALUES (seq_stampbook_id.nextval, '부산 영도', '오늘 하루, 영도에서', 'gold@google.com');

INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 1, 66);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 2, 1);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 3, 0);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 4, 117);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 5, 3);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 6, 2);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 7, 150);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 8, 133);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 9, 124);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com', seq_stampbook_id.currval);

--silver
INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID)
VALUES (seq_stampbook_id.nextval, '부산 축제', '부산 10월 축제', 'silver@google.com');

INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 1, 147);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 2, 148);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 3, 146);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 4,161 );
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 5, 163);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 6, 162);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 7, 158);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 8, 154);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 9, 140);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES('silver@google.com',seq_stampbook_id.currval);

--ruby
INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID)
VALUES (seq_stampbook_id.nextval, '부산 박물관', '부산지식 여행 ', 'ruby@google.com');

INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 1, 2);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 2, 14);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 3, 15);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 4, 18 );
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 5, 20);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 6, 64);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 7, 78);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 8, 98);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 9, 99);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES('ruby@google.com',seq_stampbook_id.currval);

--sapphire
INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID)
VALUES (seq_stampbook_id.nextval, '부산 마을', '어서와 부산 마을은 처음이지? ', 'sapphire@google.com');

INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 1, 109);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 2, 90);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 3, 62);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 4, 57 );
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 5, 29);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 6, 1);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 7, 0);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 8, 112);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 9, 117);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES( 'sapphire@google.com',seq_stampbook_id.currval);

--white
INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID)
VALUES (seq_stampbook_id.nextval, '부산 MZ ', '부산 MZ 취향 저격!', 'white@google.com');

INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 1, 120);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 2, 121);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 3, 69);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 4, 169);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 5, 25);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 6, 100);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 7, 118);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 8, 127);
INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID)
VALUES (seq_stampbook_id.currval, 9, 119);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES( 'white@google.com',seq_stampbook_id.currval); 

--------------------------------------------------------유저 스탬프 담기 더미 데이터
--골드(4~8)--
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com', 5);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com', 6);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com', 7);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com', 8);

--실버(6~8)--
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('silver@google.com', 6);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('silver@google.com', 7);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('silver@google.com', 8);

--루비(7~8)--
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('ruby@google.com', 7);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('ruby@google.com', 8);

--사파이어(4~6)--
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('sapphire@google.com', 4);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('sapphire@google.com', 5);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('sapphire@google.com', 6);

--화이트(4~7)--
INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('white@google.com', 4);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('white@google.com', 5);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('white@google.com', 6);

INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID)
VALUES ('white@google.com', 7);

---------------------------------------------------------유저 좋아요 더미 데이터
--레드(4~8)--
INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID)
VALUES ('red@google.com', 4);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 4;

INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID)
VALUES ('red@google.com', 5);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 5;

INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID)
VALUES ('red@google.com', 6);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 6;

INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID)
VALUES ('red@google.com', 7);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 7;

INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID)
VALUES ('red@google.com', 8);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 8;

--그린(4~8)--
INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('green@google.com', 4);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 4;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('green@google.com', 5);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 5;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('green@google.com', 6);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 6;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('green@google.com', 7);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 7;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('green@google.com',  8);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 8;

--골드(4~8)--
INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com', 4);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 4;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com', 5);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 5;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com', 6);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 6;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com', 7);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 7;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('gold@google.com',  8);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 8;

--실버(4~8)--
INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('silver@google.com', 4);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 4;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('silver@google.com', 5);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 5;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('silver@google.com', 6);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 6;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('silver@google.com', 7);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 7;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('silver@google.com',  8);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 8;

--루비(4~8)--
INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('ruby@google.com', 4);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 4;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('ruby@google.com', 5);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 5;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('ruby@google.com', 6);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 6;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('ruby@google.com', 7);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 7;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('ruby@google.com',  8);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 8;

--사파이어(4~8)
INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('sapphire@google.com', 4);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 4;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('sapphire@google.com', 5);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 5;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('sapphire@google.com', 6);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 6;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('sapphire@google.com', 7);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 7;

INSERT INTO USER_LIKE(USER_ID, STAMPBOOK_ID)
VALUES ('sapphire@google.com',  8);

UPDATE STAMPBOOK
SET LIKECOUNT = LIKECOUNT + 1
WHERE STAMPBOOK_ID = 8;

--------------------------------------------------------스탬프 북 댓글(필요하시면 사용하세요.)
--레드--

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'red@google.com' , '멋져요');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 5, 'red@google.com', '좋아요');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 6, 'red@google.com', '최고입니다');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 7, 'red@google.com', '올ㅋㅋㅋ');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 8, 'red@google.com', '꼭 가볼게요.');

--그린(4~8)--
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'green@google.com', '좋아요');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 5, 'green@google.com', '이번주 방문각');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 6, 'green@google.com', '가보고 싶었는 데 가야겠다..');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 7, 'green@google.com', '올 꿀팁ㅋㅋㅋ.');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 8, 'green@google.com', '놀러가야겠다');

--골드(4~8)--
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'gold@google.com', '가즈아');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 5, 'gold@google.com', '긔긔긔긔긔');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 6, 'gold@google.com', '멋진 정보 감사해요');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 7, 'gold@google.com', '가볼게요');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 8, 'gold@google.com', '감사감사');

--실버(4~8)--
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'silver@google.com', '감사합니다');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 5, 'silver@google.com', '들어 가자~~');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 6, 'silver@google.com', '한번 생각해봐야겠다.');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 7, 'silver@google.com', '개꿀.');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 8, 'silver@google.com', '괜찮은듯');

--루비(4~8)--
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'ruby@google.com', '좋아요');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 5, 'ruby@google.com', '괜춘');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 6, 'ruby@google.com', '괜춘');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 7, 'ruby@google.com', '괜춘');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 8, 'ruby@google.com', '괜춘');

--사파이어(4~8)
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'sapphire@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 5, 'sapphire@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 6, 'sapphire@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 7, 'sapphire@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 8, 'sapphire@google.com', 'GOOD');

--다이아몬드(0~4)--
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 0, 'diamond@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 1, 'diamond@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 2, 'diamond@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 3, 'diamond@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'diamond@google.com', 'GOOD');

--펄(0~4)--
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 0, 'pearl@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 1, 'pearl@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 2, 'pearl@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 3, 'pearl@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'pearl@google.com', 'GOOD');

--블랙(1~5)--
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 1, 'black@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 2, 'black@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 3, 'black@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'black@google.com', 'GOOD');


INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 5, 'black@google.com', 'GOOD');

--화이트(1~5)--
INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 1, 'white@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 2, 'white@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 3, 'white@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 4, 'white@google.com', 'GOOD');

INSERT INTO STB_CMT (COMMENT_ID, STAMPBOOK_ID, USER_ID, BCOMMENT)
VALUES (seq_comment_id.nextval, 5, 'white@google.com', 'GOOD');

--------------------------------------------------------스탬프 찍기
--골드(4~8)--
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 4, 1, '/boogimon/images/upload/user/stamp/gold1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 4, 2, '/boogimon/images/upload/user/stamp/gold2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 4, 3, '/boogimon/images/upload/user/stamp/gold3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 4, 4, '/boogimon/images/upload/user/stamp/gold4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 4, 5, '/boogimon/images/upload/user/stamp/gold5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 4, 6, '/boogimon/images/upload/user/stamp/gold6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 4, 7, '/boogimon/images/upload/user/stamp/gold7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 4, 8, '/boogimon/images/upload/user/stamp/gold8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 4, 9, '/boogimon/images/upload/user/stamp/gold9.jpg');

-- 골드 담은 4번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'gold@google.com' AND STAMPBOOK_ID = 4;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 5, 1, '/boogimon/images/upload/user/stamp/silver1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 5, 2, '/boogimon/images/upload/user/stamp/silver2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 5, 3, '/boogimon/images/upload/user/stamp/silver3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 5, 4, '/boogimon/images/upload/user/stamp/silver4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 5, 5, '/boogimon/images/upload/user/stamp/silver5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 5, 6, '/boogimon/images/upload/user/stamp/silver6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 5, 7, '/boogimon/images/upload/user/stamp/silver7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 5, 8, '/boogimon/images/upload/user/stamp/silver8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 5, 9, '/boogimon/images/upload/user/stamp/silver9.jpg');

-- 골드 담은 5번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'gold@google.com' AND STAMPBOOK_ID = 5;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 6, 1, '/boogimon/images/upload/user/stamp/ruby1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 6, 2, '/boogimon/images/upload/user/stamp/ruby2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 6, 3, '/boogimon/images/upload/user/stamp/ruby3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 6, 4, '/boogimon/images/upload/user/stamp/ruby4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 6, 5, '/boogimon/images/upload/user/stamp/ruby5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 6, 6, '/boogimon/images/upload/user/stamp/ruby6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 6, 7, '/boogimon/images/upload/user/stamp/ruby7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 6, 8, '/boogimon/images/upload/user/stamp/ruby8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 6, 9, '/boogimon/images/upload/user/stamp/ruby9.jpg');

-- 골드 담은 6번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'gold@google.com' AND STAMPBOOK_ID = 6;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 7, 1, '/boogimon/images/upload/user/stamp/sapphire1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 7, 2, '/boogimon/images/upload/user/stamp/sapphire2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 7, 3, '/boogimon/images/upload/user/stamp/sapphire3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 7, 4, '/boogimon/images/upload/user/stamp/sapphire4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 7, 5, '/boogimon/images/upload/user/stamp/sapphire5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 7, 6, '/boogimon/images/upload/user/stamp/sapphire6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 7, 7, '/boogimon/images/upload/user/stamp/sapphire7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 7, 8, '/boogimon/images/upload/user/stamp/sapphire8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 7, 9, '/boogimon/images/upload/user/stamp/sapphire9.jpg');

-- 골드 담은 7번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'gold@google.com' AND STAMPBOOK_ID = 7;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 8, 1, '/boogimon/images/upload/user/stamp/white1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 8, 2, '/boogimon/images/upload/user/stamp/white2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 8, 3, '/boogimon/images/upload/user/stamp/white3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 8, 4, '/boogimon/images/upload/user/stamp/white4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 8, 5, '/boogimon/images/upload/user/stamp/white5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 8, 6, '/boogimon/images/upload/user/stamp/white6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 8, 7, '/boogimon/images/upload/user/stamp/white7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 8, 8, '/boogimon/images/upload/user/stamp/white8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('gold@google.com', 8, 9, '/boogimon/images/upload/user/stamp/white9.jpg');

-- 골드 담은 8번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'gold@google.com' AND STAMPBOOK_ID = 8;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 6, 1, '/boogimon/images/upload/user/stamp/ruby1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 6, 2, '/boogimon/images/upload/user/stamp/ruby2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 6, 3, '/boogimon/images/upload/user/stamp/ruby3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 6, 4, '/boogimon/images/upload/user/stamp/ruby4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 6, 5, '/boogimon/images/upload/user/stamp/ruby5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 6, 6, '/boogimon/images/upload/user/stamp/ruby6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 6, 7, '/boogimon/images/upload/user/stamp/ruby7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 6, 8, '/boogimon/images/upload/user/stamp/ruby8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 6, 9, '/boogimon/images/upload/user/stamp/ruby9.jpg');

-- 실버 담은 6번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'silver@google.com' AND STAMPBOOK_ID = 6;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 7, 1, '/boogimon/images/upload/user/stamp/sapphire1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 7, 2, '/boogimon/images/upload/user/stamp/sapphire2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 7, 3, '/boogimon/images/upload/user/stamp/sapphire3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 7, 4, '/boogimon/images/upload/user/stamp/sapphire4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 7, 5, '/boogimon/images/upload/user/stamp/sapphire5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 7, 6, '/boogimon/images/upload/user/stamp/sapphire6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 7, 7, '/boogimon/images/upload/user/stamp/sapphire7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 7, 8, '/boogimon/images/upload/user/stamp/sapphire8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 7, 9, '/boogimon/images/upload/user/stamp/sapphire9.jpg');

-- 실버 담은 7번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'silver@google.com' AND STAMPBOOK_ID = 7;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 8, 1, '/boogimon/images/upload/user/stamp/white1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 8, 2, '/boogimon/images/upload/user/stamp/white2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 8, 3, '/boogimon/images/upload/user/stamp/white3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 8, 4, '/boogimon/images/upload/user/stamp/white4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 8, 5, '/boogimon/images/upload/user/stamp/white5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 8, 6, '/boogimon/images/upload/user/stamp/white6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 8, 7, '/boogimon/images/upload/user/stamp/white7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 8, 8, '/boogimon/images/upload/user/stamp/white8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('silver@google.com', 8, 9, '/boogimon/images/upload/user/stamp/white9.jpg');

--실버 담은 8번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'silver@google.com' AND STAMPBOOK_ID = 8;


--루비(7~8)--
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 7, 1, '/boogimon/images/upload/user/stamp/sapphire1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 7, 2, '/boogimon/images/upload/user/stamp/sapphire2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 7, 3, '/boogimon/images/upload/user/stamp/sapphire3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 7, 4, '/boogimon/images/upload/user/stamp/sapphire4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 7, 5, '/boogimon/images/upload/user/stamp/sapphire5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 7, 6, '/boogimon/images/upload/user/stamp/sapphire6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 7, 7, '/boogimon/images/upload/user/stamp/sapphire7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 7, 8, '/boogimon/images/upload/user/stamp/sapphire8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 7, 9, '/boogimon/images/upload/user/stamp/sapphire9.jpg');

--루비 담은 7번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'ruby@google.com' AND STAMPBOOK_ID = 7;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 8, 1, '/boogimon/images/upload/user/stamp/white1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 8, 2, '/boogimon/images/upload/user/stamp/white2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 8, 3, '/boogimon/images/upload/user/stamp/white3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 8, 4, '/boogimon/images/upload/user/stamp/white4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 8, 5, '/boogimon/images/upload/user/stamp/white5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 8, 6, '/boogimon/images/upload/user/stamp/white6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 8, 7, '/boogimon/images/upload/user/stamp/white7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 8, 8, '/boogimon/images/upload/user/stamp/white8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('ruby@google.com', 8, 9, '/boogimon/images/upload/user/stamp/white9.jpg');

--루비 담은 8번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'ruby@google.com' AND STAMPBOOK_ID = 8;


--사파이어(4~8)
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 4, 1, '/boogimon/images/upload/user/stamp/gold1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 4, 2, '/boogimon/images/upload/user/stamp/gold2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 4, 3, '/boogimon/images/upload/user/stamp/gold3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 4, 4, '/boogimon/images/upload/user/stamp/gold4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 4, 5, '/boogimon/images/upload/user/stamp/gold5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 4, 6, '/boogimon/images/upload/user/stamp/gold6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 4, 7, '/boogimon/images/upload/user/stamp/gold7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 4, 8, '/boogimon/images/upload/user/stamp/gold8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 4, 9, '/boogimon/images/upload/user/stamp/gold9.jpg');

--사파이어 담은 4번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'sapphire@google.com' AND STAMPBOOK_ID = 4;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 5, 1, '/boogimon/images/upload/user/stamp/silver1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 5, 2, '/boogimon/images/upload/user/stamp/silver2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 5, 3, '/boogimon/images/upload/user/stamp/silver3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 5, 4, '/boogimon/images/upload/user/stamp/silver4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 5, 5, '/boogimon/images/upload/user/stamp/silver5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 5, 6, '/boogimon/images/upload/user/stamp/silver6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 5, 7, '/boogimon/images/upload/user/stamp/silver7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 5, 8, '/boogimon/images/upload/user/stamp/silver8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 5, 9, '/boogimon/images/upload/user/stamp/silver9.jpg');

--사파이어 담은 5번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'sapphire@google.com' AND STAMPBOOK_ID = 5;


INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 6, 1, '/boogimon/images/upload/user/stamp/ruby1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 6, 2, '/boogimon/images/upload/user/stamp/ruby2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 6, 3, '/boogimon/images/upload/user/stamp/ruby3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 6, 4, '/boogimon/images/upload/user/stamp/ruby4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 6, 5, '/boogimon/images/upload/user/stamp/ruby5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 6, 6, '/boogimon/images/upload/user/stamp/ruby6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 6, 7, '/boogimon/images/upload/user/stamp/ruby7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 6, 8, '/boogimon/images/upload/user/stamp/ruby8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('sapphire@google.com', 6, 9, '/boogimon/images/upload/user/stamp/ruby9.jpg');

--사파이어 담은 6번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'sapphire@google.com' AND STAMPBOOK_ID = 6;

--화이트(4)
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 4, 1, '/boogimon/images/upload/user/stamp/gold1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 4, 2, '/boogimon/images/upload/user/stamp/gold2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 4, 3, '/boogimon/images/upload/user/stamp/gold3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 4, 4, '/boogimon/images/upload/user/stamp/gold4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 4, 5, '/boogimon/images/upload/user/stamp/gold5.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 4, 6, '/boogimon/images/upload/user/stamp/gold6.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 4, 7, '/boogimon/images/upload/user/stamp/gold7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 4, 8, '/boogimon/images/upload/user/stamp/gold8.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 4, 9, '/boogimon/images/upload/user/stamp/gold9.jpg');

--화이트 담은 4번 스탬프북을 완성함
UPDATE USER_PICK
SET COMPLETE_DATE = SYSDATE
WHERE USER_ID = 'white@google.com' AND STAMPBOOK_ID = 4;


---------------------------------------------------------------------------------------------------스탬프북의 스탬프를 찍음
--white 5번 스탬프북의 1, 5번째 스탬프를 찍음
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 5, 1, '/boogimon/images/upload/user/stamp/silver1.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 5, 5, '/boogimon/images/upload/user/stamp/silver5.jpg');

--white 6번 스탬프북의 2, 4, 6번째 스탬프를 찍음
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 5, 2, '/boogimon/images/upload/user/stamp/silver2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 5, 4, '/boogimon/images/upload/user/stamp/silver4.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 5, 6, '/boogimon/images/upload/user/stamp/silver6.jpg');

--white 7번 스탬프북의 2, 3, 7, 8번째 스탬프를 찍음
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 7, 2, '/boogimon/images/upload/user/stamp/sapphire2.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 7, 3, '/boogimon/images/upload/user/stamp/sapphire3.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 7, 7, '/boogimon/images/upload/user/stamp/sapphire7.jpg');
INSERT INTO USER_STAMP_HISTORY (USER_ID, STAMPBOOK_ID, STAMPNO, UPLOAD_IMG)
VALUES ('white@google.com', 7, 8, '/boogimon/images/upload/user/stamp/sapphire8.jpg');

commit;