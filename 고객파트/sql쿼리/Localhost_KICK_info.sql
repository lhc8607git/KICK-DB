--조회 프로시저--
----------------------------member_info: 회원정보 조회----------------------------
CREATE OR REPLACE PROCEDURE member_info
(
    puser_id member.user_id%TYPE
)
IS
    vuser_id member.user_id%TYPE;
    vpassword member.password%TYPE;
    vuser_name member.user_name%TYPE;
    vbirth member.birth%TYPE;
    vtel member.tel%TYPE;
    vlicence_check VARCHAR2(4000);
    vmembership_term_agree VARCHAR2(4000);
BEGIN
    SELECT m.user_id 아이디,
           LPAD('*', LENGTH(password), '*') 비밀번호,
           user_name 이름,
           TO_CHAR(birth, 'YYYYMMDD') 생년월일,
           tel 연락처,
           DECODE(license_num, NULL, '(등록안됨)', license_regidate)운전면허등록,
           DECODE(agree, 1, '동의', '비동의') 마케팅수신동의여부
            INTO vuser_id, vpassword, vuser_name, vbirth, vtel, vlicence_check, vmembership_term_agree
    FROM member m JOIN drivers_license d ON m.user_id = d.user_id
                 JOIN membership_term mt ON m.user_id = mt.user_id
    WHERE term_serial_num=104 
          AND m.user_id = puser_id;
    
    DBMS_OUTPUT.put_line('아이디           '||vuser_id);
    DBMS_OUTPUT.put_line('비밀번호         '||vpassword);
    DBMS_OUTPUT.put_line('이름            '||vuser_name);
    DBMS_OUTPUT.put_line('생년월일        '||vbirth);
    DBMS_OUTPUT.put_line('연락처          '||vtel);
    DBMS_OUTPUT.put_line('운전면허        '||vlicence_check);
    DBMS_OUTPUT.put_line('마케팅수신동의   '||vmembership_term_agree);
END;

----------------------------card_info: 카드 조회------------------------------
CREATE OR REPLACE PROCEDURE card_info
(
    puser_id card.user_id%TYPE
)
IS
    CURSOR card_cursor IS (SELECT * FROM card WHERE user_id = puser_id);
BEGIN
    FOR vcardrow IN card_cursor
    LOOP
        DBMS_OUTPUT.put_line('카드번호       '||lpad(substr(vcardrow.card_num,13,16), 12, '*'));
        DBMS_OUTPUT.put_line('-----------------------------------------------');
    END LOOP;
END;
