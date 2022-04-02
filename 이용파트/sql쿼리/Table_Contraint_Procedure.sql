/* 대여킥보드 */
CREATE TABLE rentalkbod (
   kbod_qrnum VARCHAR2(6) NOT NULL /* 큐알넘버 */
);

CREATE UNIQUE INDEX PK_rentalkbod
   ON rentalkbod (
      kbod_qrnum ASC
   );

ALTER TABLE rentalkbod
   ADD
      CONSTRAINT PK_rentalkbod
      PRIMARY KEY (
         kbod_qrnum
      );

/* 킥보드대여현황 */
CREATE TABLE kbodrentalstate (
   code NUMBER NOT NULL, /* 킥보드대여현황코드 */
   user_ID VARCHAR2(4000) NOT NULL, /* 회원ID */
   kbod_qrnum VARCHAR2(6) NOT NULL, /* 큐알넘버 */
   state CHAR(1) NOT NULL /* 대여상황 */
);

CREATE UNIQUE INDEX PK_kbodrentalstate
   ON kbodrentalstate (
      code ASC
   );

ALTER TABLE kbodrentalstate
   ADD
      CONSTRAINT PK_kbodrentalstate
      PRIMARY KEY (
         code
      );

/* 킥보드위치 */
CREATE TABLE kbodlocation (
   kbod_qrnum VARCHAR2(6) NOT NULL, /* 큐알넘버 */
   img VARCHAR(100) DEFAULT '기본이미지', /* 현재위치이미지 */
   startlat DECIMAL(16,14) NOT NULL, /* 시작위치위도 */
   startlong DECIMAL(17,14) NOT NULL, /* 시작위치경도 */
   reallat DECIMAL(16,14) NOT NULL, /* 실시간위치위도 */
   reallong DECIMAL(17,14) NOT NULL, /* 실시간위치경도 */
   endlat DECIMAL(16,14), /* 반납위치위도 */
   endlong DECIMAL(17,14) /* 반납위치경도 */
);

CREATE UNIQUE INDEX PK_kbodlocation
   ON kbodlocation (
      kbod_qrnum ASC
   );

ALTER TABLE kbodlocation
   ADD
      CONSTRAINT PK_kbodlocation
      PRIMARY KEY (
         kbod_qrnum
      );

/* 결제방식 */
CREATE TABLE paymethod (
   code NUMBER NOT NULL, /* 결제방식코드 */
   category VARCHAR2(10) NOT NULL, /* 결제종류 */
   card_code VARCHAR2(4000) NOT NULL, /* 카드등록번호 */
   user_ID VARCHAR2(4000) NOT NULL /* 회원ID */
);

CREATE UNIQUE INDEX PK_paymethod
   ON paymethod (
      code ASC
   );

ALTER TABLE paymethod
   ADD
      CONSTRAINT PK_paymethod
      PRIMARY KEY (
         code
      );

/* 결제 */
CREATE TABLE pay (
   code NUMBER NOT NULL, /* 결제코드 */
   time TIMESTAMP NOT NULL, /* 결제시간 */
   charge NUMBER NOT NULL, /* 결제금액 */
   addcharge NUMBER NOT NULL, /* 반납추가금액 */
   kickboardcharge_section VARCHAR2(20) NOT NULL, /* 시간대 */
   locationstatus_code NUMBER NOT NULL, /* 씽씽스테이션 위치여부 코드 */
   user_ID VARCHAR2(4000) NOT NULL, /* 회원ID */
   paymethod_code NUMBER NOT NULL, /* 결제방식코드 */
   passchargestatus_code NUMBER NOT NULL, /* 부가서비스여부코드 */
   coupon_name VARCHAR2(20 char) NOT NULL, /* 쿠폰명 */
   passcharge_name VARCHAR2(20 char) NOT NULL, /* 부가서비스요금명 */
   coupon_list_code NUMBER NOT NULL /* 쿠폰내역코드 */
);

CREATE UNIQUE INDEX PK_pay
   ON pay (
      code ASC
   );

ALTER TABLE pay
   ADD
      CONSTRAINT PK_pay
      PRIMARY KEY (
         code
      );

/* 센트럴지역위치 */
CREATE TABLE centralstation (
   code NUMBER NOT NULL, /* 센트럴지역 위치코드 */
   name VARCHAR2(60) NOT NULL, /* 센트럴지역명 */
   explain VARCHAR2(200) NOT NULL, /* 센트럴지역 설명 */
   latitude DECIMAL(16,14) NOT NULL, /* 위도 */
   longitude DECIMAL(17,14) NOT NULL /* 경도 */
);

CREATE UNIQUE INDEX PK_centralstation
   ON centralstation (
      code ASC
   );

ALTER TABLE centralstation
   ADD
      CONSTRAINT PK_centralstation
      PRIMARY KEY (
         code
      );

/* 구성품 */
CREATE TABLE compose (
   kbod_qrnum VARCHAR2(6) NOT NULL, /* 큐알넘버 */
   part_code CHAR(1) NOT NULL, /* 부품상태 */
   state NUMBER NOT NULL /* 부품코드 */
);

CREATE UNIQUE INDEX PK_compose
   ON compose (
      kbod_qrnum ASC
   );

ALTER TABLE compose
   ADD
      CONSTRAINT PK_compose
      PRIMARY KEY (
         kbod_qrnum
      );

/* 부가서비스여부 */
CREATE TABLE passchargestatus (
   code NUMBER NOT NULL, /* 부가서비스여부코드 */
   status CHAR(1) NOT NULL, /* 부가서비스여부 */
   passcharge_name VARCHAR2(20 char) NOT NULL /* 부가서비스요금명 */
);

CREATE UNIQUE INDEX PK_passchargestatus
   ON passchargestatus (
      code ASC
   );

ALTER TABLE passchargestatus
   ADD
      CONSTRAINT PK_passchargestatus
      PRIMARY KEY (
         code
      );

/* 씽씽스테이션위치 */
CREATE TABLE singstation (
   code NUMBER NOT NULL, /* 씽씽스테이션 위치코드 */
   spacename VARCHAR2(60) NOT NULL, /* 장소명 */
   img VARCHAR(100) NOT NULL, /* 이미지 */
   latitude DECIMAL(16,14) NOT NULL, /* 위도 */
   longitude DECIMAL(17,14) NOT NULL /* 경도 */
);

CREATE UNIQUE INDEX PK_singstation
   ON singstation (
      code ASC
   );

ALTER TABLE singstation
   ADD
      CONSTRAINT PK_singstation
      PRIMARY KEY (
         code
      );

/* 킥보드사용시간 */
CREATE TABLE kbodusetime (
   code NUMBER NOT NULL, /* 킥보드사용시간 코드 */
   startuse TIMESTAMP NOT NULL, /* 시작시간 */
   enduse TIMESTAMP, /* 반납시간 */
   lockstart TIMESTAMP, /* 임시잠금시작시간 */
   lockend TIMESTAMP, /* 임시잠금해제시간 */
   kbod_qrnum VARCHAR2(6) NOT NULL /* 큐알넘버 */
);

CREATE UNIQUE INDEX PK_kbodusetime
   ON kbodusetime (
      code ASC
   );

ALTER TABLE kbodusetime
   ADD
      CONSTRAINT PK_kbodusetime
      PRIMARY KEY (
         code
      );

/* 대여회원 */
CREATE TABLE rentaluser (
   user_ID VARCHAR2(4000) NOT NULL /* 회원ID */
);

CREATE UNIQUE INDEX PK_rentaluser
   ON rentaluser (
      user_ID ASC
   );

ALTER TABLE rentaluser
   ADD
      CONSTRAINT PK_rentaluser
      PRIMARY KEY (
         user_ID
      );

/* 부품 */
CREATE TABLE part (
   code NUMBER NOT NULL, /* 부품코드 */
   name VARCHAR2(10) NOT NULL /* 부품명 */
);

CREATE UNIQUE INDEX PK_part
   ON part (
      code ASC
   );

ALTER TABLE part
   ADD
      CONSTRAINT PK_part
      PRIMARY KEY (
         code
      );

/* 씽씽스테이션 위치 여부 */
CREATE TABLE locationstatus (
   code NUMBER NOT NULL, /* 씽씽스테이션 위치여부 코드 */
   status CHAR(1) NOT NULL, /* 위치여부 */
   kbod_qrnum VARCHAR2(6) NOT NULL, /* 큐알넘버 */
   singstation_code NUMBER NOT NULL, /* 씽씽스테이션 위치코드 */
   centralstation_code NUMBER NOT NULL /* 센트럴지역 위치코드 */
);

CREATE UNIQUE INDEX PK_locationstatus
   ON locationstatus (
      code ASC
   );

ALTER TABLE locationstatus
   ADD
      CONSTRAINT PK_locationstatus
      PRIMARY KEY (
         code
      );

/* 부가서비스요금 */
CREATE TABLE passcharge (
   name VARCHAR2(20 char) NOT NULL, /* 부가서비스요금명 */
   charge NUMBER NOT NULL /* 요금 */
);

CREATE UNIQUE INDEX PK_passcharge
   ON passcharge (
      name ASC
   );

ALTER TABLE passcharge
   ADD
      CONSTRAINT PK_passcharge
      PRIMARY KEY (
         name
      );

/* 킥보드 */
CREATE TABLE kbod (
   qrnum VARCHAR2(6) NOT NULL, /* 큐알넘버 */
   bettery NUMBER NOT NULL, /* 베터리잔량 */
   state CHAR(1) NOT NULL, /* 킥보드상태 */
   model VARCHAR2(10) NOT NULL /* 킥보드 모델명 */
);

CREATE UNIQUE INDEX PK_kbod
   ON kbod (
      qrnum ASC
   );

ALTER TABLE kbod
   ADD
      CONSTRAINT PK_kbod
      PRIMARY KEY (
         qrnum
      );

/* 킥보드요금 */
CREATE TABLE kickboardcharge (
   section VARCHAR2(20) NOT NULL, /* 시간대 */
   starttime TIMESTAMP NOT NULL, /* 시작시간 */
   endtime TIMESTAMP NOT NULL, /* 종료시간 */
   unlockcharge NUMBER NOT NULL, /* 잠금해제요금 */
   drivecharge NUMBER NOT NULL /* 주행요금 */
);

CREATE UNIQUE INDEX PK_kickboardcharge
   ON kickboardcharge (
      section ASC
   );

ALTER TABLE kickboardcharge
   ADD
      CONSTRAINT PK_kickboardcharge
      PRIMARY KEY (
         section
      );

/* 킥보드 이용기록 */
CREATE TABLE kbodrecord (
   user_ID VARCHAR2(4000) NOT NULL, /* 회원ID */
   kbod_qrnum VARCHAR2(6) NOT NULL, /* 큐알넘버 */
   kbodusetime_code NUMBER NOT NULL, /* 킥보드사용시간 코드 */
   usetime TIMESTAMP NOT NULL, /* 이용시간 */
   locktime TIMESTAMP NOT NULL /* 임시잠금시간 */
);

/* 카카오페이 */
CREATE TABLE kakaopay (
   user_ID VARCHAR2(4000) NOT NULL, /* 회원ID */
   kakao_account VARCHAR2(320) NOT NULL /* 카카오계정 */
);

CREATE UNIQUE INDEX PK_kakaopay
   ON kakaopay (
      user_ID ASC
   );

ALTER TABLE kakaopay
   ADD
      CONSTRAINT PK_kakaopay
      PRIMARY KEY (
         user_ID
      );

/* 약관 */
CREATE TABLE term (
   term_code NUMBER NOT NULL, /* 약관분류번호 */
   term_category VARCHAR2(50) NOT NULL, /* 약관분류 */
   term_name VARCHAR2(100) NOT NULL, /* 약관명 */
   term_content VARCHAR(4000) NOT NULL /* 약관내용 */
);

CREATE UNIQUE INDEX PK_term
   ON term (
      term_code ASC
   );

ALTER TABLE term
   ADD
      CONSTRAINT PK_term
      PRIMARY KEY (
         term_code
      );

/* 회원 */
CREATE TABLE member (
   user_ID VARCHAR2(4000) NOT NULL, /* 회원ID */
   log_in_method NUMBER(1) NOT NULL, /* 로그인방식 */
   password VARCHAR2(20 byte) NOT NULL, /* 비밀번호 */
   user_name VARCHAR2(30 char) NOT NULL, /* 이름 */
   birth DATE NOT NULL, /* 생년월일 */
   tel VARCHAR2(13 byte) NOT NULL, /* 연락처 */
   business_account_check NUMBER(1) DEFAULT NULL, /* 비즈니스 계정여부 */
   regidate DATE DEFAULT SYSDATE NOT NULL, /* 가입일 */
   additional_serviece_name VARCHAR2(5 char) DEFAULT NULL, /* 부가서비스명 */
   point NUMBER DEFAULT 0 /* 씽마일 */
);

CREATE UNIQUE INDEX PK_member
   ON member (
      user_ID ASC
   );

ALTER TABLE member
   ADD
      CONSTRAINT PK_member
      PRIMARY KEY (
         user_ID
      );

/* 페이코 */
CREATE TABLE payco (
   user_ID VARCHAR2(4000) NOT NULL, /* 회원ID */
   payco_account VARCHAR2(320) NOT NULL /* 페이코계정 */
);

CREATE UNIQUE INDEX PK_payco
   ON payco (
      user_ID ASC
   );

ALTER TABLE payco
   ADD
      CONSTRAINT PK_payco
      PRIMARY KEY (
         user_ID
      );

/* 가입약관 */
CREATE TABLE membership_term (
   membership_term_code VARCHAR2(320 char) NOT NULL, /* 가입약관일련번호 */
   COL VARCHAR2(4000) NOT NULL, /* 회원ID */
   term_serial_num NUMBER NOT NULL, /* 약관분류번호 */
   agree NUMBER(1) NOT NULL /* 동의여부 */
);

CREATE UNIQUE INDEX PK_membership_term
   ON membership_term (
      membership_term_code ASC
   );

ALTER TABLE membership_term
   ADD
      CONSTRAINT PK_membership_term
      PRIMARY KEY (
         membership_term_code
      );

/* 체크/신용카드 */
CREATE TABLE card (
   card_code VARCHAR2(4000) NOT NULL, /* 카드등록번호 */
   user_ID VARCHAR2(4000) NOT NULL, /* 회원ID */
   card_num NUMBER(16) NOT NULL, /* 카드번호 */
   card_valid_thru VARCHAR2(4) NOT NULL, /* 유효기간 */
   card_password VARCHAR2(2) NOT NULL, /* 카드비밀번호 */
   card_check_num NUMBER(10) NOT NULL, /* 확인번호 */
   term_serial_num NUMBER NOT NULL /* 약관분류번호 */
);

CREATE UNIQUE INDEX PK_card
   ON card (
      card_code ASC
   );

ALTER TABLE card
   ADD
      CONSTRAINT PK_card
      PRIMARY KEY (
         card_code
      );

/* 부가서비스 */
CREATE TABLE additional_service (
   additional_service VARCHAR2(10) NOT NULL, /* 부가서비스명 */
   term_code NUMBER NOT NULL /* 약관분류번호 */
);

CREATE UNIQUE INDEX PK_additional_service
   ON additional_service (
      additional_service ASC
   );

ALTER TABLE additional_service
   ADD
      CONSTRAINT PK_additional_service
      PRIMARY KEY (
         additional_service
      );

/* 보유쿠폰 */
CREATE TABLE mycoupon3 (
   coupon_list_code NUMBER NOT NULL, /* 쿠폰내역코드 */
   issue_date DATE, /* 발급일 */
   coupon_validity DATE, /* 유효기간 */
   coupon_name VARCHAR2(20 char), /* 쿠폰명 */
   COL VARCHAR2(4000) /* 회원ID */
);

CREATE UNIQUE INDEX PK_mycoupon3
   ON mycoupon3 (
      coupon_list_code ASC
   );

ALTER TABLE mycoupon3
   ADD
      CONSTRAINT PK_mycoupon3
      PRIMARY KEY (
         coupon_list_code
      );

/* 쿠폰 */
CREATE TABLE coupon (
   coupon_name VARCHAR2(20 char) NOT NULL, /* 쿠폰명 */
   discount NUMBER(5), /* 할인금액 */
   coupon_period DATE, /* 사용기간 */
   coupon_code VARCHAR2(200) /* 쿠폰코드 */
);

CREATE UNIQUE INDEX PK_coupon
   ON coupon (
      coupon_name ASC
   );

ALTER TABLE coupon
   ADD
      CONSTRAINT PK_coupon
      PRIMARY KEY (
         coupon_name
      );

ALTER TABLE rentalkbod
   ADD
      CONSTRAINT FK_kbod_TO_rentalkbod
      FOREIGN KEY (
         kbod_qrnum
      )
      REFERENCES kbod (
         qrnum
      );

ALTER TABLE kbodrentalstate
   ADD
      CONSTRAINT FK_rentalkbod_TO_kbdrntlst
      FOREIGN KEY (
         kbod_qrnum
      )
      REFERENCES rentalkbod (
         kbod_qrnum
      );

ALTER TABLE kbodrentalstate
   ADD
      CONSTRAINT FK_rentaluser_TO_kbdrntlst
      FOREIGN KEY (
         user_ID
      )
      REFERENCES rentaluser (
         user_ID
      );

ALTER TABLE kbodlocation
   ADD
      CONSTRAINT FK_kbod_TO_kbodlocation
      FOREIGN KEY (
         kbod_qrnum
      )
      REFERENCES kbod (
         qrnum
      );

ALTER TABLE paymethod
   ADD
      CONSTRAINT FK_card_TO_paymethod
      FOREIGN KEY (
         card_code
      )
      REFERENCES card (
         card_code
      );

ALTER TABLE paymethod
   ADD
      CONSTRAINT FK_member_TO_paymethod2
      FOREIGN KEY (
         user_ID
      )
      REFERENCES member (
         user_ID
      );

ALTER TABLE pay
   ADD
      CONSTRAINT FK_locationstatus_TO_pay
      FOREIGN KEY (
         locationstatus_code
      )
      REFERENCES locationstatus (
         code
      );

ALTER TABLE pay
   ADD
      CONSTRAINT FK_kickboardcharge_TO_pay
      FOREIGN KEY (
         kickboardcharge_section
      )
      REFERENCES kickboardcharge (
         section
      );

ALTER TABLE pay
   ADD
      CONSTRAINT FK_passcharge_TO_pay
      FOREIGN KEY (
         passcharge_name
      )
      REFERENCES passcharge (
         name
      );

ALTER TABLE pay
   ADD
      CONSTRAINT FK_mycoupon3_TO_pay
      FOREIGN KEY (
         coupon_list_code
      )
      REFERENCES SCOTT.mycoupon3 (
         coupon_list_code
      );

ALTER TABLE pay
   ADD
      CONSTRAINT FK_passchargestatus_TO_pay
      FOREIGN KEY (
         passchargestatus_code
      )
      REFERENCES passchargestatus (
         code
      );

ALTER TABLE pay
   ADD
      CONSTRAINT FK_coupon_TO_pay
      FOREIGN KEY (
         coupon_name
      )
      REFERENCES SCOTT.coupon (
         coupon_name
      );

ALTER TABLE pay
   ADD
      CONSTRAINT FK_paymethod_TO_pay
      FOREIGN KEY (
         paymethod_code
      )
      REFERENCES paymethod (
         code
      );

ALTER TABLE pay
   ADD
      CONSTRAINT FK_member_TO_pay2
      FOREIGN KEY (
         user_ID
      )
      REFERENCES member (
         user_ID
      );

ALTER TABLE compose
   ADD
      CONSTRAINT FK_kbod_TO_compose
      FOREIGN KEY (
         kbod_qrnum
      )
      REFERENCES kbod (
         qrnum
      );

ALTER TABLE compose
   ADD
      CONSTRAINT FK_part_TO_compose
      FOREIGN KEY (
         state
      )
      REFERENCES part (
         code
      );

ALTER TABLE passchargestatus
   ADD
      CONSTRAINT FK_passcharge_TO_pschrgsts
      FOREIGN KEY (
         passcharge_name
      )
      REFERENCES passcharge (
         name
      );

ALTER TABLE kbodusetime
   ADD
      CONSTRAINT FK_kbod_TO_kbodusetime
      FOREIGN KEY (
         kbod_qrnum
      )
      REFERENCES kbod (
         qrnum
      );

ALTER TABLE rentaluser
   ADD
      CONSTRAINT FK_member_TO_rentaluser2
      FOREIGN KEY (
         user_ID
      )
      REFERENCES member (
         user_ID
      );

ALTER TABLE locationstatus
   ADD
      CONSTRAINT FK_kbodlocation_TO_lctnsts
      FOREIGN KEY (
         kbod_qrnum
      )
      REFERENCES kbodlocation (
         kbod_qrnum
      );

ALTER TABLE locationstatus
   ADD
      CONSTRAINT FK_singstation_TO_lctnsts
      FOREIGN KEY (
         singstation_code
      )
      REFERENCES singstation (
         code
      );

ALTER TABLE locationstatus
   ADD
      CONSTRAINT FK_cntrlstn_TO_lctnsts
      FOREIGN KEY (
         centralstation_code
      )
      REFERENCES centralstation (
         code
      );

ALTER TABLE kbodrecord
   ADD
      CONSTRAINT FK_kbodusetime_TO_kbodrecord
      FOREIGN KEY (
         kbodusetime_code
      )
      REFERENCES kbodusetime (
         code
      );

ALTER TABLE kbodrecord
   ADD
      CONSTRAINT FK_kbod_TO_kbodrecord
      FOREIGN KEY (
         kbod_qrnum
      )
      REFERENCES kbod (
         qrnum
      );

ALTER TABLE kbodrecord
   ADD
      CONSTRAINT FK_member_TO_kbodrecord2
      FOREIGN KEY (
         user_ID
      )
      REFERENCES member (
         user_ID
      );

ALTER TABLE kakaopay
   ADD
      CONSTRAINT FK_member_TO_kakaopay2
      FOREIGN KEY (
         user_ID
      )
      REFERENCES member (
         user_ID
      );

ALTER TABLE payco
   ADD
      CONSTRAINT FK_member_TO_payco2
      FOREIGN KEY (
         user_ID
      )
      REFERENCES member (
         user_ID
      );

ALTER TABLE membership_term
   ADD
      CONSTRAINT FK_term_TO_membership_term
      FOREIGN KEY (
         term_serial_num
      )
      REFERENCES term (
         term_code
      );

ALTER TABLE membership_term
   ADD
      CONSTRAINT FK_member_TO_membership_term
      FOREIGN KEY (
         COL
      )
      REFERENCES member (
         user_ID
      );

ALTER TABLE card
   ADD
      CONSTRAINT FK_term_TO_card
      FOREIGN KEY (
         term_serial_num
      )
      REFERENCES term (
         term_code
      );

ALTER TABLE card
   ADD
      CONSTRAINT FK_member_TO_card2
      FOREIGN KEY (
         COL
      )
      REFERENCES member (
         user_ID
      );

ALTER TABLE additional_service
   ADD
      CONSTRAINT FK_term_TO_additional_service
      FOREIGN KEY (
         term_code
      )
      REFERENCES term (
         term_code
      );

ALTER TABLE mycoupon3
   ADD
      CONSTRAINT FK_coupon_TO_mycoupon3
      FOREIGN KEY (
         coupon_name
      )
      REFERENCES coupon (
         coupon_name
      );

ALTER TABLE mycoupon3
   ADD
      CONSTRAINT FK_member_TO_mycoupon32
      FOREIGN KEY (
         COL
      )
      REFERENCES member (
         user_ID                            
      );

------------------------------------------------------------------------------
ALTER TABLE kbodlocation MODIFY STARTLAT VARCHAR2(30);
ALTER TABLE kbodlocation MODIFY STARTLONG VARCHAR2(30);
ALTER TABLE kbodlocation MODIFY REALLAT VARCHAR2(30);
ALTER TABLE kbodlocation MODIFY REALLONG VARCHAR2(30);
ALTER TABLE CENTRALSTATION MODIFY LATITUDE VARCHAR2(20);
ALTER TABLE CENTRALSTATION MODIFY LONGITUDE VARCHAR2(20);

DELETE FROM CENTRALSTATION
WHERE
CODE = 2;

ALTER TABLE kbodlocation MODIFY KBOD_QRNUM 


SELECT *
FROM KBODRENTALSTATE;

DESC LOCATIONSTATUS;

SELECT * FROM CARD
SELECT * FROM KBOD
SELECT * FROM MEMBER
SELECT * FROM RENTALKBOD
SELECT * FROM RENTALUSER
SELECT * FROM KBODRENTALSTATE
SELECT * FROM KBODLOCATION -- VARCHAR2(20)
SELECT * FROM KBODUSETIME
SELECT * FROM CENTRALSTATION
DESC CENTRALSTATION
INSERT INTO CENTRALSTATION (CODE, NAME, EXPLAIN, LATITUDE, LONGITUDE) VALUES (1,'씽씽센트럴 내','반납시 추가요금 발생하지 않아요.',4480402.4418775,14122741.5855834);



--제약조건--
------------------------------kbodrentalstate-------------------------------------
ALTER TABLE kbodrentalstate
ADD CONSTRAINT CK_kbodrentalstate_STATE
CHECK(state IN ('1','0'));
------------------------------compose-------------------------------------
ALTER TABLE compose
ADD CONSTRAINT CK_compose_STATE
CHECK(state IN ('1','0'));
------------------------------kbod-------------------------------------
-- qrnum 제약조건 추가 (대문자+숫자 6자리)
ALTER TABLE kbod
ADD CONSTRAINT CK_kbod_QRNUM
CHECK (REGEXP_LIKE(qrnum, '^[0-9A-Z]{6}$'));

ALTER TABLE kbod
ADD CONSTRAINT CK_kbod_BETTERY
CHECK (bettery BETWEEN 0 AND 100); 

ALTER TABLE kbod
ADD CONSTRAINT CK_kbod_STATE
CHECK(state IN ('1','0'));

ALTER TABLE kbod
ADD CONSTRAINT CK_kbod_MODEL
CHECK(model IN ('1세대', '2세대', '3세대', '4세대'));
------------------------------kickboardcharge-------------------------------------
ALTER TABLE kickboardcharge
ADD CONSTRAINT CK_kickboardcharge_SECTION
CHECK(section IN ('평일', '주말', '심야'));
------------------------------centralstation-------------------------------------
ALTER TABLE centralstation
ADD CONSTRAINT CK_centralstation_NAME
CHECK(name IN ('씽씽센트럴 내', '씽씽센트럴 외', '반납금지지역', '주행금지지역'));
------------------------------locationstatus-------------------------------------
ALTER TABLE locationstatus
ADD CONSTRAINT CK_locationstatus_STATE
CHECK(state IN ('1','0'));
------------------------------passchargestatus-------------------------------------
ALTER TABLE passchargestatus
ADD CONSTRAINT CK_passchargestatus_STATE
CHECK(state IN ('1','0'));




-- 1.대여
(대여킥보드)
-------------------------rental_proc: 대여킥보드 프로시저 생성--------------------------
CREATE OR REPLACE PROCEDURE rental_proc
(
   pkbod_qrnum    rentalkbod.kbod_qrnum%TYPE  -- 대여킥보드
)
IS
BEGIN
   INSERT INTO rentalkbod ( kbod_qrnum )
   VALUES ( pkbod_qrnum );
   COMMIT;
END;
-- Procedure RENTAL_PROC이(가) 컴파일되었습니다.

EXEC RENTAL_PROC('FFF666');



-- 2.대여 
(대여회원)
-------------------------rentaluser_proc: 대여회원 프로시저 생성--------------------------
CREATE OR REPLACE PROCEDURE rentaluser_proc
(
   puser_id   rentaluser.user_id%TYPE  -- 대여회원
)
IS
BEGIN
   INSERT INTO rentaluser ( user_id )
   VALUES ( puser_id );
   COMMIT;
END;
-- Procedure RENTALUSER_PROC이(가) 컴파일되었습니다.

EXEC RENTALUSER_PROC('SOO@NAVER.COM');


-- 3.킥보드 대여 현황
(킥보드 대여 중인 사용자 리스트)
-------------------------up_kbodrentalstate: 킥보드 대여 중인 사용자 리스트 프로시저 생성--------------------------
CREATE OR REPLACE PROCEDURE up_kbodrentalstate
IS
BEGIN
   FOR vkbodrow IN ( SELECT * FROM kbodrentalstate )
   LOOP
      DBMS_OUTPUT.PUT_LINE( vkbodrow.user_id || ', ' || vkbodrow.kbod_qrnum);
   END LOOP; 
-- EXCEPTION
END;
-- Procedure UP_KBODRENTALSTATE이(가) 컴파일되었습니다.
EXEC UP_KBODRENTALSTATE;
--HEE@NAVER.COM, AAA111
--JIN@NATE.COM, BBB222
--SEO@GMAIL.COM, CCC333