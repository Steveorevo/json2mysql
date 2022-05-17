-- MariaDB dump 10.19  Distrib 10.4.21-MariaDB, for osx10.10 (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	10.4.21-MariaDB

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
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_options`
--

LOCK TABLES `wp_options` WRITE;
/*!40000 ALTER TABLE `wp_options` DISABLE KEYS */;
INSERT INTO `wp_options` VALUES (158,'duplicator_settings','a:17:{s:
7:\"version\";s:
5:\"1.4.5\";s:
18:\"uninstall_settings\";b:1;s:
15:\"uninstall_files\";b:1;s:
16:\"uninstall_tables\";b:1;s:
13:\"package_debug\";b:0;s:
17:\"package_mysqldump\";b:1;s:
22:\"package_mysqldump_path\";s:
0:\"\";s:
24:\"package_phpdump_qrylimit\";s:
3:\"100\";s:
17:\"package_zip_flush\";b:0;s:
19:\"installer_name_mode\";s:
6:\"simple\";s:
16:\"storage_position\";s:
6:\"wpcont\";s:
20:\"storage_htaccess_off\";b:0;s:
18:\"archive_build_mode\";i:2;s:
17:\"skip_archive_scan\";b:0;s:
21:\"unhook_third_party_js\";b:0;s:
22:\"unhook_third_party_css\";b:0;s:
17:\"active_package_id\";i:1;}','yes'),(159,'duplicator_version_plugin','1.4.5','yes'),(160,'duplicator_ui_view_state','a:4:{s:
22:\"dup-pack-storage-panel\";s:
1:\"0\";s:
22:\"dup-pack-archive-panel\";s:
1:\"0\";s:
24:\"dup-pack-installer-panel\";s:
1:\"0\";s:
29:\"dup-package-dtl-general-panel\";s:
1:\"1\";}','yes'),(164,'duplicator_package_active','O:11:\"DUP_Package\":23:{s:
7:\"Created\";s:
19:\"2022-05-01 21:15:25\";s:
7:\"Version\";s:
5:\"1.4.5\";s:
9:\"VersionWP\";s:
5:\"5.9.3\";s:
9:\"VersionDB\";s:
7:\"10.4.21\";s:
10:\"VersionPHP\";s:
6:\"7.4.28\";s:
9:\"VersionOS\";s:
6:\"Darwin\";s:
2:\"ID\";N;s:
4:\"Name\";s:
16:\"20220501_example\";s:
4:\"Hash\";s:
35:\"76dc5ca09a3a0f3a8360_20220501211525\";s:
8:\"NameHash\";s:
52:\"20220501_example_76dc5ca09a3a0f3a8360_20220501211525\";s:
4:\"Type\";i:0;s:
5:\"Notes\";s:
0:\"\";s:
8:\"ScanFile\";s:
62:\"20220501_example_76dc5ca09a3a0f3a8360_20220501211525_scan.json\";s:
10:\"TimerStart\";i:-1;s:
7:\"Runtime\";N;s:
7:\"ExeSize\";N;s:
7:\"ZipSize\";N;s:
6:\"Status\";i:0;s:
6:\"WPUser\";N;s:
7:\"Archive\";O:11:\"DUP_Archive\":21:{s:
10:\"FilterDirs\";s:
0:\"\";s:
11:\"FilterFiles\";s:
0:\"\";s:
10:\"FilterExts\";s:
0:\"\";s:
13:\"FilterDirsAll\";a:0:{}s:
14:\"FilterFilesAll\";a:0:{}s:
13:\"FilterExtsAll\";a:0:{}s:
8:\"FilterOn\";i:0;s:
12:\"ExportOnlyDB\";i:0;s:
4:\"File\";N;s:
6:\"Format\";s:
3:\"ZIP\";s:
7:\"PackDir\";s:
40:\"/Users/sjcarnam/Sites/www.example.dev.cc\";s:
4:\"Size\";i:0;s:
4:\"Dirs\";a:0:{}s:
5:\"Files\";a:0:{}s:
10:\"FilterInfo\";O:23:\"DUP_Archive_Filter_Info\":8:{s:
4:\"Dirs\";O:34:\"DUP_Archive_Filter_Scope_Directory\":6:{s:
7:\"Warning\";a:0:{}s:
10:\"Unreadable\";a:0:{}s:
10:\"AddonSites\";a:0:{}s:
4:\"Core\";a:0:{}s:
6:\"Global\";a:0:{}s:
8:\"Instance\";a:0:{}}s:
5:\"Files\";O:29:\"DUP_Archive_Filter_Scope_File\":7:{s:
4:\"Size\";a:0:{}s:
7:\"Warning\";a:0:{}s:
10:\"Unreadable\";a:0:{}s:
10:\"AddonSites\";a:0:{}s:
4:\"Core\";a:0:{}s:
6:\"Global\";a:0:{}s:
8:\"Instance\";a:0:{}}s:
4:\"Exts\";O:29:\"DUP_Archive_Filter_Scope_Base\":3:{s:
4:\"Core\";a:0:{}s:
6:\"Global\";a:0:{}s:
8:\"Instance\";a:0:{}}s:
9:\"UDirCount\";i:0;s:
10:\"UFileCount\";i:0;s:
9:\"UExtCount\";i:0;s:
8:\"TreeSize\";a:0:{}s:
11:\"TreeWarning\";a:0:{}}s:
14:\"RecursiveLinks\";a:0:{}s:
10:\"file_count\";i:-1;s:
10:\"\0*\0Package\";O:11:\"DUP_Package\":23:{s:
7:\"Created\";s:
19:\"2022-05-01 21:15:25\";s:
7:\"Version\";s:
5:\"1.4.5\";s:
9:\"VersionWP\";s:
5:\"5.9.3\";s:
9:\"VersionDB\";s:
7:\"10.4.21\";s:
10:\"VersionPHP\";s:
6:\"7.4.28\";s:
9:\"VersionOS\";s:
6:\"Darwin\";s:
2:\"ID\";N;s:
4:\"Name\";s:
16:\"20220501_example\";s:
4:\"Hash\";s:
35:\"76dc5ca09a3a0f3a8360_20220501211525\";s:
8:\"NameHash\";s:
52:\"20220501_example_76dc5ca09a3a0f3a8360_20220501211525\";s:
4:\"Type\";i:0;s:
5:\"Notes\";s:
0:\"\";s:
8:\"ScanFile\";N;s:
10:\"TimerStart\";i:-1;s:
7:\"Runtime\";N;s:
7:\"ExeSize\";N;s:
7:\"ZipSize\";N;s:
6:\"Status\";i:0;s:
6:\"WPUser\";N;s:
7:\"Archive\";r:21;s:
9:\"Installer\";O:13:\"DUP_Installer\":13:{s:
4:\"File\";N;s:
4:\"Size\";i:0;s:
10:\"OptsDBHost\";s:
0:\"\";s:
10:\"OptsDBPort\";s:
0:\"\";s:
10:\"OptsDBName\";s:
0:\"\";s:
10:\"OptsDBUser\";s:
0:\"\";s:
13:\"OptsDBCharset\";s:
0:\"\";s:
15:\"OptsDBCollation\";s:
0:\"\";s:
12:\"OptsSecureOn\";i:0;s:
14:\"OptsSecurePass\";s:
0:\"\";s:
13:\"numFilesAdded\";i:0;s:
12:\"numDirsAdded\";i:0;s:
10:\"\0*\0Package\";r:63;}s:
8:\"Database\";O:12:\"DUP_Database\":14:{s:
4:\"Type\";s:
5:\"MySQL\";s:
4:\"Size\";N;s:
4:\"File\";N;s:
4:\"Path\";N;s:
12:\"FilterTables\";s:
0:\"\";s:
8:\"FilterOn\";i:0;s:
4:\"Name\";N;s:
10:\"Compatible\";s:
0:\"\";s:
8:\"Comments\";s:
19:\"Source distribution\";s:
4:\"info\";O:16:\"DUP_DatabaseInfo\":16:{s:
9:\"buildMode\";N;s:
13:\"collationList\";a:0:{}s:
17:\"isTablesUpperCase\";N;s:
15:\"isNameUpperCase\";N;s:
4:\"name\";N;s:
15:\"tablesBaseCount\";N;s:
16:\"tablesFinalCount\";N;s:
14:\"tablesRowCount\";N;s:
16:\"tablesSizeOnDisk\";N;s:
18:\"varLowerCaseTables\";i:0;s:
7:\"version\";N;s:
14:\"versionComment\";N;s:
18:\"tableWiseRowCounts\";a:0:{}s:
11:\"triggerList\";a:0:{}s:
33:\"\0DUP_DatabaseInfo\0intFieldsStruct\";a:0:{}s:
42:\"\0DUP_DatabaseInfo\0indexProcessedSchemaSize\";a:0:{}}s:
10:\"\0*\0Package\";r:63;s:
24:\"\0DUP_Database\0tempDbPath\";N;s:
23:\"\0DUP_Database\0EOFMarker\";s:
0:\"\";s:
26:\"\0DUP_Database\0networkFlush\";b:0;}s:
13:\"BuildProgress\";O:18:\"DUP_Build_Progress\":12:{s:
17:\"thread_start_time\";N;s:
11:\"initialized\";b:0;s:
15:\"installer_built\";b:0;s:
15:\"archive_started\";b:0;s:
20:\"archive_has_database\";b:0;s:
13:\"archive_built\";b:0;s:
21:\"database_script_built\";b:0;s:
6:\"failed\";b:0;s:
7:\"retries\";i:0;s:
14:\"build_failures\";a:0:{}s:
19:\"validation_failures\";a:0:{}s:
27:\"\0DUP_Build_Progress\0package\";r:63;}}s:
29:\"\0DUP_Archive\0tmpFilterDirsAll\";a:0:{}s:
24:\"\0DUP_Archive\0wpCorePaths\";a:5:{i:0;s:
49:\"/Users/sjcarnam/Sites/www.example.dev.cc/wp-admin\";i:1;s:
59:\"/Users/sjcarnam/Sites/www.example.dev.cc/wp-content/uploads\";i:2;s:
61:\"/Users/sjcarnam/Sites/www.example.dev.cc/wp-content/languages\";i:3;s:
58:\"/Users/sjcarnam/Sites/www.example.dev.cc/wp-content/themes\";i:4;s:
52:\"/Users/sjcarnam/Sites/www.example.dev.cc/wp-includes\";}s:
29:\"\0DUP_Archive\0wpCoreExactPaths\";a:2:{i:0;s:
40:\"/Users/sjcarnam/Sites/www.example.dev.cc\";i:1;s:
51:\"/Users/sjcarnam/Sites/www.example.dev.cc/wp-content\";}}s:
9:\"Installer\";r:84;s:
8:\"Database\";r:98;s:
13:\"BuildProgress\";r:129;}','yes');
/*!40000 ALTER TABLE `wp_options` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-16 23:38:10
