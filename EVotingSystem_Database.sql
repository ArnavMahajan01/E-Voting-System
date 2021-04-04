-- MariaDB dump 10.17  Distrib 10.4.11-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: voting_system
-- ------------------------------------------------------
-- Server version	10.4.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `b_party_candidate`
--

DROP TABLE IF EXISTS `b_party_candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_party_candidate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `party_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ins_dt` datetime NOT NULL,
  `ins_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  `upd_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `upd_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `paty_idx` (`party_id`),
  KEY `candidate_idx` (`candidate_id`),
  CONSTRAINT `candidate` FOREIGN KEY (`candidate_id`) REFERENCES `t_candidate` (`candidate_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `party` FOREIGN KEY (`party_id`) REFERENCES `t_party` (`party_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_party_candidate`
--

LOCK TABLES `b_party_candidate` WRITE;
/*!40000 ALTER TABLE `b_party_candidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_party_candidate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_gender`
--

DROP TABLE IF EXISTS `m_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_gender` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gender_name` varchar(50) DEFAULT NULL,
  `rec_st` tinyint(1) DEFAULT 1,
  `ins_dt` datetime DEFAULT NULL,
  `ins_by` varchar(100) DEFAULT 'sysadmin',
  `upd_dt` timestamp NULL DEFAULT current_timestamp(),
  `upd_by` varchar(100) DEFAULT 'sysadmin',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`gender_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_gender`
--

LOCK TABLES `m_gender` WRITE;
/*!40000 ALTER TABLE `m_gender` DISABLE KEYS */;
INSERT INTO `m_gender` VALUES (1,'Male',1,'2021-01-10 00:00:00','sysadmin','2021-01-09 20:24:14','sysadmin'),(2,'Female',1,'2021-01-10 00:00:00','sysadmin','2021-01-09 20:24:14','sysadmin'),(3,'Transgender',1,'2021-01-10 00:00:00','sysadmin','2021-01-09 20:24:14','sysadmin');
/*!40000 ALTER TABLE `m_gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_candidate`
--

DROP TABLE IF EXISTS `t_candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_candidate` (
  `candidate_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `short_desc` varchar(100) NOT NULL,
  `long_desc` varchar(500) DEFAULT NULL,
  `photo` varchar(500) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ins_dt` datetime NOT NULL,
  `ins_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  `upd_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `upd_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  PRIMARY KEY (`candidate_id`),
  UNIQUE KEY `candidate_id_UNIQUE` (`candidate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_candidate`
--

LOCK TABLES `t_candidate` WRITE;
/*!40000 ALTER TABLE `t_candidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_candidate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_elections`
--

DROP TABLE IF EXISTS `t_elections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_elections` (
  `elections_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ins_dt` datetime NOT NULL,
  `ins_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  `upd_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `upd_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  PRIMARY KEY (`elections_id`),
  UNIQUE KEY `id_UNIQUE` (`elections_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_elections`
--

LOCK TABLES `t_elections` WRITE;
/*!40000 ALTER TABLE `t_elections` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_elections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_party`
--

DROP TABLE IF EXISTS `t_party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_party` (
  `party_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `standing` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ins_dt` datetime NOT NULL,
  `ins_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  `upd_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `upd_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  PRIMARY KEY (`party_id`),
  UNIQUE KEY `id_UNIQUE` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_party`
--

LOCK TABLES `t_party` WRITE;
/*!40000 ALTER TABLE `t_party` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user_credentials`
--

DROP TABLE IF EXISTS `t_user_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_credentials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `userid` varchar(100) NOT NULL COMMENT 'userid=email',
  `password` varchar(1000) NOT NULL,
  `userrole` int(11) NOT NULL DEFAULT 2 COMMENT '1=admin, 2=user',
  `temppwd` varchar(767) DEFAULT NULL,
  `temppwdvalid` datetime DEFAULT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `otpvalid` date DEFAULT NULL,
  `allowedmenu` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ins_dt` datetime NOT NULL,
  `ins_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  `upd_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `upd_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  `tmp_txtpwd` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `userid_UNIQUE` (`userid`),
  UNIQUE KEY `users_id_UNIQUE` (`users_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user_credentials`
--

LOCK TABLES `t_user_credentials` WRITE;
/*!40000 ALTER TABLE `t_user_credentials` DISABLE KEYS */;
INSERT INTO `t_user_credentials` VALUES (1,1,'arnav.mahajan.2001@gmail.com','$2b$10$hEZjXUZTEwDgOln5de7nyOHOvIajW/tT191vTT7bp4Xa1t04qCaS.',2,'$2b$10$B5k1octroiIFJjSqtv0ZoeIapTRBN/5JGy4VH86qXTn0V0qrNhPtS','2021-03-28 23:34:32',NULL,NULL,NULL,1,'2021-03-07 12:42:21','sysadmin','2021-03-07 07:12:21','sysadmin',NULL),(3,3,'arun1@npm.com','$2b$10$vgc8NLEeASc.DIYl8dLpgu.01QYXB4XbBoYMYlr1LiXHQ4Kxm3FHK',2,NULL,NULL,NULL,NULL,NULL,1,'2021-03-24 12:55:09','sysadmin','2021-03-24 07:25:09','sysadmin',NULL),(4,4,'arun2@npm.com','$2b$10$0GZapaYZDjQ9LEF16OGu2ups4ZhWU89AZQuI10sXf3nc1dMksGqpq',2,NULL,NULL,NULL,NULL,NULL,1,'2021-03-24 13:06:13','sysadmin','2021-03-24 07:36:13','sysadmin','Arnav@5'),(5,5,'visheshsinha@gmail.com','$2b$10$B.dYoO8u72OlsZV5yylyp.jAc4DTaba90/S465fMzdgCEtRpMeCeS',2,'$2b$10$1g6QvdIPYNw7Q.FyaafARO7VvkTYD95qIGtRqdQBMRgu2nMXCN0Am','2021-03-28 19:37:49',NULL,NULL,NULL,1,'2021-03-28 19:07:08','sysadmin','2021-03-28 13:37:08','sysadmin','vishesh123');
/*!40000 ALTER TABLE `t_user_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_users`
--

DROP TABLE IF EXISTS `t_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `genderid` int(11) DEFAULT NULL,
  `primobno` varchar(25) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ins_dt` datetime NOT NULL,
  `ins_by` varchar(100) NOT NULL DEFAULT 'sysamind',
  `upd_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `upd_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_users`
--

LOCK TABLES `t_users` WRITE;
/*!40000 ALTER TABLE `t_users` DISABLE KEYS */;
INSERT INTO `t_users` VALUES (1,'Arnav Mahajan',1,'999970097','arnav.mahajan.2001@gmail.com',1,'2021-03-07 12:42:20','sysamind','2021-03-07 07:12:20','sysadmin'),(3,'Arun',1,'9716299115','arun1@npm.com',1,'2021-03-24 12:55:09','sysamind','2021-03-24 07:25:09','sysadmin'),(4,'Arun',1,'9716299115','arun2@npm.com',1,'2021-03-24 13:06:13','sysamind','2021-03-24 07:36:13','sysadmin'),(5,'Vishesh',1,'97312356232','visheshsinha@gmail.com',1,'2021-03-28 19:07:08','sysamind','2021-03-28 13:37:08','sysadmin');
/*!40000 ALTER TABLE `t_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_vote_transc`
--

DROP TABLE IF EXISTS `t_vote_transc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_vote_transc` (
  `vot_transc_id` int(11) NOT NULL AUTO_INCREMENT,
  `voter_id` int(11) NOT NULL,
  `party_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `election_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ins_dt` datetime NOT NULL,
  `ins_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  `upd_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `upd_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  PRIMARY KEY (`vot_transc_id`),
  UNIQUE KEY `id_UNIQUE` (`vot_transc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_vote_transc`
--

LOCK TABLES `t_vote_transc` WRITE;
/*!40000 ALTER TABLE `t_vote_transc` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_vote_transc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'voting_system'
--

--
-- Dumping routines for database 'voting_system'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-04 14:20:49
