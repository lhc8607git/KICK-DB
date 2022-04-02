--����, ������ν���--
-------------------------join_proc: ȸ������ ���ν��� ����--------------------------
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
    --����Ȯ��
    IF LENGTH(ppassword) NOT BETWEEN 8 AND 20 THEN
        RAISE v_password_length;
    ELSE
        --��й�ȣ ����Ȯ��
        IF REGEXP_LIKE(ppassword, '[a-zA-Z]') 
            AND REGEXP_LIKE(ppassword, '\d') 
            AND REGEXP_LIKE(ppassword, '[[:punct:]]') THEN
            --��й�ȣ ��ġ Ȯ��
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
    --ID �ߺ� ����
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20000, '> �̹� �����ϴ� ���̵� �Դϴ�. �ٸ� ���̵� �Է��ϼ���!');
    --��й�ȣ ���� ����
    WHEN v_password_length THEN
        RAISE_APPLICATION_ERROR(-20001, '> ��й�ȣ�� ���̰� ���� �ʽ��ϴ�!');
    --��й�ȣ ���� ����
    WHEN v_password_format THEN
        RAISE_APPLICATION_ERROR(-20001, '> ��й�ȣ ������ ���� �ʽ��ϴ�!');
    --��й�ȣ ����ġ ����
    WHEN v_password_not_matched THEN
        RAISE_APPLICATION_ERROR(-20003, '> ��й�ȣ�� ��ġ���� �ʽ��ϴ�!');
    --��Ÿ
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, '>OTHERS EXCEPTION');
END;
--------join_trigger: ȸ������ �ϸ� drivers_license, moving_record�� �� �߰�--------
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
-------------------------join_term_agree: ���Ծ������-----------------------------
CREATE OR REPLACE PROCEDURE join_term_agree
( 
    puser_id              membership_term.user_id%TYPE,
    pagree_all            CHAR := 'O'
)
IS
    vmembership_term_code membership_term.membership_term_code%TYPE;
    vagree membership_term.agree%TYPE;
    CURSOR term_serial_cursor IS (SELECT term_code,term_name FROM term WHERE term_category='ȸ������');
BEGIN
    FOR vtermrow IN term_serial_cursor
    LOOP
        --������ǹ�ȣ ��������
        SELECT user_id || ((SELECT COUNT(*) FROM membership_term WHERE user_id=puser_id)+1)
            INTO vmembership_term_code
        FROM member
        WHERE user_id=puser_id;
        
        --���� ����
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
        --�ʼ� ����
        ELSE
            INSERT INTO membership_term(membership_term_code, user_id, term_serial_num, agree) 
                    VALUES(vmembership_term_code, puser_id, vtermrow.term_code, 1);
            COMMIT;
        END IF;
    END LOOP;
END;
----------------------------register_card: ī�� ���-----------------------------
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
    v_card_num_check    NUMBER(2); --�ִ� ���ī��� 10���̶� ����
    
    v_card_num_duplicated EXCEPTION;
    v_card_wrongformat EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_card_wrongformat, -02290);
BEGIN
    
    --ī���Ϲ�ȣ ��������
    SELECT user_id || ((SELECT COUNT(*) FROM card WHERE user_id=puser_id)+1)
        INTO vcard_code
    FROM member
    WHERE user_id=puser_id;
    
    --���� ��� ��������
    SELECT term_code
        INTO vterm_serial_num
    FROM term
    WHERE term_category='ī����';
    
    --ī���ȣ �ߺ� Ȯ��
    SELECT COUNT(*) 
        INTO v_card_num_check
    FROM card WHERE puser_id=user_id AND pcard_num=card_num;
    
    IF v_card_num_check >= 1 THEN
        RAISE v_card_num_duplicated;
    ELSE
        --ī�����̺� �� �ֱ�
        INSERT INTO card (card_code,user_id,card_num,card_valid_thru,card_password,card_check_num, term_serial_num)
        VALUES( vcard_code,puser_id,pcard_num,pcard_valid_thru,pcard_password,pcard_check_num, vterm_serial_num);
        COMMIT;
    END IF;
EXCEPTION
    --ī���ȣ �ߺ� ����
    WHEN v_card_num_duplicated THEN
        RAISE_APPLICATION_ERROR(-20010, '> �̹� �����ϴ� ī���ȣ �Դϴ�. �ٸ� ī���ȣ�� �Է��ϼ���!');
    WHEN v_card_wrongformat THEN
        RAISE_APPLICATION_ERROR(-20011, '> �߸��� �Է� �����Դϴ�! �Է� ������ Ȯ���ϼ���!');
END;
