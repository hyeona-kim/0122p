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
-- Table structure for table `advice_t`
--

DROP TABLE IF EXISTS `advice_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advice_t` (
  `so_idx` int NOT NULL AUTO_INCREMENT,
  `so_day` date DEFAULT NULL,
  `tr_idx` int DEFAULT NULL,
  `so_menu` varchar(45) DEFAULT NULL,
  `so_pp` varchar(60) DEFAULT NULL,
  `so_subject` varchar(3000) DEFAULT NULL,
  `so_pd` varchar(3000) DEFAULT NULL,
  `c_idx` int DEFAULT NULL,
  `so_status` int DEFAULT NULL,
  PRIMARY KEY (`so_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advice_t`
--

LOCK TABLES `advice_t` WRITE;
/*!40000 ALTER TABLE `advice_t` DISABLE KEYS */;
INSERT INTO `advice_t` VALUES (1,'2024-01-23',1,'일반상담','과정중 어려운 부분이나 고충 사항들이 있는지 상담 및 문제점 파악 후 해결하기 위함','과정중 어려운 부분이 많아 이해하기 힘들다는 불만사항이 나옴','다른 훈련생들과 의견을 종합하여 보충수업을 진행하기로 함(3/2예정)',1,0);
/*!40000 ALTER TABLE `advice_t` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-24 11:05:22
