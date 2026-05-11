-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: insurance_management_ds
-- ------------------------------------------------------
-- Server version	9.3.0

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
-- Table structure for table `claim_audit`
--

DROP TABLE IF EXISTS `claim_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `claim_audit` (
  `audit_id` bigint NOT NULL AUTO_INCREMENT,
  `claim_id` bigint NOT NULL,
  `old_status` varchar(40) DEFAULT NULL,
  `new_status` varchar(40) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`audit_id`),
  KEY `fk_claim_audit_claim` (`claim_id`),
  CONSTRAINT `fk_claim_audit_claim` FOREIGN KEY (`claim_id`) REFERENCES `claims` (`claim_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claim_audit`
--

LOCK TABLES `claim_audit` WRITE;
/*!40000 ALTER TABLE `claim_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `claim_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `claims`
--

DROP TABLE IF EXISTS `claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `claims` (
  `claim_id` bigint NOT NULL AUTO_INCREMENT,
  `claim_number` varchar(30) NOT NULL,
  `policy_id` bigint NOT NULL,
  `staff_id` int NOT NULL,
  `date_of_loss` date NOT NULL,
  `reported_date` date NOT NULL,
  `description` text,
  `amount_claimed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `amount_paid` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status` enum('Open','Under Review','Approved','Rejected','Closed') NOT NULL DEFAULT 'Open',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`claim_id`),
  UNIQUE KEY `uq_claims_number` (`claim_number`),
  KEY `fk_claims_staff` (`staff_id`),
  KEY `idx_claims_policy` (`policy_id`),
  KEY `idx_claims_status` (`status`),
  KEY `idx_claims_dates` (`date_of_loss`,`reported_date`),
  KEY `idx_claims_policy_status` (`policy_id`,`status`),
  CONSTRAINT `fk_claims_policy` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_claims_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_claims_amounts` CHECK (((`amount_claimed` >= 0) and (`amount_paid` >= 0))),
  CONSTRAINT `chk_claims_dates` CHECK ((`reported_date` >= `date_of_loss`))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claims`
--

LOCK TABLES `claims` WRITE;
/*!40000 ALTER TABLE `claims` DISABLE KEYS */;
INSERT INTO `claims` VALUES (1,'CLM-2001',1,1,'2025-03-10','2025-03-11','Minor front bumper damage',900.00,750.00,'Closed','2025-10-11 13:25:24'),(2,'CLM-2002',1,2,'2025-07-05','2025-07-05','Side mirror stolen',150.00,150.00,'Closed','2025-10-11 13:25:24'),(3,'CLM-3001',12,1,'2025-09-20','2025-09-20','Flight cancellation',600.00,600.00,'Approved','2025-10-11 13:26:16'),(4,'CLM-3003',14,3,'2025-03-05','2025-03-05','Life insurance claim',10000.00,9000.00,'Approved','2025-10-11 13:28:45'),(5,'CLM-3004',15,2,'2025-02-22','2025-02-23','Minor fender-bender',450.00,300.00,'Closed','2025-10-11 13:28:45'),(6,'CLM-3005',7,1,'2025-06-20','2025-06-21','Lost cat - recovery expenses',400.00,0.00,'Under Review','2025-10-11 13:29:24'),(7,'CLM-3006',4,2,'2025-06-10','2025-06-11','Phone screen damaged',300.00,250.00,'Closed','2025-10-11 13:30:02');
/*!40000 ALTER TABLE `claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(60) NOT NULL,
  `last_name` varchar(60) NOT NULL,
  `dob` date NOT NULL,
  `phone` varchar(25) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address_line1` varchar(120) NOT NULL,
  `address_line2` varchar(120) DEFAULT NULL,
  `city` varchar(80) NOT NULL,
  `postcode` varchar(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `uq_customers_email` (`email`),
  KEY `idx_customers_lastname` (`last_name`),
  KEY `idx_customers_city` (`city`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Andrei','Popescu','1991-03-12','+40 722 111 111','andrei.popescu@gmail.com','Str. Mihai Eminescu 10',NULL,'Bucharest','010001','2025-10-11 11:37:09'),(2,'Maria','Ionescu','1987-07-25','+40 723 222 222','maria.ionescu@yahoo.com','Bd. Eroilor 25','Ap. 7','Cluj-Napoca','400001','2025-10-11 11:37:09'),(3,'Alexandru','Stoica','1994-11-05','+40 724 333 333','alexandru.stoica@gmail.com','Str. Lapusneanu 3',NULL,'Iasi','700001','2025-10-11 11:37:09'),(4,'Diana','Radu','1996-09-14','+40 725 444 444','diana.radu@gmail.com','Str. Traian 14','Ap. 5','Constanta','900001','2025-10-11 11:37:09'),(5,'Cristian','Moldovan','1985-02-27','+40 726 555 555','cristian.moldovan@yahoo.com','Str. Republicii 20',NULL,'Brasov','500001','2025-10-11 11:37:09');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` bigint NOT NULL AUTO_INCREMENT,
  `policy_id` bigint NOT NULL,
  `payment_date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `method` enum('Card','BankTransfer','Cash','DirectDebit') NOT NULL,
  `reference_no` varchar(60) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `idx_payments_policy` (`policy_id`),
  KEY `idx_payments_date` (`payment_date`),
  CONSTRAINT `fk_payments_policy` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`policy_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_payments_amount` CHECK ((`amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,'2025-01-01',650.00,'Card','PAY-2001-2025','2025-10-11 13:20:04'),(2,2,'2025-02-01',400.00,'Card','PAY-2002-2025','2025-10-11 13:20:04'),(3,3,'2025-03-01',280.00,'Card','PAY-2003-2025','2025-10-11 13:20:04'),(4,4,'2025-03-10',180.00,'Card','PAY-2004-2025','2025-10-11 13:20:04'),(5,5,'2024-05-01',320.00,'DirectDebit','PAY-2005-2024','2025-10-11 13:21:37'),(6,6,'2024-09-01',1500.00,'Card','PAY-2006-2024','2025-10-11 13:21:37'),(7,7,'2025-04-01',300.00,'Card','PAY-2007-2025','2025-10-11 13:21:37'),(8,8,'2025-04-10',200.00,'Card','PAY-2008-2025','2025-10-11 13:21:37'),(9,9,'2024-03-01',560.00,'DirectDebit','PAY-2009-2024','2025-10-11 13:22:15'),(10,10,'2025-10-01',310.00,'BankTransfer','PAY-2010-2025','2025-10-11 13:22:15'),(11,11,'2025-08-15',140.00,'Cash','PAY-2011-2025','2025-10-11 13:22:15'),(12,12,'2025-06-01',720.00,'BankTransfer','PAY-2012-2025','2025-10-11 13:23:26'),(13,13,'2025-07-01',210.00,'Cash','PAY-2013-2025','2025-10-11 13:23:26'),(14,12,'2025-06-01',720.00,'BankTransfer','PAY-2012-2025','2025-10-11 13:23:29'),(15,13,'2025-07-01',210.00,'Cash','PAY-2013-2025','2025-10-11 13:23:29'),(16,14,'2023-09-15',2000.00,'Card','PAY-2014-2023','2025-10-11 13:24:28'),(17,15,'2025-01-20',640.00,'Card','PAY-2015-2025','2025-10-11 13:24:28'),(18,16,'2025-02-15',350.00,'Card','PAY-2016-2025','2025-10-11 13:24:28');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policies`
--

DROP TABLE IF EXISTS `policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policies` (
  `policy_id` bigint NOT NULL AUTO_INCREMENT,
  `policy_number` varchar(30) NOT NULL,
  `customer_id` bigint NOT NULL,
  `policy_type_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `premium_amount` decimal(10,2) NOT NULL,
  `status` enum('Active','Expired','Cancelled','Pending') NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`policy_id`),
  UNIQUE KEY `uq_policies_number` (`policy_number`),
  KEY `fk_policies_type` (`policy_type_id`),
  KEY `idx_policies_customer` (`customer_id`),
  KEY `idx_policies_status` (`status`),
  KEY `idx_policies_dates` (`start_date`,`end_date`),
  CONSTRAINT `fk_policies_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_policies_type` FOREIGN KEY (`policy_type_id`) REFERENCES `policy_types` (`policy_type_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_policies_dates` CHECK ((`end_date` > `start_date`)),
  CONSTRAINT `chk_policies_premium` CHECK ((`premium_amount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policies`
--

LOCK TABLES `policies` WRITE;
/*!40000 ALTER TABLE `policies` DISABLE KEYS */;
INSERT INTO `policies` VALUES (1,'POL-2001',1,1,'2025-01-01','2026-01-01',650.00,'Active','2025-10-11 11:53:15'),(2,'POL-2002',1,5,'2025-02-01','2026-02-01',400.00,'Active','2025-10-11 11:53:15'),(3,'POL-2003',1,6,'2025-03-01','2026-03-01',280.00,'Active','2025-10-11 11:53:15'),(4,'POL-2004',1,7,'2025-03-10','2026-03-10',180.00,'Active','2025-10-11 11:53:15'),(5,'POL-2005',2,2,'2024-05-01','2025-05-01',320.00,'Expired','2025-10-11 11:55:08'),(6,'POL-2006',2,3,'2024-09-01','2034-09-01',1500.00,'Active','2025-10-11 11:55:08'),(7,'POL-2007',2,6,'2025-04-01','2026-04-01',300.00,'Active','2025-10-11 11:55:08'),(8,'POL-2008',2,7,'2025-04-10','2026-04-10',200.00,'Active','2025-10-11 11:55:08'),(9,'POL-2009',3,1,'2024-03-01','2025-03-01',560.00,'Expired','2025-10-11 11:56:11'),(10,'POL-2010',3,2,'2025-10-01','2026-10-01',310.00,'Pending','2025-10-11 11:56:11'),(11,'POL-2011',3,4,'2025-08-15','2025-11-30',140.00,'Active','2025-10-11 11:56:11'),(12,'POL-2012',4,4,'2025-06-01','2026-06-01',720.00,'Active','2025-10-11 11:56:59'),(13,'POL-2013',4,5,'2025-07-01','2026-07-01',210.00,'Active','2025-10-11 11:56:59'),(14,'POL-2014',5,3,'2023-09-15','2033-09-15',2000.00,'Active','2025-10-11 13:16:49'),(15,'POL-2015',5,1,'2025-01-20','2026-01-20',640.00,'Active','2025-10-11 13:16:49'),(16,'POL-2016',5,6,'2025-02-15','2026-02-15',350.00,'Active','2025-10-11 13:16:49');
/*!40000 ALTER TABLE `policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy_types`
--

DROP TABLE IF EXISTS `policy_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy_types` (
  `policy_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`policy_type_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy_types`
--

LOCK TABLES `policy_types` WRITE;
/*!40000 ALTER TABLE `policy_types` DISABLE KEYS */;
INSERT INTO `policy_types` VALUES (1,'Auto','Vehicle insurance'),(2,'Home','Home and contents insurance'),(3,'Life','Life insurance'),(4,'Travel','Travel insurance'),(5,'Health','Private medical insurance'),(6,'Pets','Insurance for domestic animals such as dogs and cats'),(7,'Phones','Insurance for mobile phones');
/*!40000 ALTER TABLE `policy_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(120) NOT NULL,
  `role` varchar(80) NOT NULL,
  `department` varchar(80) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(25) NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Ștefan Dumitrescu','Senior Officer','Claims','stefan.dumitrescu@ims.co.uk','+40 21 300 1001'),(2,'Elena Georgescu','Officer','Claims','elena.georgescu@ims.co.uk','+40 21 300 1002'),(3,'Tudor Marin','Manager','Operations','tudor.marin@ims.co.uk','+40 21 300 1003'),(4,'Irina Pavel','Analyst','Finance','irina.pavel@ims.co.uk','+40 21 300 1004');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_customer_policies_claims`
--

DROP TABLE IF EXISTS `v_customer_policies_claims`;
/*!50001 DROP VIEW IF EXISTS `v_customer_policies_claims`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_customer_policies_claims` AS SELECT 
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `email`,
 1 AS `policy_id`,
 1 AS `policy_number`,
 1 AS `policy_status`,
 1 AS `start_date`,
 1 AS `end_date`,
 1 AS `claim_id`,
 1 AS `claim_number`,
 1 AS `claim_status`,
 1 AS `amount_claimed`,
 1 AS `amount_paid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_customers_public`
--

DROP TABLE IF EXISTS `v_customers_public`;
/*!50001 DROP VIEW IF EXISTS `v_customers_public`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_customers_public` AS SELECT 
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `email`,
 1 AS `city`,
 1 AS `postcode`,
 1 AS `created_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_policy_claim_counts`
--

DROP TABLE IF EXISTS `v_policy_claim_counts`;
/*!50001 DROP VIEW IF EXISTS `v_policy_claim_counts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_policy_claim_counts` AS SELECT 
 1 AS `policy_id`,
 1 AS `policy_number`,
 1 AS `customer_id`,
 1 AS `policy_type`,
 1 AS `start_date`,
 1 AS `end_date`,
 1 AS `status`,
 1 AS `claim_count`,
 1 AS `total_claim_paid`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_customer_policies_claims`
--

/*!50001 DROP VIEW IF EXISTS `v_customer_policies_claims`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_customer_policies_claims` AS select `c`.`customer_id` AS `customer_id`,concat(`c`.`first_name`,' ',`c`.`last_name`) AS `customer_name`,`c`.`email` AS `email`,`p`.`policy_id` AS `policy_id`,`p`.`policy_number` AS `policy_number`,`p`.`status` AS `policy_status`,`p`.`start_date` AS `start_date`,`p`.`end_date` AS `end_date`,`cl`.`claim_id` AS `claim_id`,`cl`.`claim_number` AS `claim_number`,`cl`.`status` AS `claim_status`,`cl`.`amount_claimed` AS `amount_claimed`,`cl`.`amount_paid` AS `amount_paid` from ((`customers` `c` join `policies` `p` on((`p`.`customer_id` = `c`.`customer_id`))) left join `claims` `cl` on((`cl`.`policy_id` = `p`.`policy_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_customers_public`
--

/*!50001 DROP VIEW IF EXISTS `v_customers_public`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_customers_public` AS select `customers`.`customer_id` AS `customer_id`,concat(`customers`.`first_name`,' ',`customers`.`last_name`) AS `customer_name`,`customers`.`email` AS `email`,`customers`.`city` AS `city`,`customers`.`postcode` AS `postcode`,`customers`.`created_at` AS `created_at` from `customers` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_policy_claim_counts`
--

/*!50001 DROP VIEW IF EXISTS `v_policy_claim_counts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_policy_claim_counts` AS select `p`.`policy_id` AS `policy_id`,`p`.`policy_number` AS `policy_number`,`p`.`customer_id` AS `customer_id`,`pt`.`name` AS `policy_type`,`p`.`start_date` AS `start_date`,`p`.`end_date` AS `end_date`,`p`.`status` AS `status`,count(`cl`.`claim_id`) AS `claim_count`,coalesce(sum(`cl`.`amount_paid`),0) AS `total_claim_paid` from ((`policies` `p` join `policy_types` `pt` on((`pt`.`policy_type_id` = `p`.`policy_type_id`))) left join `claims` `cl` on((`cl`.`policy_id` = `p`.`policy_id`))) group by `p`.`policy_id`,`p`.`policy_number`,`p`.`customer_id`,`pt`.`name`,`p`.`start_date`,`p`.`end_date`,`p`.`status` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-11 20:12:52
