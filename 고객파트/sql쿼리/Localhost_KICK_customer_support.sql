--���ν���--
------------------------------inquiry_proc: �����ϱ�------------------------------
--���� ��ȣ ������
CREATE SEQUENCE inquiry_seq;
CREATE OR REPLACE PROCEDURE inquiry_proc
(
    puser_id            inquiry.user_id%TYPE,
    pinquiry_category   inquiry.inquiry_category%TYPE,
    pinquiry_content    inquiry.inquiry_content%TYPE := NULL,
    pride_serial_num    inquiry.ride_serial_num%TYPE,
    ploc                inquiry.loc%TYPE    := NULL,
    pimage              inquiry.image%TYPE := NULL,
    prefund             inquiry.refund%TYPE := 0,
    pinquiry_status     inquiry.inquiry_status%TYPE := 'X'
)
IS
BEGIN
    INSERT INTO inquiry (inquiry_code, user_id, inquiry_category, inquiry_content, ride_serial_num, loc, image, refund, inquiry_status) 
    VALUES (inquiry_seq.NEXTVAL, puser_id, pinquiry_category, pinquiry_content, pride_serial_num, ploc, pimage, prefund, pinquiry_status);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('���� ���� �Ǿ����ϴ�!');
END;
--------------------------inquiry_answer_proc: ���� ó��--------------------------
CREATE OR REPLACE PROCEDURE inquiry_answer_proc
(
    pinquiry_code inquiry.inquiry_code%TYPE,
    pemp_id inquiry.emp_id%TYPE,
    pinquiry_status     inquiry.inquiry_status%TYPE := 'O'
)
IS
BEGIN
    UPDATE inquiry
    SET emp_id = pemp_id, inquiry_status = pinquiry_status
    WHERE inquiry_code=pinquiry_code;
END;
----------------------------inquiry_info: ���� ��ȸ----------------------------
CREATE OR REPLACE PROCEDURE inquiry_info
(
    puser_id inquiry.user_id%TYPE
)
IS
    CURSOR inquiry_cursor IS (SELECT * FROM inquiry WHERE user_id = puser_id);
BEGIN
    FOR vinquiryrow IN inquiry_cursor
    LOOP
        DBMS_OUTPUT.put_line('���ǹ�ȣ       '||vinquiryrow.inquiry_code);
        DBMS_OUTPUT.put_line('�����׸�       '||vinquiryrow.inquiry_category);
        DBMS_OUTPUT.put_line('���ǳ���       '||vinquiryrow.inquiry_content);
        DBMS_OUTPUT.put_line('�̿�ű����     '||vinquiryrow.ride_serial_num);
        DBMS_OUTPUT.put_line('��ġ          '||vinquiryrow.loc);
        DBMS_OUTPUT.put_line('����          '||vinquiryrow.image);
        DBMS_OUTPUT.put_line('ȯ�ҿ���       '||vinquiryrow.refund);
        DBMS_OUTPUT.put_line('ó������       '||vinquiryrow.inquiry_status);
        DBMS_OUTPUT.put_line('-----------------------------------------------');
    END LOOP;
END;
--------------------------accident_proc: ��� ����-------------------------------
CREATE SEQUENCE accident_seq;
CREATE OR REPLACE PROCEDURE accident_proc
(
    pagree_all            CHAR := 'O'
    , pride_serial_num    accident.ride_serial_num%type
    , puser_ID            accident.user_id%type
    , prrn7               accident.rrn7%type
    , paccident_date      accident.accident_date%type
    , paccident_loc       accident.accident_loc%type
    , paccident_detail    accident.accident_detail%type
)
IS
BEGIN
    IF pagree_all='O' THEN
        INSERT INTO accident (accident_code, option_term, ride_serial_num, user_id, rrn7, accident_date, accident_loc, accident_detail)
        VALUES (accident_seq.NEXTVAL, 1,pride_serial_num, puser_id, prrn7, paccident_date, paccident_loc, paccident_detail);
        COMMIT;
    ELSE
        INSERT INTO accident (accident_code, option_term, ride_serial_num, user_id, rrn7, accident_date, accident_loc, accident_detail)
        VALUES (accident_seq.NEXTVAL, 0, pride_serial_num, puser_id, prrn7, paccident_date, paccident_loc, paccident_detail);
        COMMIT;
    END IF;
    DBMS_OUTPUT.PUT_LINE('��� ���� �Ǿ����ϴ�!');
END;
--------------------------accident_answer_proc: ��� ó��--------------------------
CREATE OR REPLACE PROCEDURE accident_answer_proc
(
    paccident_code accident.accident_code%TYPE,
    pemp_id accident.emp_id%TYPE
)
IS
BEGIN
    UPDATE accident
    SET emp_id = pemp_id
    WHERE accident_code=paccident_code;
END;
