-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.3.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for mos
DROP DATABASE IF EXISTS `mos`;
CREATE DATABASE IF NOT EXISTS `mos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mos`;

-- Dumping structure for table mos.curriculum
DROP TABLE IF EXISTS `curriculum`;
CREATE TABLE IF NOT EXISTS `curriculum` (
  `wiki_no` int NOT NULL AUTO_INCREMENT COMMENT '위키 키',
  `study_no` int NOT NULL COMMENT '파트/위키 대상이 되는 스터디 키',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '해당 위키 제목',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '해당 위키 내용(md)',
  `layer` int DEFAULT NULL COMMENT '위키간 위계구조',
  `order` int DEFAULT NULL COMMENT '파트의 순서(같은 오더에 다른 레이어)',
  `likes` int NOT NULL DEFAULT '0' COMMENT '유저들에게 받은 좋아요 수 (반정규화)',
  `created_date` datetime NOT NULL DEFAULT (now()) COMMENT '파트를 생성한 시간',
  `updated_date` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP COMMENT '파트를 업데이트한 시간',
  `content_created_date` datetime DEFAULT NULL COMMENT '위키를 생성한 시간',
  `content_last_updated_date` datetime DEFAULT NULL COMMENT '위키를 업데이트한 시간',
  `stat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT (1) COMMENT '예: 1(정상) 2(삭제) 3(숨김)',
  PRIMARY KEY (`wiki_no`) USING BTREE,
  KEY `FK_curriculum_study` (`study_no`),
  CONSTRAINT `FK_curriculum_study` FOREIGN KEY (`study_no`) REFERENCES `study` (`study_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스터디마다 여러개 가질 수 있는 커리큘럼. 각 파트들을 레코드로 가진다.';

-- Dumping data for table mos.curriculum: ~0 rows (approximately)
DELETE FROM `curriculum`;
INSERT INTO `curriculum` (`wiki_no`, `study_no`, `title`, `content`, `layer`, `order`, `likes`, `created_date`, `updated_date`, `content_created_date`, `content_last_updated_date`, `stat`) VALUES
	(1, 1, '변수', '변수에 대해 훌륭히 정리한 마크다운 문서', NULL, NULL, 0, '2024-03-26 21:34:54', '2024-03-26 21:34:54', NULL, NULL, '1'),
	(2, 1, '조건문과 반복문', '조건문과 반복문에 대해 훌륭히 정리한 마크다운 문서', NULL, NULL, 0, '2024-03-26 21:36:12', '2024-03-26 21:36:12', NULL, NULL, '1'),
	(3, 1, 'JVM 메모리 영역', 'JVM이 사용하는 세가지 메모리 영역에 대해서 아주 훌륭하게 정리한 마크다운 문서를 통째로 저장함', NULL, NULL, 0, '2024-03-26 21:36:54', '2024-03-26 21:36:54', NULL, NULL, '1'),
	(4, 2, '오리엔테이션', '스프링 강의의 오리엔테이션에 대해 재미나게 정리한 마크다운 문서', NULL, NULL, 0, '2024-03-26 21:37:24', '2024-03-26 21:37:24', NULL, NULL, '1'),
	(5, 2, 'IoC 컨테이너 개념', '스프링의 IoC 컨테이너에 대해 기깔나게 정리한 마크다운 문서', NULL, NULL, 0, '2024-03-26 21:37:53', '2024-03-26 21:37:53', NULL, NULL, '1'),
	(6, 3, 'README.MD', '항시운영되는 CS 스터디 진행 방법에 대해 안내된 마크다운 문서', NULL, NULL, 0, '2024-03-26 21:38:40', '2024-03-26 21:38:40', NULL, NULL, '1');

-- Dumping structure for table mos.member
DROP TABLE IF EXISTS `member`;
CREATE TABLE IF NOT EXISTS `member` (
  `member_no` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `platform` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `photo_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'path = UUID+time',
  `created_date` datetime NOT NULL DEFAULT (now()),
  `updated_date` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `stat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '예시: 1(정상) 2(정지) 3(탈퇴)',
  `score` int NOT NULL DEFAULT '0',
  `biography` varchar(255) DEFAULT NULL,
  `belong` varchar(50) DEFAULT NULL,
  `career` varchar(50) DEFAULT NULL,
  `job_group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `social_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`member_no`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `photo_path` (`photo_path`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원 개개인에 관한 정보를 저장하는 테이블';

-- Dumping data for table mos.member: ~0 rows (approximately)
DELETE FROM `member`;
INSERT INTO `member` (`member_no`, `email`, `username`, `platform`, `photo_path`, `created_date`, `updated_date`, `stat`, `score`, `biography`, `belong`, `career`, `job_group`, `social_link`) VALUES
	(1, 'user01@test.com', 'user01', 'facebook', 'app/upload/uuid+time - 1', '2024-03-26 19:33:54', '2024-03-26 21:43:19', '정상', 0, '안녕하세요. user01입니다.', '소속입니다. user01', 'user01 경력입니다.', 'user01 직군입니다.', NULL),
	(2, 'user02@gmail.com', 'user02', 'github', 'app/upload/uuid+time - 2', '2024-03-26 19:30:53', '2024-03-26 21:43:21', '정상', 0, '안녕하세요! 이것은 자기소개입니다.', '소속은 네이버입니다.', '경력은 1년차 입니다.', '직군은 프론트엔드 입니다.', 'https://mylink.com/thesublink/thepage'),
	(3, 'user03@test.com', 'user03', 'google', NULL, '2024-03-26 19:47:20', '2024-03-26 21:43:24', '정상', 0, NULL, NULL, NULL, NULL, NULL),
	(4, 'user04@test.com', 'user04', 'kakao', NULL, '2024-03-26 19:47:35', '2024-03-26 21:43:26', '정상', 0, '같이 공부해요 난 좋은 사람', NULL, NULL, NULL, NULL),
	(5, 'user05@test.com', 'user05', 'naver', NULL, '2024-03-26 19:50:24', '2024-03-26 21:44:06', '정상', 0, NULL, '구직중', '마음만은 10년차', '풀스택', 'https://github.com/joonhoekim'),
	(6, 'user06@test.com', 'user06', 'so', NULL, '2024-03-26 21:42:52', '2024-03-26 21:44:02', '탈퇴', 0, '탈퇴예정', '어디에도 소속되지 않음', NULL, NULL, NULL);

-- Dumping structure for table mos.member_study_status
DROP TABLE IF EXISTS `member_study_status`;
CREATE TABLE IF NOT EXISTS `member_study_status` (
  `member_no` int NOT NULL,
  `study_no` int NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '참여회원의 상태\r\n상태미정. 스터디장/스터디원\r\n정상\r\n신고(정지)\r\n자진탈퇴',
  UNIQUE KEY `member_no_study_no` (`member_no`,`study_no`),
  KEY `FK_member_study_status_study` (`study_no`),
  CONSTRAINT `FK_member_study_status_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`),
  CONSTRAINT `FK_member_study_status_study` FOREIGN KEY (`study_no`) REFERENCES `study` (`study_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원이 어떤 스터디에 참여했는지를 저장하는 테이블. 다대다 관계를 해소함.';

-- Dumping data for table mos.member_study_status: ~0 rows (approximately)
DELETE FROM `member_study_status`;
INSERT INTO `member_study_status` (`member_no`, `study_no`, `status`) VALUES
	(1, 1, '1'),
	(1, 2, '1'),
	(2, 1, '1'),
	(2, 2, '1'),
	(3, 1, '1'),
	(3, 3, '1'),
	(4, 3, '1'),
	(5, 3, '1');

-- Dumping structure for table mos.member_tag_status
DROP TABLE IF EXISTS `member_tag_status`;
CREATE TABLE IF NOT EXISTS `member_tag_status` (
  `member_no` int NOT NULL COMMENT '회원키',
  `tag_no` int NOT NULL COMMENT '태그키',
  UNIQUE KEY `unique` (`member_no`,`tag_no`) USING BTREE,
  KEY `FK_member_skill_status_skill` (`tag_no`),
  CONSTRAINT `FK_member_skill_status_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`),
  CONSTRAINT `FK_member_skill_status_skill` FOREIGN KEY (`tag_no`) REFERENCES `tag` (`tag_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원이 관심 목록으로 저장한 스킬(기술 스택)들을 저장하는 테이블. 다대다 관계를 해소한다.';

-- Dumping data for table mos.member_tag_status: ~7 rows (approximately)
DELETE FROM `member_tag_status`;
INSERT INTO `member_tag_status` (`member_no`, `tag_no`) VALUES
	(1, 1),
	(5, 1),
	(3, 2),
	(2, 3),
	(2, 4),
	(2, 5),
	(1, 7);

-- Dumping structure for table mos.notification
DROP TABLE IF EXISTS `notification`;
CREATE TABLE IF NOT EXISTS `notification` (
  `noti_no` int NOT NULL AUTO_INCREMENT COMMENT '알림 키',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '메세지 내용',
  `read_or_not` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'N' COMMENT '읽지않음: ''N'', 읽음: ''Y''',
  `created_date` datetime NOT NULL DEFAULT (now()) COMMENT '알림 발송시간 저장',
  `member_no` int NOT NULL COMMENT '알림 받는 회원',
  `link` varchar(255) DEFAULT NULL COMMENT '메시지박스에 연결된 링크',
  PRIMARY KEY (`noti_no`),
  KEY `FK_notification_member` (`member_no`),
  CONSTRAINT `FK_notification_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원에게 발송되는 알림을 저장하는 테이블';

-- Dumping data for table mos.notification: ~0 rows (approximately)
DELETE FROM `notification`;
INSERT INTO `notification` (`noti_no`, `message`, `read_or_not`, `created_date`, `member_no`, `link`) VALUES
	(1, 'user01님이 "[항시모집] CS 스터디"에 참여 신청하셨어요!', 'N', '2024-03-26 21:39:49', 3, 'https://mos.work/app/mypage/studymgmt/list');

-- Dumping structure for table mos.quit_message
DROP TABLE IF EXISTS `quit_message`;
CREATE TABLE IF NOT EXISTS `quit_message` (
  `message_no` int NOT NULL AUTO_INCREMENT,
  `member_no` int NOT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_date` datetime NOT NULL DEFAULT (now()),
  PRIMARY KEY (`message_no`),
  KEY `FK_quit_message_member` (`member_no`),
  CONSTRAINT `FK_quit_message_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원이 탈퇴시 남긴 메세지를 저장함';

-- Dumping data for table mos.quit_message: ~0 rows (approximately)
DELETE FROM `quit_message`;
INSERT INTO `quit_message` (`message_no`, `member_no`, `message`, `created_date`) VALUES
	(1, 6, '무임승차하려는 사람들이 너무 많아서 탈퇴합니다.', '2024-03-26 21:45:20');

-- Dumping structure for table mos.sigg
DROP TABLE IF EXISTS `sigg`;
CREATE TABLE IF NOT EXISTS `sigg` (
  `sigg_no` int NOT NULL,
  `map_no` int DEFAULT NULL,
  PRIMARY KEY (`sigg_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='sigg는 시(si)군(g)구(g)를 의미한다. 사전에 지역정보 입력할 때 이미 저장된 정보에서만 입력할 수 있도록, 시군구 정보를 저장하는데 이는 시도 테이블(sido)을 시군구테이블과 중개하여 구현한다.';

-- Dumping data for table mos.sigg: ~0 rows (approximately)
DELETE FROM `sigg`;

-- Dumping structure for table mos.study
DROP TABLE IF EXISTS `study`;
CREATE TABLE IF NOT EXISTS `study` (
  `study_no` int NOT NULL AUTO_INCREMENT,
  `member_no` int NOT NULL COMMENT '스터디장',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '모집글의 title',
  `introduction` longtext NOT NULL COMMENT '모집 소개글 (MD)',
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '스터디 장소 (NULL 가능)',
  `start_date` date DEFAULT NULL COMMENT '미설정 가능?',
  `end_date` date DEFAULT NULL COMMENT '미설정 가능?',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '예시: 0(모집중) 1(모집완료) 2(진행중) 3(종료)',
  `intake` int DEFAULT NULL COMMENT '모집정원',
  `method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '진행방식',
  `recruitment_deadline` datetime DEFAULT NULL COMMENT '모집마감일',
  `created_date` datetime NOT NULL DEFAULT (now()) COMMENT '작성일',
  `updated_date` datetime DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 수정일',
  `sigg_no` int DEFAULT NULL COMMENT '(위치) 시군구키 (NULL 가능)',
  PRIMARY KEY (`study_no`),
  KEY `FK_study_member` (`member_no`),
  KEY `FK_study_sigg` (`sigg_no`),
  CONSTRAINT `FK_study_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`),
  CONSTRAINT `FK_study_sigg` FOREIGN KEY (`sigg_no`) REFERENCES `sigg` (`sigg_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스터디 모집글을 작성하면 이 테이블에 데이터를 저장함. 각 스터디는 이 테이블에 고유한 값으로 저장됨.';

-- Dumping data for table mos.study: ~0 rows (approximately)
DELETE FROM `study`;
INSERT INTO `study` (`study_no`, `member_no`, `title`, `introduction`, `location`, `start_date`, `end_date`, `status`, `intake`, `method`, `recruitment_deadline`, `created_date`, `updated_date`, `sigg_no`) VALUES
	(1, 1, '[북스터디] 이것이 자바다 요약스터디 모집!', '(마크다운문서) [요약스터디소개] 우리 스터디는 딱딱한 자바를 씹어먹습니다.', '가능하면 홍대에서 모여요 (필참아님)', NULL, NULL, '0', 5, NULL, NULL, '2024-03-26 21:17:02', '2024-03-26 21:49:14', NULL),
	(2, 2, '[인프런] 김영한 스프링 같이 정리하실 분', '(마크다운문서) [인강스터디소개] 세컨드 브레인 같이 만들어요', NULL, '2024-03-26', NULL, '0', 2, NULL, NULL, '2024-03-26 21:25:12', '2024-03-26 21:49:16', NULL),
	(3, 3, '(항시모집) CS 인터뷰 문서 같이 만들어요! 💕💕', '비전공자 환영! 함께 CS (마크다운문서) 지식을 시각화해나가요. Brilliant.org를 많이 참조합니다.', '저희는 완전 비대면입니다!', NULL, NULL, '0', 99, NULL, NULL, '2024-03-26 21:28:06', '2024-03-26 21:49:21', NULL);

-- Dumping structure for table mos.study_comment
DROP TABLE IF EXISTS `study_comment`;
CREATE TABLE IF NOT EXISTS `study_comment` (
  `comment_no` int NOT NULL AUTO_INCREMENT,
  `study_no` int NOT NULL,
  `member_no` int NOT NULL,
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `order` int DEFAULT NULL,
  `layer` int DEFAULT NULL,
  `stat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '예: 1(정상) 2(삭제됨) 3(신고됨) 4(운영진삭제)',
  `created_date` datetime DEFAULT (now()),
  `updated_date` datetime DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_no`),
  KEY `FK_study_comment_member` (`member_no`),
  KEY `FK_study_comment_study` (`study_no`),
  CONSTRAINT `FK_study_comment_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`),
  CONSTRAINT `FK_study_comment_study` FOREIGN KEY (`study_no`) REFERENCES `study` (`study_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모집글에 달리는 댓글들을 저장하는 테이블.';

-- Dumping data for table mos.study_comment: ~0 rows (approximately)
DELETE FROM `study_comment`;
INSERT INTO `study_comment` (`comment_no`, `study_no`, `member_no`, `content`, `order`, `layer`, `stat`, `created_date`, `updated_date`) VALUES
	(1, 3, 1, '한달에 몇번정도 진행되나요?', NULL, NULL, '1', '2024-03-26 21:46:36', '2024-03-26 21:46:36');

-- Dumping structure for table mos.study_like_status
DROP TABLE IF EXISTS `study_like_status`;
CREATE TABLE IF NOT EXISTS `study_like_status` (
  `member_no` int DEFAULT NULL,
  `study_no` int DEFAULT NULL,
  UNIQUE KEY `member_no_study_no` (`member_no`,`study_no`),
  KEY `FK_study_like_status_study` (`study_no`),
  CONSTRAINT `FK_study_like_status_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`),
  CONSTRAINT `FK_study_like_status_study` FOREIGN KEY (`study_no`) REFERENCES `study` (`study_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원이 스터디 모집글에 ''좋아요''를 남긴 경우 그 데이터를 저장하는 테이블. 이 테이블을 통해 회원은 이전에 좋아요한 모집글을 모아볼 수 있다.';

-- Dumping data for table mos.study_like_status: ~0 rows (approximately)
DELETE FROM `study_like_status`;
INSERT INTO `study_like_status` (`member_no`, `study_no`) VALUES
	(1, 3);

-- Dumping structure for table mos.study_tag_status
DROP TABLE IF EXISTS `study_tag_status`;
CREATE TABLE IF NOT EXISTS `study_tag_status` (
  `study_no` int DEFAULT NULL,
  `tag_no` int DEFAULT NULL,
  UNIQUE KEY `study_no_tag_no` (`study_no`,`tag_no`),
  KEY `FK_study_tag_status_tag` (`tag_no`),
  CONSTRAINT `FK_study_tag_status_study` FOREIGN KEY (`study_no`) REFERENCES `study` (`study_no`),
  CONSTRAINT `FK_study_tag_status_tag` FOREIGN KEY (`tag_no`) REFERENCES `tag` (`tag_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='스터디에 설정한 태그들을 저장하는 테이블.';

-- Dumping data for table mos.study_tag_status: ~0 rows (approximately)
DELETE FROM `study_tag_status`;
INSERT INTO `study_tag_status` (`study_no`, `tag_no`) VALUES
	(1, 1),
	(2, 1),
	(2, 7),
	(3, 3),
	(3, 4);

-- Dumping structure for table mos.tag
DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `tag_no` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '직접입력(운영측에서 사전설정)',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '직접입력(운영측에서 사전설정)',
  PRIMARY KEY (`tag_no`),
  UNIQUE KEY `name_path` (`name`,`path`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='기술 스택(스킬)들을 저장해두는 테이블. 해당 스킬의 아이콘 경로도 이 테이블에 저장된다.';

-- Dumping data for table mos.tag: ~0 rows (approximately)
DELETE FROM `tag`;
INSERT INTO `tag` (`tag_no`, `name`, `path`) VALUES
	(3, 'C', NULL),
	(4, 'C++', NULL),
	(5, 'Go', NULL),
	(1, 'Java', NULL),
	(2, 'Python', NULL),
	(6, 'R', NULL),
	(7, 'Spring', NULL);

-- Dumping structure for table mos.wiki_comment
DROP TABLE IF EXISTS `wiki_comment`;
CREATE TABLE IF NOT EXISTS `wiki_comment` (
  `comment_no` int NOT NULL AUTO_INCREMENT COMMENT '위키 댓글 키',
  `wiki_no` int NOT NULL COMMENT '댓글이 작성된 위키의 키',
  `member_no` int NOT NULL COMMENT '작성 회원 키',
  `parent_comment_no` int DEFAULT NULL COMMENT '부모댓글의 키 (대댓글일 때)',
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '댓글 내용 (text 보다 이것이 나을까?)',
  `layer` int DEFAULT NULL COMMENT '묶음을 정렬하기 위한 키 (indent)',
  `order` int NOT NULL DEFAULT '0' COMMENT '댓글+대댓글 묶음은 댓글 기준으로 같은 order를 가짐',
  `stat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '댓글의 상태 (대댓글 없으면 진짜삭제)',
  `created_date` datetime NOT NULL DEFAULT (now()) COMMENT '작성시점',
  `updated_date` datetime NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP COMMENT 'UPDATE하면 날짜도 자동변경',
  PRIMARY KEY (`comment_no`),
  KEY `FK_wiki_comment_curriculum` (`wiki_no`),
  KEY `FK_wiki_comment_member` (`member_no`),
  KEY `FK_wiki_comment_wiki_comment` (`parent_comment_no`),
  CONSTRAINT `FK_wiki_comment_curriculum` FOREIGN KEY (`wiki_no`) REFERENCES `curriculum` (`wiki_no`),
  CONSTRAINT `FK_wiki_comment_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`),
  CONSTRAINT `FK_wiki_comment_wiki_comment` FOREIGN KEY (`parent_comment_no`) REFERENCES `wiki_comment` (`comment_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='위키에 달리는 댓글들이 저장되는 테이블. 부모댓글을 parent_no에 저장한다.';

-- Dumping data for table mos.wiki_comment: ~1 rows (approximately)
DELETE FROM `wiki_comment`;
INSERT INTO `wiki_comment` (`comment_no`, `wiki_no`, `member_no`, `parent_comment_no`, `content`, `layer`, `order`, `stat`, `created_date`, `updated_date`) VALUES
	(1, 4, 1, NULL, '정독 시작합니다!', NULL, 0, '0', '2024-03-26 21:51:52', '2024-03-26 21:51:52');

-- Dumping structure for table mos.wiki_like_status
DROP TABLE IF EXISTS `wiki_like_status`;
CREATE TABLE IF NOT EXISTS `wiki_like_status` (
  `member_no` int NOT NULL COMMENT '좋아요 한 회원 키',
  `wiki_no` int NOT NULL COMMENT '좋아요 대상이 된 위키 키',
  UNIQUE KEY `member_no_wiki_no` (`member_no`,`wiki_no`),
  KEY `FK_wiki_like_status_curriculum` (`wiki_no`),
  CONSTRAINT `FK_wiki_like_status_curriculum` FOREIGN KEY (`wiki_no`) REFERENCES `curriculum` (`wiki_no`),
  CONSTRAINT `FK_wiki_like_status_member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='여러 회원이 여러 위키들에 좋아요를 한 현황. 다대다 관계를 해소함. 본인이 좋아요한 위키를 모아보기 위해 이 테이블을 사용함.';

-- Dumping data for table mos.wiki_like_status: ~1 rows (approximately)
DELETE FROM `wiki_like_status`;
INSERT INTO `wiki_like_status` (`member_no`, `wiki_no`) VALUES
	(1, 4);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
