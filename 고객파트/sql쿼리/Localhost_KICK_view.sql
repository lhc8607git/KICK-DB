--VIEW: ������ ȸ�������� Ȯ���� �� ���
-----------------------------member_view: ȸ������ ��-----------------------------
CREATE OR REPLACE VIEW member_view
AS
    SELECT m.user_id ���̵�,
           DECODE(log_in_method, 0, '�ž�', 1, 'īī��' )������,
           --password ��й�ȣ,
           RPAD(SUBSTR(password, 1, 2), LENGTH(password)-2, '*') ��й�ȣ,
           user_name �̸�,
           birth �������,
           tel ����ó,
           DECODE(business_account_check, NULL,'�ش����', '����Ͻ�������') ����Ͻ���������,
           regidate ������,
           NVL(ADDITIONAL_SERVIECE_NAME, '����')  ���Ժΰ�����,
           point ������Ʈ,
           DECODE(license_num, NULL, '(��Ͼȵ�)', license_regidate) ��������,
           DECODE(agree, 1, '����', '����') �����ü��ŵ��ǿ���
    FROM member m JOIN drivers_license d ON m.user_id = d.user_id
                  JOIN membership_term mt ON m.user_id = mt.user_id
    WHERE term_serial_num=104
    WITH READ ONLY;
    
    select * from member_view;
