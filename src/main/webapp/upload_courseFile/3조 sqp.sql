-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: project_db
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `advice_sst`
--

DROP TABLE IF EXISTS `advice_sst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advice_sst` (
  `ss_idx` int NOT NULL AUTO_INCREMENT,
  `ss_time` varchar(45) DEFAULT NULL,
  `sf_idx` varchar(45) DEFAULT NULL,
  `ss_day` varchar(45) DEFAULT NULL,
  `ss_name` varchar(45) DEFAULT NULL,
  `ss_pp` varchar(45) DEFAULT NULL,
  `tr_idx` varchar(45) DEFAULT NULL,
  `ss_msg` varchar(45) DEFAULT NULL,
  `ss_msubject` varchar(45) DEFAULT NULL,
  `ss_bd` varchar(45) DEFAULT NULL,
  `ss_member` varchar(45) DEFAULT NULL,
  `ss_mday` varchar(45) DEFAULT NULL,
  `ss_pa` varchar(45) DEFAULT NULL,
  `ss_img` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ss_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advice_sst`
--

LOCK TABLES `advice_sst` WRITE;
/*!40000 ALTER TABLE `advice_sst` DISABLE KEYS */;
/*!40000 ALTER TABLE `advice_sst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advice_t`
--

DROP TABLE IF EXISTS `advice_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advice_t` (
  `so_idx` int NOT NULL AUTO_INCREMENT,
  `ss_day` varchar(45) DEFAULT NULL,
  `tr_idx` varchar(45) DEFAULT NULL,
  `ss_menu` varchar(45) DEFAULT NULL,
  `ss_pp` varchar(45) DEFAULT NULL,
  `ss_subject` varchar(45) DEFAULT NULL,
  `ss_pd` varchar(45) DEFAULT NULL,
  `so_status` int DEFAULT NULL,
  `c_idx` int DEFAULT NULL,
  PRIMARY KEY (`so_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advice_t`
--

LOCK TABLES `advice_t` WRITE;
/*!40000 ALTER TABLE `advice_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `advice_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_t`
--

DROP TABLE IF EXISTS `board_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_t` (
  `bd_idx` bigint NOT NULL AUTO_INCREMENT,
  `bd_subject` varchar(45) DEFAULT NULL,
  `bd_writer` varchar(45) DEFAULT NULL,
  `bd_write_date` varchar(45) DEFAULT NULL,
  `bd_hit` varchar(45) DEFAULT NULL,
  `bd_content` longtext,
  `bd_file` varchar(45) DEFAULT NULL,
  `bd_notice` varchar(45) DEFAULT NULL,
  `bd_status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`bd_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_t`
--

LOCK TABLES `board_t` WRITE;
/*!40000 ALTER TABLE `board_t` DISABLE KEYS */;
INSERT INTO `board_t` VALUES (1,'첫번째글1',NULL,'2023-12-27','0','안녕하세요',NULL,NULL,'0'),(2,'제목2',NULL,'2023-12-28 12:43:26','0','12312421','',NULL,'0'),(3,'잘되나',NULL,'2023-12-28 13:03:23','0','잘되면써짐','',NULL,'0'),(4,'',NULL,'2023-12-28 13:06:35','0','','',NULL,'0'),(5,'수정수정',NULL,'2023-12-28 13:06:46','0','1232145214','',NULL,'0'),(6,'공지예시',NULL,'2023-12-28 13:07:39','0','1244','','1','0'),(7,'',NULL,'2023-12-28 13:10:22','0','','',NULL,'0'),(8,'수정확인',NULL,'2023-12-28 13:10:52','0','121234','',NULL,'0'),(9,'re:수정확인',NULL,'2023-12-28 14:38:10','0','						========================================\r\n*** 님이 작성한 글\r\n						수정됬나요\r\n					','',NULL,'0'),(10,NULL,NULL,'2023-12-28 14:39:02','0',NULL,NULL,NULL,'0'),(11,'12321',NULL,'2023-12-29 16:58:59','0','1231212','',NULL,'0'),(12,'',NULL,'2023-12-29 17:01:34','0','','',NULL,'0'),(13,'',NULL,'2023-12-29 17:02:13','0','','',NULL,'0');
/*!40000 ALTER TABLE `board_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_t`
--

DROP TABLE IF EXISTS `course_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_t` (
  `c_idx` bigint NOT NULL AUTO_INCREMENT,
  `c_name` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `course_fee` varchar(45) DEFAULT NULL,
  `c_peo_num` int DEFAULT NULL,
  `c_round_num` int DEFAULT NULL,
  `sf_idx` bigint DEFAULT NULL,
  `ti_idx` bigint DEFAULT NULL,
  `s_idx` bigint DEFAULT NULL,
  `r_idx` bigint DEFAULT NULL,
  `ct_idx` bigint DEFAULT NULL,
  `c_status` varchar(45) DEFAULT NULL,
  `c_day` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`c_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_t`
--

LOCK TABLES `course_t` WRITE;
/*!40000 ALTER TABLE `course_t` DISABLE KEYS */;
INSERT INTO `course_t` VALUES (1,'풀스택 개발자 과정2','2023-09-20','2024-03-13','1000',10,2,1,NULL,NULL,2,1,'1','월,화,수,목,금'),(2,'자바전문가 과정','2023-10-31','2024-04-29','5000',15,1,2,NULL,NULL,4,2,'1','월,화,수,목,금'),(3,'데이터베이스 과정','2022-11-25','2023-03-11','3000',20,2,3,NULL,NULL,5,1,'1','월,화,수,목,금'),(4,'과정명','2023-12-31','2024-05-24','0',24,1,1,NULL,NULL,3,1,'1','월,화,수,목,금'),(5,'과정명','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'1','월,화,수,목,금'),(6,'과정명','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,2,1,'1','월,화,수,목,금'),(7,'과정명','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,4,1,'0','월,화,수'),(8,'과정명','2023-12-31','2024-05-24','0',24,1,3,NULL,NULL,2,1,'0','월,화,금'),(9,'과정명2','2023-12-31','2024-05-24','0',24,1,3,NULL,NULL,3,1,'1','월,수,금'),(10,'과정명3','2023-12-31','2024-05-24','0',24,1,3,NULL,NULL,1,1,'0','월,화,수,목,금'),(11,'dd','2023-12-31','2024-05-24','0',24,1,1,NULL,NULL,5,2,'0','월,화,수,목,금'),(12,'dd','2023-12-31','2024-05-24','0',24,1,1,NULL,NULL,4,2,'0','월,화,수,목,금'),(13,'과정명2','2023-12-31','2024-05-24','0',24,1,1,NULL,NULL,1,1,'0','월,화,수,목,금'),(14,'과정명입니다','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(15,'과정명2','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(16,'과정명2','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(17,'과정명2','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(18,'과정명2','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(19,'과정명2','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'1','월,화,수,목,금'),(20,'과정명2','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(21,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(22,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(23,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(24,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목'),(25,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(26,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(27,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(28,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(29,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수'),(30,'과정명2','2024-01-01','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(31,'이가은','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0','월,화,수,목,금'),(47,'풀스택 개발자 과정','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,3,2,'0','월,화,수,목,금'),(48,'과정입니다','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,3,2,'0','월,화,수,목,금'),(49,'스프링부트체험','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,3,2,'0','월,화,수,목,금'),(50,'스프링부트체험','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,3,2,'0','월,화,수,목,금'),(51,'스프링부트체험','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,3,2,'0','월,화,수,목,금'),(52,'스프링부트체험입니다','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,3,2,'0','월,화,수,목,금'),(53,'스프링부트체험입니다','2023-12-31','2024-05-24','0',24,1,1,NULL,NULL,3,2,'0','월,화,수,목,금'),(54,'스프링부트체험입니다2','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,3,2,'0','화,수'),(55,'개발자 과정','2023-12-31','2024-05-24','0',24,1,2,NULL,NULL,1,2,'0',NULL);
/*!40000 ALTER TABLE `course_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_type_t`
--

DROP TABLE IF EXISTS `course_type_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_type_t` (
  `ct_idx` bigint NOT NULL AUTO_INCREMENT,
  `ct_name` varchar(45) DEFAULT NULL,
  `ct_color` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ct_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_type_t`
--

LOCK TABLES `course_type_t` WRITE;
/*!40000 ALTER TABLE `course_type_t` DISABLE KEYS */;
INSERT INTO `course_type_t` VALUES (1,'국가기관','#ff0f0f'),(2,'내일배움카드','#00f000'),(3,'테스트','#e60000'),(4,'테스트2','#e29292'),(5,'테스트3','#8e3939');
/*!40000 ALTER TABLE `course_type_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_t`
--

DROP TABLE IF EXISTS `file_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file_t` (
  `f_idx` bigint NOT NULL AUTO_INCREMENT,
  `f_name` varchar(45) DEFAULT NULL,
  `f_info` varchar(45) DEFAULT NULL,
  `c_idx` bigint DEFAULT NULL,
  PRIMARY KEY (`f_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_t`
--

LOCK TABLES `file_t` WRITE;
/*!40000 ALTER TABLE `file_t` DISABLE KEYS */;
INSERT INTO `file_t` VALUES (1,'memoVO6.png','운영계획서',7),(2,'member_mapper2.png','학습안내서',7),(3,'memoVO4.png','OT설명자료',7),(4,NULL,'평가계획서',7),(5,'member_mapper3.png','평가도구적절성',7),(6,'memoVO5.png','훈련일일시간표',7),(7,NULL,'운영계획서',2),(8,NULL,'OT설명자료',2),(9,NULL,'평가계획서',2),(10,NULL,'평가도구적절성',2),(11,NULL,'훈련일일시간표',2),(12,NULL,'학습안내서',2),(19,'m_delete1.png','운영계획서',11),(20,NULL,'학습안내서',11),(21,'memberVO.png','OT설명자료',11),(22,'','평가계획서',11),(23,'memoList1.png','평가도구적절성',11),(24,'7.png','훈련일일시간표',11),(25,NULL,'운영계획서',8),(26,'memoVO1.png','학습안내서',8),(27,'','OT설명자료',8),(28,'static_factory1.png','평가계획서',8),(29,'','평가도구적절성',8),(30,'memoVO3.png','훈련일일시간표',8),(31,NULL,'운영계획서',10),(32,NULL,'학습안내서',10),(33,'m_delete.png','OT설명자료',10),(34,NULL,'평가계획서',10),(35,NULL,'평가도구적절성',10),(36,NULL,'훈련일일시간표',10),(37,NULL,'운영계획서',20),(38,'member_mapper.png','학습안내서',20),(39,NULL,'OT설명자료',20),(40,NULL,'평가계획서',20),(41,'member_mapper1.png','평가도구적절성',20),(42,NULL,'훈련일일시간표',20),(43,'static_factory2.png','운영계획서',31),(44,NULL,'학습안내서',31),(45,NULL,'OT설명자료',31),(46,NULL,'평가계획서',31),(47,'memoVO7.png','평가도구적절성',31),(48,NULL,'훈련일일시간표',31),(49,'static_factory3.png','운영계획서',50),(50,NULL,'학습안내서',50),(51,NULL,'OT설명자료',50),(52,NULL,'평가계획서',50),(53,NULL,'평가도구적절성',50),(54,NULL,'훈련일일시간표',50);
/*!40000 ALTER TABLE `file_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `right_t`
--

DROP TABLE IF EXISTS `right_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `right_t` (
  `rt_idx` bigint NOT NULL AUTO_INCREMENT,
  `rt_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`rt_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `right_t`
--

LOCK TABLES `right_t` WRITE;
/*!40000 ALTER TABLE `right_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `right_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_t`
--

DROP TABLE IF EXISTS `room_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_t` (
  `r_idx` bigint NOT NULL AUTO_INCREMENT,
  `r_name` varchar(45) DEFAULT NULL,
  `r_sep` int DEFAULT NULL,
  `r_status` int DEFAULT NULL,
  PRIMARY KEY (`r_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_t`
--

LOCK TABLES `room_t` WRITE;
/*!40000 ALTER TABLE `room_t` DISABLE KEYS */;
INSERT INTO `room_t` VALUES (1,'101호',2,0),(2,'103호',2,0),(3,'204호',2,0),(4,'201호',2,0),(5,'303호',2,0),(6,'301호',2,0),(7,'501호',2,0),(8,'601호',2,0);
/*!40000 ALTER TABLE `room_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_t`
--

DROP TABLE IF EXISTS `skill_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skill_t` (
  `sk_idx` bigint NOT NULL AUTO_INCREMENT,
  `sk_name` varchar(45) DEFAULT NULL,
  `us_idx` bigint DEFAULT NULL,
  PRIMARY KEY (`sk_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_t`
--

LOCK TABLES `skill_t` WRITE;
/*!40000 ALTER TABLE `skill_t` DISABLE KEYS */;
INSERT INTO `skill_t` VALUES (1,'DB경험',2),(2,'모델링경험',3),(3,'서버경험',4),(4,'웹경험',5),(5,'앱경험',6),(6,'코딩능력향상',1);
/*!40000 ALTER TABLE `skill_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_t`
--

DROP TABLE IF EXISTS `staff_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_t` (
  `sf_idx` bigint NOT NULL AUTO_INCREMENT,
  `sf_code` varchar(45) NOT NULL,
  `sf_name` varchar(45) DEFAULT NULL,
  `sf_phone` varchar(45) DEFAULT NULL,
  `sf_email` varchar(45) DEFAULT NULL,
  `sf_job` varchar(45) DEFAULT NULL,
  `sf_hire_date` date DEFAULT NULL,
  `sf_fire_date` date DEFAULT NULL,
  `status` int DEFAULT NULL,
  `sf_id` varchar(45) DEFAULT NULL,
  `sf_pwd` varchar(45) DEFAULT NULL,
  `rt_idx` bigint DEFAULT NULL,
  `sf_fname` varchar(45) DEFAULT NULL,
  `sf_link` int DEFAULT NULL,
  `sf_mgr` int DEFAULT NULL,
  PRIMARY KEY (`sf_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_t`
--

LOCK TABLES `staff_t` WRITE;
/*!40000 ALTER TABLE `staff_t` DISABLE KEYS */;
INSERT INTO `staff_t` VALUES (1,'123','나상담','010','na@naver.com','상담직원','2018-10-30',NULL,0,'sangdam','1234',0,NULL,0,0),(2,'1111','정책임','011','jung@daum.net','총책임자','2016-11-14',NULL,0,'jung','1111',9,NULL,0,9),(3,'2211','임사무','011','lim@naver.com','사무직','2022-12-11',NULL,0,'clerk','1212',0,NULL,0,0),(4,'tcnull','일지매','010-1234-5678',NULL,'사원','2023-01-01',NULL,0,'jimae','1234',0,NULL,NULL,0),(8,'tc108636','이도','010-1234-5678',NULL,'사원','2023-01-01',NULL,0,'jimae','1111',1,NULL,NULL,1),(16,'tcnull','이가은','010-1234-5647',NULL,'사원','2023-12-29',NULL,0,'lke','1234',9,NULL,NULL,9),(17,'tcnull','일지매','010ff-1234-4554ff',NULL,'사원','2023-12-15',NULL,0,'jimae','1234',9,NULL,NULL,9);
/*!40000 ALTER TABLE `staff_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_t`
--

DROP TABLE IF EXISTS `subject_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject_t` (
  `s_idx` bigint NOT NULL AUTO_INCREMENT,
  `s_title` varchar(50) DEFAULT NULL,
  `s_type` varchar(10) DEFAULT NULL,
  `s_time` bigint DEFAULT NULL,
  `t_idx` bigint DEFAULT NULL,
  `r_idx` bigint DEFAULT NULL,
  `sk_idx` bigint DEFAULT NULL,
  `c_idx` bigint DEFAULT NULL,
  PRIMARY KEY (`s_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_t`
--

LOCK TABLES `subject_t` WRITE;
/*!40000 ALTER TABLE `subject_t` DISABLE KEYS */;
INSERT INTO `subject_t` VALUES (1,'기초프로그래밍','비NCS',12,1,1,NULL,NULL),(2,'데이터베이스','NCS',10,2,3,NULL,NULL),(3,'DB모델링','비NCS',11,1,2,NULL,NULL),(4,'서버프로그래밍','NCS',14,3,4,NULL,NULL),(5,'웹퍼블리싱','NCS',13,2,6,NULL,NULL),(6,'앱프로그래밍','비NCS',11,1,5,NULL,NULL);
/*!40000 ALTER TABLE `subject_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggestion_t`
--

DROP TABLE IF EXISTS `suggestion_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suggestion_t` (
  `sg_idx` bigint NOT NULL AUTO_INCREMENT,
  `sg_subject` varchar(45) DEFAULT NULL,
  `sg_writer` varchar(45) DEFAULT NULL,
  `sg_write_date` varchar(45) DEFAULT NULL,
  `sg_hit` varchar(45) DEFAULT NULL,
  `sg_content` longtext,
  `sg_file` varchar(45) DEFAULT NULL,
  `notice` int DEFAULT NULL,
  `c_code` varchar(45) DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`sg_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggestion_t`
--

LOCK TABLES `suggestion_t` WRITE;
/*!40000 ALTER TABLE `suggestion_t` DISABLE KEYS */;
INSERT INTO `suggestion_t` VALUES (1,'출첵','홍길동','2023-12-26','0','출첵입니다',NULL,1,'1',0),(2,'123123',NULL,'2023-12-26 12:42:00','0','실험','',NULL,NULL,0),(3,'123123',NULL,'2023-12-26 12:48:47','0','실험','',NULL,NULL,1),(4,'123123',NULL,'2023-12-26 12:50:44','0','실험','',NULL,NULL,1),(5,'안녕',NULL,'2023-12-26 12:52:44','0','111','',NULL,NULL,0),(6,'안녕',NULL,'2023-12-26 12:52:49','0','111','',NULL,NULL,0),(7,'불만',NULL,'2023-12-26 13:14:33','0','없음','',1,NULL,0),(8,'안녕하십니까',NULL,'2023-12-26 14:25:26','0','공지','',1,NULL,0),(9,'re:불만','정책임','2023-12-26 18:48:08','0','						========================================\r\n*** 님이 작성한 글\r\n						========================================\r\n없음\r\n\r\n==> 답변입니다.\r\n없어서 다행이군요\r\n					','',NULL,NULL,0),(10,'re:안녕','정책임','2023-12-26 18:48:32','0','						========================================\r\n*** 님이 작성한 글\r\n						========================================\r\n111\r\n					\r\n==> 답변입니다.\r\n안녕하세요','',NULL,NULL,0),(11,'re:123123','정책임','2023-12-26 18:50:05','0','						========================================\r\n*** 님이 작성한 글\r\n						========================================\r\n실험\r\n					\r\n==> 답변입니다.\r\n실험 성공?','',NULL,NULL,0),(12,'re:안녕','정책임','2023-12-26 18:50:19','0','						========================================\r\n*** 님이 작성한 글\r\n						========================================\r\n111\r\n					\r\n==> 답변입니다.\r\ntest','',1,NULL,0),(13,'안녕하세여',NULL,'2023-12-29 16:55:43','0','ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ','',1,NULL,0),(14,'',NULL,'2023-12-29 17:01:07','0','','',NULL,NULL,0),(15,'ddd',NULL,'2023-12-29 18:13:51','0','dddd','',1,NULL,0);
/*!40000 ALTER TABLE `suggestion_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_t`
--

DROP TABLE IF EXISTS `time_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_t` (
  `ti_idx` bigint NOT NULL AUTO_INCREMENT,
  `ti_class` varchar(10) DEFAULT NULL,
  `ti_str_time` time DEFAULT NULL,
  `ti_end_time` time DEFAULT NULL,
  PRIMARY KEY (`ti_idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_t`
--

LOCK TABLES `time_t` WRITE;
/*!40000 ALTER TABLE `time_t` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainee_t`
--

DROP TABLE IF EXISTS `trainee_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainee_t` (
  `tr_idx` bigint NOT NULL AUTO_INCREMENT,
  `tr_name` varchar(45) DEFAULT NULL,
  `tr_rrn` varchar(45) DEFAULT NULL,
  `tr_phone` varchar(45) DEFAULT NULL,
  `tr_hp` varchar(45) DEFAULT NULL,
  `tr_pos_code` varchar(45) DEFAULT NULL,
  `tr_addr` varchar(45) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `memo` varchar(45) DEFAULT NULL,
  `c_code` varchar(45) DEFAULT NULL,
  `ct_code` varchar(45) DEFAULT NULL,
  `tr_total_fee` bigint DEFAULT NULL,
  `s_code` varchar(45) DEFAULT NULL,
  `c_img` varchar(45) DEFAULT NULL,
  `ss_end` date DEFAULT NULL,
  `ss_num` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`tr_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainee_t`
--

LOCK TABLES `trainee_t` WRITE;
/*!40000 ALTER TABLE `trainee_t` DISABLE KEYS */;
INSERT INTO `trainee_t` VALUES (1,'김신조','911111-1111111','02-494-1647','010-4444-5555','02782','서울시',0,NULL,'1','2',0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `trainee_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainupload_t`
--

DROP TABLE IF EXISTS `trainupload_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainupload_t` (
  `tn_idx` bigint NOT NULL AUTO_INCREMENT,
  `subject` varchar(50) DEFAULT NULL,
  `content` text,
  `file_name` varchar(50) DEFAULT NULL,
  `ori_name` varchar(50) DEFAULT NULL,
  `tn_name` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`tn_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainupload_t`
--

LOCK TABLES `trainupload_t` WRITE;
/*!40000 ALTER TABLE `trainupload_t` DISABLE KEYS */;
INSERT INTO `trainupload_t` VALUES (1,'테스트','<p>ddd</p><p>&nbsp;</p><p>&nbsp;</p><p>cols=\"100\" rows=\"8\"&gt;</p><p>cols=\"100\" rows=\"8\"&gt;</p>','mydb.txt','mydb.txt','교재','1'),(2,'테스트2','내용2',NULL,NULL,'교재','1'),(3,'테스트3','내용3',NULL,NULL,'교재','1'),(4,'세번째','<p>1111</p><p>&nbsp;</p><p>cols=\"100\" rows=\"8\"&gt;</p>','교,강사 아이콘.png','교,강사 아이콘.png',NULL,'1'),(5,'세번째','<p>11111</p><p>&nbsp;</p><p>cols=\"100\" rows=\"8\"&gt;</p>','관리자 아이콘.png','관리자 아이콘.png',NULL,'0'),(6,'22222','<p>11111</p>',NULL,'첫번째이미지테스트.jpeg',NULL,'0'),(7,'22222','<p>11111</p>',NULL,'첫번째이미지테스트.jpeg',NULL,'0');
/*!40000 ALTER TABLE `trainupload_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upskill_t`
--

DROP TABLE IF EXISTS `upskill_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upskill_t` (
  `us_idx` bigint NOT NULL AUTO_INCREMENT,
  `us_name` varchar(45) DEFAULT NULL,
  `s_idx` bigint DEFAULT NULL,
  `us_ncs` varchar(45) DEFAULT NULL,
  `sk_idx` varchar(45) DEFAULT NULL,
  `t_idx` int DEFAULT NULL,
  `us_cnum` int DEFAULT NULL,
  PRIMARY KEY (`us_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upskill_t`
--

LOCK TABLES `upskill_t` WRITE;
/*!40000 ALTER TABLE `upskill_t` DISABLE KEYS */;
INSERT INTO `upskill_t` VALUES (1,'능력향상',2,'ncs','1',2,1);
/*!40000 ALTER TABLE `upskill_t` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-24 17:57:38
