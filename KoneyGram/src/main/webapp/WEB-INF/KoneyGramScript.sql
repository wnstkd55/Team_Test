--게시판 테이블 생성
CREATE TABLE MP_BOARD(
    BNO NUMBER NOT NULL,
    TITLE VARCHAR2(100)     NOT NULL,
    CONTENT VARCHAR2(2000)  NOT NULL,
    WRITER VARCHAR2(100)    NOT NULL,
    REGDATE DATE            DEFAULT SYSDATE,
    PRIMARY KEY(BNO)
);

--게시판 번호 시퀀스 생성
CREATE SEQUENCE MP_BOARD_SEQ
START WITH 1
INCREMENT BY 1;

--게시판 더미 데이터 생성
INSERT INTO MP_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (MP_BOARD_SEQ.NEXTVAL, '제목입니다', '내용입니다', 'BTS');
INSERT INTO MP_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (MP_BOARD_SEQ.NEXTVAL, '안녕하세요', '호이', '뷔');
INSERT INTO MP_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (MP_BOARD_SEQ.NEXTVAL, '고기줘', '배고파', '정국');

--2배수 게시물 증가 쿼리
insert into mp_board(bno, title, content, writer)
select mp_board_seq.nextval, title, content, writer from mp_board;

--조회수 컬럼 추가
ALTER TABLE MP_BOARD ADD(HIT NUMBER DEFAULT 0);
COMMIT;

--답변 완료 컬럼 추가
ALTER TABLE MP_BOARD ADD(answer varchar(20) DEFAULT '답변대기');

--답변 완료 컬럼 삭제
ALTER TABLE MP_BOARD DROP COLUMN replyCom;

SELECT * FROM MP_BOARD order by bno desc;
COMMIT;

--댓글 테이블 생성
create table mp_reply (
    bno number not null,
    rno number not null,
    content varchar2(1000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    primary key(bno, rno)
);

drop table mp_reply;

--외래키 설정
alter table mp_reply add constraint mp_reply_bno foreign key(bno)
references mp_board(bno) on delete cascade;

SELECT * FROM mp_reply;
COMMIT;

--댓글 번호 시퀀스 생성
create sequence mp_reply_seq START WITH 1 MINVALUE 0;
drop sequence mp_reply_seq;
--댓글 더미 데이터 생성
insert into mp_reply(bno, rno, content, writer)
    values(418, mp_reply_seq.nextval, '테스트댓글', '테스트 작성자');

select rno, content, writer, regdate
  from mp_reply
 where bno = 418;


--SID번호 확인
select name from v$database;

-----------------------------------------------------

UPDATE
    MP_BOARD A
SET
    ANSWER = '답변완료'
WHERE EXISTS (
    SELECT
        RNO
    FROM
        MP_REPLY B
    WHERE
        A.BNO = B.BNO
    );
--------------------------------------------------------
update MP_BOARD A
SET
    ANSWER = (
case
when exists
( select rno from MP_REPLY B where A.BNO = B.BNO) 
then '답변완료' else '답변대기' end);


--------------------------------------------------------
SELECT * FROM MP_BOARD order by bno desc;
commit;

-------------------------------------------------------------------------------------------
--팀장님작업(tours)

select * from tours;		--관광지
alter table tours add constraint pk_t_id primary key (t_id);

create table users(			-- 유저테이블(임시)
    userID varchar2(50) primary key
);

create table arr_point(		-- 도착점 테이블
    arr_id varchar2(30) primary key,
    arr_loadaddress varchar2(500),
    arr_gnumaddress varchar2(500),
    arr_ny number(38,8) not null,
    arr_nx number(38,8) not null
);

create table dp_point(		-- 출발점 테이블
    dp_id varchar2(30) primary key,
    dp_loadaddress varchar2(500),
    dp_gnumaddress varchar2(500),
    dp_ny number(38,8) not null,
    dp_nx number(38,8) not null
);

create table my_tourroute(	-- 여행루트 테이블
    tr_id varchar2(30) primary key,
    tr_title varchar2(100) not null,
    tr_date varchar2(100),
    dp_id varchar2(30) not null,
    arr_id varchar2(30) not null,
    t_id number not null,
    userId varchar2(50) not null
);

alter table my_tourroute add tr_content varchar2(2400);

/* 외래키 작업*/
ALTER TABLE my_tourroute
ADD CONSTRAINT fk_dp_id foreign KEY(dp_id) references dp_point (dp_id);

ALTER TABLE my_tourroute
ADD CONSTRAINT fk_arr_id foreign KEY(arr_id) references arr_point (arr_id);

ALTER TABLE my_tourroute
ADD CONSTRAINT fk_t_id foreign KEY(t_id) references tours (t_id);

drop table my_tourroute;
drop table arr_point;
drop table dp_point;

select * from dp_point;

--출발점 임시 더미데이터
insert into dp_point values('1','서울 금천구 독산동 독산4동',' 서울 금천구 독산동 독산4동',37.467779,126.901991);
-- 도착점 임시 더미 데이터
insert into arr_point values('1','서울 금천구 독산동 독산4동',' 서울 금천구 독산동 독산4동',37.467779,126.901991);

select * from dp_point;

select * from arr_point;

desc arr_point;

--행정구역 테이블
create table city(
    c_name varchar2(100) primary key,
    c_ny number(38,8) not null,
    c_nx number(38,8) not null,
    c_pic varchar2(200)
);

-- 행정구역 데이터
insert into city values('강원도',37.555837,128.209315,'강원도.jpg');
insert into city values('경기도',37.567167,127.190292,'경기도.jpg');
insert into city values('경상남도',35.259787,128.664734,'경상남도.jpg');
insert into city values('경상북도',36.248647,128.664734,'경상북도.jpg');
insert into city values('충청남도',36.557229,126.779757,'충청남도.jpg');
insert into city values('충청북도',36.628503,127.929344,'충청북도.jpg');
insert into city values('서울특별시',37.540705,126.956764,'서울특별시.jpg');
insert into city values('광주광역시',35.126033,126.831302,'광주광역시.jpg');
insert into city values('대구광역시',35.798838,128.583052,'대구광역시.jpg');
insert into city values('대전광역시',36.321655,127.378953,'대전광역시.jpg');
insert into city values('부산광역시',35.198362,129.053922,'부산광역시.jpg');
insert into city values('울산광역시',35.519301,129.239078,'울산광역시.jpg');
insert into city values('인천광역시',37.469221,126.573234,'인천광역시.jpg');
insert into city values('전라북도',35.716705,127.144185,'전라북도.jpg');
insert into city values('전라남도',34.819400,126.893113,'전라남도.jpg');
insert into city values('제주특별자치도',33.364805,126.542671,'제주특별자치도.jpg');

select * from city;
SELECT * FROM tours where t_city = '제주특별자치도';
commit;

-- 나의 관광지 일정 페이지 메인 sql
select tr_title as "계획제목", tr_date as "계획날짜", tr_content as "계획 메모", dp_ny as "출발지경도", dp_nx as "출발지위도",
arr_ny as "도착지경도", arr_nx as "도착지위도", t_ny as "관광지 경도", t_nx as "관광지 위도"
from dp_point d, arr_point a, tours t, my_tourroute mt
where d.dp_id = mt.dp_id and a.arr_id = mt.arr_id and t.t_id = mt.tr_id;

commit;

select * from festival;
select * from tours;
delete festival where f_ny is null or f_nx is null;