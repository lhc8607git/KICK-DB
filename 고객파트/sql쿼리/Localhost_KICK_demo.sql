--1.����&���---------------------------------------------------------------------
 --1.1 ȸ������
 BEGIN 
    JOIN_PROC(:���̵�, :�α��ι��, :��й�ȣ, :��й�ȣȮ��, :�̸�, :����, :��ȭ��ȣ);
 END;
    --���� ���: join_term_agree(ȸ��id[, ���þ��])
    EXEC join_term_agree('JIN@NATE.COM');

  --1.2 ī����: register_card(���̵�, ī���ȣ, ��ȿ�Ⱓ, ��й�ȣ�յ��ڸ�, �������(����ڹ�ȣ))
  EXEC register_card('HEE@NAVER.COM', '5134123412341234', '1221', '09', 201113);
--2.�α���-----------------------------------------------------------------------
 --2.1 �α���
 DECLARE
    LOGONCHECK NUMBER(1);
 BEGIN
    member_logon('a@a', 'e1', LOGONCHECK);
    IF LOGONCHECK = 0 THEN
        DBMS_OUTPUT.PUT_LINE('�α��� ����');
    ELSIF LOGONCHECK = 1 THEN
        DBMS_OUTPUT.PUT_LINE('ID����');
    ELSE
        DBMS_OUTPUT.PUT_LINE('��й�ȣ ����');
    END IF;
 END;
 --2.2 ���̵� ã��: idfound(ȸ����, ��ȭ��ȣ)
 EXEC idfound( '����â', '010-1234-5678' );
 --2.3 ��й�ȣ �缳��
 EXEC passwordfound( 'HEE@NAVER.COM', '����â', '010-1234-5678' );
--3.������ȸ----------------------------------------------------------------------
 --3.1ȸ������ : member_info(���̵�)
 EXEC member_info('HEE@NAVER.COM');
 
 --3.2ī������ : card_info(���̵�)
 EXEC card_info('HEE@NAVER.COM');
--4.������----------------------------------------------------------------------
 --4.1 1:1 �����ϱ� : inquiry_proc(���̵�,�����׸�,�̿�ű����,��ġ,����,ȯ�ҿ���)
 EXEC inquiry_proc('HEE@NAVER.COM', '��� ����', null, 'a123', null, 1);
 --4.2 ����ó�� : inquiry_answer_proc(���ǹ�ȣ,�亯����id)
 EXEC inquiry_answer_proc(2, 'hwangjm@')
 --4.3 ���ǳ��� : inquiry_info(���̵�)
 EXEC inquiry_info('HEE@NAVER.COM')
 
 --4.4 �������* : accident_proc(�������,�̿�ø����ڵ�,���̵�,�ֹι�ȣ��7�ڸ�,����Ͻ�,�����ġ,������)
  --��� ��ü ����
  EXEC accident_proc('O', '123', 'HEE@NAVER.COM', 1231231,'20211113', '����', '�ļ�');
  --��� �ʼ� ����
  EXEC accident_proc('X', '123', 'HEE@NAVER.COM', 1231231,'20211113', '����', '�ļ�');
 --4.5 ���ó�� : accident_answer_proc(����ȣ,ó������id)
 EXEC accident_answer_proc(22, 'joeis@');
----5.������ ��------------------------------------------------------------------
 --5.1 ȸ������ Ȯ��
SELECT * 
FROM member_view;