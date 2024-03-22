-- 회원
DROP TABLE IF EXISTS members RESTRICT;

-- 스터디댓글
DROP TABLE IF EXISTS study_comments RESTRICT;

-- 스터디
DROP TABLE IF EXISTS study RESTRICT;

-- 회원 스터디 현황
DROP TABLE IF EXISTS members_study_status RESTRICT;

-- 커리큘럼
DROP TABLE IF EXISTS curriculum RESTRICT;

-- 위키(파트에 작성된 글)
DROP TABLE IF EXISTS wiki RESTRICT;

-- 스터디 카테고리
DROP TABLE IF EXISTS study_categories RESTRICT;

-- 위키(파트에 작성된 글)좋아요 현황
DROP TABLE IF EXISTS wiki_like_status RESTRICT;

-- 알림
DROP TABLE IF EXISTS notifications RESTRICT;

-- 스터디 좋아요 현황
DROP TABLE IF EXISTS study_like_status RESTRICT;

-- 위키댓글
DROP TABLE IF EXISTS wiki_comments RESTRICT;

-- 시군구
DROP TABLE IF EXISTS sigg RESTRICT;

-- 시도
DROP TABLE IF EXISTS sido RESTRICT;

-- 공통코드
DROP TABLE IF EXISTS common_codes RESTRICT;

-- 기술스택
DROP TABLE IF EXISTS tag RESTRICT;

-- 직군
DROP TABLE IF EXISTS occupation RESTRICT;

-- 프로필사진
DROP TABLE IF EXISTS photo RESTRICT;

-- 회원 관심스택
DROP TABLE IF EXISTS member_skill_status RESTRICT;

-- 스터디 태그 현황
DROP TABLE IF EXISTS study_tag_status RESTRICT;

-- 탈퇴메세지
DROP TABLE IF EXISTS message RESTRICT;

-- 회원
CREATE TABLE members (
	member_no       INT          NOT NULL COMMENT '회원key', -- 회원key
	email           varchar(255) NULL     COMMENT '이메일', -- 이메일
	platform        varchar(50)  NULL     COMMENT '로그인플랫폼', -- 로그인플랫폼
	created_date    DATETIME     NULL     COMMENT '생성일', -- 생성일
	updated_date    DATETIME     NULL     COMMENT '수정일', -- 수정일
	status          VARCHAR(255) NULL     COMMENT '상태', -- 상태
	exp             VARCHAR(50)  NULL     COMMENT '점수', -- 점수
	last_login_date DATETIME     NULL     COMMENT '마지막 접속일', -- 마지막 접속일
	last_login_ip   varchar(15)  NULL     COMMENT '마지막 접속 IP', -- 마지막 접속 IP
	about           TEXT         NULL     COMMENT '자기소개', -- 자기소개
	belong          VARCHAR(50)  NULL     COMMENT '소속', -- 소속
	career          VARCHAR(5)   NULL     COMMENT '경력', -- 경력
	position        VARCHAR(20)  NULL     COMMENT '직군', -- 직군
	file_no         INT          NULL     COMMENT '파일key', -- 파일key
	social_link     VARCHAR(255) NULL     COMMENT '소셜링크' -- 소셜링크
)
COMMENT '회원';

-- 회원
ALTER TABLE members
	ADD CONSTRAINT PK_members -- 회원 기본키
	PRIMARY KEY (
	member_no -- 회원key
	);

-- 스터디댓글
CREATE TABLE study_comments (
	comment_no   INT          NOT NULL COMMENT '댓글key', -- 댓글key
	parent_no    INT          NULL     COMMENT '부모댓글', -- 부모댓글
	content      VARCHAR(500) NULL     COMMENT '내용', -- 내용
	status       varchar(50)  NULL     COMMENT '상태', -- 상태
	order        INT          NULL     COMMENT '순서', -- 순서
	created_date DATETIME     NULL     COMMENT '생성일', -- 생성일
	updated_date DATETIME     NULL     COMMENT '수정일', -- 수정일
	layer        INT          NULL     COMMENT '계층', -- 계층
	member_no    INT          NULL     COMMENT '회원key', -- 회원key
	study_no     INT          NULL     COMMENT '스터디key' -- 스터디key
)
COMMENT '스터디댓글';

-- 스터디댓글
ALTER TABLE study_comments
	ADD CONSTRAINT PK_study_comments -- 스터디댓글 기본키
	PRIMARY KEY (
	comment_no -- 댓글key
	);

-- 스터디
CREATE TABLE study (
	study_no             INT          NOT NULL COMMENT '스터디key', -- 스터디key
	member_no            INT          NULL     COMMENT '스터디장', -- 스터디장
	location             varchar(50)  NULL     COMMENT '장소', -- 장소
	started_date         DATETIME     NULL     COMMENT '시작일', -- 시작일
	ended_date           DATETIME     NULL     COMMENT '종료일', -- 종료일
	status               varchar(50)  NULL     COMMENT '상태', -- 상태
	intake               INT          NULL     COMMENT '모집인원', -- 모집인원
	method               VARCHAR(50)  NULL     COMMENT '진행방식', -- 진행방식
	recruitment_deadline DATETIME     NULL     COMMENT '모집마감일', -- 모집마감일
	created_date         DATETIME     NULL     COMMENT '생성일', -- 생성일
	updated_date         DATETIME     NULL     COMMENT '수정일', -- 수정일
	introduction         varchar(255) NULL     COMMENT '모집소개글(MD)', -- 모집소개글(MD)
	title                varchar(50)  NULL     COMMENT '제목(모집글제목)', -- 제목(모집글제목)
	category_no          INT          NULL     COMMENT '스터디카테고리key', -- 스터디카테고리key
	sigg_no              INT          NULL     COMMENT '시군구key' -- 시군구key
)
COMMENT '스터디';

-- 스터디
ALTER TABLE study
	ADD CONSTRAINT PK_study -- 스터디 기본키
	PRIMARY KEY (
	study_no -- 스터디key
	);

-- 회원 스터디 현황
CREATE TABLE members_study_status (
	member_no INT         NOT NULL COMMENT '회원key', -- 회원key
	study_no  INT         NOT NULL COMMENT '스터디key', -- 스터디key
	status    varchar(50) NULL     COMMENT '상태' -- 상태
)
COMMENT '회원 스터디 현황';

-- 회원 스터디 현황
ALTER TABLE members_study_status
	ADD CONSTRAINT PK_members_study_status -- 회원 스터디 현황 기본키
	PRIMARY KEY (
	member_no, -- 회원key
	study_no   -- 스터디key
	);

-- 커리큘럼
CREATE TABLE curriculum (
	part_no      INT          NOT NULL COMMENT '파트key', -- 파트key
	title        varchar(100) NULL     COMMENT '제목', -- 제목
	layer        INT          NULL     COMMENT '계층레벨', -- 계층레벨
	order        INT          NULL     COMMENT '순서', -- 순서
	created_date DATETIME     NULL     COMMENT '생성일', -- 생성일
	updated_date DATETIME     NULL     COMMENT '수정일', -- 수정일
	study_no     INT          NULL     COMMENT '스터디key' -- 스터디key
)
COMMENT '커리큘럼';

-- 커리큘럼
ALTER TABLE curriculum
	ADD CONSTRAINT PK_curriculum -- 커리큘럼 기본키
	PRIMARY KEY (
	part_no -- 파트key
	);

-- 위키(파트에 작성된 글)
CREATE TABLE wiki (
	part_no      INT         NOT NULL COMMENT '파트key', -- 파트key
	content      LONGTEXT    NULL     COMMENT '내용', -- 내용
	created_date DATETIME    NULL     COMMENT '생성일', -- 생성일
	updated_date DATETIME    NULL     COMMENT '수정일', -- 수정일
	like         INT         NULL     COMMENT '좋아요', -- 좋아요
	status       VARCHAR(10) NULL     COMMENT '상태' -- 상태
)
COMMENT '위키(파트에 작성된 글)';

-- 위키(파트에 작성된 글)
ALTER TABLE wiki
	ADD CONSTRAINT PK_wiki -- 위키(파트에 작성된 글) 기본키
	PRIMARY KEY (
	part_no -- 파트key
	);

-- 스터디 카테고리
CREATE TABLE study_categories (
	category_no INT         NOT NULL COMMENT '스터디카테고리key', -- 스터디카테고리key
	keyword     VARCHAR(20) NULL     COMMENT '카테고리명' -- 카테고리명
)
COMMENT '스터디 카테고리';

-- 스터디 카테고리
ALTER TABLE study_categories
	ADD CONSTRAINT PK_study_categories -- 스터디 카테고리 기본키
	PRIMARY KEY (
	category_no -- 스터디카테고리key
	);

-- 위키(파트에 작성된 글)좋아요 현황
CREATE TABLE wiki_like_status (
	member_no INT NOT NULL COMMENT '회원key', -- 회원key
	part_no   INT NOT NULL COMMENT '파트key' -- 파트key
)
COMMENT '위키(파트에 작성된 글)좋아요 현황';

-- 위키(파트에 작성된 글)좋아요 현황
ALTER TABLE wiki_like_status
	ADD CONSTRAINT PK_wiki_like_status -- 위키(파트에 작성된 글)좋아요 현황 기본키
	PRIMARY KEY (
	member_no, -- 회원key
	part_no    -- 파트key
	);

-- 알림
CREATE TABLE notifications (
	noti_no      INT          NOT NULL COMMENT '알림key', -- 알림key
	message      VARCHAR(255) NULL     COMMENT '알림메시지', -- 알림메시지
	read_or_not  BOOL         NULL     COMMENT '읽기여부', -- 읽기여부
	created_date DATETIME     NULL     COMMENT '작성일', -- 작성일
	member_no    INT          NULL     COMMENT '수신회원key' -- 수신회원key
)
COMMENT '알림';

-- 알림
ALTER TABLE notifications
	ADD CONSTRAINT PK_notifications -- 알림 기본키
	PRIMARY KEY (
	noti_no -- 알림key
	);

-- 스터디 좋아요 현황
CREATE TABLE study_like_status (
	member_no INT NOT NULL COMMENT '회원key', -- 회원key
	study_no  INT NOT NULL COMMENT '스터디key' -- 스터디key
)
COMMENT '스터디 좋아요 현황';

-- 스터디 좋아요 현황
ALTER TABLE study_like_status
	ADD CONSTRAINT PK_study_like_status -- 스터디 좋아요 현황 기본키
	PRIMARY KEY (
	member_no, -- 회원key
	study_no   -- 스터디key
	);

-- 위키댓글
CREATE TABLE wiki_comments (
	comment_no   INT           NOT NULL COMMENT '댓글key', -- 댓글key
	parent_no    INT           NULL     COMMENT '부모댓글key', -- 부모댓글key
	content      VARCHAR(1000) NULL     COMMENT '내용', -- 내용
	status       VARCHAR(50)   NULL     COMMENT '상태', -- 상태
	order        INT           NULL     COMMENT '순서', -- 순서
	created_date DATETIME      NULL     COMMENT '생성일', -- 생성일
	updated_date DATETIME      NULL     COMMENT '수정일', -- 수정일
	layer        INT           NULL     COMMENT '계층', -- 계층
	part_no      INT           NULL     COMMENT '파트key', -- 파트key
	member_no    INT           NULL     COMMENT '회원key' -- 회원key
)
COMMENT '위키댓글';

-- 위키댓글
ALTER TABLE wiki_comments
	ADD CONSTRAINT PK_wiki_comments -- 위키댓글 기본키
	PRIMARY KEY (
	comment_no -- 댓글key
	);

-- 시군구
CREATE TABLE sigg (
	sigg_no INT NOT NULL COMMENT '시군구key', -- 시군구key
	sido_no INT NULL     COMMENT '시도key' -- 시도key
)
COMMENT '시군구';

-- 시군구
ALTER TABLE sigg
	ADD CONSTRAINT PK_sigg -- 시군구 기본키
	PRIMARY KEY (
	sigg_no -- 시군구key
	);

-- 시도
CREATE TABLE sido (
	sido_no   INT         NOT NULL COMMENT '시도key', -- 시도key
	sido_name VARCHAR(50) NULL     COMMENT '시도명' -- 시도명
)
COMMENT '시도';

-- 시도
ALTER TABLE sido
	ADD CONSTRAINT PK_sido -- 시도 기본키
	PRIMARY KEY (
	sido_no -- 시도key
	);

-- 공통코드
CREATE TABLE common_codes (
	code_no INT                NOT NULL COMMENT '코드key', -- 코드key
	domain  <데이터 타입 없음> NULL     COMMENT '도메인', -- 도메인
	code    VARCHAR(5)         NULL     COMMENT '코드' -- 코드
)
COMMENT '공통코드';

-- 공통코드
ALTER TABLE common_codes
	ADD CONSTRAINT PK_common_codes -- 공통코드 기본키
	PRIMARY KEY (
	code_no -- 코드key
	);

-- 기술스택
CREATE TABLE tag (
	tag_no INT          NOT NULL COMMENT '태그key', -- 태그key
	tname  varchar(20)  NULL     COMMENT '태그명', -- 태그명
	path   varchar(255) NULL     COMMENT '아이콘경로' -- 아이콘경로
)
COMMENT '기술스택';

-- 기술스택
ALTER TABLE tag
	ADD CONSTRAINT PK_tag -- 기술스택 기본키
	PRIMARY KEY (
	tag_no -- 태그key
	);

-- 직군
CREATE TABLE occupation (
	no   INT         NOT NULL COMMENT '직군key', -- 직군key
	name VARCHAR(50) NULL     COMMENT '직군명' -- 직군명
)
COMMENT '직군';

-- 직군
ALTER TABLE occupation
	ADD CONSTRAINT PK_occupation -- 직군 기본키
	PRIMARY KEY (
	no -- 직군key
	);

-- 프로필사진
CREATE TABLE photo (
	file_no   INT          NOT NULL COMMENT '파일key', -- 파일key
	file_path VARCHAR(255) NULL     COMMENT '파일명' -- 파일명
)
COMMENT '프로필사진';

-- 프로필사진
ALTER TABLE photo
	ADD CONSTRAINT PK_photo -- 프로필사진 기본키
	PRIMARY KEY (
	file_no -- 파일key
	);

-- 회원 관심스택
CREATE TABLE member_skill_status (
	member_no INT NOT NULL COMMENT '회원key', -- 회원key
	tag_no    INT NOT NULL COMMENT '태그key' -- 태그key
)
COMMENT '회원 관심스택';

-- 회원 관심스택
ALTER TABLE member_skill_status
	ADD CONSTRAINT PK_member_skill_status -- 회원 관심스택 기본키
	PRIMARY KEY (
	member_no, -- 회원key
	tag_no     -- 태그key
	);

-- 스터디 태그 현황
CREATE TABLE study_tag_status (
	study_no INT NOT NULL COMMENT '스터디key', -- 스터디key
	tag_no   INT NOT NULL COMMENT '태그key' -- 태그key
)
COMMENT '스터디 태그 현황';

-- 스터디 태그 현황
ALTER TABLE study_tag_status
	ADD CONSTRAINT PK_study_tag_status -- 스터디 태그 현황 기본키
	PRIMARY KEY (
	study_no, -- 스터디key
	tag_no    -- 태그key
	);

-- 탈퇴메세지
CREATE TABLE message (
	mno        INT          NOT NULL COMMENT '메세지번호', -- 메세지번호
	message    VARCHAR(255) NULL     COMMENT '메세지', -- 메세지
	write_time DATETIME     NULL     COMMENT '작성시간' -- 작성시간
)
COMMENT '탈퇴메세지';

-- 탈퇴메세지
ALTER TABLE message
	ADD CONSTRAINT PK_message -- 탈퇴메세지 기본키
	PRIMARY KEY (
	mno -- 메세지번호
	);

-- 회원
ALTER TABLE members
	ADD CONSTRAINT FK_photo_TO_members -- 프로필사진 -> 회원
	FOREIGN KEY (
	file_no -- 파일key
	)
	REFERENCES photo ( -- 프로필사진
	file_no -- 파일key
	);

-- 스터디댓글
ALTER TABLE study_comments
	ADD CONSTRAINT FK_members_TO_study_comments -- 회원 -> 스터디댓글
	FOREIGN KEY (
	member_no -- 회원key
	)
	REFERENCES members ( -- 회원
	member_no -- 회원key
	);

-- 스터디댓글
ALTER TABLE study_comments
	ADD CONSTRAINT FK_study_comments_TO_study_comments -- 스터디댓글 -> 스터디댓글
	FOREIGN KEY (
	parent_no -- 부모댓글
	)
	REFERENCES study_comments ( -- 스터디댓글
	comment_no -- 댓글key
	);

-- 스터디댓글
ALTER TABLE study_comments
	ADD CONSTRAINT FK_study_TO_study_comments -- 스터디 -> 스터디댓글
	FOREIGN KEY (
	study_no -- 스터디key
	)
	REFERENCES study ( -- 스터디
	study_no -- 스터디key
	);

-- 스터디
ALTER TABLE study
	ADD CONSTRAINT FK_members_TO_study -- 회원 -> 스터디
	FOREIGN KEY (
	member_no -- 스터디장
	)
	REFERENCES members ( -- 회원
	member_no -- 회원key
	);

-- 스터디
ALTER TABLE study
	ADD CONSTRAINT FK_study_categories_TO_study -- 스터디 카테고리 -> 스터디
	FOREIGN KEY (
	category_no -- 스터디카테고리key
	)
	REFERENCES study_categories ( -- 스터디 카테고리
	category_no -- 스터디카테고리key
	);

-- 스터디
ALTER TABLE study
	ADD CONSTRAINT FK_sigg_TO_study -- 시군구 -> 스터디
	FOREIGN KEY (
	sigg_no -- 시군구key
	)
	REFERENCES sigg ( -- 시군구
	sigg_no -- 시군구key
	);

-- 회원 스터디 현황
ALTER TABLE members_study_status
	ADD CONSTRAINT FK_members_TO_members_study_status -- 회원 -> 회원 스터디 현황
	FOREIGN KEY (
	member_no -- 회원key
	)
	REFERENCES members ( -- 회원
	member_no -- 회원key
	);

-- 회원 스터디 현황
ALTER TABLE members_study_status
	ADD CONSTRAINT FK_study_TO_members_study_status -- 스터디 -> 회원 스터디 현황
	FOREIGN KEY (
	study_no -- 스터디key
	)
	REFERENCES study ( -- 스터디
	study_no -- 스터디key
	);

-- 커리큘럼
ALTER TABLE curriculum
	ADD CONSTRAINT FK_study_TO_curriculum -- 스터디 -> 커리큘럼
	FOREIGN KEY (
	study_no -- 스터디key
	)
	REFERENCES study ( -- 스터디
	study_no -- 스터디key
	);

-- 위키(파트에 작성된 글)
ALTER TABLE wiki
	ADD CONSTRAINT FK_curriculum_TO_wiki -- 커리큘럼 -> 위키(파트에 작성된 글)
	FOREIGN KEY (
	part_no -- 파트key
	)
	REFERENCES curriculum ( -- 커리큘럼
	part_no -- 파트key
	);

-- 위키(파트에 작성된 글)좋아요 현황
ALTER TABLE wiki_like_status
	ADD CONSTRAINT FK_members_TO_wiki_like_status -- 회원 -> 위키(파트에 작성된 글)좋아요 현황
	FOREIGN KEY (
	member_no -- 회원key
	)
	REFERENCES members ( -- 회원
	member_no -- 회원key
	);

-- 위키(파트에 작성된 글)좋아요 현황
ALTER TABLE wiki_like_status
	ADD CONSTRAINT FK_wiki_TO_wiki_like_status -- 위키(파트에 작성된 글) -> 위키(파트에 작성된 글)좋아요 현황
	FOREIGN KEY (
	part_no -- 파트key
	)
	REFERENCES wiki ( -- 위키(파트에 작성된 글)
	part_no -- 파트key
	);

-- 알림
ALTER TABLE notifications
	ADD CONSTRAINT FK_members_TO_notifications -- 회원 -> 알림
	FOREIGN KEY (
	member_no -- 수신회원key
	)
	REFERENCES members ( -- 회원
	member_no -- 회원key
	);

-- 스터디 좋아요 현황
ALTER TABLE study_like_status
	ADD CONSTRAINT FK_members_TO_study_like_status -- 회원 -> 스터디 좋아요 현황
	FOREIGN KEY (
	member_no -- 회원key
	)
	REFERENCES members ( -- 회원
	member_no -- 회원key
	);

-- 스터디 좋아요 현황
ALTER TABLE study_like_status
	ADD CONSTRAINT FK_study_TO_study_like_status -- 스터디 -> 스터디 좋아요 현황
	FOREIGN KEY (
	study_no -- 스터디key
	)
	REFERENCES study ( -- 스터디
	study_no -- 스터디key
	);

-- 위키댓글
ALTER TABLE wiki_comments
	ADD CONSTRAINT FK_wiki_comments_TO_wiki_comments -- 위키댓글 -> 위키댓글
	FOREIGN KEY (
	parent_no -- 부모댓글key
	)
	REFERENCES wiki_comments ( -- 위키댓글
	comment_no -- 댓글key
	);

-- 위키댓글
ALTER TABLE wiki_comments
	ADD CONSTRAINT FK_wiki_TO_wiki_comments -- 위키(파트에 작성된 글) -> 위키댓글
	FOREIGN KEY (
	part_no -- 파트key
	)
	REFERENCES wiki ( -- 위키(파트에 작성된 글)
	part_no -- 파트key
	);

-- 위키댓글
ALTER TABLE wiki_comments
	ADD CONSTRAINT FK_members_TO_wiki_comments -- 회원 -> 위키댓글
	FOREIGN KEY (
	member_no -- 회원key
	)
	REFERENCES members ( -- 회원
	member_no -- 회원key
	);

-- 시군구
ALTER TABLE sigg
	ADD CONSTRAINT FK_sido_TO_sigg -- 시도 -> 시군구
	FOREIGN KEY (
	sido_no -- 시도key
	)
	REFERENCES sido ( -- 시도
	sido_no -- 시도key
	);

-- 회원 관심스택
ALTER TABLE member_skill_status
	ADD CONSTRAINT FK_members_TO_member_skill_status -- 회원 -> 회원 관심스택
	FOREIGN KEY (
	member_no -- 회원key
	)
	REFERENCES members ( -- 회원
	member_no -- 회원key
	);

-- 회원 관심스택
ALTER TABLE member_skill_status
	ADD CONSTRAINT FK_tag_TO_member_skill_status -- 기술스택 -> 회원 관심스택
	FOREIGN KEY (
	tag_no -- 태그key
	)
	REFERENCES tag ( -- 기술스택
	tag_no -- 태그key
	);

-- 스터디 태그 현황
ALTER TABLE study_tag_status
	ADD CONSTRAINT FK_study_TO_study_tag_status -- 스터디 -> 스터디 태그 현황
	FOREIGN KEY (
	study_no -- 스터디key
	)
	REFERENCES study ( -- 스터디
	study_no -- 스터디key
	);

-- 스터디 태그 현황
ALTER TABLE study_tag_status
	ADD CONSTRAINT FK_tag_TO_study_tag_status -- 기술스택 -> 스터디 태그 현황
	FOREIGN KEY (
	tag_no -- 태그key
	)
	REFERENCES tag ( -- 기술스택
	tag_no -- 태그key
	);