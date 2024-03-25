# Boogimon

# boogimon


## User

1) 로그인 처리 ✔︎

`POST | /boogimon/user/user.jsp` 

- 요청 변수
    
    ```text
    command : login 
    userId : 30글자 이내 email 형식
    passwd : 32문자 sha-256암호화 문자열
    ```
    
- 출력 예시

    로그인 성공시
    ```json
    {
    		"resultCode":"00", 
    		"resultMsg":"NORMAL_CODE"
    }
    ```
    로그인 실패시
    ```json
    {
        "resultCode": "21",
        "resultMsg": "INVALID_USER_ERROR"
    }
    ```
    

2) 회원 가입 ✔︎

`POST | /boogimon/user/userUpload.jsp`

- 요청 변수
    
    ```text
    command : join
    userId : 30글자 이내 email 형식
    passwd : 32문자 sha-256암호화 문자열
    nickname : 2글자 이상 15글자 이하 문자열
    profileImg : form-data 이미지 포함
    ```
    
- 출력 예시
    가입 성공시
    ```json
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    ```
    가입 실패시
    ```json
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

3) 회원 정보 조회 ✔︎

`GET | /boogimon/user/user.jsp`

- 요청 변수
    
    ```text
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시

    조회 성공시
    ```json
    {
        "resultCode": "00",
    		"resultMsg": "NORMAL_CODE",
        "user": {
            "nickname": "Green",
            "regdate": "2023-11-07 07:49:42",
            "ranking": 2,
            "userTotalVisit": 2,
            "exp": 0,
            "profileImg": "/boogimon/upload/user/profile/green.png",
            "userLikeCount": 1
        }
    }
    ```
    조회 실패시
    ```json
    {"resultCode": 99, "msg": "UNKNOWN_ERROR"}
    ```
    

4) 회원 닉네임 수정 ✔︎

`POST | /boogimon/user/user.jsp`

- 요청 변수
    
    ```text
    command : changeNickname
    userId : 30글자 이내 email 형식
    newNickname : 2글자 이상 15글자 이하 문자열
    ```
    
- 출력 예시

    변경 성공시
    ```json
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    ```
    변경 실패시
    ```json
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

5) 회원 패스워드 수정 ✔︎

`POST | /boogimon/user/user.jsp`

- 요청 변수
    
    ```text
    command : changePasswd
    userId : 30글자 이내 email 형식
    newPasswd : 32문자 sha-256암호화 문자열
    ```
    
- 출력 예시

    변경 성공시
    ```json
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    ```
    변경 실패시
    ```json
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

6) 회원 프로필 사진 수정 ✔︎

`POST | /boogimon/user/userUpload.jsp`

- 요청 변수
    
    ```text
    command : changeImg
    userId : 30글자 이내 email 형식
    profileImg : form-data 이미지 포함
    ```
    
- 출력 예시

    변경 성공시
    ```json
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    ```
    변경 실패시
    ```json
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

7) 랜덤 닉네임 요청 ✔︎

`GET | /boogimon/user/user.jsp?command=randomNickname`

- 요청 변수 없음
    
- 출력 예시

    요청 성공시
    ```json
    {
        "resultCode": "00",
        "resultMsg": "NORMAL_CODE",
        "user": {
            "nickname": "분리수거하는 살바도르 달리"
        }
    }
    ```
    요청 실패시
    ```json
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

8) 회원 탈퇴 ✔︎

`GET | /boogimon/user/user.jsp?command=delete` 

- 요청 변수
    
    ```text
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시

    탈퇴 성공시
    ```json
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    ```
    탈퇴 실패시
    ```json
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

## Stampbook

### 스탬프북

1) 스탬프북 리스트 요청 ✔︎

`GET | /boogimon/stampbook/stampbook.jsp?command=list`

- 요청 변수
    
- 출력 예시

    요청 성공시
    ```json
    {
        "resultCode": "00",
        "stampbookList": [
            {
                "stampList": [
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191222180829962_thumbL",
                        "name": "태종대 유원지",
                        "stampNo": 1
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191231091948765_thumbL",
                        "name": "장안사",
                        "stampNo": 2
                    },
                    ...
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191226182356876_thumbL",
                        "name": "구포어린이교통공원",
                        "stampNo": 9
                    }
                ],
                "stampbookId": 2,
                "isLike": false,
                "nickname": "운영자",
                "description": "무작위 번호 부여한 스탬프북 차후에 수정해야함",
                "stampbookRegdate": "2023-11-09 05:37:32",
                "likeCount": 0,
                "title": "무작위 더미 스탬프북2",
                "profileImg": "/boogimon/images/upload/user/profile/admin.png",
                "completeDate": null
            },
            {
                "stampList": [
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191229160529389_thumbL",
                        "name": "광안리 해수욕장",
                        "stampNo": 1
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20230824152948887_thumbL",
                        "name": "해운대리버크루즈, 영화의전당, 유라리광장, 다대포해수욕장, 화명생태공원, 금빛노을브릿지",
                        "stampNo": 2
                    },
                    ...
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191224093809621_thumbL",
                        "name": "임랑해수욕장 ",
                        "stampNo": 9
                    }
                ],
                "stampbookId": 0,
                "isLike": false,
                "nickname": "운영자",
                "description": "세븐비치이지만 스탬프는 9개임",
                "stampbookRegdate": "2023-11-09 05:37:32",
                "likeCount": 2,
                "title": "부산 세븐비치 여행 총정리",
                "profileImg": "/boogimon/images/upload/user/profile/admin.png",
                "completeDate": null
            }
        ],
        "resultMsg": "NORMAL_CODE"
    }
    ```
    요청 실패시
    ```json
    {"resultCode": 99, "msg": "UNKNOWN_ERROR"}
    ```
    

2) 로그인한 사용자의 스탬프북 리스트 요청 ✔︎

`GET | /boogimon/stampbook/stampbook.jsp?command=list`

- 요청 변수
    
    ```text
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시

    요청 성공시
    ```json
    {
        "resultCode": "00",
        "stampbookList": [
            {
                "stampList": [
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191229160529389_thumbL",
                        "name": "광안리 해수욕장",
                        "stampNo": 1
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20230824152948887_thumbL",
                        "name": "해운대리버크루즈, 영화의전당, 유라리광장, 다대포해수욕장, 화명생태공원, 금빛노을브릿지",
                        "stampNo": 2
                    },
                    ...
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191224093809621_thumbL",
                        "name": "임랑해수욕장 ",
                        "stampNo": 9
                    }
                ],
                "stampbookId": 0,
                **"isLike": true,**
                "nickname": "운영자",
                "description": "세븐비치이지만 스탬프는 9개임",
                "stampbookRegdate": "2023-11-12 08:01:59",
                "likeCount": 2,
                "title": "부산 세븐비치 여행 총정리",
                "profileImg": "/boogimon/images/upload/user/profile/admin.png",
                **"isPick": true,**
                "completeDate": null
            },
            {
                "stampList": [
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191222180829962_thumbL",
                        "name": "태종대 유원지",
                        "stampNo": 1
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191231091948765_thumbL",
                        "name": "장안사",
                        "stampNo": 2
                    },
                    ...
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191226182356876_thumbL",
                        "name": "구포어린이교통공원",
                        "stampNo": 9
                    }
                ],
                "stampbookId": 2,
                **"isLike": false,**
                "nickname": "운영자",
                "description": "무작위 번호 부여한 스탬프북 차후에 수정해야함",
                "stampbookRegdate": "2023-11-12 08:01:59",
                "likeCount": 0,
                "title": "무작위 더미 스탬프북2",
                "profileImg": "/boogimon/images/upload/user/profile/admin.png",
                **"isPick": false,**
                "completeDate": null
            },
            {
                "stampList": [
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191229160529389_thumbL",
                        "name": "광안리 해수욕장",
                        "stampNo": 1
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20230824152948887_thumbL",
                        "name": "해운대리버크루즈, 영화의전당, 유라리광장, 다대포해수욕장, 화명생태공원, 금빛노을브릿지",
                        "stampNo": 2
                    },
                    ...
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191224093809621_thumbL",
                        "name": "임랑해수욕장 ",
                        "stampNo": 9
                    }
                ],
                "stampbookId": 3,
                **"isLike": true,**
                "nickname": "Green",
                "description": "내용 긴빠이함",
                "stampbookRegdate": "2023-11-12 08:01:59",
                "likeCount": 1,
                "title": "그린이 만든 세븐비치",
                "profileImg": "/boogimon/images/upload/user/profile/green.png",
                **"isPick": true,**
                "completeDate": null
            }
        ],
        "resultMsg": "정상"
    }
    ```
    
    요청 실패시
    ```json
    {"resultCode": 99, "msg": "UNKNOWN_ERROR"}
    ```
    

3) 로그인한 사용자의 마이페이지 스탬프북 리스트 요청 ✔︎

`GET | /boogimon/stampbook/stampbook.jsp?command=mylist`

- 요청 변수
    
    ```text
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시

    요청 성공시
    ```json
    {
        "resultCode": "00",
        "stampbookList": [
            {
                "stampList": [
                    {
                        "thumbnail": "/boogimon/images/upload/user/stamp/red10.jpg",
                        "isStamped": true,
                        "stampedDate": "2023-11-13 15:00:52",
                        "name": "광안리 해수욕장",
                        "stampNo": 1
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20230824152948887_thumbL",
                        "isStamped": false,
                        "stampedDate": null,
                        "name": "해운대리버크루즈, 영화의전당, 유라리광장, 다대포해수욕장, 화명생태공원, 금빛노을브릿지",
                        "stampNo": 2
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191230180157336_thumbL",
                        "isStamped": false,
                        "stampedDate": null,
                        "name": "부산불꽃축제",
                        "stampNo": 3
                    },
                    {
                        "thumbnail": "/boogimon/images/upload/user/stamp/red11.jpg",
                        "isStamped": true,
                        "stampedDate": "2023-11-13 15:00:52",
                        "name": "다대포 해수욕장",
                        "stampNo": 4
                    },
                    {
                        "thumbnail": "/boogimon/images/upload/user/stamp/red12.jpg",
                        "isStamped": true,
                        "stampedDate": "2023-11-13 15:00:52",
                        "name": "송도해수욕장",
                        "stampNo": 5
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20230508183214812_thumbL",
                        "isStamped": false,
                        "stampedDate": null,
                        "name": "송도해상케이블카, 송도해수욕장, 송도구름산책로, 송도용궁구름다리",
                        "stampNo": 6
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20230630185239164_thumbL",
                        "isStamped": false,
                        "stampedDate": null,
                        "name": "송정해수욕장, 죽도공원",
                        "stampNo": 7
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191225143353231_thumbL",
                        "isStamped": false,
                        "stampedDate": null,
                        "name": "일광해수욕장",
                        "stampNo": 8
                    },
                    {
                        "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191224093809621_thumbL",
                        "isStamped": false,
                        "stampedDate": null,
                        "name": "임랑해수욕장 ",
                        "stampNo": 9
                    }
                ],
                "stampbookId": 3,
                "isLike": true,
                "nickname": "Green",
                "description": "내용 긴빠이함",
                "stampbookRegdate": "2023-11-13 15:00:49",
                "likeCount": 1,
                "title": "그린이 만든 세븐비치",
                "profileImg": "/boogimon/images/upload/user/profile/green.png",
                "isPick": true,
                "completeDate": null
            }
        ],
        "resultMsg": "정상"
    }
    ```
    요청 실패시
    ```json
    {"resultCode": 99, "msg": "UNKNOWN_ERROR"}
    ```
    

4-1) 특정 스탬프북 데이터 요청 ✔︎

`GET | /boogimon/stampbook/stampbook.jsp`

- 요청 변수
    
    ```text
    stampbookId : number
    ```
    
- 출력 예시

    요청 성공시
    ```json
    {"resultCode":"00","resultMsg":"NORMAL_CODE",
    "stampbook":{
    "stampList":[{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191229160529389_thumbL","isStamped":false,"placeId":71,"stampNo":1,"placeName":"광안리 해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230824152948887_thumbL","isStamped":false,"placeId":171,"stampNo":2,"placeName":"해운대리버크루즈, 영화의전당, 유라리광장, 다대포해수욕장, 화명생태공원, 금빛노을브릿지"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191230180157336_thumbL","isStamped":false,"placeId":141,"stampNo":3,"placeName":"부산불꽃축제"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191229143230630_thumbL","isStamped":false,"placeId":63,"stampNo":4,"placeName":"다대포 해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191225175459392_thumbL","isStamped":false,"placeId":27,"stampNo":5,"placeName":"송도해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230508183214812_thumbL","isStamped":false,"placeId":122,"stampNo":6,"placeName":"송도해상케이블카, 송도해수욕장, 송도구름산책로, 송도용궁구름다리"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230630185239164_thumbL","isStamped":false,"placeId":24,"stampNo":7,"placeName":"송정해수욕장, 죽도공원"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191225143353231_thumbL","isStamped":false,"placeId":9,"stampNo":8,"placeName":"일광해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191224093809621_thumbL","isStamped":false,"placeId":7,"stampNo":9,"placeName":"임랑해수욕장 "}],
    "commentList":[{"nickname":"RED","writeDate":"2023-11-01","commentId":0,"comment":"..."}],
    "stampbookId":0,"isLike":false,"nickname":"운영자","description":"세븐비치이지만 스탬프는 9개임","stampbookRegdate":"2023-11-01 01:53:25","likeCount":2,"title":"부산 세븐비치 여행 총정리"}
    }
    ```
    요청 실패시
    ```json
    {"resultCode": 99, "msg": "UNKNOWN_ERROR"}
    ```
    

4-2) 특정 스탬프북 데이터 요청 (로그인 유저) ✔︎

`GET | /boogimon/stampbook/stampbook.jsp?stampbookId=?&userId=?`

- 요청 변수
    
    ```json
    stampbookId : number
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {
        "stampbook": {
            "stampList": [
                {
                    "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191229160529389_thumbL",
                    "isStamped": false,
                    "placeId": 71,
                    "lon": "129.11887",
                    "stampNo": 1,
                    "placeName": "광안리 해수욕장",
                    "lat": "35.15318"
                },
    						...
                {
                    "thumbnail": "https://www.visitbusan.net/uploadImgs/files/cntnts/20191224093809621_thumbL",
                    "isStamped": false,
                    "placeId": 7,
                    "lon": "129.26451",
                    "stampNo": 9,
                    "placeName": "임랑해수욕장 ",
                    "lat": "35.31905"
                }
            ],
            "commentList": [
                {
                    "nickname": "RED",
                    "writeDate": "2023-11-12 08:02:00",
                    "commentId": 0,
                    "comment": "...",
                    "profileImg": "/boogimon/images/upload/user/profile/red.png"
                }
            ],
            "stampbookId": 0,
            **"isLike": true,**
            "nickname": "운영자",
            "description": "세븐비치이지만 스탬프는 9개임",
            "stampbookRegdate": "2023-11-12 08:01:59",
            "likeCount": 2,
            "title": "부산 세븐비치 여행 총정리",
            "profileImg": "/boogimon/images/upload/user/profile/admin.png",
            **"isPick": true,**
            "completeDate": null
        },
        "resultCode": "00",
        "resultMsg": "정상"
    }
    
    요청 실패시
    {"resultCode": 99, "msg": "UNKNOWN_ERROR"}
    ```
    

5) 스탬프북 담기 ✔︎

`POST | /boogimon/stampbook/stampbook.jsp?command=pick`

- 요청 변수
    
    ```json
    stampbookId: number
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode": 00, "resultMsg":"NORMAL_CODE"}
    
    요청 실패시
    {"resultCode": 99, "msg": "UNKNOWN_ERROR"}
    ```
    

6) 스탬프북 담기 취소 ✔︎

`GET | /boogimon/stampbook/stampbook.jsp?command=unpick`

- 요청 변수
    
    ```json
    userId : 30글자 이내 email 형식
    stampbookId: number
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

7) 스탬프북 삭제 ✔︎

`GET | /boogimon/stampbook/stampbook.jsp?command=delete`

- 요청 변수
    
    ```json
    stampbookId: number
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

8) 스탬프북 좋아요 ✔︎

`GET | /boogimon/stampbook/stampbook.jsp?command=like`

- 요청 변수
    
    ```json
    stampbookId: number
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

9) 스탬프북 좋아요 취소 ✔︎

`GET | /boogimon/stampbook/stampbook.jsp?command=unlike`

- 요청 변수
    
    ```json
    stampbookId: number
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

10) 스탬프북 생성 ✔︎

`POST | /boogimon/stampbook/stampbook.jsp?command=insert`

- 요청 변수
    
    ```json
    userId : 30글자 이내 email 형식
    title : 스탬프북 제목
    description : 스탬프북 설명
    rStampList : json 배열 String
    
    rStampList 예시
    "[
      {
        "stampNo": 1,
        "placeId": 1
      },
      {
        "stampNo": 2,
        "placeId": 2
      },
      {
        "stampNo": 3,
        "placeId": 3
      },
    
    	...
    
      {
        "stampNo": 100,
        "placeId": 100
      }
    ]"
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

### 스탬프

1) 스탬프북의 Stamp List를 요청 ✔︎

`GET | /boogimon/stampbook/stamp.jsp?command=list`

- 요청 변수
    
    ```json
    command : list
    stampbookId: number
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE", 
    "stampList":
    [{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191229160529389_thumbL","isStamped":false,"placeId":71,"stampNo":1,"placeName":"광안리 해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230824152948887_thumbL","isStamped":false,"placeId":171,"stampNo":2,"placeName":"해운대리버크루즈, 영화의전당, 유라리광장, 다대포해수욕장, 화명생태공원, 금빛노을브릿지"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191230180157336_thumbL","isStamped":false,"placeId":141,"stampNo":3,"placeName":"부산불꽃축제"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191229143230630_thumbL","isStamped":false,"placeId":63,"stampNo":4,"placeName":"다대포 해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191225175459392_thumbL","isStamped":false,"placeId":27,"stampNo":5,"placeName":"송도해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230508183214812_thumbL","isStamped":false,"placeId":122,"stampNo":6,"placeName":"송도해상케이블카, 송도해수욕장, 송도구름산책로, 송도용궁구름다리"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230630185239164_thumbL","isStamped":false,"placeId":24,"stampNo":7,"placeName":"송정해수욕장, 죽도공원"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191225143353231_thumbL","isStamped":false,"placeId":9,"stampNo":8,"placeName":"일광해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191224093809621_thumbL","isStamped":false,"placeId":7,"stampNo":9,"placeName":"임랑해수욕장 "}]
    }
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

2) 사용자가 담은 스탬프북의 Stamp List를 요청 ✔︎

`GET | /boogimon/stampbook/stamp.jsp?command=list`

- 요청 변수
    
    ```json
    command : list
    stampbookId: number
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE"
    "stampList":
    [{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191229160529389_thumbL","isStamped":true,"stampedDate":"2023-10-30 02:50:04","placeId":71,"uploadImg":"\/ush\/sample.png","stampNo":1,"placeName":"광안리 해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230824152948887_thumbL","isStamped":false,"placeId":171,"stampNo":2,"placeName":"해운대리버크루즈, 영화의전당, 유라리광장, 다대포해수욕장, 화명생태공원, 금빛노을브릿지"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191230180157336_thumbL","isStamped":false,"placeId":141,"stampNo":3,"placeName":"부산불꽃축제"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191229143230630_thumbL","isStamped":true,"stampedDate":"2023-10-30 02:50:04","placeId":63,"uploadImg":"\/ush\/sample.png","stampNo":4,"placeName":"다대포 해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191225175459392_thumbL","isStamped":true,"stampedDate":"2023-10-30 02:50:04","placeId":27,"uploadImg":"\/ush\/sample.png","stampNo":5,"placeName":"송도해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230508183214812_thumbL","isStamped":false,"placeId":122,"stampNo":6,"placeName":"송도해상케이블카, 송도해수욕장, 송도구름산책로, 송도용궁구름다리"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230630185239164_thumbL","isStamped":false,"placeId":24,"stampNo":7,"placeName":"송정해수욕장, 죽도공원"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191225143353231_thumbL","isStamped":false,"placeId":9,"stampNo":8,"placeName":"일광해수욕장"},{"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191224093809621_thumbL","isStamped":false,"placeId":7,"stampNo":9,"placeName":"임랑해수욕장 "}]
    }
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

3) 스탬프 찍기 ✔︎

`POST | /boogimon/stampbook/stampUpload.jsp` 

- 요청 변수
    
    ```json
    command : newStamp
    stampbookId: number
    userId : 30글자 이내 email 형식
    stampNo : number
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {
        "resultCode": "00",
        "resultMsg": "NORMAL_CODE"
    }
    
    요청 실패시
    {
        "resultCode": "12",
        "resultMsg": "NO_MANDATORY_REQUEST_PARAMETERS_ERROR"
    }
    ```
    

### 코멘트

1) 스탬프북의 Comment List를 요청 ✔︎

`GET | /boogimon/stampbook/comment.jsp?command=list`

- 요청 메소드 `GET`
- 요청 변수
    
    ```json
    command : list
    stampbookId: number
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE", 
    }
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

2) 코멘트 작성 ✔︎

`POST | /boogimon/stampbook/comment.jsp`

- 요청 메소드 `POST`
- 요청 변수
    
    ```json
    stampbookId: number
    userId : 30글자 이내 email 형식
    comment : 공백 불가 250자 이내 문자열 // 공백 불가 검사를 프론트에서..
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

3) 코멘트 삭제 ✔︎

`GET| /boogimon/stampbook/comment.jsp?command=delete`

- 요청 메소드 `GET`
- 요청 변수
    
    ```json
    command : delete
    commentId : number
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE"}
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

## Place

1) 명소의 상세 정보 요청 ✔︎

`GET | /boogimon/place.jsp`

- 요청 변수
    
    ```json
    placeId: number
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE",
    "placeDetail":{
    "img":null,"name":"우암동 도시숲","pay":"무료","tel":"051-607-4000",
    "detail":"우암동 도시숲","addr":"부산광역시 남구 우암2동 산12","close":"12:00 PM",
    "facility":"공영주차장,화장실","open":"12:00 AM","traffic":null,
    "homepage":"www.bsnamgu.go.kr"}
    }
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

2) 명소 목록 요청 ✔︎

`GET | /boogimon/place.jsp?command=list`

- 요청 변수
    
    ```json
    command : list
    keyword : 공백 불가, 검색어 문자열
    ```
    
- 출력 예시
    
    ```json
    요청 성공시 (keyword: 강변)
    {"searchList":[
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191227204420832_thumbL","placeId":60,"name":"APEC나루공원","lon":"129.12564","addr":"부산광역시 해운대구 수영강변대로 85","lat":"35.170307"},
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191230210358362_thumbL","placeId":80,"name":"영화의 전당","lon":"129.12703","addr":"부산광역시 해운대구 수영강변대로 120","lat":"35.171055"},
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20200102124932671_thumbL","placeId":158,"name":"사상강변축제","lon":"128.97198","addr":"부산광역시 사상구 삼락생태공원 럭비구장 일원","lat":"35.168854"},
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20200110131702589_thumbL","placeId":162,"name":"부산국제영화제","lon":"129.12697","addr":"부산광역시 해운대구 수영강변대로 120(영화의 전당)","lat":"35.171078"},
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20200701210502556_thumbL","placeId":164,"name":"부산푸드필름페스타","lon":"129.12698","addr":"부산광역시 해운대구 수영강변대로 120","lat":"35.17107"},
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230703113706201_thumbL","placeId":167,"name":"APEC나루공원","lon":"129.12547","addr":"부산광역시 해운대구 수영강변대로 85","lat":"35.170654"},
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20230821115632607_thumbL","placeId":168,"name":"영화의전당","lon":"129.1269","addr":"부산광역시 해운대구 수영강변대로 120","lat":"35.171036"},
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191227114742493_thumbL","placeId":138,"name":"센텀맥주축제, 영화의전당","lon":"129.12915","addr":"부산광역시 해운대구 수영강변대로 120","lat":"35.172085"}],
    "resultCode":"00","resultMsg":"NORMAL_CODE"
    }
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

3) 부기도감 리스트 요청 ✔︎

`GET | /boogimon/place.jsp?command=boogibook`

- 요청 변수
    
    ```json
    command : boogibook
    userId : 30글자 이내 email 형식
    ```
    
- 출력 예시
    
    ```json
    요청 성공시 
    {"resultCode":"00","resultMsg":"NORMAL_CODE"
    "boogiBook":[
    {"thumbnail":"\/ush\/sample.png","totalVisitCount":1,"name":"임랑해수욕장 ","lastVisitDate":"2023-11-01 08:00:39"},
    {"thumbnail":"\/ush\/sample.png","totalVisitCount":1,"name":"송정해수욕장, 죽도공원","lastVisitDate":"2023-11-01 08:00:39"},
    {"thumbnail":"\/ush\/sample.png","totalVisitCount":2,"name":"다대포 해수욕장","lastVisitDate":"2023-11-01 08:00:39"},
    ...
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191226115628787_thumbL","totalVisitCount":0,"name":"최민식갤러리","lastVisitDate":null},
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191226132135171_thumbL","totalVisitCount":0,"name":"수영사적공원","lastVisitDate":null},
    {"thumbnail":"https:\/\/www.visitbusan.net\/uploadImgs\/files\/cntnts\/20191226132812226_thumbL","totalVisitCount":0,"name":"부산기상관측소","lastVisitDate":null}
    ]}
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```
    

4) 부기도감 명소의 히스토리 정보 요청 ✔︎

`GET | /boogimon/place.jsp?command=boogibookDetail`

- 요청 변수
    
    ```json
    command : boogibook
    userId : 30글자 이내 email 형식
    placeId : number
    ```
    
- 출력 예시
    
    ```json
    요청 성공시
    {"resultCode":"00","resultMsg":"NORMAL_CODE"
    "boogiBookDetail":[
    {"stampedDate":"2023-11-01 08:00:39","name":"송도해수욕장","uploadImg":"\/ush\/sample.png"},
    {"stampedDate":"2023-11-01 08:00:40","name":"송도해수욕장","uploadImg":"\/ush\/sample2.png"}
    ]}
    
    요청 실패시
    {"resultCode":"99","resultMsg":"UNKNOWN_ERROR"}
    ```


## 결과 상태 코드

| ResultCode | ResultMsg | 내용 |
| --- | --- | --- |
| 00 | NORMAL_CODE | 정상 |
| 01 | DB_ERROR | DB에러 |
| 02 | UPDATE_FAILED_ERROR | DB업데이트 실패 |
| 10 | INVALID_REQUEST_ERROR | 잘못된 요청 |
| 11 | INVALID_REQUEST_PARAMETER_ERROR | 잘못된 파라미터 값 |
| 12 | NO_MANDATORY_REQUEST_PARAMETERS_ERROR | 필수 파라미터 누락 |
| 13 | DUPLICATE_REQUEST_ERROR | 중복된 요청 |
| 20 | NON_EXISTENT_USER_ERROR | 존재하지 않는 사용자 |
| 21 | INVALID_USER_ERROR | 잘못된 사용자 요청 |
| 22 | DUPLICATE_USERID_ERROR | 중복된 사용자ID |
| 23 | DUPLICATE_NICKNAME_ERROR | 중복된 닉네임 |
| 24 | DELETED_USER_ERROR | 탈퇴한 회원 |
| 25 | RANDOM_NICKNAME_GENERATION_FAILED_ERROR | 랜덤 닉네임 생성 실패 |
| 26 | USER_EXP_CHANGE_FAILED | 경험치 증감 처리 실패 |
| 30 | NON_EXISTENT_STAMPBOOK_ERROR | 존재하지 않는 스탬프북 |
| 31 | DELETED_STAMPBOOK_ERROR | 삭제된 스탬프북 |
| 32 | LIKE_PROCESSING_FAILED_ERROR | 좋아요 작업 실패 |
| 33 | UNLIKE_PROCESSING_FAILED_ERROR | 좋아요 취소 작업 실패 |
| 34 | LIKE_COUNT_INCREMENT_FAILED_ERROR | 좋아요수 가산 실패 |
| 35 | LIKE_COUNT_DECREMENT_FAILED_ERROR | 좋아요수 감산 실패 |
| 36 | ALREADY_PICKED_STAMPBOOK_ERROR | 사용자가 이미 담은 스탬프북 |
| 37 | UNPICKED_STAMPBOOK_ERROR | 사용자가 담지 않은 스탬프북 |
| 38 | STAMPBOOK_CREATION_FAILED_ERROR | 스탬프북 생성 실패 |
| 39 | STAMPBOOK_PICK_FAILED_ERROR | 스탬프북 담기 실패 |
| 40 | STAMPBOOK_COMPLETE_PROCESS_FAILED_ERROR | 스탬프북 컴플리트 처리 실패 |
| 50 | NON_EXISTENT_STAMP_ERROR | 존재하지 않는 스탬프 |
| 51 | STAMP_CREATION_FAILED_ERROR | 스탬프 생성 실패 |
| 52 | STAMP_UPLOAD_FAILED_ERROR | 스탬프 업로드 실패 |
| 60 | NON_EXISTENT_PLACE_ERROR | 존재하지 않는 명소 |
| 99 | UNKNOWN_ERROR | 기타 에러 |
