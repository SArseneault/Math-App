-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 15, 2015 at 10:08 PM
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`class_id`, `class_name`, `teacher_name`, `salt`, `class_password`, `teacher_id`) VALUES
(14, 'Mr. Sam''s Class', 'Mr. Sam', 'îaàcúõÚ%A­¹ù\nZY¨v¸EŒh7)ñú''', '9bb693ffb92be4679dbaa32a4d57bb', 57);

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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`level_id`, `name`, `description`, `time_limit`, `class_id`) VALUES
(37, 'Level 1', 'Zero Rule', 5, 14),
(38, 'Level 2', 'One Rule', 6, 14),
(39, 'Level 3', '2 plus 2', 5, 14),
(40, 'Level 4', '2 plus 3', 3, 14);

-- --------------------------------------------------------

--
-- Table structure for table `level_progress`
--

CREATE TABLE IF NOT EXISTS `level_progress` (
`levelprog_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `level_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `elapsed_time` time NOT NULL,
  `attempts` int(2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `level_progress`
--

INSERT INTO `level_progress` (`levelprog_id`, `student_id`, `level_id`, `status`, `elapsed_time`, `attempts`) VALUES
(35, 23, 37, 1, '00:00:00', 0),
(36, 23, 38, 1, '00:00:00', 0),
(37, 23, 39, 1, '00:00:00', 0),
(38, 23, 40, 0, '00:00:00', 0),
(39, 24, 37, 0, '00:00:00', 0),
(40, 24, 38, 0, '00:00:00', 0),
(41, 24, 39, 0, '00:00:00', 0),
(42, 24, 40, 0, '00:00:00', 0),
(47, 26, 37, 0, '00:00:00', 0),
(48, 26, 38, 0, '00:00:00', 0),
(49, 26, 39, 0, '00:00:00', 0),
(50, 26, 40, 0, '00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
`question_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `level_id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `operand1` int(11) NOT NULL,
  `operand2` int(11) NOT NULL,
  `operator` varchar(2) NOT NULL,
  `question_type` tinyint(1) NOT NULL,
  `freq` int(11) NOT NULL,
  `answer` int(2) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`question_id`, `name`, `level_id`, `description`, `operand1`, `operand2`, `operator`, `question_type`, `freq`, `answer`, `class_id`) VALUES
(14, 'L1Q1', 37, 'Level1Q1', 2, 2, '+', 0, 2, 4, 14),
(15, 'L1Q2', 37, 'Level1Q2', 4, 3, '+', 1, 3, 6, 14),
(16, 'Q2L1', 38, 'Q2L1', 5, 6, '+', 1, 4, 11, 14),
(17, 'Q45', 37, 'Q4', 5, 5, '+', 0, 4, 10, 14);

-- --------------------------------------------------------

--
-- Table structure for table `question_progress`
--

CREATE TABLE IF NOT EXISTS `question_progress` (
`questionprog_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `level_id` int(11) NOT NULL,
  `answer` int(2) NOT NULL,
  `student_id` int(11) NOT NULL,
  `attemps` int(2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question_progress`
--

INSERT INTO `question_progress` (`questionprog_id`, `question_id`, `level_id`, `answer`, `student_id`, `attemps`) VALUES
(7, 14, 37, -1, 23, 0),
(8, 15, 37, -1, 23, 0),
(9, 16, 38, -1, 23, 0),
(10, 17, 37, -1, 23, 0),
(11, 14, 37, -1, 26, 0),
(12, 15, 37, -1, 26, 0),
(13, 16, 38, -1, 26, 0),
(14, 17, 37, -1, 26, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `first_name`, `last_name`, `username`, `password`, `joined`, `class_id`, `salt`) VALUES
(23, 'Ken', 'Ben', 'KBen', '470210c9f9353208cab042767979354a2bff7000b846dd6d29', '2015-03-15 21:59:17', 14, 'É-™²g™,íHx*‚h¤·ž@M;¤wü¨?¿Ã±9^'),
(24, 'Ben', 'Marco', 'BMarco', '8661a0c1cee70bbbe91e8ae63f81a4b324bf2025cbab87c2bd', '2015-03-15 22:03:51', 14, 'Q†BÊEÙ|íÜúN¢«L2ö¦$3Ûà\\(,õ³'),
(26, 'Pen', 'Marker', 'PMarker', '7d55e06cd76e7411d23dbea1d541711b19e2d6818eea4365d2', '2015-03-15 22:08:01', 14, 'Å&ìŠMÈ¥ÓŠ\n+öÖ—Rûˆ”•/*µGŸHþò');

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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `name`, `username`, `password`, `salt`, `joined`, `group`) VALUES
(57, 'Sam Arseneault', 'Sam', 'cc88d7b4127c56b6cf1582210f9414b64f40f992b5a93eb885', '¾—ÏniAv9Óo*¦¶6a\0 Âb·;0£«ÈÀød', '2015-03-15 21:54:29', 0);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_session`
--

CREATE TABLE IF NOT EXISTS `teacher_session` (
`id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `hash` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher_session`
--

INSERT INTO `teacher_session` (`id`, `teacher_id`, `hash`) VALUES
(6, 57, '8d9b5bbe19ac4a63685719499f93e39aca2dc46e72f709a3ad');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
 ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
 ADD PRIMARY KEY (`level_id`);

--
-- Indexes for table `level_progress`
--
ALTER TABLE `level_progress`
 ADD PRIMARY KEY (`levelprog_id`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
 ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `question_progress`
--
ALTER TABLE `question_progress`
 ADD PRIMARY KEY (`questionprog_id`);

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
MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `level`
--
ALTER TABLE `level`
MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `level_progress`
--
ALTER TABLE `level_progress`
MODIFY `levelprog_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `question_progress`
--
ALTER TABLE `question_progress`
MODIFY `questionprog_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=58;
--
-- AUTO_INCREMENT for table `teacher_session`
--
ALTER TABLE `teacher_session`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
