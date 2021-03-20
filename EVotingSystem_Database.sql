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
  `temppwdvalid` date DEFAULT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `otpvalid` date DEFAULT NULL,
  `allowedmenu` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ins_dt` datetime NOT NULL,
  `ins_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  `upd_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `upd_by` varchar(100) NOT NULL DEFAULT 'sysadmin',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `userid_UNIQUE` (`userid`),
  UNIQUE KEY `users_id_UNIQUE` (`users_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user_credentials`
--

LOCK TABLES `t_user_credentials` WRITE;
/*!40000 ALTER TABLE `t_user_credentials` DISABLE KEYS */;
INSERT INTO `t_user_credentials` VALUES (1,1,'arnav.mahajan.2001@gmail.com','$2b$10$phRysdzoHdwtrdZehLsJtuOGWIGRw/XsM5uP2yir1txf8wIlfs3KW',2,NULL,NULL,NULL,NULL,NULL,1,'2021-03-07 12:42:21','sysadmin','2021-03-07 07:12:21','sysadmin');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_users`
--

LOCK TABLES `t_users` WRITE;
/*!40000 ALTER TABLE `t_users` DISABLE KEYS */;
INSERT INTO `t_users` VALUES (1,'Arnav Mahajan',1,'999970097','arnav.mahajan.2001@gmail.com',1,'2021-03-07 12:42:20','sysamind','2021-03-07 07:12:20','sysadmin');
/*!40000 ALTER TABLE `t_users` ENABLE KEYS */;
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

-- Dump completed on 2021-03-20 14:15:42
