--가입, 등록프로시저--
-------------------------join_proc: 회원가입 프로시저 생성--------------------------
CREATE OR REPLACE PROCEDURE join_proc
(
    puser_id             member.user_id%TYPE,
    plog_in_method       member.log_in_method%TYPE,
    ppassword            member.password%TYPE,
    ppasswordcheck       member.password%TYPE,
    puser_name           member.user_name%TYPE,
    pbirth               member.birth%TYPE,
    ptel                 member.tel%TYPE,
    pregidate            member.regidate%TYPE := SYSDATE
)
IS
    v_password_not_matched EXCEPTION;
    v_password_length EXCEPTION;
    v_password_format EXCEPTION;
BEGIN
    --길이확인
    IF LENGTH(ppassword) NOT BETWEEN 8 AND 20 THEN
        RAISE v_password_length;
    ELSE
        --비밀번호 포맷확인
        IF REGEXP_LIKE(ppassword, '[a-zA-Z]') 
            AND REGEXP_LIKE(ppassword, '\d') 
            AND REGEXP_LIKE(ppassword, '[[:punct:]]') THEN
            --비밀번호 일치 확인
             IF ppassword != ppasswordcheck THEN
                RAISE v_password_not_matched;
            ELSE
                INSERT INTO member (user_id, log_in_method, password, user_name, birth, tel, regidate)
                VALUES(puser_id, plog_in_method, ppassword, puser_name, pbirth, ptel, pregidate);
                COMMIT;
            END IF;
            
        ELSE
            RAISE v_password_format;
        END IF;
    END IF;
    
EXCEPTION
    --ID 중복 에러
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20000, '> 이미 존재하는 아이디 입니다. 다른 아이디를 입력하세요!');
    --비밀번호 길이 에러
    WHEN v_password_length THEN
        RAISE_APPLICATION_ERROR(-20001, '> 비밀번호가 길이가 맞지 않습니다!');
    --비밀번호 포맷 에러
    WHEN v_password_format THEN
        RAISE_APPLICATION_ERROR(-20001, '> 비밀번호 형식이 맞지 않습니다!');
    --비밀번호 불일치 에러
    WHEN v_password_not_matched THEN
        RAISE_APPLICATION_ERROR(-20003, '> 비밀번호가 일치하지 않습니다!');
    --기타
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, '>OTHERS EXCEPTION');
END;
--------join_trigger: 회원가입 하면 drivers_license, moving_record에 행 추가--------
CREATE OR REPLACE TRIGGER join_trigger
AFTER
    INSERT ON member
FOR EACH ROW
DECLARE
    vuser_id drivers_license.user_id%TYPE;
BEGIN
    vuser_id := :NEW.user_id;
    INSERT INTO drivers_license(user_id, license_num, serial_num, license_regidate)
    VALUES (vuser_id, DEFAULT, DEFAULT, DEFAULT);
    
    INSERT INTO moving_record(user_id, totride, totdistance, tottime)
    VALUES (vuser_id, DEFAULT, DEFAULT, DEFAULT);

END;
-------------------------join_term_agree: 가입약관동의-----------------------------
CREATE OR REPLACE PROCEDURE join_term_agree
( 
    puser_id              membership_term.user_id%TYPE,
    pagree_all            CHAR := 'O'
)
IS
    vmembership_term_code membership_term.membership_term_code%TYPE;
    vagree membership_term.agree%TYPE;
    CURSOR term_serial_cursor IS (SELECT term_code,term_name FROM term WHERE term_category='회원가입');
BEGIN
    FOR vtermrow IN term_serial_cursor
    LOOP
        --약관동의번호 가져오기
        SELECT user_id || ((SELECT COUNT(*) FROM membership_term WHERE user_id=puser_id)+1)
            INTO vmembership_term_code
        FROM member
        WHERE user_id=puser_id;
        
        --선택 동의
        IF vtermrow.term_code=104 THEN
            IF pagree_all = 'O' THEN
                INSERT INTO membership_term(membership_term_code, user_id, term_serial_num, agree) 
                    VALUES(vmembership_term_code, puser_id, vtermrow.term_code, 1);
                COMMIT;
            ELSE
                INSERT INTO membership_term(membership_term_code, user_id, term_serial_num, agree) 
                    VALUES(vmembership_term_code, puser_id, vtermrow.term_code, 0);
                COMMIT;
            END IF;
        --필수 동의
        ELSE
            INSERT INTO membership_term(membership_term_code, user_id, term_serial_num, agree) 
                    VALUES(vmembership_term_code, puser_id, vtermrow.term_code, 1);
            COMMIT;
        END IF;
    END LOOP;
END;
----------------------------register_card: 카드 등록-----------------------------
CREATE OR REPLACE PROCEDURE register_card
(
    puser_id                card.user_id%TYPE,
    pcard_num               card.card_num%TYPE,
    pcard_valid_thru        card.card_valid_thru%TYPE,
    pcard_password          card.card_password%TYPE,
    pcard_check_num         card.card_check_num %TYPE
)
IS
    vcard_code          card.card_code%TYPE;
    vterm_serial_num    card.term_serial_num%TYPE;
    v_card_num_check    NUMBER(2); --최대 등록카드수 10장이라 가정
    
    v_card_num_duplicated EXCEPTION;
    v_card_wrongformat EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_card_wrongformat, -02290);
BEGIN
    
    --카드등록번호 가져오기
    SELECT user_id || ((SELECT COUNT(*) FROM card WHERE user_id=puser_id)+1)
        INTO vcard_code
    FROM member
    WHERE user_id=puser_id;
    
    --관련 약관 가져오기
    SELECT term_code
        INTO vterm_serial_num
    FROM term
    WHERE term_category='카드등록';
    
    --카드번호 중복 확인
    SELECT COUNT(*) 
        INTO v_card_num_check
    FROM card WHERE puser_id=user_id AND pcard_num=card_num;
    
    IF v_card_num_check >= 1 THEN
        RAISE v_card_num_duplicated;
    ELSE
        --카드테이블에 값 넣기
        INSERT INTO card (card_code,user_id,card_num,card_valid_thru,card_password,card_check_num, term_serial_num)
        VALUES( vcard_code,puser_id,pcard_num,pcard_valid_thru,pcard_password,pcard_check_num, vterm_serial_num);
        COMMIT;
    END IF;
EXCEPTION
    --카드번호 중복 에러
    WHEN v_card_num_duplicated THEN
        RAISE_APPLICATION_ERROR(-20010, '> 이미 존재하는 카드번호 입니다. 다른 카드번호를 입력하세요!');
    WHEN v_card_wrongformat THEN
        RAISE_APPLICATION_ERROR(-20011, '> 잘못된 입력 형식입니다! 입력 형식을 확인하세요!');
END;
