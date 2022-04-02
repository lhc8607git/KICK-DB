--제약조건--
------------------------------member--------------------------------------------
--user_id 제약조건 추가
ALTER TABLE member
ADD CONSTRAINT CK_member_USERID
CHECK (REGEXP_LIKE(user_id, '@'));
----------------------------drivers_license-------------------------------------
--license_num 제약조건 추가(00-00-000000-00)
ALTER TABLE drivers_license
ADD CONSTRAINT CK_DRIVERSLICENSE_LICENSE_NUM 
CHECK (REGEXP_LIKE(license_num, '^\d{2}-\d{2}-\d{6}-\d{2}$'));

--serial_num 제약조건 추가(대문자+숫자 5자리)
ALTER TABLE drivers_license
ADD CONSTRAINT CK_DRIVERSLICENSE_SERIAL_NUM 
CHECK (REGEXP_LIKE(serial_num, '^[0-9A-Z]{5}$'));
--------------------------------------card--------------------------------------
--카드번호
ALTER TABLE card
ADD CONSTRAINT CK_CARD_NUM 
CHECK (REGEXP_LIKE(card_num, '^\d{16}$'));
--유효기간
ALTER TABLE card
ADD CONSTRAINT CK_CARD_VALID_THRU
CHECK (SUBSTR(card_valid_thru, 1, 2) BETWEEN 01 AND 12); 
--비밀번호
ALTER TABLE card
ADD CONSTRAINT CK_CARD_PASSWORD
CHECK (card_password BETWEEN 00 AND 99); 
--생년월일, 사업자등록번호
ALTER TABLE card
ADD CONSTRAINT CK_CARD_CHECK_NUM
CHECK (REGEXP_LIKE(card_check_num, '^\d{6,10}$')); 