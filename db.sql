CREATE DATABASE  IF NOT EXISTS `schooldb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `schooldb`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: schooldb
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `allexam`
--

DROP TABLE IF EXISTS `allexam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allexam` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `persion_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allexam`
--

LOCK TABLES `allexam` WRITE;
/*!40000 ALTER TABLE `allexam` DISABLE KEYS */;
INSERT INTO `allexam` VALUES (1,41,NULL,NULL,NULL),(2,48,NULL,NULL,NULL);
/*!40000 ALTER TABLE `allexam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_assignment`
--

DROP TABLE IF EXISTS `answer_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer_assignment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int DEFAULT NULL,
  `assignment_id` int DEFAULT NULL,
  `title` longtext COLLATE utf8mb4_unicode_ci,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `score` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_assignment`
--

LOCK TABLES `answer_assignment` WRITE;
/*!40000 ALTER TABLE `answer_assignment` DISABLE KEYS */;
INSERT INTO `answer_assignment` VALUES (1,14,4,'The result of study concludes from a survey and from literature review the implementation areas and challenges of the Node.js. Lastly will provide suggestion on',NULL,2,'2023-09-25 01:58:07','2023-09-26 19:04:54','100'),(2,14,4,'The React. js framework is an open-source JavaScript framework and library developed by Facebook.',NULL,2,'2023-09-25 23:51:22','2023-09-26 09:28:54','10'),(3,14,5,'Noted Teacher\nThank You Than You',NULL,2,'2023-09-25 23:54:22','2023-09-27 19:41:18','100'),(4,15,6,'Noted Teacher',NULL,2,'2023-09-25 23:55:12','2023-09-26 10:12:44','100'),(5,15,7,'Aws is a cloude service',NULL,2,'2023-09-26 10:27:00','2023-09-26 10:27:00',NULL);
/*!40000 ALTER TABLE `answer_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_midterm`
--

DROP TABLE IF EXISTS `answer_midterm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer_midterm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int DEFAULT NULL,
  `midterm_id` int DEFAULT NULL,
  `title` longtext COLLATE utf8mb4_unicode_ci,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `score` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_midterm`
--

LOCK TABLES `answer_midterm` WRITE;
/*!40000 ALTER TABLE `answer_midterm` DISABLE KEYS */;
INSERT INTO `answer_midterm` VALUES (1,14,3,'noted Teacher \nThank You...',NULL,2,'2023-09-25 01:47:04','2023-09-26 19:42:30',NULL),(2,14,8,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',NULL,2,'2023-09-25 20:18:54','2023-09-25 20:18:54',NULL),(3,12,1,'ABCDEFG',NULL,2,'2023-09-25 20:25:57','2023-09-25 20:25:57',NULL),(4,12,6,'ABCDEFGHIJKLMNOP',NULL,2,'2023-09-25 20:27:12','2023-09-25 20:27:12',NULL),(5,12,7,'ABCDeFGHIJKLMN',NULL,2,'2023-09-25 20:29:57','2023-09-25 20:29:57',NULL),(6,15,9,'print(\"Hello World\")',NULL,2,'2023-09-25 20:43:04','2023-09-26 10:12:59','100'),(7,14,11,'node js is js framwork using for backend',NULL,2,'2023-09-26 00:10:47','2023-09-26 09:26:12','10'),(8,15,10,'React js is js framwork develop by facebook',NULL,2,'2023-09-27 05:58:03','2023-09-27 05:58:03',NULL);
/*!40000 ALTER TABLE `answer_midterm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_quiz`
--

DROP TABLE IF EXISTS `answer_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer_quiz` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int DEFAULT NULL,
  `quiz_id` int DEFAULT NULL,
  `title` longtext COLLATE utf8mb4_unicode_ci,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `score` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_quiz`
--

LOCK TABLES `answer_quiz` WRITE;
/*!40000 ALTER TABLE `answer_quiz` DISABLE KEYS */;
INSERT INTO `answer_quiz` VALUES (1,14,7,'Node.js is an open source server environment.',NULL,2,'2023-09-25 01:04:47','2023-09-26 19:49:49','100'),(2,14,8,'for run program in computer.',NULL,2,'2023-09-25 10:11:06','2023-09-26 09:23:53','9'),(3,14,9,'noted Teacher',NULL,2,'2023-09-25 10:13:36','2023-09-26 19:01:43',NULL),(4,14,11,'Get Post Put Delete',NULL,2,'2023-09-25 10:16:47','2023-09-25 10:16:47',NULL),(5,16,5,'Vue is frontend framwork',NULL,2,'2023-09-25 10:17:52','2023-09-26 18:58:04',NULL),(6,15,10,'React is fromwork for frontend developer by facebook',NULL,2,'2023-09-25 10:21:17','2023-09-26 10:11:06','10'),(7,15,12,'yes yes yes yes yes yes yes yes yes yes yes',NULL,2,'2023-09-25 10:25:46','2023-09-25 10:25:46',NULL),(8,16,6,'Java Script',NULL,2,'2023-09-25 10:29:17','2023-09-25 10:29:17',NULL),(9,12,2,'Yes Teacher',NULL,2,'2023-09-25 10:30:07','2023-09-25 10:30:07',NULL),(10,12,3,'yes yes yes',NULL,2,'2023-09-25 10:30:43','2023-09-25 10:30:43',NULL),(11,13,4,'css framework',NULL,2,'2023-09-25 10:32:10','2023-09-25 10:32:10',NULL),(12,15,24,'ok ok \nThank You',NULL,2,'2023-09-30 08:56:03','2023-09-30 08:57:25','100');
/*!40000 ALTER TABLE `answer_quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `all_exam_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `persion_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `assignment_id` int DEFAULT NULL,
  `date_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
INSERT INTO `assignment` VALUES (1,48,NULL,NULL,NULL,NULL,'Your assignment Research About Khmer History',NULL,'2023-09-10 02:11:43','2023-09-10 02:11:43',NULL,NULL,NULL,NULL),(2,48,NULL,NULL,NULL,NULL,'Research about Khmer History',NULL,'2023-09-21 19:45:05','2023-09-21 19:45:05',12,NULL,NULL,NULL),(3,48,NULL,NULL,NULL,NULL,'Research about Khmer History',NULL,'2023-09-21 19:53:13','2023-09-21 19:53:13',12,NULL,NULL,NULL),(4,71,NULL,NULL,NULL,NULL,'Research about nodeJS.',NULL,'2023-09-22 08:53:28','2023-09-22 08:53:28',14,NULL,NULL,NULL),(5,71,NULL,NULL,NULL,NULL,'TasK:2\nDo book at last 15 page',NULL,'2023-09-22 08:54:35','2023-09-22 08:54:35',14,NULL,NULL,NULL),(6,71,NULL,NULL,NULL,NULL,'Hello all Student\nPlease Research about React Js\n- include how it was born\n- How to set up\n- How to use\n- benifiet',NULL,'2023-09-23 03:21:13','2023-09-23 03:21:13',15,NULL,'9/23/2023',NULL),(7,71,NULL,NULL,NULL,NULL,'Research About AWS',NULL,'2023-09-25 20:46:43','2023-09-25 20:46:43',15,NULL,'9/26/2023',NULL);
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `major` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_id` int DEFAULT NULL,
  `codeId` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `id_class` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (66,NULL,NULL,'Khmer',NULL,NULL,NULL,14),(67,NULL,NULL,'English',NULL,NULL,NULL,13),(68,NULL,NULL,'Mobile',NULL,NULL,NULL,17),(69,NULL,NULL,'CoM2',NULL,NULL,NULL,1),(70,NULL,NULL,'AA',NULL,NULL,NULL,15),(71,NULL,NULL,'front-end',NULL,NULL,NULL,16),(72,NULL,NULL,'Back-end',NULL,NULL,NULL,16),(73,NULL,NULL,'Network',NULL,NULL,NULL,18),(74,NULL,NULL,'Law',NULL,NULL,NULL,19),(75,NULL,NULL,'CoM1',NULL,NULL,NULL,21),(76,NULL,NULL,'CoM3',NULL,NULL,NULL,14),(77,NULL,NULL,'BB',NULL,NULL,NULL,15),(78,NULL,NULL,'CoE1',NULL,NULL,NULL,22),(79,NULL,NULL,'CoE2',NULL,NULL,NULL,22),(80,NULL,NULL,'Database',NULL,NULL,NULL,16),(81,NULL,NULL,'CoE2',NULL,NULL,17,NULL),(82,NULL,NULL,'CoM4',NULL,NULL,NULL,17),(83,NULL,NULL,'CoM5',NULL,NULL,NULL,17);
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_assignment`
--

DROP TABLE IF EXISTS `comment_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_assignment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int DEFAULT NULL,
  `assignment_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_assignment`
--

LOCK TABLES `comment_assignment` WRITE;
/*!40000 ALTER TABLE `comment_assignment` DISABLE KEYS */;
INSERT INTO `comment_assignment` VALUES (1,12,2,'Hello Teacher How can i submit my assignment',NULL,'2023-09-21 21:39:52','2023-09-21 21:39:52',NULL),(2,12,2,'comming soon',NULL,'2023-09-21 21:46:19','2023-09-21 21:46:19',NULL),(3,12,2,'Do in Group or not',NULL,'2023-09-23 04:41:00','2023-09-23 04:41:00',NULL),(4,12,2,'how many people per group',NULL,'2023-09-23 04:41:32','2023-09-23 04:41:32',NULL),(5,15,6,'Noted with thank teacher',NULL,'2023-09-23 04:49:13','2023-09-23 04:49:13',NULL),(6,12,3,'Noted Teacher',NULL,'2023-09-23 07:52:09','2023-09-23 07:52:09',NULL),(7,14,4,'Noted Teacher',NULL,'2023-09-25 02:05:01','2023-09-25 02:05:01',NULL);
/*!40000 ALTER TABLE `comment_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_midterm`
--

DROP TABLE IF EXISTS `comment_midterm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_midterm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int DEFAULT NULL,
  `midterm_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_midterm`
--

LOCK TABLES `comment_midterm` WRITE;
/*!40000 ALTER TABLE `comment_midterm` DISABLE KEYS */;
INSERT INTO `comment_midterm` VALUES (1,12,7,'What\'s time we start exam teacher?',NULL,'2023-09-21 21:04:09','2023-09-21 21:04:09',NULL),(2,12,1,'What\'s time we start exam teacher?',NULL,'2023-09-21 21:33:02','2023-09-21 21:33:02',NULL),(3,12,1,'What\'s time we start exam teacher?',NULL,'2023-09-23 03:44:41','2023-09-23 03:44:41',NULL),(4,12,1,'What\'s time we start exam teacher?',NULL,'2023-09-23 03:50:19','2023-09-23 03:50:19',NULL),(5,15,9,'What\'s time we start exam teacher?',NULL,'2023-09-23 04:11:56','2023-09-23 04:11:56',NULL),(6,15,9,'Can i deley Teacher?',NULL,'2023-09-23 04:20:04','2023-09-23 04:20:04',NULL),(7,15,9,'what\'s time we start teacher?',NULL,'2023-09-23 04:26:13','2023-09-23 04:26:13',NULL),(8,15,9,'Do in team or solo teacher?',NULL,'2023-09-23 04:26:31','2023-09-23 04:26:31',NULL),(9,14,3,'Noted with Thank You Teacher',NULL,'2023-09-25 00:25:39','2023-09-25 00:25:39',NULL),(10,12,6,'Deadline Teacher',NULL,'2023-09-25 00:29:04','2023-09-25 00:29:04',NULL),(11,15,9,'yk mong man lork kro',NULL,'2023-09-25 21:17:32','2023-09-25 21:17:32',NULL);
/*!40000 ALTER TABLE `comment_midterm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_quize`
--

DROP TABLE IF EXISTS `comment_quize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_quize` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int DEFAULT NULL,
  `quize_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_quize`
--

LOCK TABLES `comment_quize` WRITE;
/*!40000 ALTER TABLE `comment_quize` DISABLE KEYS */;
INSERT INTO `comment_quize` VALUES (1,12,2,'Hello Teacher. Can you explaination?',NULL,'2023-09-21 20:20:44','2023-09-21 20:20:44',NULL),(2,12,2,'Hello Teacher. Can you explaination?',NULL,'2023-09-21 20:53:02','2023-09-21 20:53:02',NULL),(3,12,2,'Hello Teacher. Can you explaination?',NULL,'2023-09-23 02:19:47','2023-09-23 02:19:47',NULL),(4,12,2,'Hello Teacher. Can you explaination?',NULL,'2023-09-23 02:30:22','2023-09-23 02:30:22',NULL),(5,12,2,'Hello Teacher. Can you explaination?',NULL,'2023-09-23 02:32:31','2023-09-23 02:32:31',2),(6,12,2,'Hello Teacher. Can you explaination?',NULL,'2023-09-23 02:58:21','2023-09-23 02:58:21',2),(7,12,2,'Hello Teacher. Can you explaination?',NULL,'2023-09-23 02:58:24','2023-09-23 02:58:24',NULL),(8,12,2,'Hello Teacher. Can you explaination?',NULL,'2023-09-23 02:58:45','2023-09-23 02:58:45',NULL),(9,12,3,'Deadline Teacher?',NULL,'2023-09-23 03:14:25','2023-09-23 03:14:25',NULL),(10,15,10,'Can i submit like file?',NULL,'2023-09-23 03:15:12','2023-09-23 03:15:12',NULL),(11,15,10,'Can i submit like file?',NULL,'2023-09-23 03:18:54','2023-09-23 03:18:54',NULL),(12,15,12,'Deadline Teacher?',NULL,'2023-09-23 03:25:37','2023-09-23 03:25:37',NULL),(13,15,10,'What\'s react js Teacher?',NULL,'2023-09-23 03:28:21','2023-09-23 03:28:21',NULL),(14,14,7,'Deadline Teacher?',NULL,'2023-09-23 03:35:52','2023-09-23 03:35:52',NULL),(15,15,9,'What\'s date time deadline teacher?',NULL,'2023-09-23 03:56:47','2023-09-23 03:56:47',NULL),(16,15,10,'good',NULL,'2023-09-23 04:26:44','2023-09-23 04:26:44',NULL),(17,15,12,'Cam someone help me',NULL,'2023-09-23 04:44:18','2023-09-23 04:44:18',NULL),(18,13,20,'Deadline Teacher?',NULL,'2023-09-24 00:21:22','2023-09-24 00:21:22',NULL),(19,13,20,'Hi',NULL,'2023-09-24 09:57:26','2023-09-24 09:57:26',NULL),(20,13,21,'Noted Teacher',NULL,'2023-09-24 20:58:39','2023-09-24 20:58:39',NULL),(21,14,7,'Pel na yk teacher',NULL,'2023-09-25 08:01:07','2023-09-25 08:01:07',NULL),(22,14,7,'nodted',NULL,'2023-09-27 05:56:39','2023-09-27 05:56:39',NULL),(23,12,3,'ok',NULL,'2023-09-29 19:34:59','2023-09-29 19:34:59',NULL),(24,15,24,'let\'s do it',NULL,'2023-09-30 08:49:36','2023-09-30 08:49:36',NULL),(25,15,24,'yes',NULL,'2023-09-30 08:55:41','2023-09-30 08:55:41',NULL);
/*!40000 ALTER TABLE `comment_quize` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `event_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `date_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (2,'Hello Teacher We have meeting at 11am',NULL,NULL,'2023-09-27 10:03:48','2023-09-27 10:03:48',NULL),(3,'Hello Teacher We have meeting at 11am',NULL,NULL,'2023-09-28 01:24:38','2023-09-28 01:24:38','3:24');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `final_exam`
--

DROP TABLE IF EXISTS `final_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `final_exam` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `all_exam_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `persion_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `date_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `final_exam`
--

LOCK TABLES `final_exam` WRITE;
/*!40000 ALTER TABLE `final_exam` DISABLE KEYS */;
INSERT INTO `final_exam` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2023-09-10 01:32:55','2023-09-10 01:32:55',NULL,NULL),(2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2023-09-10 01:33:34','2023-09-10 01:33:34',NULL,NULL),(3,48,NULL,NULL,NULL,NULL,'Hello This is your first Final Exam',NULL,'2023-09-10 01:34:19','2023-09-10 01:34:19',NULL,NULL),(4,48,NULL,NULL,NULL,NULL,'Hello This is your first Final Exam',NULL,'2023-09-10 10:46:59','2023-09-10 10:46:59',NULL,NULL),(5,48,NULL,NULL,NULL,NULL,'Hello This your final Exam',NULL,'2023-09-11 00:25:21','2023-09-11 00:25:21',NULL,NULL),(6,48,NULL,NULL,NULL,NULL,'Hello Your final Exam',NULL,'2023-09-11 00:26:47','2023-09-11 00:26:47',NULL,NULL),(7,46,NULL,NULL,NULL,NULL,'Hello Your final Exam',NULL,'2023-09-11 00:27:25','2023-09-11 00:27:25',NULL,NULL),(8,42,NULL,NULL,NULL,NULL,'ប្រលងឆមាស',NULL,'2023-09-11 00:29:33','2023-09-11 00:29:33',NULL,NULL),(9,42,NULL,NULL,NULL,NULL,'final Exam Second',NULL,'2023-09-11 00:30:31','2023-09-11 00:30:31',NULL,NULL),(10,42,NULL,NULL,NULL,NULL,'Your Task',NULL,'2023-09-11 00:31:27','2023-09-11 00:31:27',NULL,NULL),(11,46,NULL,NULL,NULL,NULL,'Click Link for start final Exam',NULL,'2023-09-11 00:41:34','2023-09-11 00:41:34',NULL,NULL),(12,42,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-11 00:58:50','2023-09-11 00:58:50',NULL,NULL),(13,43,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-11 01:21:04','2023-09-11 01:21:04',NULL,NULL),(14,46,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-11 01:38:33','2023-09-11 01:38:33',NULL,NULL),(15,45,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-11 02:09:07','2023-09-11 02:09:07',NULL,NULL),(16,42,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-11 02:12:44','2023-09-11 02:12:44',NULL,NULL),(17,50,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-11 02:13:48','2023-09-11 02:13:48',NULL,NULL),(18,46,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-11 02:14:20','2023-09-11 02:14:20',NULL,NULL),(19,47,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-11 02:16:57','2023-09-11 02:16:57',NULL,NULL),(20,45,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-11 02:17:43','2023-09-11 02:17:43',NULL,NULL),(21,46,NULL,NULL,NULL,NULL,'link final Exam:....',NULL,'2023-09-11 10:26:43','2023-09-11 10:26:43',NULL,NULL),(22,41,NULL,NULL,NULL,NULL,'test',NULL,'2023-09-11 21:03:30','2023-09-11 21:03:30',NULL,NULL),(23,44,NULL,NULL,NULL,NULL,'test',NULL,'2023-09-12 19:19:45','2023-09-12 19:19:45',NULL,NULL),(24,49,NULL,NULL,NULL,NULL,'Hello this is your final exam',NULL,'2023-09-14 00:44:46','2023-09-14 00:44:46',NULL,NULL),(25,68,NULL,NULL,NULL,NULL,'https://web.facebook.com/?_rdc=1&_rdr',NULL,'2023-09-14 09:41:48','2023-09-14 09:41:48',NULL,NULL),(26,71,NULL,NULL,NULL,NULL,'https://app.quicktype.io/',NULL,'2023-09-14 09:57:05','2023-09-14 09:57:05',NULL,NULL),(27,71,NULL,NULL,NULL,NULL,'https://github.com/LongThav/massar_mobile/blob',NULL,'2023-09-26 21:06:47','2023-09-26 21:06:47',14,'1h:30mn'),(28,71,NULL,NULL,NULL,NULL,'https://github.com/LongThav/massar_mobile/blo',NULL,'2023-09-26 21:28:17','2023-09-26 21:28:17',14,'1h:30mn'),(29,71,NULL,NULL,NULL,NULL,'https://quicktype.io/dart',NULL,'2023-09-27 05:47:18','2023-09-27 05:47:18',12,'1h:30'),(30,71,NULL,NULL,NULL,NULL,'https://quicktype./dart',NULL,'2023-09-27 05:48:46','2023-09-27 05:48:46',12,'1h'),(31,71,NULL,NULL,NULL,NULL,'https://quicktype./dart',NULL,'2023-09-27 05:49:05','2023-09-27 05:49:05',12,'1h');
/*!40000 ALTER TABLE `final_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gender`
--

DROP TABLE IF EXISTS `gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gender` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sex` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gender_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender`
--

LOCK TABLES `gender` WRITE;
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` VALUES (1,'Male',NULL,NULL,NULL,NULL,NULL),(2,'Female',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `major_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `year_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major`
--

LOCK TABLES `major` WRITE;
/*!40000 ALTER TABLE `major` DISABLE KEYS */;
INSERT INTO `major` VALUES (13,'English',NULL,NULL,NULL,NULL,NULL,NULL,2),(14,'khmer',NULL,NULL,NULL,NULL,NULL,NULL,2),(15,'AA',NULL,NULL,NULL,NULL,NULL,NULL,2),(16,'Web Developer',NULL,NULL,NULL,NULL,NULL,NULL,1),(17,'Mobile Developer',NULL,NULL,NULL,NULL,NULL,NULL,1),(18,'Computer',NULL,NULL,NULL,NULL,NULL,NULL,3),(19,'computer',NULL,NULL,NULL,NULL,NULL,NULL,4),(20,'network',NULL,NULL,NULL,NULL,NULL,NULL,4),(21,'Network',NULL,NULL,NULL,NULL,NULL,NULL,3),(22,'Computer',NULL,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `midterm`
--

DROP TABLE IF EXISTS `midterm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `midterm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `all_exam_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `persion_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `midterm_id` int DEFAULT NULL,
  `date_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `midterm`
--

LOCK TABLES `midterm` WRITE;
/*!40000 ALTER TABLE `midterm` DISABLE KEYS */;
INSERT INTO `midterm` VALUES (1,48,NULL,NULL,NULL,NULL,'Hello This is your midterm',NULL,'2023-09-10 01:51:35','2023-09-10 01:51:35',12,NULL,NULL,NULL),(2,48,NULL,NULL,NULL,NULL,'Hello This is your midterm 2',NULL,'2023-09-10 02:04:49','2023-09-10 02:04:49',13,NULL,NULL,NULL),(3,71,NULL,NULL,NULL,NULL,'Hello This is your midterm 2',NULL,'2023-09-21 00:30:36','2023-09-21 00:30:36',14,NULL,NULL,NULL),(4,71,NULL,NULL,NULL,NULL,'Hello This is your midterm 2',NULL,'2023-09-21 00:46:05','2023-09-21 00:46:05',NULL,NULL,NULL,NULL),(5,71,NULL,NULL,NULL,NULL,'Hello This is your midterm 2',NULL,'2023-09-21 02:03:12','2023-09-21 02:03:12',NULL,NULL,NULL,NULL),(6,71,NULL,NULL,NULL,NULL,'Hello This is your midterm 2',NULL,'2023-09-21 02:33:21','2023-09-21 02:33:21',12,NULL,NULL,NULL),(7,71,NULL,NULL,NULL,NULL,'Hello This is your midterm 3',NULL,'2023-09-21 02:33:40','2023-09-21 02:33:40',12,NULL,NULL,NULL),(8,71,NULL,NULL,NULL,NULL,'Hello This is your midterm',NULL,'2023-09-22 08:49:43','2023-09-22 08:49:43',14,NULL,NULL,NULL),(9,71,NULL,NULL,NULL,NULL,'Hello Student \nPlease do responsive facebook website with Reat Js.\ni will give your score.\nThank You',NULL,'2023-09-23 03:56:14','2023-09-23 03:56:14',15,NULL,'9/23/2023',NULL),(10,71,NULL,NULL,NULL,NULL,'Write Hello World with ReactJs',NULL,'2023-09-25 20:46:26','2023-09-25 20:46:26',15,NULL,'9/26/2023',NULL),(11,71,NULL,NULL,NULL,NULL,'Who build node js?',NULL,'2023-09-26 00:10:08','2023-09-26 00:10:08',14,NULL,'9/26/2023',NULL);
/*!40000 ALTER TABLE `midterm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (131,'2023_09_07_035741_person_add_class_i_d',5),(135,'2014_10_12_100000_create_password_reset_tokens_table',6),(136,'2019_08_19_000000_create_failed_jobs_table',6),(137,'2019_12_14_000001_create_personal_access_tokens_table',6),(138,'2023_09_03_030452_person',6),(139,'2023_09_03_030530_major',6),(140,'2023_09_03_030606_payment',6),(141,'2023_09_03_030642_class',6),(142,'2023_09_03_030720_attendance',6),(143,'2023_09_03_030806_subject',6),(144,'2023_09_03_142738_role',6),(145,'2023_09_06_030519_change_body_to_nullable_in_reviews_table',6),(146,'2023_09_06_160149_gender_table',6),(147,'2023_09_06_164634_add_gend_i_d',6),(163,'2023_09_06_165017_add_gender',7),(164,'2023_09_06_172326_province_table',7),(165,'2023_09_07_040646_class_class_id',7),(166,'2023_09_07_110138_person_add_id_class',7),(167,'2023_09_08_150614_class_add_major_id',7),(168,'2023_09_08_151444_major_add_major_id',7),(169,'2014_10_12_000000_create_users_table',8),(170,'2023_09_09_174333_person_add_role',9),(171,'2023_09_10_073400_all_exam_table',10),(172,'2023_09_10_081736_final_exam_table',11),(173,'2023_09_10_081748_midterm_table',11),(174,'2023_09_10_084340_midterm_table',12),(175,'2023_09_10_085333_quize_table',13),(176,'2023_09_10_090522_assignment_table',14),(177,'2023_09_11_154950_person_add_more_field',15),(178,'2023_09_12_042812_person_add_status',16),(179,'2023_09_12_045400_year_table',16),(180,'2023_09_13_032429_year_add_year_id',17),(181,'2023_09_13_034631_major_add_year_id',18),(182,'2023_09_13_040915_year_add_id_class',19),(183,'2023_09_15_160658_subject_table',20),(184,'2023_09_16_025804_subject_addperson_id',21),(185,'2023_09_16_032959_person_added_subject_id',22),(186,'2023_09_17_073000_user_add_image',23),(187,'2023_09_20_074842_payment_add_id_class',24),(188,'2023_09_21_074821_midterm_add_subject_id',24),(189,'2023_09_22_023636_quiz_add_subject_id',25),(190,'2023_09_22_023647_assignment_add_sub_ject_id',25),(192,'2023_09_22_030411_comment_quize',26),(193,'2023_09_22_030703_midterm_comment',27),(194,'2023_09_22_030712_assignnment',27),(195,'2023_09_22_034036_qize_added_quize_id',28),(196,'2023_09_22_033726_quize_added_quize_id',29),(197,'2023_09_22_041519_midterm_added_midterm_id',29),(198,'2023_09_22_044328_assignment_added_assignment_id',30),(199,'2023_09_22_160338_quiz_add_date_time',31),(200,'2023_09_22_160407_assignment_add_date_time',31),(201,'2023_09_22_160419_midterm_add_date_t_ime',31),(202,'2023_09_23_092125_quiz_add_userid',32),(203,'2023_09_23_092140_comment_midterm_add_user_id',32),(204,'2023_09_23_092206_comment_assignment_add_user_id',32),(205,'2023_09_25_073414_answer_quiz_table',33),(206,'2023_09_25_073433_answer_assignment_table',33),(207,'2023_09_25_073440_answer_midterm_table',33),(208,'2023_09_26_160356_quiz_added_score',34),(209,'2023_09_26_160413_midterm_added_score',34),(210,'2023_09_26_160425_assignment_added_score',34),(211,'2023_09_26_161919_answer_quiz_added_score',35),(212,'2023_09_26_161930_answer_midterm_added_score',35),(213,'2023_09_26_161938_answer_assignment_added_score',35),(214,'2023_09_27_035511_final_exam_added_subjectid',36),(215,'2023_09_27_040128_final_exam_added_subjectid',37),(216,'2023_09_27_165520_event_table',38),(217,'2023_09_28_082053_event_added_time',39),(218,'2023_09_28_151207_person_added_lat_long',40),(219,'2023_10_01_144732_result_table',41);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `total_payment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `id_class` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,NULL,1,'500$',NULL,NULL,NULL),(2,NULL,14,'500$',NULL,NULL,NULL),(3,NULL,14,'700$',NULL,NULL,NULL),(4,NULL,1,'1000$',NULL,NULL,NULL),(5,NULL,1,'1000$',NULL,NULL,NULL),(6,NULL,1,'$',NULL,NULL,NULL),(7,NULL,7,'1000$',NULL,NULL,NULL),(8,NULL,7,'1000$',NULL,NULL,NULL),(9,NULL,14,'1000$',NULL,NULL,NULL),(10,NULL,7,'1000$',NULL,NULL,NULL),(11,NULL,7,'1500$',NULL,NULL,NULL),(12,NULL,1,'1000$',NULL,NULL,NULL);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codeId` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sex` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `khan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sangkat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_class` int DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `payment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `year_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `lat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `long` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `person_codeid_unique` (`codeId`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Mr. LongThav SiPav','A01010101010','21',NULL,'Phom Penh','Prey Veng','Prey Veng',1,1,NULL,'Cambodia','0889246029',NULL,NULL,'2023-09-07 04:13:53','2023-09-27 05:18:29',71,'Student',NULL,NULL,16,NULL,1,12,NULL,NULL),(2,'Mr. LongThav SiPav','A0101010','21',NULL,'Phom Penh','Prey Veng','Prey Veng',4,2,'PYkN5ghqQV.png','Cambodia','0889246027',NULL,NULL,'2023-09-07 04:29:44','2023-09-09 07:44:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'Mr. Phy','B20211366','21','Male','Phnom Penh','khan','Sangkat',3,1,NULL,'Cambodia','088383831',NULL,NULL,'2023-09-07 07:46:39','2023-09-27 05:18:30',71,'Teacher',NULL,NULL,16,NULL,1,12,NULL,NULL),(4,'User002','B20212233','21','Male','Phom Penh','Khan','Khan',5,2,NULL,'Country','088922333',NULL,NULL,'2023-09-07 08:17:53','2023-09-16 09:55:28',66,'Student',NULL,'700$',14,NULL,2,6,NULL,NULL),(5,'User02','B20213445','21',NULL,'Phom Penh','Prey Veng','Prey Veng',5,2,'nooV82iAUz.jpeg','Cambodia','0889246029',NULL,NULL,'2023-09-07 08:20:29','2023-09-16 03:57:23',52,NULL,NULL,'500$',1,NULL,1,23,NULL,NULL),(6,'Mr Thea','B20211201','21','Male','Phom Penh','Prey Veng','Prey Veng',6,2,NULL,'Cambodia','0889246027',NULL,NULL,'2023-09-07 19:13:17','2023-09-16 19:58:59',66,'Student',NULL,NULL,14,NULL,2,23,NULL,NULL),(7,NULL,'B0220202','21',NULL,'Phom Penh','Prey Veng','Prey Veng',11,2,NULL,'Cambodia','0889246027',NULL,NULL,'2023-09-07 20:17:56','2023-09-27 05:18:31',71,'Student',NULL,NULL,16,NULL,1,12,NULL,NULL),(8,'Mr. Bopha','B00001001','21','Male','Phom Penh','Prey Veng','Prey Veng',12,2,NULL,'Cambodia','0889246027',NULL,NULL,'2023-09-07 21:29:51','2023-09-16 10:25:35',66,'Student',NULL,NULL,14,NULL,2,6,NULL,NULL),(9,'Mr. Parker','B02020202','35',NULL,'Phom Penh','Doun Penh','Prey Veng',14,2,NULL,'Cambodia','08838333',NULL,NULL,'2023-09-08 07:22:18','2023-09-09 06:34:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'Mr. Join','B0122222','21',NULL,'Phom Penh','Prey Veng','Prey Veng',1,2,NULL,'Cambodia','0889246029',NULL,NULL,'2023-09-08 07:23:55','2023-09-16 04:10:11',52,NULL,NULL,'500$',1,NULL,1,10,NULL,NULL),(11,'Mr. Dony','A00202223','33','Male','sdcs','pp','PP',16,2,NULL,'USA','08383833',NULL,NULL,'2023-09-08 07:25:51','2023-09-27 05:18:33',71,'Teacher',NULL,NULL,16,NULL,1,12,NULL,NULL),(12,'Mr. Phy','B20211363','20',NULL,'Phnom Penh','khan','Sangkat',13,2,NULL,'Cambodia','08838383',NULL,NULL,'2023-09-08 09:14:18','2023-09-15 19:54:52',74,'Student',NULL,'600$',19,NULL,4,NULL,NULL,NULL),(13,'Mr. Bee','BB2022222','21','Male','Phom Penh','Prey Veng','Prey Veng',17,2,NULL,'Cambodia','0889246029',NULL,NULL,'2023-09-08 20:00:20','2023-12-23 04:41:12',68,'Teacher',NULL,NULL,17,NULL,1,8,NULL,NULL),(14,'LongThav SiPav','B0111111111111','21','Male','Phom Penh','Prey Veng','Prey Veng',2,2,NULL,'Cambodia','0889246029',NULL,NULL,'2023-09-09 08:43:27','2023-10-11 20:43:07',71,'Student',NULL,'500$',16,NULL,1,12,'0','0'),(15,'Mr. Roony','B001919919','21','Female','Phom Penh','Prey Veng','Prey Veng',7,2,NULL,'Cambodia','0889246029',NULL,NULL,'2023-09-09 09:58:02','2023-09-27 05:18:36',71,'Teacher',NULL,NULL,16,NULL,1,12,NULL,NULL),(16,'Mr. Pew Pew','B020202011','22','Male','USA','USA','USA',8,2,NULL,'USA','0838383838',NULL,NULL,'2023-09-09 10:28:34','2023-09-27 05:17:04',71,'Teacher',NULL,NULL,16,NULL,1,14,NULL,NULL),(17,'Mr. Dav','B043212222','21',NULL,'Phom Penh','Prey Veng','Prey Veng',17,2,NULL,'Cambodia','0889246029',NULL,NULL,'2023-09-09 10:53:12','2023-09-13 23:22:13',52,NULL,NULL,'600$',1,NULL,1,NULL,NULL,NULL),(18,'Mr. Ronal','B09929292','21','Male','PP','khan','Sk',10,1,NULL,'Cambodia','083838833',NULL,NULL,'2023-09-09 19:10:39','2023-09-27 05:17:04',71,'Teacher',NULL,NULL,16,NULL,1,14,NULL,NULL),(19,'Mr. Phy','B20211360','21','2','Phnom Penh','khan','Sangkat',1,1,NULL,'Cambodia','08838383',NULL,NULL,'2023-09-11 09:02:07','2023-09-11 09:02:07',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,'Mr. LongThav SiPav','B202113601','21','2','Phnom Penh','khan','Sangkat',11,1,NULL,'Cambodia','08838383',NULL,NULL,'2023-09-11 09:09:03','2023-09-11 09:09:03',1,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(21,'Mr. LongThav SiPav','B202113609','21','2','Phnom Penh','khan','Sangkat',12,1,NULL,'Cambodia','08838383',NULL,NULL,'2023-09-11 09:34:25','2023-09-11 09:34:25',1,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(22,'Mrs. LeakhaNa','B92020202','20','Female','sdcd','ppc','csdc',13,1,NULL,'Cambodia','0282882822',NULL,NULL,'2023-09-11 09:50:33','2023-09-12 01:59:40',42,'Student',NULL,'600$',3,NULL,NULL,NULL,NULL,NULL),(23,'AA','B92222222','20',NULL,'PP','PP','PP',15,2,NULL,'CB','083838388',NULL,NULL,'2023-09-11 10:14:23','2023-09-14 00:45:54',53,'Student',NULL,'500$',6,NULL,NULL,NULL,NULL,NULL),(24,'ll','B032233333','22','Male','pp','dd','sk',21,1,NULL,'Cambodia','083883883',NULL,NULL,'2023-09-11 10:24:05','2023-09-16 10:27:21',66,'Student',NULL,'550$',14,NULL,2,6,NULL,NULL),(25,'Mr. Ronaldo','B020202','11','Male','sdc','vf','sdc',22,1,NULL,'Cambodia','09883883',NULL,NULL,'2023-09-11 10:29:34','2023-09-16 20:05:02',66,'Teacher',NULL,NULL,14,NULL,2,6,NULL,NULL),(26,'qq','B020202021','40','Male','cc','pp','cc',20,2,NULL,'USA','083883833',NULL,NULL,'2023-09-11 20:50:11','2023-09-16 10:43:21',66,'Teacher',NULL,NULL,14,NULL,2,6,NULL,NULL),(27,'Mr. KunThea','B0121244544','20','Male','Phnom Penh','Doun Penh','Doun Penh',23,1,NULL,'Cambodia','08893445',NULL,NULL,'2023-09-12 02:10:42','2023-09-16 09:58:39',66,'Student',NULL,'500$',14,NULL,2,6,NULL,NULL),(28,'Mr. LongThav SiPav01','B202113608','21','Male','Phnom Penh','khan','Sangkat',9,1,NULL,'Cambodia','08838383',NULL,NULL,'2023-09-14 08:13:58','2023-09-16 20:10:38',68,'Student',NULL,NULL,17,NULL,1,8,NULL,NULL),(29,'SS','B08291129','21',NULL,'PP','khan','Sk',18,1,NULL,'Cambodia','088766666',NULL,NULL,'2023-09-14 08:38:32','2023-09-16 20:29:59',67,'Teacher',NULL,NULL,13,NULL,2,11,NULL,NULL),(30,'Mr. Bee','B09281130','21','Male','PP','kn','Sk',25,1,NULL,'Cambodia','082822222',NULL,NULL,'2023-09-14 08:40:39','2023-09-27 05:19:07',71,'Student',NULL,NULL,16,NULL,1,16,NULL,NULL),(31,'DD','B02022222211','22','Male','PP','KK','PP',19,1,NULL,'Cambodia','08282882',NULL,NULL,'2023-09-14 08:45:00','2023-09-16 20:05:00',66,'Teacher',NULL,NULL,14,NULL,2,6,NULL,NULL),(32,'Mr. Thea01','B01113333','20','Male','PP','PP','PP',27,1,NULL,'Cambodia','088393933',NULL,NULL,'2023-09-14 10:28:30','2023-12-23 04:41:17',68,'Student',NULL,NULL,17,NULL,1,8,NULL,NULL),(33,'Mr. Dog','B80202102','21','Male','PP','Khan','Sk',26,1,NULL,'Cambodia','088383333',NULL,NULL,'2023-09-15 08:54:25','2023-09-16 10:41:04',66,'Student',NULL,NULL,14,NULL,2,6,NULL,NULL),(34,'join','B0210201022','21',NULL,'PP','PP','PP',30,1,NULL,'Cambodia','0889293844',NULL,NULL,'2023-09-26 01:33:57','2023-09-30 08:47:34',71,'Teacher',NULL,NULL,16,NULL,1,14,'11.5906083','104.91028'),(35,'LongThav','P01010101','45',NULL,'PP','PP','SK',32,1,NULL,'Cambodia','084940321',NULL,NULL,'2023-09-29 19:59:29','2023-09-30 08:41:12',71,'Parent',NULL,NULL,16,NULL,1,NULL,'11.5906083','104.91028'),(36,'Mr. Choumroun','B103839393','32',NULL,'kjbkdsv','kjbd','dkjbvd',33,1,NULL,'cambodia','0848884844',NULL,NULL,'2023-12-04 08:22:03','2023-12-04 08:22:03',74,'Teacher',NULL,NULL,19,NULL,4,NULL,NULL,NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',32,'myapptoken','e15ed46b5b8019a2a24b9b473c281dd2fc90e661df3a55b4a216a4dcef8b47d1','[\"*\"]',NULL,NULL,'2023-10-11 20:41:13','2023-10-11 20:41:13'),(2,'App\\Models\\User',32,'myapptoken','b019d9aa3f1ab89e7f54d3b0b222f9f713d03d194ae05c92c7344ba8155c353d','[\"*\"]',NULL,NULL,'2023-11-09 05:43:23','2023-11-09 05:43:23');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `province` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_province` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `province`
--

LOCK TABLES `province` WRITE;
/*!40000 ALTER TABLE `province` DISABLE KEYS */;
INSERT INTO `province` VALUES (1,'Phome Penh',NULL,NULL,NULL,'2023-09-09 08:41:46','2023-09-09 08:41:46'),(2,'Prey Veng',NULL,NULL,NULL,'2023-09-09 08:41:52','2023-09-09 08:41:52'),(3,'Mondolkiri',NULL,NULL,NULL,'2023-09-12 19:10:29','2023-09-12 19:10:29'),(4,'USA',NULL,NULL,NULL,'2023-09-15 08:59:23','2023-09-15 08:59:23');
/*!40000 ALTER TABLE `province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `all_exam_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `persion_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `quize_id` int DEFAULT NULL,
  `date_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES (1,48,NULL,NULL,NULL,NULL,'Hello This is your quiz',NULL,'2023-09-10 01:58:26','2023-09-10 01:58:26',NULL,NULL,NULL,NULL),(2,71,NULL,NULL,NULL,NULL,'Hello This is your quiz',NULL,'2023-09-21 19:42:51','2023-09-21 19:42:51',12,NULL,NULL,NULL),(3,71,NULL,NULL,NULL,NULL,'Hello This is your quiz',NULL,'2023-09-21 19:51:25','2023-09-21 19:51:25',12,NULL,NULL,NULL),(4,71,NULL,NULL,NULL,NULL,'What\' is bootsrap?',NULL,'2023-09-22 08:14:17','2023-09-22 08:14:17',13,NULL,NULL,NULL),(5,71,NULL,NULL,NULL,NULL,'What\'s vue?',NULL,'2023-09-22 08:43:30','2023-09-22 08:43:30',16,NULL,NULL,NULL),(6,71,NULL,NULL,NULL,NULL,'Which main programming for vue?',NULL,'2023-09-22 08:45:57','2023-09-22 08:45:57',16,NULL,NULL,NULL),(7,71,NULL,NULL,NULL,NULL,'What is node Js?',NULL,'2023-09-22 08:49:56','2023-09-26 09:16:42',14,NULL,NULL,'10'),(8,71,NULL,NULL,NULL,NULL,'Which main programming?',NULL,'2023-09-22 09:18:37','2023-09-22 09:18:37',14,NULL,'9/22/2023',NULL),(9,71,NULL,NULL,NULL,NULL,'Implement Hello World in Node Js',NULL,'2023-09-22 09:36:34','2023-09-22 09:36:34',14,NULL,'9/22/2023',NULL),(10,71,NULL,NULL,NULL,NULL,'What is React Js?',NULL,'2023-09-22 09:55:03','2023-09-22 09:55:03',15,NULL,'9/22/2023',NULL),(11,71,NULL,NULL,NULL,NULL,'Create rest api with node js!',NULL,'2023-09-23 02:01:39','2023-09-23 02:01:39',14,NULL,'9/23/2023',NULL),(12,71,NULL,NULL,NULL,NULL,'Hello all Student!\nPlease  Responsive facebook with ReactJs.',NULL,'2023-09-23 03:19:59','2023-09-23 03:19:59',15,NULL,'9/23/2023',NULL),(20,71,NULL,NULL,NULL,NULL,'Do this task.','b1DGBg1Chy.png','2023-09-23 23:44:15','2023-09-23 23:44:15',13,NULL,'9/24/2023',NULL),(21,71,NULL,NULL,NULL,NULL,'Do this task.','lp7Ak7HEFs.pdf','2023-09-23 23:44:44','2023-09-23 23:44:44',13,NULL,'9/24/2023',NULL),(22,71,NULL,NULL,NULL,NULL,'Who create ReactJs?',NULL,'2023-09-25 20:53:43','2023-09-25 20:53:43',15,NULL,'9/26/2023',NULL),(23,71,NULL,NULL,NULL,NULL,'node js use for backend?',NULL,'2023-09-27 06:00:06','2023-09-27 06:00:06',14,NULL,'9/27/2023',NULL),(24,71,NULL,NULL,NULL,NULL,'Testing',NULL,'2023-09-30 08:49:01','2023-09-30 08:49:01',15,NULL,'9/30/2023',NULL);
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `result`
--

DROP TABLE IF EXISTS `result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `result` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` longtext COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `result`
--

LOCK TABLES `result` WRITE;
/*!40000 ALTER TABLE `result` DISABLE KEYS */;
INSERT INTO `result` VALUES (1,'test','test',NULL,NULL,NULL);
/*!40000 ALTER TABLE `result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_id` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin',NULL,NULL,NULL,NULL),(2,'Student',NULL,NULL,NULL,NULL),(3,'Teacher',NULL,NULL,NULL,NULL),(7,'Kandal',NULL,NULL,NULL,NULL),(8,'Kandal',NULL,NULL,NULL,NULL),(9,'Kandal',NULL,NULL,NULL,NULL),(10,'Kandal',NULL,NULL,NULL,NULL),(11,'Kandal',NULL,NULL,NULL,NULL),(12,'Kandal',NULL,NULL,NULL,NULL),(13,'Kandal',NULL,NULL,NULL,NULL),(14,'Seam Reip',NULL,NULL,NULL,NULL),(15,'Parent',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_id` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `major_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `all_exam_id` int DEFAULT NULL,
  `year_id` int DEFAULT NULL,
  `persion_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (6,66,NULL,NULL,NULL,NULL,'កំណាន',NULL,'2023-09-15 20:05:23','2023-09-15 20:05:23',NULL),(7,66,NULL,NULL,NULL,NULL,'គេហរ',NULL,'2023-09-15 20:05:50','2023-09-15 20:05:50',NULL),(8,68,NULL,NULL,NULL,NULL,'API',NULL,'2023-09-16 01:45:33','2023-09-16 01:45:33',NULL),(9,75,NULL,NULL,NULL,NULL,'Rocky',NULL,'2023-09-16 01:46:47','2023-09-16 01:46:47',NULL),(10,68,NULL,NULL,NULL,NULL,'Database',NULL,'2023-09-16 01:49:39','2023-09-16 01:49:39',NULL),(11,67,NULL,NULL,NULL,NULL,'English',NULL,'2023-09-16 20:29:48','2023-09-16 20:29:48',NULL),(12,71,NULL,NULL,NULL,NULL,'Html/CSS/JS',NULL,'2023-09-20 20:46:19','2023-09-20 20:46:19',NULL),(13,71,NULL,NULL,NULL,NULL,'bootsrap',NULL,'2023-09-20 21:19:02','2023-09-20 21:19:02',NULL),(14,71,NULL,NULL,NULL,NULL,'node js',NULL,'2023-09-20 21:19:10','2023-09-20 21:19:10',NULL),(15,71,NULL,NULL,NULL,NULL,'React Js',NULL,'2023-09-20 21:19:18','2023-09-20 21:19:18',NULL),(16,71,NULL,NULL,NULL,NULL,'Vue Js',NULL,'2023-09-20 21:19:24','2023-09-20 21:19:24',NULL);
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender_id` int DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,'user@gmail.com',2,NULL,'$2y$10$AauKn6XM8hZeYgrKGXSSOeRNhG1y3ylofo24iN9iUa6cdnqNewqy.',NULL,NULL,NULL,'qc8YCXT4vY.jpeg'),(2,'LongThav SiPav',NULL,NULL,NULL,NULL,1,'longthavsipav@gmail.com',2,NULL,'$2y$10$kk4ZwDMdqdWP.EJMdssmTenKGu4RCLYAFUrHrZOKkGBxit7DnDOai',NULL,NULL,NULL,'null'),(3,'Mr. Gina',NULL,NULL,NULL,NULL,1,'gina@gmail.com',3,NULL,'$2y$10$/hZpNicrRcwetINn12UnterdFJWqb9pitqTtHyvV5ReTTxtd.fH8.',NULL,NULL,NULL,NULL),(5,'mr. aa',NULL,NULL,NULL,NULL,1,'aa@gmail.com',2,NULL,'$2y$10$rsajBrddTFdWvOD2FcaCP.cMGmLO/CCaL/caFP1Gb4g7PD8GN5AXC',NULL,NULL,NULL,NULL),(6,'testoo',NULL,NULL,NULL,NULL,1,'aaa@gmail.com',2,NULL,'$2y$10$pz./XkB/L4CMxPSGaLv1JeuVfkoEYf.cQ27OIoMV7nc1C2S5Dh9oW',NULL,NULL,NULL,NULL),(7,'Mr. Roony',NULL,NULL,NULL,NULL,1,'roony@gmail.com',3,NULL,'$2y$10$ko1NNlNRUzP.pNBL6T0TWuYhOzzF/qVoUrooBvsSrTKrzQTykfheK',NULL,NULL,NULL,NULL),(8,'Mr. Pew Pew',NULL,NULL,NULL,NULL,2,'pew@gmail.com',3,NULL,'$2y$10$yU1vqtStWfdf9D/ehZbTReRqPuMtpZqP.rAp.jPCXLVfgZcI9Fcrq',NULL,NULL,NULL,NULL),(9,'Mr. Dav',NULL,NULL,NULL,NULL,1,'dav@gmail.com',2,NULL,'$2y$10$WsFd9/Cn0p0lnJDaWfFs8.CsIq5jr2iamVmcKn06pB3vqIo1rmr7u',NULL,NULL,NULL,NULL),(10,'Mr. Ronal',NULL,NULL,NULL,NULL,1,'ronal@gmail.com',3,NULL,'$2y$10$S3ENUvWU1THeXqTbeB56/.pAc1ve9zK6L/tWv5W8jGWZcBElp1MVS',NULL,NULL,NULL,NULL),(11,NULL,NULL,NULL,NULL,NULL,NULL,'longthavsipav0101@gmail.com',2,NULL,'$2y$10$m1DDNeKQkVdKjrHMiy31DuZ0l4AQ712LheTQ/rSvOJdg1lekhciwC',NULL,NULL,NULL,NULL),(12,NULL,NULL,NULL,NULL,NULL,NULL,'longthavsipav001@gmail.com',2,NULL,'$2y$10$xrx95fcluMntScPB0VGbu.E5LnfeVH9gB/maI3Q6KT6gTLh9KC4iy',NULL,NULL,NULL,NULL),(13,'Mrs. LeakhaNa',NULL,NULL,NULL,NULL,2,'leak@gmail.com',2,NULL,'$2y$10$My3L7WXlOjdm2sRlrU6WbOGWaYyDUJfoD.sA4OAjzt0B8fQ1WW1aK',NULL,NULL,NULL,NULL),(15,'AA',NULL,NULL,NULL,NULL,1,'a@gmail.com',2,NULL,'$2y$10$uSv/Ay4syFTlJrWOxQS1HehL8U/6bygLEj9Hmxi6EzdI0q0JQyQiy',NULL,NULL,NULL,NULL),(16,'BB',NULL,NULL,NULL,NULL,1,'bb@gmail.com',3,NULL,'$2y$10$iQKP/nxNFIUO.KMOKXAZE.WCsf5EgEr8ONBaXXz044kTNshGQ7e4a',NULL,NULL,NULL,NULL),(17,'CC',NULL,NULL,NULL,NULL,1,'c@gmail.com',3,NULL,'$2y$10$Mu6px2HStdfkGFj3sduJLerXZwkPHLz8t3Iutu0.DLT3me4jRi0em',NULL,NULL,NULL,NULL),(18,'SS',NULL,NULL,NULL,NULL,1,'s@gmail.com',3,NULL,'$2y$10$eJVFC6Lhb2CP0BFge/qdruU4Va/jzIFROtoWVwjnvtMxSM4TdfclG',NULL,NULL,NULL,NULL),(19,'DD',NULL,NULL,NULL,NULL,1,'d@gmail.com',3,NULL,'$2y$10$nqtJp.uH3Il2Il6gxmDj2ekGdLjQ0SPL739hjn9tLsZuiEt9Xu0cS',NULL,NULL,NULL,NULL),(20,'qq',NULL,NULL,NULL,NULL,1,'qq@gmail.com',3,NULL,'$2y$10$T4r5.1gYxkcyly/jvuh6NeuBqmEwJTcgtItoMJLzmvMmkQYGpfQqi',NULL,NULL,NULL,NULL),(21,'ll',NULL,NULL,NULL,NULL,1,'ll@gmail.com',2,NULL,'$2y$10$HAZD2kigaatzPbk/R82RVem0MsmdqZcjhOQrYuFOtwotL8/xmlQym',NULL,NULL,NULL,NULL),(22,'Mr. Ronaldo',NULL,NULL,NULL,NULL,1,'ronaldo@gmail.com',3,NULL,'$2y$10$fRAO.H7imFhPH9sgUwbvVOu1Kj56UK.7.LHztuhxitbRb8VJU397C',NULL,NULL,NULL,NULL),(23,'Mr. KunThea',NULL,NULL,NULL,NULL,1,'kunthea@gmail.com',2,NULL,'$2y$10$zsjp04lvkukJXopji4NpDeR1O3b.ED6FVqYAnFB6QLKhWfEb3Tmly',NULL,NULL,NULL,NULL),(25,'Mr. Bee',NULL,NULL,NULL,NULL,1,'bee@gmail.com',2,NULL,'$2y$10$qbzzjiPt61YuUYOHRh/30O7SO08u5tqA7qrtNNf1LMZ4NzH9b83O6',NULL,NULL,NULL,NULL),(26,'Mr. Dog',NULL,NULL,NULL,NULL,1,'dog@gmail.com',2,NULL,'$2y$10$Ec24xiPIOwoxAgbwRlWdxe8fIMsQx.oxxbtNtHk7zOV8wAlyMRoVa',NULL,NULL,NULL,NULL),(27,'Mr. Thea01',NULL,NULL,NULL,NULL,2,'thea02@gmail.com',2,NULL,'$2y$10$UiSnL.yZ.lPzBF0G440lxOACeC1ZkwhjHIo/NCuGbnqj0FGRj2mEy',NULL,NULL,NULL,NULL),(28,'LongThav SiPav',NULL,NULL,NULL,NULL,1,'longthav69@gmail.com',2,NULL,'$2y$10$LxsNTXDBz0iHm626N8X3aOCHA40TX2HHSQiJbSrdlWwJfRFqDMlH6',NULL,NULL,NULL,NULL),(29,'GG',NULL,NULL,NULL,NULL,1,'gg@gmail.com',2,NULL,'$2y$10$5VhPrLcGhejjHEt8bipUkeC2RamHb518iHyqiC.3VJPudH/drZNfi',NULL,NULL,NULL,NULL),(30,'join',NULL,NULL,NULL,NULL,1,'joinjoin@gmail.com',3,NULL,'$2y$10$b5uR6DaeHm4pYpbaLAfcD.C82NRzSUC51DFtzgJ0JWzg3ngQWVCam',NULL,NULL,NULL,NULL),(31,'join',NULL,NULL,NULL,NULL,1,'joinjoin009@gmail.com',2,NULL,'$2y$10$/5eKjLSQwduY2/.iwy2c7evjdGN64MiytwzjKD/KeoUUt1pmaWXI6',NULL,NULL,NULL,NULL),(32,'LongThav',NULL,NULL,NULL,NULL,1,'longthav11@gmail.com',15,NULL,'$2y$10$.hzX5A/YtcIDJ2Jk7dIxjOUP9BpQJ40RUl/KhBhp31Xmi/lCu4.ie',NULL,NULL,NULL,NULL),(33,'Mr. Choumroun',NULL,NULL,NULL,NULL,2,'choumroun@gmail.com',3,NULL,'$2y$10$pBHizvWNvCxL6iF8PijcGu6FxRe/e6t2RafblC3rPsmNLfD.UJCx.',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `year`
--

DROP TABLE IF EXISTS `year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `year` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int DEFAULT NULL,
  `major_id` int DEFAULT NULL,
  `all_exam_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `persion_id` int DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `year_id` int DEFAULT NULL,
  `id_class` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `year`
--

LOCK TABLES `year` WRITE;
/*!40000 ALTER TABLE `year` DISABLE KEYS */;
INSERT INTO `year` VALUES (1,NULL,NULL,NULL,NULL,NULL,'I','2023-09-12 19:21:53','2023-09-12 21:24:59',NULL,48),(2,NULL,NULL,NULL,NULL,NULL,'II','2023-09-12 19:21:57','2023-09-12 19:21:57',NULL,NULL),(3,NULL,NULL,NULL,NULL,NULL,'III','2023-09-12 19:22:03','2023-09-12 19:22:03',NULL,NULL),(4,NULL,NULL,NULL,NULL,NULL,'IV','2023-09-12 19:22:07','2023-09-12 19:22:07',NULL,NULL),(5,NULL,NULL,NULL,NULL,NULL,'V','2023-09-12 19:22:13','2023-09-12 19:22:13',NULL,NULL),(6,NULL,NULL,NULL,NULL,NULL,'VI','2023-09-14 06:04:31','2023-09-14 06:04:31',NULL,NULL);
/*!40000 ALTER TABLE `year` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-15 16:06:25
