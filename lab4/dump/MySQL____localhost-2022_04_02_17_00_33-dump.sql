-- MySQL dump 10.13  Distrib 5.7.37, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: lab4_8
-- ------------------------------------------------------
-- Server version	5.7.37-log

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
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor` (
  `id_actor` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `second_name` varchar(255) NOT NULL,
  `birth` date DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT '0',
  `biography` text,
  PRIMARY KEY (`id_actor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actor`
--

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `box_office`
--

DROP TABLE IF EXISTS `box_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `box_office` (
  `id_box_office` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_film` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `id_premiere` int(10) unsigned DEFAULT NULL,
  `value` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_box_office`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Кассовые сборы по странам';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `box_office`
--

LOCK TABLES `box_office` WRITE;
/*!40000 ALTER TABLE `box_office` DISABLE KEYS */;
/*!40000 ALTER TABLE `box_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id_country` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `flag_image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `film`
--

DROP TABLE IF EXISTS `film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `film` (
  `id_film` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_film_company` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `short_description` text,
  `likes_count` int(10) unsigned NOT NULL DEFAULT '0',
  `dislikes_count` int(10) unsigned DEFAULT '0',
  `budget` int(10) unsigned DEFAULT NULL,
  `running_time` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_film`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `film`
--

LOCK TABLES `film` WRITE;
/*!40000 ALTER TABLE `film` DISABLE KEYS */;
INSERT INTO `film` VALUES (1,1,'Matrix','The Matrix movie. Post apocalypse, cyberpunk.',145,23,83000000,183),(2,1,'Forrest Gump','Forrest Gump is a 1994 American comedy-drama film directed by Robert Zemeckis and written by Eric Roth.',256,43,55000000,142),(3,2,'Terminator','Cyborg invasion comes true story',276,12,120000000,160),(4,3,'Lord of the Ring','The Lord of the Rings: The Fellowship of the Ring has beautiful visuals, ambitious story, great characters, heart and is brooding as well.',780,134,100000000,179),(5,3,'Star Wars','Every once in a while I have what I think of as an out-of-the-body experience at a movie. When the ESP people use a phrase like that, they\'re referring to the sensation of the mind actually leaving the body and spiriting itself off to China or Peoria or a galaxy far, far away.',567,23,45000000,156);
/*!40000 ALTER TABLE `film` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `film_backup`
--

DROP TABLE IF EXISTS `film_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `film_backup` (
  `id_film` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_film_company` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `short_description` text NOT NULL,
  `likes_count` int(10) unsigned NOT NULL DEFAULT '0',
  `dislikes_count` int(10) unsigned DEFAULT '0',
  `budget` int(10) unsigned DEFAULT NULL,
  `running_time` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_film`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `film_backup`
--

LOCK TABLES `film_backup` WRITE;
/*!40000 ALTER TABLE `film_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `film_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `film_company`
--

DROP TABLE IF EXISTS `film_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `film_company` (
  `id_film_company` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_country` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `rating` int(11) DEFAULT '0',
  `lead_producer_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_film_company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `film_company`
--

LOCK TABLES `film_company` WRITE;
/*!40000 ALTER TABLE `film_company` DISABLE KEYS */;
/*!40000 ALTER TABLE `film_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `premiere`
--

DROP TABLE IF EXISTS `premiere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `premiere` (
  `id_premiere` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_film` int(10) unsigned NOT NULL,
  `id_country` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id_premiere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `premiere`
--

LOCK TABLES `premiere` WRITE;
/*!40000 ALTER TABLE `premiere` DISABLE KEYS */;
/*!40000 ALTER TABLE `premiere` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id_role` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_film` int(10) unsigned NOT NULL,
  `id_actor` int(10) unsigned NOT NULL,
  `is_main_role` bit(1) DEFAULT NULL,
  `fee` int(10) unsigned DEFAULT NULL,
  `character_name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-02 17:00:34
