--로그인 프로시저--
------------------------------member_logon: 로그인------------------------------
CREATE OR REPLACE PROCEDURE member_logon
(
    puser_id IN member.user_id%TYPE,
    ppassword IN member.password%TYPE,
    PLOGONCHECK OUT NUMBER
)
IS
    vuser_id member.user_id%TYPE;
    vpassword member.password%TYPE;
BEGIN
    SELECT COUNT(*) INTO vuser_id
    FROM member
    WHERE user_id = puser_id;
    
    IF vuser_id = 0 THEN
        PLOGONCHECK := 1;
    ELSE
        SELECT password INTO vpassword
        FROM member
        WHERE user_id=puser_id;
        
        IF ppassword = vpassword THEN
            PLOGONCHECK := 0;
        ELSE 
            PLOGONCHECK := 2;
        END IF ;
    END IF; 
END;
-------------------------------idfound: 아이디찾기-------------------------------
CREATE OR REPLACE PROCEDURE idfound
(
    puser_name IN member.user_name%type,
    ptel IN member.tel%type
)
IS
    vid member.user_id%type;
BEGIN
    SELECT user_id INTO vid
    FROM member
    WHERE user_name = puser_name AND tel = ptel;

    DBMS_OUTPUT.PUT_LINE(vid);
END;
----------------------------passwordfound: 비번찾기-------------------------------
CREATE OR REPLACE PROCEDURE passwordfound
(
    puser_id    member.user_id%type,
    puser_name  member.user_name%type,
    ptel        member.tel%type
)
IS
    vpassword member.password%type;
BEGIN
    SELECT DBMS_RANDOM.STRING('P',8)||TRUNC(DBMS_RANDOM.VALUE(1,9)) INTO vpassword
    FROM member
    WHERE user_id = puser_id AND user_name = puser_name AND tel = ptel;
    
    UPDATE member
    SET
        password = vpassword
    WHERE user_id = puser_id AND user_name = puser_name AND tel = ptel;
    
    DBMS_OUTPUT.PUT_LINE(vpassword);  
END;