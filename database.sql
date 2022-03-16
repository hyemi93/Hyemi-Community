/*회원 테이블*/
drop table user_tbl;
create table user_tbl(
	id varchar2(20) primary key,			--회원 아이디
	nickname varchar2(20) unique not null,  --회원 닉네임
	pw varchar2(20) not null,				--계정 비밀번호
	tel varchar2(15) not null,				--회원 연락처
	email varchar2(30) not null,			--회원 이메일
	grade number(1) default 1 not null		--회원 등급
);

/*테스트용 쿼리*/
insert into user_tbl values('hyemi0509', 'hh', '1234', '010-1234-5678', 'hmheo@hanmail.net', '3');
insert into user_tbl values('hmheo93', 'hyemi', '1234', '010-3456-7890', 'hmheo@hanmail.net', '1');

select * from user_tbl;


/*관리자 테이블*/
drop table admin_tbl;
create table admin_tbl(
	aid varchar2(20) primary key,  --관리자 아이디
	nickname varchar2(20),		   --관리자 닉네임
	apw varchar2(20)			   --관리자 비밀번호
);

/*테스트용 쿼리*/
insert into admin_tbl values('admin', '관리자', 'admin');

select * from admin_tbl;


/*일반게시판 테이블*/
alter table board_tbl drop primary key cascade;
drop table board_tbl;
create table board_tbl(
	bnum number(5) not null,		 --게시판 글번호
	rebnum number(5), 				 --게시판 답글번호
	id varchar2(20) not null, 		 --작성자 아이디
	nickname varchar2(20) not null,  --작성자 닉네임
	title varchar2(80) not null, 	 --글제목
	content varchar2(2000) not null, --글내용
	bdate date default sysdate, 	 --작성일
	hit number(5) default 0, 		 --조회수
	depth number(5) default 0, 		 --들여쓰기
	location number(5) default 1,  	 --새 글이 위에 오게 위치 정보 저장
	commnum number(5) default 0, 	 --댓글 수
	category varchar2(30), 			 --게시판 카테고리
	primary key(bnum, category)
);

/*테스트용 쿼리*/
insert into board_tbl values(1, null, 'admin', '관리자', '공지1', '공지내용', sysdate, 0, 0, 2, 0, '공지사항');
insert into board_tbl values(2, null, 'admin', '관리자', '공지2', '공지내용2', sysdate, 0, 0, 1, 0, '공지사항');

insert into board_tbl values(1, null, 'hyemi0509', 'hh', '안녕하세요', '반갑습니다', sysdate, 0, 0, 2, 0, '인사말');
insert into board_tbl values(2, null, 'hyemi0509', 'hh', '잘부탁드립니다', '반가워요', sysdate, 0, 0, 1, 0, '인사말');

select * from board_tbl;


/*한줄게시판 테이블*/
drop table lineboard_tbl;
create table lineboard_tbl (
	bnum number(5) primary key,		 --글번호
	rebnum number(5), 				 --답글번호
	id varchar2(20) not null, 		 --작성자 아이디
	nickname varchar2(20) not null,  --작성자 닉네임
	content varchar2(2000) not null, --글내용
	depth number(5) default 0, 		 --들여쓰기
	location number(5) default 1, 	 --새 글이 위에 오게 위치 정보 저장
	bdate date default sysdate, 	 --작성일
	secretyn char(1), 				 --비밀글 여부
	category varchar2(30) 			 --게시판 카테고리
);

/*한줄게시판 글번호 시퀀스*/
drop sequence lineboard_seq;
create sequence lineboard_seq start with 1;

/*테스트용 쿼리*/
insert into lineboard_tbl values(lineboard_seq.nextval, null, 'hyemi0509', 'hh', '등업신청합니다', 0, 2, sysdate, 'Y', '등업신청');
insert into lineboard_tbl values(lineboard_seq.nextval, null, 'hmheo93', 'hyemi', '등업신청합니다', 0, 1, sysdate, 'Y', '등업신청');

select * from lineboard_tbl;


/*사진게시판 테이블*/
drop table photoboard_tbl;
create table photoboard_tbl (
	bnum number(5) primary key, 		--글번호
	id varchar2(20) not null, 			--작성자 아이디
	nickname varchar2(20) not null,		--작성자 닉네임
	title varchar2(80) not null, 		--글제목
	content varchar2(2000) not null, 	--글내용
	photoimg varchar2(2000) not null,	--사진 이미지
	hit number(5) default 0, 			--조회수
	bdate date default sysdate, 		--작성일
	category varchar2(30) 				--게시판 카테고리
);

/*사진게시판 글번호 시퀀스*/
drop sequence photoboard_seq;
create sequence photoboard_seq start with 1;

/*테스트용 쿼리*/
insert into photoboard_tbl values(photoboard_seq.nextval, 'hyemi0509', 'hh', '사진1', '하늘 사진입니다', 'test1.jpg', 0, sysdate, '갤러리');
insert into photoboard_tbl values(photoboard_seq.nextval, 'hyemi0509', 'hh', '사진2', '무지개 사진입니다', 'test2.jpg', 0, sysdate, '갤러리');
insert into photoboard_tbl values(photoboard_seq.nextval, 'hyemi0509', 'hh', '사진3', '튤립 사진입니다', 'test3.jpg', 0, sysdate, '갤러리');
insert into photoboard_tbl values(photoboard_seq.nextval, 'hyemi0509', 'hh', '사진4', '꽃사진입니다', 'test4.jpg', 0, sysdate, '갤러리');

select * from photoboard_tbl;


/*댓글 테이블*/
drop table comment_tbl;
create table comment_tbl(
	bnum number(5) not null, 			--부모글 번호
	category varchar2(30) not null, 	--게시판 카테고리
	cnum number(5) primary key, 		--댓글 번호
	id varchar2(20) not null, 			--작성자 아이디
	nickname varchar2(20) not null, 	--작성자 닉네임
	ccomment varchar2(300) not null, 	--댓글 내용
	cdate date default sysdate, 		--댓글 작성일
	constraint comment_tbl_fk foreign key(bnum, category) references board_tbl(bnum, category) on delete cascade --부모글 삭제되면 댓글도 삭제
);

/*댓글번호 시퀀스*/
drop sequence comment_seq;
create sequence comment_seq start with 1;

/*테스트용 쿼리*/
insert into comment_tbl values(1, '인사말', comment_seq.nextval, 'hmheo93', 'hyemi', '안녕하세요.', sysdate);
update board_tbl set commnum=commnum+1 where bnum=1 and category='인사말';
insert into comment_tbl values(1, '인사말', comment_seq.nextval, 'hmheo93', 'hyemi', '반가워요.', sysdate);
update board_tbl set commnum=commnum+1 where bnum=1 and category='인사말';

select * from comment_tbl;


/*공지글 뷰*/
create or replace view notice_tbl as
select * from (select bnum, rebnum, id, nickname, title, content, to_char(bdate, 'yyyy-mm-dd') as bdate, 
hit, depth, location, commnum, category from board_tbl where category='공지사항'
start with rebnum is null connect by prior bnum=rebnum order siblings by location asc) where rownum <=2;

select * from notice_tbl;


/*회원 작성글 뷰*/
create or replace view userboard_tbl as
select bnum, id, nickname, title, to_char(bdate, 'yyyy-mm-dd') as bdate, hit, category
from board_tbl union all select bnum, id, nickname, title, to_char(bdate, 'yyyy-mm-dd') as bdate, hit, category
from photoboard_tbl order by bnum desc;

select * from userboard_tbl;


/*최신글 뷰*/
create or replace view new_tbl as
select * from(select bnum, nickname, title, to_char(bdate, 'yyyy-mm-dd') as bdate, bdate as bdate2, hit, commnum, category from board_tbl order by bdate2 desc)
where rownum <=5;

select * from new_tbl;