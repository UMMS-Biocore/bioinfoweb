-- MySQL dump 10.13  Distrib 5.6.33, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: bioinfo
-- ------------------------------------------------------
-- Server version	5.6.33-0ubuntu0.14.04.1

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
-- Current Database: `bioinfo`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bioinfo` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `bioinfo`;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_bin NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL,
  `allDay` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT 'false',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (44,'workshop-second week','2014-01-15 00:00:00','0000-00-00 00:00:00','','false'),(52,'name','2014-02-05 00:00:00','2014-02-05 00:00:00','','false'),(53,'Meeting AmbrosLab','2014-04-23 00:00:00','2014-04-23 00:00:00','','false'),(54,'Bootcamp Week6','2014-03-18 09:00:00','0000-00-00 00:00:00','','false'),(57,'Khvorova Lab Meeting AS4-1049','2014-03-28 10:00:00','0000-00-00 00:00:00','','false'),(58,'Peterson Lab','2014-03-26 00:00:00','2014-03-26 00:00:00','','false'),(59,'zdfs','2014-04-24 00:00:00','2014-04-24 00:00:00','','false');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqcategory`
--

DROP TABLE IF EXISTS `faqcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faqcategory` (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqcategory`
--

LOCK TABLES `faqcategory` WRITE;
/*!40000 ALTER TABLE `faqcategory` DISABLE KEYS */;
INSERT INTO `faqcategory` VALUES (1,'Services'),(2,'Galaxy'),(3,'Dolphin'),(4,'Training'),(5,'RStudio');
/*!40000 ALTER TABLE `faqcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqitems`
--

DROP TABLE IF EXISTS `faqitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faqitems` (
  `faq_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) NOT NULL,
  `faq_question` text NOT NULL,
  `faq_answer` text NOT NULL,
  PRIMARY KEY (`faq_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqitems`
--

LOCK TABLES `faqitems` WRITE;
/*!40000 ALTER TABLE `faqitems` DISABLE KEYS */;
INSERT INTO `faqitems` VALUES (1,1,'How can I start using biocore services?','Please send an email to help desk to join galaxy group.'),(2,2,'How can I reach galaxy.umassmed.edu from home?','You need to connect school network using VPN. To get VPN access, please send an email to help desk.'),(3,3,'What is dolphin?','Dolphin is a pipeline generation platform. We are using dolphin to submit jobs to cluster using galaxy interface. '),(4,4,'How can I join workshops?','Please send an email to biocore@umassmed.edu to join the workshops. '),(5,1,'What kind of services can I use in biocore?','Please consult services section to learn supported services and pipelines. To have an individual support for any service, please send an email to <a href=\"mailto:biocore@umassmed.edu\">biocore@umassmed.edu</a>.'),(6,2,'How can I transfer a file from cluster to galaxy history?','To see how to do please <a href=\"http://bioinfo.umassmed.edu/index.php?p=21&link=nCDQUTuN9nQ\">click here</a> to watch the clip;<br><br>\r\n<p>\r\nBasically;</br>\r\nFrom galaxy; find \"FileTransfer from/to the Cluster\" under UMassTools section. \r\n-To transfer a file from cluster(ghpcc06) to the galaxy (Import a file). Please select \"FreeText\" from the \"Select Source File\" box and write full path of the file in the cluster. And select \"history\" in the \"Select Output File\" box then \"execute\". You can also change the name of this transfer using pencil button (edit attributes) in the history section.'),(7,5,'I cannot login RStudio what can be the problem?','1. RStudio is case sensitive. Please use your username that you use to login UMassMed email account(usually lastname+first character of your firstname) lowercase.<br>\r\n2. You need to be in galaxy group. Please send an email to helpdesk to join galaxy group. \r\n'),(8,4,'How can find bootcamp class material?','We share bootcamp material in the pages below. <br/>\r\n\r\n<a href=\"http://bioinfo.umassmed.edu/index.php?p=17\"> Bootcamp Class Material</a>');
/*!40000 ALTER TABLE `faqitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation`
--

DROP TABLE IF EXISTS `navigation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation` (
  `pid` bigint(20) NOT NULL AUTO_INCREMENT,
  `include_file` varchar(255) NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation`
--

LOCK TABLES `navigation` WRITE;
/*!40000 ALTER TABLE `navigation` DISABLE KEYS */;
INSERT INTO `navigation` VALUES (1,'content/services.html'),(2,'content/calendar.php'),(3,'content/projects.html'),(4,'content/training.html'),(5,'content/news.html'),(6,'content/contact.html'),(7,'php/phpfaq.php'),(8,'php/tlist.php'),(9,'content/team.html'),(10,'content/services/rnaseqrsem.html'),(11,'content/services/chipseq.html'),(12,'content/services/deseq.html'),(13,'content/services/galaxy.html'),(14,'content/services/rstudio.html'),(15,'content/services/mirza.html'),(16,'php/dolphin/index.php'),(17,'content/classmaterial.html'),(18,'content/services/variantorganizer.html'),(19,'content/pdf/Week3.html'),(20,'php/dolphin/index.php'),(21,'content/services/serve.php'),(22,'content/sab.html'),(23,'content/bcw.html'),(24,'content/bcw/bcwclass2014summer.html'),(25,'content/bcw/bcw2014Jul11.html'),(26,'content/bcw/bcw2014Jul18.html'),(27,'content/bcw/bcw2014Jul25.html'),(28,'content/bcw/bcw2014Aug1.html'),(29,'content/bcw/bcw2014Aug8.html'),(30,'content/bcw/bcw2014Aug15.html'),(31,'content/classmaterial2014Fall.html'),(32,'content/classmaterial2015Fall.html'),(33,'content/pdf2015fall/week4.html'),(34,'content/pdf2015fall/week7.html'),(35,'content/workshops/ascb2015.html'),(36,'content/classmaterial2016Fall.html'),(37,'content/classmaterial2018Fall.html'),(38,'content/classmaterial.html');
/*!40000 ALTER TABLE `navigation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traininglist`
--

DROP TABLE IF EXISTS `traininglist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traininglist` (
  `Name` varchar(23) DEFAULT NULL,
  `Lab` varchar(14) DEFAULT NULL,
  `Laptop` varchar(1) DEFAULT NULL,
  `Maker` varchar(7) DEFAULT NULL,
  `OS` varchar(20) DEFAULT NULL,
  `HavingData` varchar(16) DEFAULT NULL,
  `FamiliarLinux` varchar(19) DEFAULT NULL,
  `Contact` varchar(36) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traininglist`
--

LOCK TABLES `traininglist` WRITE;
/*!40000 ALTER TABLE `traininglist` DISABLE KEYS */;
INSERT INTO `traininglist` VALUES ('Elizabeth Thatcher','Ambros','Y','Apple','OS X 10.9','not yet','some','elizabeth.thatcher@umassmed.edu'),('catherine sterling','Ambros','Y','apple','osx 10.8.5','Y','no','catherine.stering@umassmed.edu'),('Isana Lublinsky','Ambros','Y','Windows','Windows 8','Y','Y','Isana.Veksler-Lublinsky@umassmed.edu'),('Chitra Kanchagar','Ambros','N',NULL,NULL,'Y','no','chitra.kanchagar@umassmed.edu'),('Ozkan Aydemir','Bailey','Y','Dell','Linux','no','Y','ozkan.aydemir@umassmed.edu'),('Yasin Kaymaz','Bailey','Y','Sony','Linux','Y','Y',NULL),('Vahbiz Jokhi','Budnik','Y','Apple','OS X 10.6.8','No','No','Vahbiz.Jokhi@umassmed.edu'),('Yihang Li','Budnik','Y','Dell','Windows 7','no','no','yihang.li@umassmed.edu'),('SoYun Min','Corvera','Y','Apple','Mac OS 10.7.5','Will soon','a little','soyun.min@umassmed.edu'),('Olga Gealikman','Corvera','Y','Apple','Mac OS 10.7.5','will soon','a little','olga.gealikman@umassmed.edu'),('pranitha vangala','Czceh','Y','apple','Mac OS X 10.9','no','no','pranitha.vangala@umassmed.edu'),('Myriam Aouadi','Czech','Y','Apple','Mac Os X 10.6.8','Will soon','No','Myriam.Aouadi@umassmed.edu'),('Michaela Tencerova','Czech','Y','Apple','Mac OSx 10.8.5','Will soon','No','Michaela.Tencerova@umassmed.edu'),('Santiago Vernia','Davis','Y','apple','Mac OS X 10.9','no','no','santiago.vernia@umassmed.edu'),('Kasmir Ramo','Davis','Y','Windows','Windows 7','Y','No','Kasmir.Ramo@umassmed.edu'),('Seda Barutcu','Davis','Y','Dell','Windows 7','No','some','seda.barutcu@umassmed.edu'),('Ellie Kittler','DeepSequencing','Y','Dell','Windows 7','Y','Y','Ellen.Kittler@umassmed.edu'),('Amartya Sanyal','Dekker','Y','Lenevo','Windows 7','No','No','amartya.sanyal@umassmed.edu'),('Jennifer Chen','Emerson','Y','Apple','Mac Os X 10.7.5','Y','No','jennifer.chen@umassmed.edu'),('Diwash Acharya','Fazzio','Y','Apple','Mac OS X 10.7.5','no','No','diwash.acharya@umassmed.edu'),('Benson Chen','Fazzio','Y','Apple','OS X 10.6.8','Y','Y','po-shen.chen@umassmed.edu'),('Ly-sha Ee','Fazzio','Y','Apple','OS X 10.7.5','Y','no','Ly-Sha.Ee@umassmed.edu'),('Sarah Hainer','Fazzio','Y','Apple','Mac Os X 10.7.5','Y','Some','sarah.hainer@umassmed.edu'),('Ben Landry','Fazzio','Y','Windows','Windows 7','Y','Y but only a little','Benjamin.landry@umassmed.edu'),('Kurtis McCannell','Fazzio','Y','Windows','Windows 8','Will soon','No','kurtis.mccannell@umassmed.edu'),('Helene Tran','FB Gao','Y','Apple','Mac Os X 10.5.7','will soon','no','helene.tran@umassmed.edu'),('Hsin-Jung Chou','Gao','Y','PC','Windows 7','Y','some','Hsinjung.Chou@umassmed.edu'),('Alison Casserly','Gardner','Y','Apple','OSX 10.6.8','Will soon','No','alison.casserly@umassmed.edu'),('Sungmi Park','Green','Y','Samsung','Windows 8','Y','No','sungmi.park@umassmed.edu'),('Lawrence Hayward','Hayward','Y','HP','Windows 7','no','some','Lawrence.Hayward@umassmed.edu'),('Balaji Polepalli Ramesh','Hong Yu','Y','Apple','Mac OSx 10.9','No','Y',NULL),('Ricky J. Sethi','Hong Yu','Y','M$','Windoze/Linux','No','Y',NULL),('Rasim Barutcu','Imbalzano','Y','Dell','Windows7/Linux','Will soon','Some','rasim.barutcu@umassmed.edu'),('Qiong Wu','Imbalzano','Y','Lenevo','Windows 7','No','No',NULL),('Scott LeBlanc','Imbalzano','Y','Dell','Windows 7/Linux','No','No','scott.leblanc@umassmed.edu'),('Ei Ei Min','Jacobson','Y','Windows','Windows 7','Will soon','NO','eiei.min@umassmed.edu'),('Jianhong Ou','Julie Zhu','Y','Apple','Mac OS X 10.6.8','Y','Y','jianhong.ou@umassmed.edu'),('Socheata Ly','Khvorova','Y','Dell','Windows 7','No','No','socheata.ly@umassmed.edu'),('Anastasia Khvorova','Khvorova','Y','Sony','Windows 7','No','Some','anastasia.khvorova@umassmed.edu'),('Jen-Chieh Chiang','Lawrence','Y','Apple','Mavericks','No','No','jen-chieh.chiang@umassmed.edu'),('Dawn Carone','Lawrence','Y','Apple','OS X 10.9','Y','some','dawn.carone@umassmed.edu'),('Meg Byron','Lawrence','Y','HP','Windows 8','No','No','Meg.Byron@umassmed.edu'),('Lisa Hall','Lawrence','N',NULL,NULL,'No','No','Lisa.Hall@umassmed.edu'),('Michael Lee','Lee','Y','Apple','OS X 10.9','Y','some','michael.lee@umassmed.edu'),('Thomas Leete','Lee','Y','Apple','OS X 10.9','Y','No','thomas.leete@umassmed.edu'),('Diego Farfan','Lu','N',NULL,NULL,'Y','some','diego.farfan@umassmed.edu'),('Sarah Van Cor-Hosmer','Luban','Y','Apple','OS X 10.6.8','Y-ish','no','sarah.vancorhosmer@umassmed.edu'),('Shih Lin Goh','Luban','Y','Apple','OS X 10.7.5','no','no','shihlin.goh@umassmed.edu'),('Juahdi Monbo','Luban','Y','Apple','Mac OS X 10.7.5','no','No','juahdi.monbo@umassmed.edu'),('Keri Sanborn','Luzuriaga','Y','Apple','OS X 10.6.8','Y','very little','keri.sanborn@umassmed.edu'),('Margaret McManus','Luzuriaga','Y','HP','Windows 7','No','No','margaret.mcmanus@umassmed.edu'),('Eric Weiss','Luzuriaga','Y','Dell','Windows 7','Y','No','eric.weiss@umassmed.edu'),('M Somasundaran','Luzuriaga','Y','Mac','OS X 10.6.8','Y','N','mohan.somasundaran@umassmed.edu'),('Larisa Kamga','Luzuriaga','Y','Mac','OS X 10.6.8','No','No','Larisa.Kamga@umassmed.edu'),('Wen Tang','Mello','Y','Apple','Mac OSx 10.8.5','Will soon','Y','wen.tang@umassmed.edu'),('Daniel Chaves','Mello','Y','Sony','Windows 8.1','Y','no','daniel.chaves@umassmed.edu'),('Takao Ishidate','Mello','Y','apple','OS 10.6.8','Will soon','no','takao.ishidate@umassmed.edu'),('Meetu Seth','Mello','Y','Apple','OS X 10.6.8','no','no','meetu.seth@umassmed.edu'),('Heng-Chi Lee','Mello','Y','Apple','OS X 10.6.8','Y','some','hengchi.lee@umassmed.edu'),('Colin Conine','Mello','Y','Mac','OS X 10.8.5','Y','some','colin.conine@umassmed.edu'),('Li Xie','Michael Green','Y','Windows','Windows 7','Y','No','Li.Xie@umassmed.edu'),('Blandine Mercier','Moore','Y','Apple','Mac OS X 10.6.8','Y','Y but only a little','blandine.mercier@umassmed.edu'),('Emiliano Ricci','Moore','Y','Apple','Mac OS X 10.6.8','Y','Y','emiliano.ricci@umassmed.edu'),('Ami Ashar','Moore','Y','Apple','Mac Os X 10.6.8','Y','Y but only a little','ami.ashar@umassmed.edu'),('Weijun Chen','Moore','Y','apple','Mac Os X 10.6.8','Will soon','No','weijun.chen@umassmed.edu'),('Carrie Kovalak','Moore','Y','Apple','Mac OS X 10.7.5','Y','Some','Carrie.Kovalak@umassmed.edu'),('Erin Heyer','Moore','Y','Apple','Mac OS X 10.7.5','Y','Y','Erin.Heyer@umassmed.edu'),('Lingtao Peng','Moore','Y','Apple','Mac OS X 10.7.5','Y','NO','Lingtao.Peng@umassmed.edu'),('Harleen Saini','Moore','Y','Apple','Mac OSx 10.8.5','Y','Y','harleen.saini@umassmed.edu'),('Alicia Bicknell','Moore',NULL,'Apple','Mavericks','Will soon','Y','Alicia.bicknell@umassmed.edu'),('Akiko Noma','Moore','Y','Windows','Windows 7','Will soon','Y but only a little','Akiko.Noma@umassmed.edu'),('Makoto Ohira','Moore','Y','Toshiba','Windows 7','No','No','MakotoJohn.Ohira@umassmed.edu'),('Mihir Metkar','Moore','Y','Dell','Windows 7','No','No','mihir.metkar@umassmed.edu'),('Kelly Limoncelli','Moore','Y','Apple','Mac OS X 10.6.8','no','no','kelly.limoncelli@umassmed.edu'),('Nikola Wenta','Peterson','Y','Fujitsu','Linux/Windows7','No','Y','nikola.wenta@umassmed.edu'),('Shinya Watanabe','Peterson','Y','Apple','Mac OS X 10.9','No','No','Shinya.Watanabe@umassmed.edu'),('Craig Peterson','Peterson','Y','Apple','OS X 10.8.5','Y','No','craig.peterson@umassmed.edu'),('Mayuri Rege','Peterson','Y','Apple','OS X 10.8.5','Y','Y but only a little','mayuri.rege@gmail.com'),('Christopher Van','Peterson','Y','Windows','Windows 7','Y','No','christopher.van@umassmed.edu'),('Benjamin Manning','Peterson','Y','hp','Windows 8 and Debian','Y','Y, a little','benjamin.manning@umassmed.edu'),('Hsiuyi Chen','Rando','Y','Apple','OS X 10.9','Y','some','Hsiuyi.Chen@umassmed.edu'),('Marcus Vallaster','Rando','Y','Apple','OS X 10.9','Y','Y','Markus.Vallaster@umassmed.edu'),('Benjamin Carone','Rando','Y','PC','ubuntu','Y','Y','benjamin.carone@umassmed.edu'),('Tsung-Han Hsieh','Rando','Y','PC','Windows 7','Y','some','Tsung-Han.Hsieh@umassmed.edu'),('Amanda Hughes','Rando','Y','HP','Windows 7','Y','some','amanda.hughes@umassmed.edu'),('Upasna Sharma','Rando','Y','Mac','OSX10.7.5','Y','some','FNU.Upasna@umassmed.edu'),('Al Ritacco','RCS','Y','HP','Windows','No','Y','Alan.Ritacco@umassmed.edu'),('Traci Heikkinen','RCS','N',NULL,NULL,'No','No','Traci.Heikkinen@umassmed.edu'),('Melissa Greven','Rhind','Y','Apple','Mac OS X 10.9.1','Y','Y but only a little','melissa.greven@umassmed.edu'),('Ki Young Paek','Richter','Y','apple','OS X 10.7.5','Y','No','kiyoung.paek@umassmed.edu'),('Maria Ivshina','Richter','Y','Wndows','Windows 7','will soon','No',NULL),('Jihae Shin','Richter','Y','Dell','Windows 7','NO','No','Jihae.Shin@umassmed.edu'),('Huan Shu','Richter','Y','Lenovo','Windows 7','Will soon','Little','shu.huan@umassmed.edu'),('Zhongfa Yang','Rosmarin','Y','Lenovo','Windows 7','Y','Y','zhongfa.yang@umassmed.edu'),('Ruth Zearfoss','Ryder','Y','Apple','OS X 10.6.8','not yet','some','Nancy.Zearfoss@umassmed.edu'),('Carina Clingman','Ryder','Y','Apple','OS X 10.8.5','no','no','carina.clingman@umassmed.edu'),('Yuxin Chen','Shan Lu','Y','Apple','Mac OS X 10.7.5','Will soon','No','yuxin.chen@umassmed.edu'),('GEN ZHANG','Theurkauf','Y','Apple','Mac Os X 10.9','No','No','gen.zhang@umassmed.edu'),('Anna Malinkevich','Theurkauf','Y','Apple','Mac OS X 10.9','No','Some','Anna.Malinkevich@umassmed.edu'),('Alfred Simkin','Theurkauf/Weng','Y','Asus','linux ubuntu 13.04','Y','Y','alfred.simkin@umassmed.edu'),('Amy Walker','Walker','Y','Apple','Mac OS X 10.9','no','no','amy.walker@umassmed.edu'),('Ankit Gupta','Wolfe','Y','Apple','Mac OS X 10.6.8','No (near future)','No','ankit.gupta@umassmed.edu'),('Mehmet Bolukbasi','Wolfe','Y','Acer','Windows 7','Will soon','No','mehmet.bolukbasi@umassmed.edu'),('Pengyu Gu','Yang Xiang','Y','Windows','windows 7','Y','no','Pengyu.Gu@umassmed.edu'),('J Broderick','Zamore','Y','Apple','10.6.8','Y','Y','Jennifer.Broderick@umassmed.edu'),('Xin Li','Zamore','Y','Apple','Mac OSx 10.8.5','Y','Some','Xin.Li@umassmed.edu'),('Cansu Colpan','Zamore','Y','apple','Mac OSx 10.8.5','Will soon','No','Cansu.Colpan@umassmed.edu'),('Chengjian Li','Zamore','Y','Apple','Mac OSx 10.8.5','Y','Some','Chengjian.Li@umassmed.edu'),('Tianfang Ge','Zamore','Y','Apple','Mavericks','Y','No',NULL),('Pei-Hsuan Wu','Zamore','Y','Apple','OS 10.8.5','Y','No','Pei-Hsuan.Wu@umassmed.edu'),('Samson Jolly','Zamore','Y','Apple','OS X 10.8.3','Soon','No','samson.jolly@umassmed.edu'),('Fabian Flores','Zamore','Y','sony','Vista','Y','some','carlos.flores@umassmed.edu'),('Revati Darp',NULL,'Y','Toshiba','Windows 8','No','No','Revati.Darp@umassmed.edu'),('sss','','','','','','',''),('Jessica Feldman','Peterson','y','Apple','OS X 10.95','Will soon','No','jessica.feldman@umassmed.edu');
/*!40000 ALTER TABLE `traininglist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-23 10:34:02
