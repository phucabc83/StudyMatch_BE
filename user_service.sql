/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `db_communication_service` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_communication_service`;

CREATE TABLE IF NOT EXISTS `messages` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `content` text,
  `type` enum('TEXT','IMAGE','FILE') DEFAULT 'TEXT',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `video_call_sessions` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `started_at` datetime NOT NULL,
  `ended_at` datetime DEFAULT NULL,
  `duration_seconds` int DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE DATABASE IF NOT EXISTS `db_group_service` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_group_service`;

CREATE TABLE IF NOT EXISTS `group_invitations` (
  `invitation_id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `inviter_id` int NOT NULL,
  `invitee_id` int NOT NULL,
  `message` text,
  `status` enum('PENDING','ACCEPTED','DECLINED') DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`invitation_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `group_invitations_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `study_groups` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `group_join_requests` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  `message` text,
  `status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `responded_at` datetime DEFAULT NULL,
  PRIMARY KEY (`request_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `group_join_requests_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `study_groups` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `group_members` (
  `group_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role` enum('LEADER','MEMBER') DEFAULT 'MEMBER',
  `joined_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`,`user_id`),
  CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `study_groups` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `schedules` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `title` varchar(150) DEFAULT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  `meeting_link` varchar(255) DEFAULT NULL,
  `is_online` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`schedule_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `study_groups` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `study_groups` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) NOT NULL,
  `description` text,
  `subject_topic` varchar(100) DEFAULT NULL,
  `max_capacity` int DEFAULT '5',
  `status` enum('OPEN','CLOSED','DISBANDED') DEFAULT 'OPEN',
  `created_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE DATABASE IF NOT EXISTS `db_recommendation_service` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_recommendation_service`;

CREATE TABLE IF NOT EXISTS `availabilities` (
  `availability_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `day_of_week` enum('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`availability_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `feedbacks` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `rater_id` int NOT NULL,
  `target_id` int NOT NULL,
  `target_type` enum('USER','GROUP') NOT NULL DEFAULT 'GROUP',
  `score` tinyint DEFAULT NULL,
  `comment` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`feedback_id`),
  CONSTRAINT `feedbacks_chk_1` CHECK ((`score` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `interaction_metrics` (
  `metric_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `target_id` int NOT NULL COMMENT 'ID của User hoặc Group được đánh giá',
  `target_type` enum('USER','GROUP') NOT NULL DEFAULT 'GROUP' COMMENT 'Loại đối tượng',
  `message_count` int DEFAULT '0' COMMENT 'Tổng số tin nhắn user đã gửi trong nhóm',
  `video_call_duration_minutes` float DEFAULT '0' COMMENT 'Tổng số phút đã tham gia call',
  `last_interaction_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Lần cuối chat hoặc call',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`metric_id`),
  UNIQUE KEY `unique_interaction` (`user_id`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Bảng tổng hợp dữ liệu ẩn (Implicit Data) cho AI';


CREATE TABLE IF NOT EXISTS `match_history` (
  `match_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `suggested_group_id` int DEFAULT NULL,
  `match_score` float DEFAULT NULL,
  `action` enum('VIEWED','CLICKED','JOIN_REQUESTED','IGNORED') DEFAULT 'VIEWED',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `skills` (
  `skill_id` int NOT NULL AUTO_INCREMENT,
  `skill_name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`skill_id`),
  UNIQUE KEY `skill_name` (`skill_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `user_skills` (
  `user_id` int NOT NULL,
  `skill_id` int NOT NULL,
  `type` enum('GOOD_AT','WANT_TO_LEARN') NOT NULL,
  `proficiency_level` tinyint DEFAULT NULL,
  PRIMARY KEY (`user_id`,`skill_id`),
  KEY `skill_id` (`skill_id`),
  CONSTRAINT `user_skills_ibfk_1` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`skill_id`) ON DELETE CASCADE,
  CONSTRAINT `user_skills_chk_1` CHECK ((`proficiency_level` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE DATABASE IF NOT EXISTS `db_user_service` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_user_service`;

CREATE TABLE IF NOT EXISTS `friend_connections` (
  `connection_id` int NOT NULL AUTO_INCREMENT,
  `requester_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `status` enum('PENDING','ACCEPTED','BLOCKED') DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`connection_id`),
  UNIQUE KEY `requester_id` (`requester_id`,`receiver_id`),
  UNIQUE KEY `UKlcehj8ovy2huqfni3nuvvqpgn` (`requester_id`,`receiver_id`),
  KEY `receiver_id` (`receiver_id`),
  CONSTRAINT `friend_connections_ibfk_1` FOREIGN KEY (`requester_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `friend_connections_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `friend_connections` (`connection_id`, `requester_id`, `receiver_id`, `status`, `created_at`) VALUES
	(1, 2, 3, 'ACCEPTED', '2025-12-24 06:33:29'),
	(2, 3, 4, 'PENDING', '2025-12-24 06:33:29'),
	(3, 4, 5, 'BLOCKED', '2025-12-24 06:33:29'),
	(4, 2, 6, 'ACCEPTED', '2025-12-24 06:33:29'),
	(5, 6, 3, 'PENDING', '2025-12-24 06:33:29');

CREATE TABLE IF NOT EXISTS `student_profiles` (
  `profile_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `student_code` varchar(20) NOT NULL,
  `major` varchar(100) DEFAULT NULL,
  `bio` text,
  `learning_style` enum('VISUAL','AUDITORY','READING','KINESTHETIC','SOCIAL','SOLITARY') DEFAULT 'SOCIAL',
  `gpa` float DEFAULT '0',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `student_code` (`student_code`),
  CONSTRAINT `student_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `student_profiles` (`profile_id`, `user_id`, `student_code`, `major`, `bio`, `learning_style`, `gpa`) VALUES
	(1, 2, 'SV2021001', 'Computer Science', 'Yêu thích lập trình Android và AI', 'VISUAL', 3.6),
	(2, 3, 'SV2021002', 'Information Systems', 'Quan tâm đến Backend và Database', 'READING', 3.4),
	(3, 4, 'SV2021003', 'Software Engineering', 'Thích làm việc nhóm và Agile', 'SOCIAL', 3.8),
	(4, 5, 'SV2021004', 'Artificial Intelligence', 'Đam mê Machine Learning', 'KINESTHETIC', 3.2),
	(5, 6, 'SV2021005', 'Cyber Security', 'Quan tâm bảo mật hệ thống', 'SOLITARY', 3);

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `role` enum('STUDENT','ADMIN') DEFAULT 'STUDENT',
  `status` enum('ACTIVE','BANNED','LOCKED') DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `users` (`user_id`, `email`, `password_hash`, `full_name`, `avatar_url`, `role`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'admin@school.edu', '$2a$10$adminhash', 'Admin System', NULL, 'ADMIN', 'ACTIVE', '2025-12-24 06:32:55', '2025-12-24 06:32:55'),
	(2, 'student1@school.edu', '$2a$10$hash1', 'Nguyễn Văn An', 'https://example.com/avatar/an.png', 'STUDENT', 'ACTIVE', '2025-12-24 06:32:55', '2025-12-24 06:32:55'),
	(3, 'student2@school.edu', '$2a$10$hash2', 'Trần Thị Bình', 'https://example.com/avatar/binh.png', 'STUDENT', 'ACTIVE', '2025-12-24 06:32:55', '2025-12-24 06:32:55'),
	(4, 'student3@school.edu', '$2a$10$hash3', 'Lê Minh Châu', NULL, 'STUDENT', 'ACTIVE', '2025-12-24 06:32:55', '2025-12-24 06:32:55'),
	(5, 'student4@school.edu', '$2a$10$hash4', 'Phạm Quốc Dũng', NULL, 'STUDENT', 'LOCKED', '2025-12-24 06:32:55', '2025-12-24 06:32:55'),
	(6, 'student5@school.edu', '$2a$10$hash5', 'Võ Thanh Hà', NULL, 'STUDENT', 'BANNED', '2025-12-24 06:32:55', '2025-12-24 06:32:55');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
