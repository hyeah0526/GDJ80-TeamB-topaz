-- --------------------------------------------------------
-- 호스트:                          3.34.212.230
-- 서버 버전:                        11.4.2-MariaDB-ubu2404 - mariadb.org binary distribution
-- 서버 OS:                        debian-linux-gnu
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- topaz 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `topaz`;
CREATE DATABASE IF NOT EXISTS `topaz` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `topaz`;

-- 테이블 topaz.amenity 구조 내보내기
DROP TABLE IF EXISTS `amenity`;
CREATE TABLE IF NOT EXISTS `amenity` (
  `amenity_no` varchar(50) NOT NULL,
  `amenity_name` varchar(50) NOT NULL COMMENT '공통코드 C001(1:샴푸, 2:린스, 3:바디워시, 4:수건, 5:휴지)',
  `amenity_stock` int(11) NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)		',
  PRIMARY KEY (`amenity_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='회사에서 보는 어매니티 용품';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.amenity_request 구조 내보내기
DROP TABLE IF EXISTS `amenity_request`;
CREATE TABLE IF NOT EXISTS `amenity_request` (
  `request_no` varchar(50) NOT NULL,
  `gst_id` varchar(50) NOT NULL,
  `amenity_no` varchar(50) NOT NULL,
  `request_quan` int(11) NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)	'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='어매니티 신청한 입주자와 신청한 용품											';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.approval_doc 구조 내보내기
DROP TABLE IF EXISTS `approval_doc`;
CREATE TABLE IF NOT EXISTS `approval_doc` (
  `approval_doc_no` varchar(50) NOT NULL,
  `template_no` varchar(50) NOT NULL COMMENT '공통 코드 S002(1:휴가, 2:기획, 3:경비)',
  `emp_no` varchar(50) NOT NULL,
  `approval_state` varchar(50) NOT NULL COMMENT '공통 코드 S001(1:취소, 2:반려, 3: 대기 4:진행, 5:승인)',
  `doc_title` varchar(100) NOT NULL,
  `doc_content` text NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통 코드 A002(Y:예, N:아니오)',
  PRIMARY KEY (`approval_doc_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='결재 문서 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.approval_history 구조 내보내기
DROP TABLE IF EXISTS `approval_history`;
CREATE TABLE IF NOT EXISTS `approval_history` (
  `approval_doc_no` varchar(50) NOT NULL,
  `approval_level` int(11) NOT NULL,
  `approval_state` varchar(50) NOT NULL COMMENT '공통 코드 S001(1:취소, 2:반려, 3: 대기 4:진행, 5:승인)',
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통 코드 A002(Y:예, N:아니오)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='결재 이력 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.approval_sign 구조 내보내기
DROP TABLE IF EXISTS `approval_sign`;
CREATE TABLE IF NOT EXISTS `approval_sign` (
  `sign_no` varchar(50) NOT NULL,
  `emp_no` varchar(50) NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통 코드 A002(Y:예, N:아니오)',
  `file_name` int(11) DEFAULT NULL,
  PRIMARY KEY (`sign_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='결재 서명 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.approval_template 구조 내보내기
DROP TABLE IF EXISTS `approval_template`;
CREATE TABLE IF NOT EXISTS `approval_template` (
  `template_no` varchar(50) NOT NULL,
  `template_category` varchar(50) NOT NULL COMMENT '공통 코드 S002(1: 휴가, 2: 기획, 3: 경비)',
  `template_content` text NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통 코드 A002(Y:예, N:아니오)',
  PRIMARY KEY (`template_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='결재 서식 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.cleaning 구조 내보내기
DROP TABLE IF EXISTS `cleaning`;
CREATE TABLE IF NOT EXISTS `cleaning` (
  `cleaning_no` varchar(50) NOT NULL,
  `room_no` varchar(50) NOT NULL,
  `room_status` varchar(50) NOT NULL COMMENT '공통코드 C002(D:Dirty, C:Clean)	',
  `cleaning_schedule` datetime NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)	',
  PRIMARY KEY (`cleaning_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='객실 청소에 관한 정보									 ';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.common_code 구조 내보내기
DROP TABLE IF EXISTS `common_code`;
CREATE TABLE IF NOT EXISTS `common_code` (
  `crp_cd` varchar(50) NOT NULL COMMENT '그룹코드',
  `cd` varchar(50) NOT NULL COMMENT '코드',
  `cd_nm` varchar(50) NOT NULL COMMENT '코드명',
  `cd_val1` varchar(50) DEFAULT NULL COMMENT '코드값',
  `cd_val2` varchar(50) DEFAULT NULL COMMENT '코드값',
  `reg_time` datetime NOT NULL,
  `mod_time` datetime NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `use_yn` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='공통코드 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.commute_history 구조 내보내기
DROP TABLE IF EXISTS `commute_history`;
CREATE TABLE IF NOT EXISTS `commute_history` (
  `commute_no` varchar(50) NOT NULL,
  `emp_no` varchar(50) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)',
  PRIMARY KEY (`commute_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='출퇴근 정보 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.employee 구조 내보내기
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `emp_no` varchar(9) NOT NULL,
  `emp_pw` varchar(100) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `emp_dept` varchar(50) NOT NULL COMMENT '공통코드 E001(E:인사부, M:마케팅부, W:행정부, C:고객관리부)',
  `emp_grade` varchar(50) NOT NULL COMMENT '공통코드 E002(1:사원, 2:대리, 3:팀장, 4:부장)',
  `emp_gender` varchar(50) NOT NULL COMMENT '공통코드 A001(M :남자, F:여자)',
  `emp_birth` datetime NOT NULL,
  `emp_phonenumber` varchar(50) NOT NULL,
  `post_no` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `file_name` varchar(100) DEFAULT NULL,
  `emp_hiredate` datetime NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)',
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='직원 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.file_upload 구조 내보내기
DROP TABLE IF EXISTS `file_upload`;
CREATE TABLE IF NOT EXISTS `file_upload` (
  `file_no` varchar(50) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL COMMENT 'file을 업로드 하는 테이블의 pk',
  `original_file_name` varchar(100) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_size` varchar(50) NOT NULL,
  `file_type` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_time` datetime NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)',
  PRIMARY KEY (`file_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='파일 업로드 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.guest 구조 내보내기
DROP TABLE IF EXISTS `guest`;
CREATE TABLE IF NOT EXISTS `guest` (
  `gst_id` varchar(50) NOT NULL,
  `gst_pw` varchar(100) NOT NULL,
  `gst_name` varchar(50) NOT NULL,
  `gst_email` varchar(50) NOT NULL,
  `gst_gender` varchar(50) NOT NULL COMMENT '공통코드 A001(M:남자, F:여자)	',
  `gst_birth` date NOT NULL,
  `post_no` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `gst_phone` varchar(50) NOT NULL,
  `gst_type` varchar(50) NOT NULL DEFAULT '''C''' COMMENT '공통코드  A003(C:고객, E:직원, O:외주업체, R:입주자)	',
  `contract_start` datetime DEFAULT NULL,
  `contract_end` datetime DEFAULT NULL,
  `room_no` varchar(50) DEFAULT NULL,
  `room_amenity` varchar(50) DEFAULT NULL COMMENT '공통코드 A002(Y:예, N:아니오)	',
  `resident_note` varchar(100) DEFAULT NULL,
  `protector_name` varchar(50) DEFAULT NULL,
  `protector_phone` varchar(50) DEFAULT NULL,
  `protector_relation` varchar(50) DEFAULT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL,
  PRIMARY KEY (`gst_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='사용자 정보											';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.leave 구조 내보내기
DROP TABLE IF EXISTS `leave`;
CREATE TABLE IF NOT EXISTS `leave` (
  `emp_no` varchar(50) NOT NULL,
  `emp_grade` varchar(50) NOT NULL COMMENT '공통 코드E002(1:사원, 2:대리, 3:팀장, 4:부장)',
  `year_count` varchar(50) DEFAULT NULL COMMENT '공통 코드E004(E:10, A:12, M:15, H:18) ',
  `month_count` int(11) DEFAULT NULL,
  `half_count` int(11) DEFAULT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통 코드 A002(Y:예, N:아니오)		',
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='직원 휴가 개수';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.leave_history 구조 내보내기
DROP TABLE IF EXISTS `leave_history`;
CREATE TABLE IF NOT EXISTS `leave_history` (
  `leave_history_no` varchar(50) NOT NULL,
  `emp_no` varchar(50) NOT NULL,
  `approval_doc_no` varchar(50) NOT NULL,
  `leave_content` varchar(50) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `regi_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통 코드 A002(Y:예, N:아니오)',
  PRIMARY KEY (`leave_history_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='휴가 사용 이력';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.news_notice 구조 내보내기
DROP TABLE IF EXISTS `news_notice`;
CREATE TABLE IF NOT EXISTS `news_notice` (
  `news_no` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `grade` varchar(50) DEFAULT NULL COMMENT '공통 코드 W004(1:직원, 2:외주 업체)',
  `category` varchar(50) NOT NULL COMMENT '공통 코드 W005(1:필독, 2:일반, 3:이벤트)',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `views` int(11) DEFAULT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통 코드 A002(Y:예, N:아니오)',
  PRIMARY KEY (`news_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='소식 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.note_history 구조 내보내기
DROP TABLE IF EXISTS `note_history`;
CREATE TABLE IF NOT EXISTS `note_history` (
  `note_id` varchar(50) NOT NULL,
  `sender_id` varchar(50) NOT NULL,
  `receiver_id` varchar(50) NOT NULL,
  `note_content` text NOT NULL,
  `send_time` datetime NOT NULL,
  `receive_time` datetime DEFAULT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `sender_delete` char(50) NOT NULL DEFAULT 'N' COMMENT '발신자 삭제 여부',
  `receiver_delete` char(50) NOT NULL DEFAULT 'N' COMMENT '수신자 삭제 여부',
  `use_yn` varchar(50) NOT NULL COMMENT '공통 코드 A002(Y:예, N:아니오)',
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='쪽지 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.old_pw_history 구조 내보내기
DROP TABLE IF EXISTS `old_pw_history`;
CREATE TABLE IF NOT EXISTS `old_pw_history` (
  `old_pw_no` varchar(50) NOT NULL,
  `user_no` varchar(50) NOT NULL COMMENT '직원번호, 사용자ID, 외주업체ID',
  `user_part` varchar(50) NOT NULL COMMENT '공통코드  A003(C:고객, E:직원, O:외주업체, R:입주자)',
  `old_pw` varchar(100) NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)',
  PRIMARY KEY (`old_pw_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='비밀번호 이력 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.outsourcing 구조 내보내기
DROP TABLE IF EXISTS `outsourcing`;
CREATE TABLE IF NOT EXISTS `outsourcing` (
  `outsourcing_no` varchar(50) NOT NULL,
  `outsourcing_pw` varchar(100) NOT NULL,
  `outsourcing_name` varchar(50) NOT NULL,
  `outsourcing_about` text NOT NULL,
  `outsourcing_state` varchar(50) NOT NULL COMMENT '공통 코드 W001(1:영업중, 2:영업종료, 3:상시)',
  `outsourcing_type` varchar(50) NOT NULL COMMENT '공통 코드 W002(1:상시, 2:예약)	',
  `incharge_name` varchar(50) NOT NULL,
  `contract_start` datetime NOT NULL,
  `contract_end` datetime NOT NULL,
  `emp_no` varchar(50) NOT NULL,
  `contact_no` varchar(12) NOT NULL,
  `post_no` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)	',
  PRIMARY KEY (`outsourcing_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='외주 업체	정보							';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.outsourcing_rsvn 구조 내보내기
DROP TABLE IF EXISTS `outsourcing_rsvn`;
CREATE TABLE IF NOT EXISTS `outsourcing_rsvn` (
  `rsvn_no` varchar(50) NOT NULL,
  `outsourcing_no` varchar(50) NOT NULL,
  `gst_id` varchar(50) NOT NULL,
  `rsvn_title` varchar(50) NOT NULL,
  `rsvn_state` varchar(50) NOT NULL COMMENT '공통코드 W006(1:대기, 2:확정, 3:취소)',
  `rsvn_content` varchar(100) NOT NULL,
  `rsvn_start` datetime NOT NULL,
  `rsvn_end` datetime NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)	',
  PRIMARY KEY (`rsvn_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='외주 업체 예약 일정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.room 구조 내보내기
DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `room_no` varchar(50) NOT NULL,
  `room_type` varchar(50) NOT NULL,
  `room_dong` varchar(50) NOT NULL,
  `room_ho` varchar(50) NOT NULL,
  `room_state` varchar(50) NOT NULL COMMENT '공통코드 C003(1:ON, 2:OFF)	',
  `room_price` varchar(50) NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)	',
  PRIMARY KEY (`room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='객실 정보											';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.schedules 구조 내보내기
DROP TABLE IF EXISTS `schedules`;
CREATE TABLE IF NOT EXISTS `schedules` (
  `schedule_no` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL COMMENT '공통코드 M001(1: 회의, 2: 행사, 3: 점검)',
  `content` varchar(100) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)		',
  PRIMARY KEY (`schedule_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='사내일정 								';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.volunteer 구조 내보내기
DROP TABLE IF EXISTS `volunteer`;
CREATE TABLE IF NOT EXISTS `volunteer` (
  `vol_no` varchar(50) NOT NULL,
  `vol_content` text NOT NULL,
  `vol_starttime` datetime NOT NULL,
  `vol_endtime` datetime NOT NULL,
  `vol_people` varchar(50) NOT NULL DEFAULT '',
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL COMMENT '공통코드 A002(Y:예, N:아니오)	',
  PRIMARY KEY (`vol_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='봉사 등록(설명 및 인원 등록)											';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 topaz.volunteer_application 구조 내보내기
DROP TABLE IF EXISTS `volunteer_application`;
CREATE TABLE IF NOT EXISTS `volunteer_application` (
  `vol_app_no` varchar(50) NOT NULL,
  `vol_no` varchar(50) NOT NULL,
  `gst_id` varchar(50) NOT NULL,
  `vol_app_people` varchar(50) NOT NULL,
  `vol_app_comment` text NOT NULL,
  `vol_app_state` varchar(50) NOT NULL COMMENT '공통코드 W003(1:대기, 2:수락, 3:거절, 4:취소)',
  `reg_id` varchar(50) NOT NULL,
  `reg_time` datetime NOT NULL,
  `mod_id` varchar(50) NOT NULL,
  `mod_time` datetime NOT NULL,
  `use_yn` varchar(50) NOT NULL,
  PRIMARY KEY (`vol_app_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='봉사 신청 및 상태											';

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
