-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2015 at 07:57 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cdcol`
--

-- --------------------------------------------------------

--
-- Table structure for table `cds`
--

CREATE TABLE IF NOT EXISTS `cds` (
  `titel` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `interpret` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `jahr` int(11) DEFAULT NULL,
`id` bigint(20) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `cds`
--

INSERT INTO `cds` (`titel`, `interpret`, `jahr`, `id`) VALUES
('Beauty', 'Ryuichi Sakamoto', 1990, 1),
('Goodbye Country (Hello Nightclub)', 'Groove Armada', 2001, 4),
('Glee', 'Bran Van 3000', 1997, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cds`
--
ALTER TABLE `cds`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cds`
--
ALTER TABLE `cds`
MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;--
-- Database: `mathappinfo`
--

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE IF NOT EXISTS `class` (
`class_id` int(11) NOT NULL,
  `class_name` varchar(30) NOT NULL,
  `teacher_name` varchar(30) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `class_password` varchar(30) NOT NULL,
  `teacher_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`class_id`, `class_name`, `teacher_name`, `salt`, `class_password`, `teacher_id`) VALUES
(1, 'RachelClass1', 'Rachel', '·¾»ÃÒ¦—iÏ¥p›ÅŒú¤ºŽ+dBÔŒÕiwºÐæU', 'b87d75fb8a977778fc87f6b8b3c670', 51),
(3, 'class1', 'Teacher1', '¾ã=7ðÞ×})2D®3ø½f®3ÿ\rïï=ÏxÈâ', '01b7c2251b4559b514fba325caf150', 54),
(10, 'KClass101', 'Kelly''s Class', '[X#·¬U·¢Kç†ÐtµÖ"]¥¬ç{ºˆ:0|e', '89f1bdbe36fd8ad87c746a40fc6765', 53),
(11, 'Rachels'' Class', 'Rachel', 'QÃ…,›¾õhk÷T¨:™™3ÛAŽ±b"U7~A£{Bæ', '1d78a20fb877e73c1b7e454e38604a', 55),
(12, '', '', 'S\rX=¡®Û)ÐžG/ÈCUAÕvµµY±Ü:UžŽ', 'c5bee484ff762bef05fabfff9977be', 55),
(13, 'TestClass', 'TestTeacher', '`ÐÚ§ˆž«âçUÙcùª8B®äéLôu`­yz”', 'e6604094e4d8c43215e3d66c561661', 56);

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE IF NOT EXISTS `group` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `permissions` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`id`, `name`, `permissions`) VALUES
(1, 'Administrator', '{"admin":1}');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `permissions` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `permissions`) VALUES
(1, 'Administrator', '{"admin":1}'),
(0, 'Standard User', '');

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE IF NOT EXISTS `level` (
`level_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `time_limit` int(11) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`level_id`, `name`, `description`, `time_limit`, `class_id`) VALUES
(1, 'Level', 'Zero Rule', 5, 11);

-- --------------------------------------------------------

--
-- Table structure for table `progress`
--

CREATE TABLE IF NOT EXISTS `progress` (
`id` int(11) NOT NULL,
  `level_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `elapsed_time` int(11) NOT NULL,
  `attemps` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
`id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `level_id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `operand1` int(11) NOT NULL,
  `operand2` int(11) NOT NULL,
  `operator` varchar(2) NOT NULL,
  `question_type` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `snapshot`
--

CREATE TABLE IF NOT EXISTS `snapshot` (
`id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table will allow the system to store snapshots of the student''s level';

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
`student_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `joined` datetime NOT NULL,
  `class_id` int(11) NOT NULL,
  `salt` varchar(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `first_name`, `last_name`, `username`, `password`, `joined`, `class_id`, `salt`) VALUES
(1, 'Ken', 'Ben', 'KenBen', '5f4a736becf5b4b54dca6c7db2b4659cc033f7e2c0dedbcdd0', '0000-00-00 00:00:00', 1, 'U?H³â`%ÓY+%`]=KHHÖš¦Z“æt¬Õ<'),
(2, 'Beck', 'Lap', 'blap', 'f2f093bbfb8968d749cc1842c51b7263811ff29e98b9809627', '2015-03-11 20:42:31', 1, 'Xr!Zy½?¬ƒ¯Ær†šÁÇÉ‰óº0}ÿGÐ	ì'),
(3, 'Kelly''s Student', 'Kelly''s Student', 'KStudent', '48992beba92452df8d916a12c3bed19de31f6d13e28b6857a0', '2015-03-11 21:28:02', 10, 'ÿ¢''6f®¨’ÝZf}iÙü¿¹½x\\x\n·æŠ<¿A'),
(4, 'Keith', 'Hamburger', 'Kham', '52c6d94dc55bc6ecf7ef2cbf6d2e9332ca4b14ad7b90bfca01', '2015-03-11 21:35:08', 1, '´MúV\Z$É“ƒGŽj•­±A‡ƒËAÜ¸J©Lº„EÐ{'),
(5, 'John', 'Brown', 'Jbrown', '5d3479e60be5362656cdf3d5bf3cb7cf4fc506001ea7b456f2', '2015-03-11 21:54:06', 1, 'çÕ>¦ÌHY^Š8#y2b¸£¹ð¹ÚCø€ºâÜñª'),
(6, 'Jane', 'Doe', 'JDoe', '56ad866e11ac3c4731085c0f85878b12a13e84f5e72746533f', '2015-03-11 22:01:08', 1, 'Ôõ”\Z‰~ÉðÐ¡µP¬«³&"ÀÉ4Ýj°Õëeì'),
(7, 'John', 'Michaels', 'JMike', '3c75ba62dd21465d92e526946283243a76ba1ba9c5af8b9d9e', '2015-03-12 03:16:17', 11, '³xÃFNÄ¯WDC°ŸŽ¼Añ·*ži³¬i ëm'),
(8, 'Ken', 'Piker', 'KPiker', 'a1cb0d4903ac2b280956b713eeccfc42a601214a252dd16911', '2015-03-12 03:16:42', 11, '~ø&D6GS¥Ã1²¡D±ŽWÊ›xÞW‡Œ‡¼´Â×²'),
(9, 'Mike', 'Valley', 'MValley', 'd8ea2c17f2f51da9abdcb48b6f59d2b68a559a5ed11a9d8eba', '2015-03-12 03:59:52', 13, 'w;½<usVDY¹„ôÂ»–o9É¢y‚ÔR©4Ï öá•'),
(10, 'Sam', 'macro', 'Smarco', 'cc8735f7d64ddf8aa040c5f9084fddbec3846197ab941a5d51', '2015-03-13 18:10:51', 13, '=ýæýÃè¶¯:XNÏÅ‡±L S9äÌµ¢"@’-');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE IF NOT EXISTS `teacher` (
`id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `joined` datetime NOT NULL,
  `group` int(11) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `name`, `username`, `password`, `salt`, `joined`, `group`, `class_id`) VALUES
(50, 'nick d', 'nick', '5ac52cefb3f758bd337263804c5a8c0c2f58010ae8c109be71', '/’—†ÛJ==gu#S}{¥\r:ùàÀ(îm‹šÀÃ7', '2015-02-28 23:09:24', 0, 0),
(51, 'Sam Arseneault', 'Sam', 'e45de85f49f5041ddbc0c10dea2066c73af079fd20ebf71c47', '&rîËðêY™sŒ''ßyÛ)ˆƒáIðïªÝ=úëbã', '2015-02-28 23:15:29', 1, 1),
(52, 'pep', 'pepper', 'c937e82f4263c3b270d3750ca81a578039e4d3e8ddf76ed78a', 'nåá¡é€YÚ»_Ç	´;å?øäQv1©Õÿ¤¡ú»', '2015-02-28 23:20:14', 0, 0),
(53, 'Kelly', 'kelly', '6f442ec1afe920e874f4f42b9fec285f30f1bc9b4117449d62', 'tdx†” dªÿjŽJ4ýËÓ¯¬Ñ*j¤¦¾¡?·¢', '2015-03-11 01:21:02', 0, 0),
(54, 'Sam', 'Sam2', 'af2a4bd6ecd01262def93c68e74fd6985fc3fdaef52c81fcc4', 'ñŽ ë,Øâ¿KÄ™-Aj”7°QÔ‚çÄ´', '2015-03-11 02:01:30', 0, 0),
(55, 'Samuel Arseneault', 'SamA', 'cf57edf35717728a202d49687f79520ad3b5be975d32e08c57', 'éW¶j·P\r‰ÙU¯õÿ›ƒpÈV§Ü© +ÂÃÐð™­', '2015-03-12 03:14:15', 0, 0),
(56, 'Tester', 'Tester', 'e93b25f581094edd223093b77e2c1d745c1a52c1485a78bd5c', '±-ð>Ì4iÍ÷’M€n´ÑÔ~µëÒAÁ•(vŠÏ', '2015-03-12 03:58:02', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_session`
--

CREATE TABLE IF NOT EXISTS `teacher_session` (
`id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `hash` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher_session`
--

INSERT INTO `teacher_session` (`id`, `teacher_id`, `hash`) VALUES
(1, 51, '523613be259b8b01c01a9481d11420aaa1c75563efb8d50d87'),
(2, 53, '9e6f9382755ccb455cdb4ce271785438fb2c48e1b27dcc8e30'),
(3, 54, '86b912c908ef9fb7edda13025bc911f862e46150e4dadc32bc'),
(4, 55, '84ea47fa5228bdee56a47ebca17f5e1efe811243b15a4225fb');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
 ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `group`
--
ALTER TABLE `group`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
 ADD PRIMARY KEY (`level_id`);

--
-- Indexes for table `progress`
--
ALTER TABLE `progress`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `snapshot`
--
ALTER TABLE `snapshot`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
 ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teacher_session`
--
ALTER TABLE `teacher_session`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `level`
--
ALTER TABLE `level`
MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `progress`
--
ALTER TABLE `progress`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `snapshot`
--
ALTER TABLE `snapshot`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT for table `teacher_session`
--
ALTER TABLE `teacher_session`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;--
-- Database: `phpmyadmin`
--

-- --------------------------------------------------------

--
-- Table structure for table `pma_bookmark`
--

CREATE TABLE IF NOT EXISTS `pma_bookmark` (
`id` int(11) NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma_column_info`
--

CREATE TABLE IF NOT EXISTS `pma_column_info` (
`id` int(5) unsigned NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

--
-- Dumping data for table `pma_column_info`
--

INSERT INTO `pma_column_info` (`id`, `db_name`, `table_name`, `column_name`, `comment`, `mimetype`, `transformation`, `transformation_options`) VALUES
(1, 'mathappinfo', 'snapShot', 'snap_ID', '', '', '_', ''),
(2, 'mathappinfo', 'snapShot', 'name', '', '', '_', ''),
(3, 'mathappinfo', 'snapShot', 'image', '', '', '_', ''),
(4, 'mathappinfo', 'Teacher', 'teacher_ID', '', '', '_', ''),
(5, 'mathappinfo', 'Teacher', 'name', '', '', '_', ''),
(6, 'mathappinfo', 'Teacher', 'username', '', '', '_', ''),
(7, 'mathappinfo', 'Teacher', 'password', '', '', '_', ''),
(8, 'mathappinfo', 'Class', 'class_ID', '', '', '_', ''),
(9, 'mathappinfo', 'Class', 'class_name', '', '', '_', ''),
(10, 'mathappinfo', 'Class', 'teacher_name', '', '', '_', ''),
(11, 'mathappinfo', 'Student', 'studnet_ID', '', '', '_', ''),
(12, 'mathappinfo', 'Student', 'first_name', '', '', '_', ''),
(13, 'mathappinfo', 'Student', 'last_name', '', '', '_', ''),
(14, 'mathappinfo', 'Student', 'username', '', '', '_', ''),
(15, 'mathappinfo', 'Student', 'password', '', '', '_', ''),
(16, 'mathappinfo', 'Progress', 'progress_ID', '', '', '_', ''),
(17, 'mathappinfo', 'Progress', 'level_ID', '', '', '_', ''),
(18, 'mathappinfo', 'Progress', 'question_ID', '', '', '_', ''),
(19, 'mathappinfo', 'Progress', 'status', '', '', '_', ''),
(20, 'mathappinfo', 'Progress', 'elapsed_time', '', '', '_', ''),
(21, 'mathappinfo', 'Progress', 'attemps', '', '', '_', ''),
(22, 'mathappinfo', 'Level', 'level_ID', '', '', '_', ''),
(23, 'mathappinfo', 'Level', 'name', '', '', '_', ''),
(24, 'mathappinfo', 'Level', 'description', '', '', '_', ''),
(25, 'mathappinfo', 'Level', 'time_limit', '', '', '_', ''),
(26, 'mathappinfo', 'Question', 'question_ID', '', '', '_', ''),
(27, 'mathappinfo', 'Question', 'name', '', '', '_', ''),
(28, 'mathappinfo', 'Question', 'level_ID', '', '', '_', ''),
(29, 'mathappinfo', 'Question', 'description', '', '', '_', ''),
(30, 'mathappinfo', 'Question', 'operand1', '', '', '_', ''),
(31, 'mathappinfo', 'Question', 'operand2', '', '', '_', ''),
(32, 'mathappinfo', 'Question', 'operator', '', '', '_', ''),
(33, 'mathappinfo', 'Question', 'question_type', '', '', '_', ''),
(34, 'mathappinfo', 'snapshot', 'snap_id', '', '', '_', ''),
(35, 'mathappinfo', 'teacher', 'salt', '', '', '_', ''),
(36, 'mathappinfo', 'teacher', 'joined', '', '', '_', ''),
(37, 'mathappinfo', 'teacher', 'id', '', '', '_', ''),
(38, 'mathappinfo', 'student', 'id', '', '', '_', ''),
(39, 'mathappinfo', 'snapshot', 'id', '', '', '_', ''),
(40, 'mathappinfo', 'question', 'id', '', '', '_', ''),
(41, 'mathappinfo', 'question', 'level_id', '', '', '_', ''),
(42, 'mathappinfo', 'progress', 'id', '', '', '_', ''),
(43, 'mathappinfo', 'progress', 'level_id', '', '', '_', ''),
(44, 'mathappinfo', 'progress', 'question_id', '', '', '_', ''),
(45, 'mathappinfo', 'level', 'level_id', '', '', '_', ''),
(46, 'mathappinfo', 'class', 'class_id', '', '', '_', ''),
(47, 'mathappinfo', 'teacher_session', 'id', '', '', '_', ''),
(48, 'mathappinfo', 'teacher_session', 'teacher_id', '', '', '_', ''),
(49, 'mathappinfo', 'teacher_session', 'hash', '', '', '_', ''),
(52, 'mathappinfo', 'class', 'salt', '', '', '_', ''),
(51, 'mathappinfo', 'student', 'joined', '', '', '_', ''),
(53, 'mathappinfo', 'class', 'class_password', '', '', '_', ''),
(54, 'mathappinfo', 'class', 'teacher_id', '', '', '_', ''),
(63, 'mathappinfo', 'student', 'class_is', '', '', '_', ''),
(62, 'mathappinfo', 'student', 'student_id', '', '', '_', ''),
(58, 'mathappinfo', 'teacher', 'group', '', '', '_', ''),
(59, 'mathappinfo', 'groups', 'id', '', '', '_', ''),
(60, 'mathappinfo', 'groups', 'name', '', '', '_', ''),
(61, 'mathappinfo', 'groups', 'permissions', '', '', '_', ''),
(64, 'mathappinfo', 'student', 'class_id', '', '', '_', ''),
(65, 'mathappinfo', 'student', 'salt', '', '', '_', ''),
(66, 'mathappinfo', 'teacher', 'class_id', '', '', '_', ''),
(67, 'mathappinfo', 'level', 'class_id', '', '', '_', '');

-- --------------------------------------------------------

--
-- Table structure for table `pma_designer_coords`
--

CREATE TABLE IF NOT EXISTS `pma_designer_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `v` tinyint(4) DEFAULT NULL,
  `h` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma_history`
--

CREATE TABLE IF NOT EXISTS `pma_history` (
`id` bigint(20) unsigned NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma_navigationhiding`
--

CREATE TABLE IF NOT EXISTS `pma_navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

--
-- Dumping data for table `pma_navigationhiding`
--

INSERT INTO `pma_navigationhiding` (`username`, `item_name`, `item_type`, `db_name`, `table_name`) VALUES
('root', 'group', 'table', 'mathappinfo', '');

-- --------------------------------------------------------

--
-- Table structure for table `pma_pdf_pages`
--

CREATE TABLE IF NOT EXISTS `pma_pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
`page_nr` int(10) unsigned NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma_recent`
--

CREATE TABLE IF NOT EXISTS `pma_recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma_recent`
--

INSERT INTO `pma_recent` (`username`, `tables`) VALUES
('root', '[{"db":"mathappinfo","table":"question"},{"db":"mathappinfo","table":"level"},{"db":"mathappinfo","table":"student"},{"db":"mathappinfo","table":"snapshot"},{"db":"mathappinfo","table":"teacher"},{"db":"mathappinfo","table":"class"},{"db":"mathappinfo","table":"progress"},{"db":"mathappinfo","table":"Question"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma_relation`
--

CREATE TABLE IF NOT EXISTS `pma_relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma_savedsearches`
--

CREATE TABLE IF NOT EXISTS `pma_savedsearches` (
`id` int(5) unsigned NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma_table_coords`
--

CREATE TABLE IF NOT EXISTS `pma_table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT '0',
  `x` float unsigned NOT NULL DEFAULT '0',
  `y` float unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma_table_info`
--

CREATE TABLE IF NOT EXISTS `pma_table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma_table_uiprefs`
--

CREATE TABLE IF NOT EXISTS `pma_table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma_tracking`
--

CREATE TABLE IF NOT EXISTS `pma_tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) unsigned NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma_userconfig`
--

CREATE TABLE IF NOT EXISTS `pma_userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma_userconfig`
--

INSERT INTO `pma_userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2015-02-22 05:42:38', '{"collation_connection":"utf8mb4_general_ci"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma_usergroups`
--

CREATE TABLE IF NOT EXISTS `pma_usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma_users`
--

CREATE TABLE IF NOT EXISTS `pma_users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma_bookmark`
--
ALTER TABLE `pma_bookmark`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma_column_info`
--
ALTER TABLE `pma_column_info`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma_designer_coords`
--
ALTER TABLE `pma_designer_coords`
 ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma_history`
--
ALTER TABLE `pma_history`
 ADD PRIMARY KEY (`id`), ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma_navigationhiding`
--
ALTER TABLE `pma_navigationhiding`
 ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma_pdf_pages`
--
ALTER TABLE `pma_pdf_pages`
 ADD PRIMARY KEY (`page_nr`), ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma_recent`
--
ALTER TABLE `pma_recent`
 ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma_relation`
--
ALTER TABLE `pma_relation`
 ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`), ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma_savedsearches`
--
ALTER TABLE `pma_savedsearches`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma_table_coords`
--
ALTER TABLE `pma_table_coords`
 ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma_table_info`
--
ALTER TABLE `pma_table_info`
 ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma_table_uiprefs`
--
ALTER TABLE `pma_table_uiprefs`
 ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma_tracking`
--
ALTER TABLE `pma_tracking`
 ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma_userconfig`
--
ALTER TABLE `pma_userconfig`
 ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma_usergroups`
--
ALTER TABLE `pma_usergroups`
 ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma_users`
--
ALTER TABLE `pma_users`
 ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma_bookmark`
--
ALTER TABLE `pma_bookmark`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma_column_info`
--
ALTER TABLE `pma_column_info`
MODIFY `id` int(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=68;
--
-- AUTO_INCREMENT for table `pma_history`
--
ALTER TABLE `pma_history`
MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma_pdf_pages`
--
ALTER TABLE `pma_pdf_pages`
MODIFY `page_nr` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma_savedsearches`
--
ALTER TABLE `pma_savedsearches`
MODIFY `id` int(5) unsigned NOT NULL AUTO_INCREMENT;--
-- Database: `test`
--
--
-- Database: `webauth`
--

-- --------------------------------------------------------

--
-- Table structure for table `user_pwd`
--

CREATE TABLE IF NOT EXISTS `user_pwd` (
  `name` char(30) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `pass` char(32) COLLATE latin1_general_ci NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `user_pwd`
--

INSERT INTO `user_pwd` (`name`, `pass`) VALUES
('xampp', 'wampp');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user_pwd`
--
ALTER TABLE `user_pwd`
 ADD PRIMARY KEY (`name`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
