-- MariaDB dump 10.19  Distrib 10.5.23-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	10.5.23-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `my_topic_users`
--

DROP TABLE IF EXISTS `my_topic_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_topic_users` (
  `id` int(11) NOT NULL,
  `user_id` text DEFAULT NULL,
  `pwd` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_topic_users`
--

LOCK TABLES `my_topic_users` WRITE;
/*!40000 ALTER TABLE `my_topic_users` DISABLE KEYS */;
INSERT INTO `my_topic_users` VALUES (1,'user1','test1111','User name','2024-01-13 16:29:39.000'),(2,'user2','test2222','User name2','2024-01-13 16:31:18.000'),(3,'user3','test3333','User name3','2024-01-13 16:32:39.000'),(4,'user4','test4444','User name4','2024-01-13 17:05:47.000'),(5,'admin','admin','Super user','2024-01-13 17:06:15.000'),(5,'user99','user99','user 99','2008-03-10 16:12:55.000');
/*!40000 ALTER TABLE `my_topic_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `product_id` varchar(20) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `qty` int(11) DEFAULT 0,
  `unit_price` int(11) DEFAULT 0,
  `total_price` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (10,'59bae8e9-8926-45cc-9e74-69d6a7ed918a','CATALOG-003','c3a2bc3b-376c-4882-93d5-468ed79ae5f8',13,1000,13000,'2024-02-04 17:01:20'),(11,'59bae8e9-8926-45cc-9e74-69d6a7ed918a','CATALOG-004','0fdee22d-28f7-4132-85c5-ce2cb3ce9167',14,1000,14000,'2024-02-04 17:01:29'),(12,'59bae8e9-8926-45cc-9e74-69d6a7ed918a','CATALOG-005','13b7318c-7274-4c99-8d1e-e50d49130b69',15,1000,15000,'2024-02-04 17:01:32'),(13,'59bae8e9-8926-45cc-9e74-69d6a7ed918a','CATALOG-006','80681785-83b8-4d3b-a661-f7a2b9b24da2',16,1000,16000,'2024-02-04 17:01:38'),(14,'c5db954c-bb25-440b-8009-3657fb7b51ef','CATALOG-001','e767eb81-996e-4e3f-a00b-120d440c5e3f',20,1000,20000,'2024-02-05 23:40:08'),(15,'2abdd13e-0d00-4b6a-8e8d-bfe57218bfdf','CATALOG-001','4300db06-7c82-44a0-8736-f3146ba2f37f',20,1000,20000,'2024-02-17 19:09:06'),(16,'2abdd13e-0d00-4b6a-8e8d-bfe57218bfdf','CATALOG-002','b0985d9e-c073-4e7d-8a5e-d6d9450da275',10,1000,10000,'2024-02-17 19:09:11'),(17,'73ee1ff4-d32d-4c5e-bf1b-8e0e2161bb64','CATALOG-001','af3561c2-3c6c-4d97-88ca-1aafc077383e',10,1000,10000,'2024-02-17 19:15:22'),(18,'73ee1ff4-d32d-4c5e-bf1b-8e0e2161bb64','CATALOG-002','d8204a57-40de-4806-b14a-bc80813ce2b3',20,1000,20000,'2024-02-17 19:15:27'),(19,'73ee1ff4-d32d-4c5e-bf1b-8e0e2161bb64','CATALOG-002','ca9b40b8-587a-44ee-8e78-a3729ab31774',20,1000,20000,'2024-02-17 19:28:44'),(20,'73ee1ff4-d32d-4c5e-bf1b-8e0e2161bb64','CATALOG-003','f958c0df-7956-4d42-8520-dc535110b278',20,1000,20000,'2024-02-17 19:30:13');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) DEFAULT NULL,
  `pwd` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user1','test1111','User name','2024-01-13 16:29:39'),(2,'user2','test2222','User name2','2024-01-13 16:31:18'),(3,'user3','test3333','User name3','2024-01-13 16:32:39'),(4,'user4','test4444','User name4','2024-01-13 17:05:47'),(5,'admin','admin','Super user','2024-01-13 17:06:15');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-03 14:04:08
