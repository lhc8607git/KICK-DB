--1.가입&등록---------------------------------------------------------------------
 --1.1 회원가입
 BEGIN 
    JOIN_PROC(:아이디, :로그인방식, :비밀번호, :비밀번호확인, :이름, :생일, :전화번호);
 END;
    --가입 약관: join_term_agree(회원id[, 선택약관])
    EXEC join_term_agree('JIN@NATE.COM');

  --1.2 카드등록: register_card(아이디, 카드번호, 유효기간, 비밀번호앞두자리, 생년월일(사업자번호))
  EXEC register_card('HEE@NAVER.COM', '5134123412341234', '1221', '09', 201113);
--2.로그인-----------------------------------------------------------------------
 --2.1 로그인
 DECLARE
    LOGONCHECK NUMBER(1);
 BEGIN
    member_logon('a@a', 'e1', LOGONCHECK);
    IF LOGONCHECK = 0 THEN
        DBMS_OUTPUT.PUT_LINE('로그인 성공');
    ELSIF LOGONCHECK = 1 THEN
        DBMS_OUTPUT.PUT_LINE('ID오류');
    ELSE
        DBMS_OUTPUT.PUT_LINE('비밀번호 오류');
    END IF;
 END;
 --2.2 아이디 찾기: idfound(회원명, 전화번호)
 EXEC idfound( '이희창', '010-1234-5678' );
 --2.3 비밀번호 재설정
 EXEC passwordfound( 'HEE@NAVER.COM', '이희창', '010-1234-5678' );
--3.정보조회----------------------------------------------------------------------
 --3.1회원정보 : member_info(아이디)
 EXEC member_info('HEE@NAVER.COM');
 
 --3.2카드정보 : card_info(아이디)
 EXEC card_info('HEE@NAVER.COM');
--4.고객지원----------------------------------------------------------------------
 --4.1 1:1 문의하기 : inquiry_proc(아이디,문의항목,이용킥보드,위치,사진,환불여부)
 EXEC inquiry_proc('HEE@NAVER.COM', '기기 고장', null, 'a123', null, 1);
 --4.2 문의처리 : inquiry_answer_proc(문의번호,답변직원id)
 EXEC inquiry_answer_proc(2, 'hwangjm@')
 --4.3 문의내역 : inquiry_info(아이디)
 EXEC inquiry_info('HEE@NAVER.COM')
 
 --4.4 사고접수* : accident_proc(약관동의,이용시리얼코드,아이디,주민번호뒤7자리,사고일시,사고위치,사고경위)
  --약관 전체 동의
  EXEC accident_proc('O', '123', 'HEE@NAVER.COM', 1231231,'20211113', '서울', '파손');
  --약관 필수 동의
  EXEC accident_proc('X', '123', 'HEE@NAVER.COM', 1231231,'20211113', '서울', '파손');
 --4.5 사고처리 : accident_answer_proc(사고번호,처리직원id)
 EXEC accident_answer_proc(22, 'joeis@');
----5.직원용 뷰------------------------------------------------------------------
 --5.1 회원정보 확인
SELECT * 
FROM member_view;