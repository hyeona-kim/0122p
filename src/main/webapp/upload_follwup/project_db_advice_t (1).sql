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
  `sf_idx` int DEFAULT NULL,
  `so_menu` varchar(45) DEFAULT NULL,
  `so_pp` varchar(60) DEFAULT NULL,
  `so_subject` varchar(3000) DEFAULT NULL,
  `so_pd` varchar(3000) DEFAULT NULL,
  `c_idx` int DEFAULT NULL,
  `so_status` int DEFAULT NULL,
  PRIMARY KEY (`so_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advice_t`
--

LOCK TABLES `advice_t` WRITE;
/*!40000 ALTER TABLE `advice_t` DISABLE KEYS */;
INSERT INTO `advice_t` VALUES (1,'2024-01-23',1,1,'일반상담','과정중 어려운 부분이나 고충 사항들이 있는지 상담 및 문제점 파악 후 해결하기 위함','과정중 어려운 부분이 많아 이해하기 힘들다는 불만사항이 나옴','다른 훈련생들과 의견을 종합하여 보충수업을 진행하기로 함(3/2예정)',1,0),(2,'2024-01-24',1,1,'고충상담','과정을 이수하는 도중 발생한 고충 사항들이 있는지 상담','자신이 학습에 있어 부족함이 많아 프로젝트를 따라가기 힘들다고 함','주말에 나와 자습하기로 함',1,0),(7,'2024-01-25',1,1,'일반상담','과정중 어려운 부분이 있는지 상담 및 문제점 파악 후 해결하기 위함','다른 이들보다 학습에 있어 뒤떨어져 혼자 질문하기 힘들다고 함','모르는 부분이 있으면 개인 톡이나 디스코드를 통해 질문하기로 함',1,0),(8,'2024-02-04',1,1,'취업상담','취업 관련하여 궁금한 사항이나 문제가 있는지 상담 및 해결하기 위함','좋은 결과를 내지 못해 자신이 취업할 수 있는지 고민이 많다고 함','현재 들어갈 수 있을만한 회사의 리스트를 주고 면접 연습을 하기로 함',1,0),(9,'2024-02-05',1,1,'고충상담','과정을 이수하는 도중 발생한 고충 사항들이 있는지 상담','동기와의 사소한 말다툼이 있어서 프로젝트를 참여할 수 있을지 모르겠다고 함','말다툼이 생긴 원인을 해결하고 중재를 통해 서로 화해함',1,0),(11,'2024-02-06',1,1,'인생상담','살아가는데 힘든 일이 있는지 상담','공부가 너무 힘들고 아무것도 하기 싫다고 함','운동을 통해 조금씩 삶의 의욕을 되찾게 하기로 함',1,0),(17,'2024-02-06',1,1,'1','1','1','1',1,1);
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

-- Dump completed on 2024-01-29  9:59:10
