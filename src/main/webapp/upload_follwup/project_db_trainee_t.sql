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
  PRIMARY KEY (`tr_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainee_t`
--

LOCK TABLES `trainee_t` WRITE;
/*!40000 ALTER TABLE `trainee_t` DISABLE KEYS */;
INSERT INTO `trainee_t` VALUES (1,'김신조','911111-1111111','02-494-1647','010-4444-5555','02782','서울시',0,NULL,'1','2',0);
/*!40000 ALTER TABLE `trainee_t` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-26 13:00:09
