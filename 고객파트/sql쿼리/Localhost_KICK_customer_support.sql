--프로시저--
------------------------------inquiry_proc: 문의하기------------------------------
--문의 번호 시퀀스
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
    DBMS_OUTPUT.PUT_LINE('문의 접수 되었습니다!');
END;
--------------------------inquiry_answer_proc: 문의 처리--------------------------
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
----------------------------inquiry_info: 문의 조회----------------------------
CREATE OR REPLACE PROCEDURE inquiry_info
(
    puser_id inquiry.user_id%TYPE
)
IS
    CURSOR inquiry_cursor IS (SELECT * FROM inquiry WHERE user_id = puser_id);
BEGIN
    FOR vinquiryrow IN inquiry_cursor
    LOOP
        DBMS_OUTPUT.put_line('문의번호       '||vinquiryrow.inquiry_code);
        DBMS_OUTPUT.put_line('문의항목       '||vinquiryrow.inquiry_category);
        DBMS_OUTPUT.put_line('문의내용       '||vinquiryrow.inquiry_content);
        DBMS_OUTPUT.put_line('이용킥보드     '||vinquiryrow.ride_serial_num);
        DBMS_OUTPUT.put_line('위치          '||vinquiryrow.loc);
        DBMS_OUTPUT.put_line('사진          '||vinquiryrow.image);
        DBMS_OUTPUT.put_line('환불여부       '||vinquiryrow.refund);
        DBMS_OUTPUT.put_line('처리여부       '||vinquiryrow.inquiry_status);
        DBMS_OUTPUT.put_line('-----------------------------------------------');
    END LOOP;
END;
--------------------------accident_proc: 사고 접수-------------------------------
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
    DBMS_OUTPUT.PUT_LINE('사고 접수 되었습니다!');
END;
--------------------------accident_answer_proc: 사고 처리--------------------------
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
