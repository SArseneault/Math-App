-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 15, 2015 at 06:43 AM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`level_id`, `name`, `description`, `time_limit`, `class_id`) VALUES
(10, 'Level1', 'Zero Rule', 5, 11),
(11, 'Level 2', 'One rule', 7, 11);

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
  `attemps` int(11) NOT NULL,
  `student_id` int(11) NOT NULL
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
  `question_type` tinyint(1) NOT NULL,
  `freq` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

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
(8, 'Ken', 'Piker', 'KPiker', 'a1cb0d4903ac2b280956b713eeccfc42a601214a252dd16911', '2015-03-12 03:16:42', 11, '~ø&D6GS¥Ã1²¡D±ŽWÊ›xÞW‡Œ‡¼´Â×²'),
(9, 'Mike', 'Valley', 'MValley', 'd8ea2c17f2f51da9abdcb48b6f59d2b68a559a5ed11a9d8eba', '2015-03-12 03:59:52', 13, 'w;½<usVDY¹„ôÂ»–o9É¢y‚ÔR©4Ï öá•'),
(10, 'Sam', 'macro', 'Smarco', 'cc8735f7d64ddf8aa040c5f9084fddbec3846197ab941a5d51', '2015-03-13 18:10:51', 13, '=ýæýÃè¶¯:XNÏÅ‡±L S9äÌµ¢"@’-'),
(11, 'Jake', 'Jumper', 'JJumper', '6d1d731c038a30f52280844222e8f3d2480e6080e739442dbc', '2015-03-15 06:41:21', 11, '™ëMA\\p4µä™­r¼ñ´—¾Üª¿mÎÚ•®ÿÉOw');

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
  `group` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `name`, `username`, `password`, `salt`, `joined`, `group`) VALUES
(50, 'nick d', 'nick', '5ac52cefb3f758bd337263804c5a8c0c2f58010ae8c109be71', '/’—†ÛJ==gu#S}{¥\r:ùàÀ(îm‹šÀÃ7', '2015-02-28 23:09:24', 0),
(51, 'Sam Arseneault', 'Sam', 'e45de85f49f5041ddbc0c10dea2066c73af079fd20ebf71c47', '&rîËðêY™sŒ''ßyÛ)ˆƒáIðïªÝ=úëbã', '2015-02-28 23:15:29', 1),
(52, 'pep', 'pepper', 'c937e82f4263c3b270d3750ca81a578039e4d3e8ddf76ed78a', 'nåá¡é€YÚ»_Ç	´;å?øäQv1©Õÿ¤¡ú»', '2015-02-28 23:20:14', 0),
(53, 'Kelly', 'kelly', '6f442ec1afe920e874f4f42b9fec285f30f1bc9b4117449d62', 'tdx†” dªÿjŽJ4ýËÓ¯¬Ñ*j¤¦¾¡?·¢', '2015-03-11 01:21:02', 0),
(54, 'Sam', 'Sam2', 'af2a4bd6ecd01262def93c68e74fd6985fc3fdaef52c81fcc4', 'ñŽ ë,Øâ¿KÄ™-Aj”7°QÔ‚çÄ´', '2015-03-11 02:01:30', 0),
(55, 'Samuel Arseneault', 'SamA', 'cf57edf35717728a202d49687f79520ad3b5be975d32e08c57', 'éW¶j·P\r‰ÙU¯õÿ›ƒpÈV§Ü© +ÂÃÐð™­', '2015-03-12 03:14:15', 0),
(56, 'Tester', 'Tester', 'e93b25f581094edd223093b77e2c1d745c1a52c1485a78bd5c', '±-ð>Ì4iÍ÷’M€n´ÑÔ~µëÒAÁ•(vŠÏ', '2015-03-12 03:58:02', 0);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_session`
--

CREATE TABLE IF NOT EXISTS `teacher_session` (
`id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `hash` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher_session`
--

INSERT INTO `teacher_session` (`id`, `teacher_id`, `hash`) VALUES
(1, 51, '523613be259b8b01c01a9481d11420aaa1c75563efb8d50d87'),
(2, 53, '9e6f9382755ccb455cdb4ce271785438fb2c48e1b27dcc8e30'),
(3, 54, '86b912c908ef9fb7edda13025bc911f862e46150e4dadc32bc'),
(5, 55, '0a4e006c6ea09ebecf07296133f0a49b7bb9ed1ca9425a1f2b');

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
MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `progress`
--
ALTER TABLE `progress`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `snapshot`
--
ALTER TABLE `snapshot`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT for table `teacher_session`
--
ALTER TABLE `teacher_session`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
