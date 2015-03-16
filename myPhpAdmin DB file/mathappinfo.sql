-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 16, 2015 at 08:59 PM
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
  `salt` varchar(64) NOT NULL,
  `class_password` varchar(64) NOT NULL,
  `teacher_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`class_id`, `class_name`, `teacher_name`, `salt`, `class_password`, `teacher_id`) VALUES
(1, 'Sam''sClass', 'Sam', '`IÏX…¾ºÒ3¥©rî Ž¹ÊšŠJÇ)VgóR«Þ', 'b83e3b482aabcd1b442f0dc9ab9e24acc00ff02d8488098ececaf51e1901b52c', 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`level_id`, `name`, `description`, `time_limit`, `class_id`) VALUES
(1, 'Level 1', 'Zero Rule', 5, 1),
(2, 'Level 2', '1 Rule', 4, 1),
(3, 'Level 3', '2 plus 2', 6, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `level_progress`
--

INSERT INTO `level_progress` (`levelprog_id`, `student_id`, `level_id`, `status`, `elapsed_time`, `attempts`) VALUES
(1, 1, 1, 0, '00:00:00', 0),
(2, 2, 1, 0, '00:00:00', 0),
(3, 1, 2, 0, '00:00:00', 0),
(4, 2, 2, 0, '00:00:00', 0),
(5, 1, 3, 0, '00:00:00', 0),
(6, 2, 3, 0, '00:00:00', 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`question_id`, `name`, `level_id`, `description`, `operand1`, `operand2`, `operator`, `question_type`, `freq`, `answer`, `class_id`) VALUES
(1, 'Q1L1', 1, 'Question1L1', 1, 1, '+', 1, 5, 2, 1),
(2, 'Q2L1', 1, 'Question2L1', 1, 1, '+', 0, 3, 2, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question_progress`
--

INSERT INTO `question_progress` (`questionprog_id`, `question_id`, `level_id`, `answer`, `student_id`, `attemps`) VALUES
(1, 1, 1, -1, 1, 0),
(2, 1, 1, -1, 2, 0),
(3, 2, 1, -1, 1, 0),
(4, 2, 1, -1, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
`student_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(64) NOT NULL,
  `joined` datetime NOT NULL,
  `class_id` int(11) NOT NULL,
  `salt` varchar(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `first_name`, `last_name`, `username`, `password`, `joined`, `class_id`, `salt`) VALUES
(1, 'Laura', 'Rabe', 'LRabe', '67535744c9972ca18d4b33506f8ca4387a771274e9a6c7210fd977ede4a07096', '2015-03-16 20:51:00', 1, 'YYd?¯“Ó”–gßßj\n„‹ª×z$c)Éã}ªÙl'),
(2, 'Samuel', 'Arseneault', 'SArseneault', 'b58f46ca11263fca5f891d6d8b22617c01ae9e4c8528bab3ab6522062d97ce3c', '2015-03-16 20:51:15', 1, 'üO:yBSÇßK‡/´‘:_\r./Š~¤¸ÞÄ2');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE IF NOT EXISTS `teacher` (
`id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(64) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `joined` datetime NOT NULL,
  `group` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `name`, `username`, `password`, `salt`, `joined`, `group`) VALUES
(1, 'Sam Arseneault', 'Sam', '3b4ca4c4d472881ba083d37a932de5082d9895114e9066354fca77070f405944', 'Ý0äØÁ[ÈÙÎ¼ì[íºB]yÏØ_ÉÀ6WV', '2015-03-16 20:50:24', 0);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_session`
--

CREATE TABLE IF NOT EXISTS `teacher_session` (
`id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `hash` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher_session`
--

INSERT INTO `teacher_session` (`id`, `teacher_id`, `hash`) VALUES
(1, 1, 'cb0f3c2e474c98270d16bda76f71d3f7de6bcbca06bb1208bb');

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
MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `level`
--
ALTER TABLE `level`
MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `level_progress`
--
ALTER TABLE `level_progress`
MODIFY `levelprog_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `question_progress`
--
ALTER TABLE `question_progress`
MODIFY `questionprog_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `teacher_session`
--
ALTER TABLE `teacher_session`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
