-- MySQL dump 10.13  Distrib 5.1.34, for Win32 (ia32)
--
-- Host: localhost    Database: jntuh
-- ------------------------------------------------------
-- Server version	5.1.34-community

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
-- Current Database: `jntuh`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jntuh` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jntuh`;

--
-- Table structure for table `allowance`
--

DROP TABLE IF EXISTS `allowance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allowance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`,`description`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allowance`
--

LOCK TABLES `allowance` WRITE;
/*!40000 ALTER TABLE `allowance` DISABLE KEYS */;
INSERT INTO `allowance` VALUES (1,'DA','Dear Allowance'),(2,'HRA','House Rent Allowance'),(3,'HON','Hon. Claimed'),(4,'FPI-PP','FPI or PP');
/*!40000 ALTER TABLE `allowance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deduction`
--

DROP TABLE IF EXISTS `deduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deduction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`,`description`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deduction`
--

LOCK TABLES `deduction` WRITE;
/*!40000 ALTER TABLE `deduction` DISABLE KEYS */;
INSERT INTO `deduction` VALUES (1,'GPF-SUB','GPF SUB'),(2,'GSLIS','GSLIS'),(3,'PT','P.Tax'),(4,'LIC-PEN','LIC PEN'),(5,'EWF','EWF'),(6,'LIC','Life Insurance'),(7,'QrRent1','Quarter Rent 1'),(8,'QrRent2','Quarter Rent 2'),(9,'Misc','Miscellaneous'),(10,'Teach-Assoc','Association'),(11,'IT','Income Tax'),(12,'JNTU-AOA','JNTU AOA'),(13,'Co-Op-Sub','Co-op Sub'),(14,'QrRent','Quarter Rent');
/*!40000 ALTER TABLE `deduction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `hod` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`,`code`,`hod`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'CSE','Computer Science Engineering','Dr.T.Venugopal'),(2,'IT','Information Technology','Prof. Vishnu Vardhan'),(3,'EEE','Electrical and Electronic Engineering','Dr.N.V.Ramana'),(4,'ECE','Electrical and Communication Engineering','Sri Dhiraj Sunehra'),(5,'MECH','Mechnical Engineering','Dr.N.V.S.Raju'),(6,'Maths','Dept. of Mathematics','----------'),(7,'Phy','Dept.of Physics','----------'),(8,'LIS','LIS','----------'),(9,'English','Dept. of English','----------'),(10,'Chem','Dpet. of Chemistry','----------'),(11,'P.Edn','Dept. of Physical Education','----------');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designation`
--

DROP TABLE IF EXISTS `designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `designation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designation`
--

LOCK TABLES `designation` WRITE;
/*!40000 ALTER TABLE `designation` DISABLE KEYS */;
INSERT INTO `designation` VALUES (1,'Principal'),(2,'Vice Principal'),(3,'Professor'),(4,'Assit.Prof'),(5,'Assos.Prof'),(6,'Assit.Registrar'),(7,'DEE'),(8,'SuperIndentent');
/*!40000 ALTER TABLE `designation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_addr`
--

DROP TABLE IF EXISTS `emp_addr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_addr` (
  `id` int(11) NOT NULL DEFAULT '0',
  `addr1` varchar(100) DEFAULT NULL,
  `addr2` varchar(100) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `zipcode` varchar(20) DEFAULT NULL,
  `homephone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `email` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_addr`
--

LOCK TABLES `emp_addr` WRITE;
/*!40000 ALTER TABLE `emp_addr` DISABLE KEYS */;
INSERT INTO `emp_addr` VALUES (1234,'','','','','','','','','','lakshman@gmail.com'),(1235,'','','','','','','','','','venkateswara@gmail.com'),(1236,'','','','','','','','','','srinivas@gmail.com'),(1237,'','','','','','','','','','ramana@gmail.com'),(1238,'','','','','','','','','','dileep@gmail.com'),(1239,'','','','','','','','','','uday@gmail.com'),(1240,'','','','','','','','','','psrinivas@gmail.com'),(1241,'','','','','','','','','','viswanadha@gmail.com'),(1242,'','','','','','','','','','vishnu@gmail.com'),(1243,'','','','','','','','','','tirumala@gmail.com'),(1244,'','','','','','','','','','raju@gmail.com'),(1245,'','','','','','','','','','joshi.jntu@gmail.com');
/*!40000 ALTER TABLE `emp_addr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_job`
--

DROP TABLE IF EXISTS `emp_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_job` (
  `id` int(11) NOT NULL DEFAULT '0',
  `joining` varchar(20) DEFAULT NULL,
  `leaving` varchar(20) DEFAULT NULL,
  `designation` varchar(40) DEFAULT NULL,
  `photograph` blob,
  `groupid` int(11) NOT NULL DEFAULT '0',
  `basic` int(11) NOT NULL DEFAULT '0',
  `branch` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_job`
--

LOCK TABLES `emp_job` WRITE;
/*!40000 ALTER TABLE `emp_job` DISABLE KEYS */;
INSERT INTO `emp_job` VALUES (1234,'15/04/2004','15/09/2020','DEE',NULL,2,23650,''),(1235,'14/09/2005','14/09/2030','Assit.Registrar',NULL,2,17540,''),(1236,'12/04/2008','12/04/2030','SuperIndentent',NULL,2,17050,''),(1237,'12/03/2001','12/04/2040','Professor',NULL,3,59010,'EEE'),(1238,'13/04/2001','13/04/2049','Professor',NULL,3,55620,'P.Edn'),(1239,'12/05/2000','12/05/2050','Assos.Prof',NULL,3,49230,'CSE'),(1240,'17/09/2000','17/09/2049','Assos.Prof',NULL,3,31425,'CSE'),(1241,'18/09/2000','18/09/2051','Professor',NULL,3,52420,'CSE'),(1242,'12/09/2000','12/08/2040','Professor',NULL,3,52420,'CSE'),(1243,'12/09/2000','12/09/2040','Professor',NULL,3,52420,'Chem'),(1244,'13/09/1999','13/09/2030','Assos.Prof',NULL,3,49240,'MECH'),(1245,'12/04/2003','12/08/2040','Assit.Prof',NULL,3,25050,'CSE');
/*!40000 ALTER TABLE `emp_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `empid` int(11) NOT NULL,
  `salutation` varchar(10) NOT NULL,
  `firstname` varchar(60) NOT NULL,
  `middlename` varchar(60) NOT NULL,
  `lastname` varchar(60) NOT NULL,
  `dob` varchar(15) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `marital` varchar(10) NOT NULL,
  `login` varchar(30) NOT NULL DEFAULT '',
  `password` varchar(30) NOT NULL,
  `admin` varchar(10) DEFAULT 'user',
  PRIMARY KEY (`login`),
  UNIQUE KEY `empid` (`empid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (0,'','','','','','','','@dm!n@jntu','@dm!n@dm!n','admin'),(1235,'Sri','A Vekateswara','','Rao','14/09/1970','Male','Married','A-V1235','A-V1235','user'),(1236,'Sri','A','','Srinivas','12/04/1972','Male','Married','A1236','A1236','user'),(1242,'Dr.','B Vishnu','','Vardhan','15/09/1967','Male','Married','B-V1242','B-V1242','user'),(1243,'Dr.','M Tirumala','','Chari','13/04/1968','Male','Married','M-T1243','M-T1243','user'),(1239,'Sri','M Uday','','Kumar','12/05/1975','Male','Married','M-U1239','M-U1239','user'),(1238,'Dr.','N S','','Dileep','13/04/1968','Male','Married','N-S1238','N-S1238','user'),(1237,'Dr.','N V','','Ramana','12/03/1970','Male','Married','N-V1237','N-V1237','user'),(1244,'Dr.','N V S','','Raju','13/09/1970','Male','Married','N-V1244','N-V1244','user'),(1240,'Sri','P Srinivas','','Rao','17/09/1970','Male','Married','P-S1240','P-S1240','user'),(1234,'Sri','R','','Lakshman','19/03/1978','Male','Married','R1234','R1234','user'),(1245,'Sri','S Joshi','','Shripad','13/08/1970','Male','Married','S-J1245','S-J1245','user'),(1241,'Dr.','S Viswanadha','','Raju','18/09/1970','Male','Married','S-V1241','S-V1241','user');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `xml` mediumtext,
  `emp` mediumtext,
  PRIMARY KEY (`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (2,'Non Teaching Staff','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><salaryhead> <allowances> <DA><name>DA</name><type>percent</type><value>35.952</value></DA><HRA><name>HRA</name><type>percent</type><value>14.5</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON><FPI-PP><name>FPI-PP</name><type>fixed</type><value>0</value></FPI-PP></allowances> <deductions> <GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>0</value></PT><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><JNTU-AOA><name>JNTU-AOA</name><type>fixed</type><value>0</value></JNTU-AOA><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><Co-Op-Sub><name>Co-Op-Sub</name><type>fixed</type><value>0</value></Co-Op-Sub><QrRent><name>QrRent</name><type>fixed</type><value>0</value></QrRent><IT><name>IT</name><type>fixed</type><value>0</value></IT></deductions> <loans> <GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value></HBL><VH-Loan><name>VH-Loan</name><type>fixed</type><value>0</value></VH-Loan><Co-Op-Loan><name>Co-Op-Loan</name><type>fixed</type><value>0</value></Co-Op-Loan><Edn-Adv><name>Edn-Adv</name><type>fixed</type><value>0</value></Edn-Adv></loans> </salaryhead>','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><employeelist><employee empid=\"1234\"><allowances><DA><name>DA</name><type>percent</type><value>35.952</value></DA><HRA><name>HRA</name><type>percent</type><value>14.5</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON><FPI-PP><name>FPI-PP</name><type>fixed</type><value>50</value></FPI-PP></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>5000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><EWF><name>EWF</name><type>fixed</type><value>20</value></EWF><JNTU-AOA><name>JNTU-AOA</name><type>fixed</type><value>0</value></JNTU-AOA><LIC><name>LIC</name><type>fixed</type><value>743</value></LIC><Co-Op-Sub><name>Co-Op-Sub</name><type>fixed</type><value>0</value></Co-Op-Sub><QrRent><name>QrRent</name><type>fixed</type><value>0</value></QrRent><IT><name>IT</name><type>fixed</type><value>500</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>1528</value><current>105</current><total>180</total></HBL><VH-Loan><name>VH-Loan</name><type>fixed</type><value>500</value><current>68</current><total>80</total></VH-Loan><Co-Op-Loan><name>Co-Op-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Co-Op-Loan><Edn-Adv><name>Edn-Adv</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Edn-Adv></loans></employee><employee empid=\"1235\"><allowances><DA><name>DA</name><type>percent</type><value>35.952</value></DA><HRA><name>HRA</name><type>percent</type><value>14.5</value></HRA><HON><name>HON</name><type>fixed</type><value>368</value></HON><FPI-PP><name>FPI-PP</name><type>fixed</type><value>40</value></FPI-PP></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>4000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>60</value></GSLIS><PT><name>PT</name><type>fixed</type><value>150</value></PT><EWF><name>EWF</name><type>fixed</type><value>20</value></EWF><JNTU-AOA><name>JNTU-AOA</name><type>fixed</type><value>100</value></JNTU-AOA><LIC><name>LIC</name><type>fixed</type><value>352</value></LIC><Co-Op-Sub><name>Co-Op-Sub</name><type>fixed</type><value>100</value></Co-Op-Sub><QrRent><name>QrRent</name><type>fixed</type><value>2743</value></QrRent><IT><name>IT</name><type>fixed</type><value>0</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>1962</value><current>29</current><total>35</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>2500</value><current>10</current><total>80</total></HBL><VH-Loan><name>VH-Loan</name><type>fixed</type><value>750</value><current>10</current><total>80</total></VH-Loan><Co-Op-Loan><name>Co-Op-Loan</name><type>fixed</type><value>1004</value><current>41</current><total>50</total></Co-Op-Loan><Edn-Adv><name>Edn-Adv</name><type>fixed</type><value>500</value><current>10</current><total>10</total></Edn-Adv></loans></employee><employee empid=\"1236\"><allowances><DA><name>DA</name><type>percent</type><value>35.952</value></DA><HRA><name>HRA</name><type>percent</type><value>14.5</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON><FPI-PP><name>FPI-PP</name><type>fixed</type><value>40</value></FPI-PP></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>2000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>60</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><EWF><name>EWF</name><type>fixed</type><value>20</value></EWF><JNTU-AOA><name>JNTU-AOA</name><type>fixed</type><value>0</value></JNTU-AOA><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><Co-Op-Sub><name>Co-Op-Sub</name><type>fixed</type><value>100</value></Co-Op-Sub><QrRent><name>QrRent</name><type>fixed</type><value>0</value></QrRent><IT><name>IT</name><type>fixed</type><value>0</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><VH-Loan><name>VH-Loan</name><type>fixed</type><value>1675</value><current>6</current><total>36</total></VH-Loan><Co-Op-Loan><name>Co-Op-Loan</name><type>fixed</type><value>1883</value><current>9</current><total>50</total></Co-Op-Loan><Edn-Adv><name>Edn-Adv</name><type>fixed</type><value>500</value><current>9</current><total>10</total></Edn-Adv></loans></employee></employeelist>'),(3,'Teaching Staff','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><salaryhead> <allowances> <DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances> <deductions> <GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>0</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>0</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>0</value></IT></deductions> <loans> <GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value></Inst></loans> </salaryhead>','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><employeelist><employee empid=\"1237\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>3000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>40</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>15000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>8000</value><current>10</current><total>25</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1238\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>3000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>664</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>3000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>3000</value><current>48</current><total>50</total></HBL><Inst><name>Inst</name><type>fixed</type><value>4000</value><current>4</current><total>50</total></Inst></loans></employee><employee empid=\"1239\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>4000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>4000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1240\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>1000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>20</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>3243</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>1500</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1241\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>8282</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>5000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1242\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>8282</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>8000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1243\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>8282</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>5071</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>10000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1244\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>7780</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>5000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1245\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>3958</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>0</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee></employeelist>');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`,`description`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,'GPF-Loan','GPF Loan'),(2,'HBL','HBL'),(3,'VH-Loan','Vechile Loan'),(4,'Co-Op-Loan','Co-op Loan'),(5,'Edn-Adv','Edn Adv'),(6,'Inst','Inst');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payslips`
--

DROP TABLE IF EXISTS `payslips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payslips` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `payslip` mediumtext,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payslips`
--

LOCK TABLES `payslips` WRITE;
/*!40000 ALTER TABLE `payslips` DISABLE KEYS */;
INSERT INTO `payslips` VALUES ('April 2012','Non Teaching Staff','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><employeelist><employee empid=\"1234\"><allowances><DA><name>DA</name><type>percent</type><value>35.952</value></DA><HRA><name>HRA</name><type>percent</type><value>14.5</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON><FPI-PP><name>FPI-PP</name><type>fixed</type><value>50</value></FPI-PP></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>5000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><EWF><name>EWF</name><type>fixed</type><value>20</value></EWF><JNTU-AOA><name>JNTU-AOA</name><type>fixed</type><value>0</value></JNTU-AOA><LIC><name>LIC</name><type>fixed</type><value>743</value></LIC><Co-Op-Sub><name>Co-Op-Sub</name><type>fixed</type><value>0</value></Co-Op-Sub><QrRent><name>QrRent</name><type>fixed</type><value>0</value></QrRent><IT><name>IT</name><type>fixed</type><value>500</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>1528</value><current>105</current><total>180</total></HBL><VH-Loan><name>VH-Loan</name><type>fixed</type><value>500</value><current>68</current><total>80</total></VH-Loan><Co-Op-Loan><name>Co-Op-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Co-Op-Loan><Edn-Adv><name>Edn-Adv</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Edn-Adv></loans></employee><employee empid=\"1235\"><allowances><DA><name>DA</name><type>percent</type><value>35.952</value></DA><HRA><name>HRA</name><type>percent</type><value>14.5</value></HRA><HON><name>HON</name><type>fixed</type><value>368</value></HON><FPI-PP><name>FPI-PP</name><type>fixed</type><value>40</value></FPI-PP></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>4000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>60</value></GSLIS><PT><name>PT</name><type>fixed</type><value>150</value></PT><EWF><name>EWF</name><type>fixed</type><value>20</value></EWF><JNTU-AOA><name>JNTU-AOA</name><type>fixed</type><value>100</value></JNTU-AOA><LIC><name>LIC</name><type>fixed</type><value>352</value></LIC><Co-Op-Sub><name>Co-Op-Sub</name><type>fixed</type><value>100</value></Co-Op-Sub><QrRent><name>QrRent</name><type>fixed</type><value>2743</value></QrRent><IT><name>IT</name><type>fixed</type><value>0</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>1962</value><current>29</current><total>35</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>2500</value><current>10</current><total>80</total></HBL><VH-Loan><name>VH-Loan</name><type>fixed</type><value>750</value><current>10</current><total>80</total></VH-Loan><Co-Op-Loan><name>Co-Op-Loan</name><type>fixed</type><value>1004</value><current>41</current><total>50</total></Co-Op-Loan><Edn-Adv><name>Edn-Adv</name><type>fixed</type><value>500</value><current>10</current><total>10</total></Edn-Adv></loans></employee><employee empid=\"1236\"><allowances><DA><name>DA</name><type>percent</type><value>35.952</value></DA><HRA><name>HRA</name><type>percent</type><value>14.5</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON><FPI-PP><name>FPI-PP</name><type>fixed</type><value>40</value></FPI-PP></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>2000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>60</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><EWF><name>EWF</name><type>fixed</type><value>20</value></EWF><JNTU-AOA><name>JNTU-AOA</name><type>fixed</type><value>0</value></JNTU-AOA><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><Co-Op-Sub><name>Co-Op-Sub</name><type>fixed</type><value>100</value></Co-Op-Sub><QrRent><name>QrRent</name><type>fixed</type><value>0</value></QrRent><IT><name>IT</name><type>fixed</type><value>0</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><VH-Loan><name>VH-Loan</name><type>fixed</type><value>1675</value><current>6</current><total>36</total></VH-Loan><Co-Op-Loan><name>Co-Op-Loan</name><type>fixed</type><value>1883</value><current>9</current><total>50</total></Co-Op-Loan><Edn-Adv><name>Edn-Adv</name><type>fixed</type><value>500</value><current>9</current><total>10</total></Edn-Adv></loans></employee></employeelist>'),('April 2012','Teaching Staff','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><employeelist><employee empid=\"1237\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>3000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>40</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>15000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>8000</value><current>10</current><total>25</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1238\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>3000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>664</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>3000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>3000</value><current>48</current><total>50</total></HBL><Inst><name>Inst</name><type>fixed</type><value>4000</value><current>4</current><total>50</total></Inst></loans></employee><employee empid=\"1239\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>4000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>4000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1240\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>1000</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>120</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>20</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>3243</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>1500</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1241\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>8282</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>5000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1242\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>8282</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>8000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1243\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>8282</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>5071</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>10000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1244\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>0</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>7780</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>5000</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee><employee empid=\"1245\"><allowances><DA><name>DA</name><type>percent</type><value>58</value></DA><HRA><name>HRA</name><type>percent</type><value>10</value></HRA><HON><name>HON</name><type>fixed</type><value>0</value></HON></allowances><deductions><GPF-SUB><name>GPF-SUB</name><type>fixed</type><value>0</value></GPF-SUB><GSLIS><name>GSLIS</name><type>fixed</type><value>0</value></GSLIS><PT><name>PT</name><type>fixed</type><value>200</value></PT><LIC-PEN><name>LIC-PEN</name><type>fixed</type><value>3958</value></LIC-PEN><EWF><name>EWF</name><type>fixed</type><value>0</value></EWF><LIC><name>LIC</name><type>fixed</type><value>0</value></LIC><QrRent1><name>QrRent1</name><type>fixed</type><value>0</value></QrRent1><QrRent2><name>QrRent2</name><type>fixed</type><value>0</value></QrRent2><Misc><name>Misc</name><type>fixed</type><value>0</value></Misc><Teach-Assoc><name>Teach-Assoc</name><type>fixed</type><value>50</value></Teach-Assoc><IT><name>IT</name><type>fixed</type><value>0</value></IT></deductions><loans><GPF-Loan><name>GPF-Loan</name><type>fixed</type><value>0</value><current>0</current><total>0</total></GPF-Loan><HBL><name>HBL</name><type>fixed</type><value>0</value><current>0</current><total>0</total></HBL><Inst><name>Inst</name><type>fixed</type><value>0</value><current>0</current><total>0</total></Inst></loans></employee></employeelist>');
/*!40000 ALTER TABLE `payslips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salutation`
--

DROP TABLE IF EXISTS `salutation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salutation` (
  `title` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salutation`
--

LOCK TABLES `salutation` WRITE;
/*!40000 ALTER TABLE `salutation` DISABLE KEYS */;
INSERT INTO `salutation` VALUES ('Dr.'),('Drs.'),('Miss.'),('Mr.'),('Mrs.'),('Ms.'),('Smt'),('Sri');
/*!40000 ALTER TABLE `salutation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-04-25  9:50:49
