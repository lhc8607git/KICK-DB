--��������--
------------------------------member--------------------------------------------
--user_id �������� �߰�
ALTER TABLE member
ADD CONSTRAINT CK_member_USERID
CHECK (REGEXP_LIKE(user_id, '@'));
----------------------------drivers_license-------------------------------------
--license_num �������� �߰�(00-00-000000-00)
ALTER TABLE drivers_license
ADD CONSTRAINT CK_DRIVERSLICENSE_LICENSE_NUM 
CHECK (REGEXP_LIKE(license_num, '^\d{2}-\d{2}-\d{6}-\d{2}$'));

--serial_num �������� �߰�(�빮��+���� 5�ڸ�)
ALTER TABLE drivers_license
ADD CONSTRAINT CK_DRIVERSLICENSE_SERIAL_NUM 
CHECK (REGEXP_LIKE(serial_num, '^[0-9A-Z]{5}$'));
--------------------------------------card--------------------------------------
--ī���ȣ
ALTER TABLE card
ADD CONSTRAINT CK_CARD_NUM 
CHECK (REGEXP_LIKE(card_num, '^\d{16}$'));
--��ȿ�Ⱓ
ALTER TABLE card
ADD CONSTRAINT CK_CARD_VALID_THRU
CHECK (SUBSTR(card_valid_thru, 1, 2) BETWEEN 01 AND 12); 
--��й�ȣ
ALTER TABLE card
ADD CONSTRAINT CK_CARD_PASSWORD
CHECK (card_password BETWEEN 00 AND 99); 
--�������, ����ڵ�Ϲ�ȣ
ALTER TABLE card
ADD CONSTRAINT CK_CARD_CHECK_NUM
CHECK (REGEXP_LIKE(card_check_num, '^\d{6,10}$')); 