--��ȸ ���ν���--
----------------------------member_info: ȸ������ ��ȸ----------------------------
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
    SELECT m.user_id ���̵�,
           LPAD('*', LENGTH(password), '*') ��й�ȣ,
           user_name �̸�,
           TO_CHAR(birth, 'YYYYMMDD') �������,
           tel ����ó,
           DECODE(license_num, NULL, '(��Ͼȵ�)', license_regidate)����������,
           DECODE(agree, 1, '����', '����') �����ü��ŵ��ǿ���
            INTO vuser_id, vpassword, vuser_name, vbirth, vtel, vlicence_check, vmembership_term_agree
    FROM member m JOIN drivers_license d ON m.user_id = d.user_id
                 JOIN membership_term mt ON m.user_id = mt.user_id
    WHERE term_serial_num=104 
          AND m.user_id = puser_id;
    
    DBMS_OUTPUT.put_line('���̵�           '||vuser_id);
    DBMS_OUTPUT.put_line('��й�ȣ         '||vpassword);
    DBMS_OUTPUT.put_line('�̸�            '||vuser_name);
    DBMS_OUTPUT.put_line('�������        '||vbirth);
    DBMS_OUTPUT.put_line('����ó          '||vtel);
    DBMS_OUTPUT.put_line('��������        '||vlicence_check);
    DBMS_OUTPUT.put_line('�����ü��ŵ���   '||vmembership_term_agree);
END;

----------------------------card_info: ī�� ��ȸ------------------------------
CREATE OR REPLACE PROCEDURE card_info
(
    puser_id card.user_id%TYPE
)
IS
    CURSOR card_cursor IS (SELECT * FROM card WHERE user_id = puser_id);
BEGIN
    FOR vcardrow IN card_cursor
    LOOP
        DBMS_OUTPUT.put_line('ī���ȣ       '||lpad(substr(vcardrow.card_num,13,16), 12, '*'));
        DBMS_OUTPUT.put_line('-----------------------------------------------');
    END LOOP;
END;
