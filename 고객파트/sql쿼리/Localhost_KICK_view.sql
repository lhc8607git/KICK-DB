--VIEW: 직원이 회원정보를 확인할 때 사용
-----------------------------member_view: 회원정보 뷰-----------------------------
CREATE OR REPLACE VIEW member_view
AS
    SELECT m.user_id 아이디,
           DECODE(log_in_method, 0, '씽씽', 1, '카카오' )사용계정,
           --password 비밀번호,
           RPAD(SUBSTR(password, 1, 2), LENGTH(password)-2, '*') 비밀번호,
           user_name 이름,
           birth 생년월일,
           tel 연락처,
           DECODE(business_account_check, NULL,'해당없음', '비즈니스계정명') 비즈니스계정여부,
           regidate 가입일,
           NVL(ADDITIONAL_SERVIECE_NAME, '없음')  가입부가서비스,
           point 씽포인트,
           DECODE(license_num, NULL, '(등록안됨)', license_regidate) 운전면허,
           DECODE(agree, 1, '동의', '비동의') 마케팅수신동의여부
    FROM member m JOIN drivers_license d ON m.user_id = d.user_id
                  JOIN membership_term mt ON m.user_id = mt.user_id
    WHERE term_serial_num=104
    WITH READ ONLY;
    
    select * from member_view;
