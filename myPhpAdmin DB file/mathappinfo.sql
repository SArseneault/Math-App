-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 22, 2015 at 02:21 AM
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`class_id`, `class_name`, `teacher_name`, `salt`, `class_password`, `teacher_id`) VALUES
(9, 'Sam''s Class', 'Mr. Sam', '°é‚å«§ÀL?ˆbwŒöÞÛQº­\0D=!kSÃ', 'fc4f532a579c2680802f71226c1bfe99dc35167cb43bd2a0f8924697a1098137', 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`level_id`, `name`, `description`, `time_limit`, `class_id`) VALUES
(3, 'Level 1', 'Level 1', 5, 9),
(4, 'Level 2', 'L2', 3, 9),
(5, 'Level 3', 'L3', 6, 9);

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
  `test_attempts` int(2) NOT NULL,
  `practice_attempts` int(2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `level_progress`
--

INSERT INTO `level_progress` (`levelprog_id`, `student_id`, `level_id`, `status`, `elapsed_time`, `test_attempts`, `practice_attempts`) VALUES
(3, 1, 3, 0, '00:00:00', 0, 0),
(4, 1, 4, 0, '00:00:00', 0, 0),
(5, 1, 5, 0, '00:00:00', 0, 0);

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
  `freq` int(2) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`question_id`, `name`, `level_id`, `description`, `operand1`, `operand2`, `operator`, `question_type`, `freq`, `class_id`) VALUES
(12, 'Q1L1', 3, 'qww', 1, 1, '/', 1, 2, 9),
(13, '23423', 3, '234234', 2, 4, '*', 0, 2, 9),
(14, '234234', 3, '234234', 4, 2, '/', 0, 2, 9),
(15, '234234', 3, '234234', 3, 2, '-', 0, 1, 9);

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
  `attempts` int(2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question_progress`
--

INSERT INTO `question_progress` (`questionprog_id`, `question_id`, `level_id`, `answer`, `student_id`, `attempts`) VALUES
(1, 1, 1, -1, 1, 0),
(2, 2, 2, -1, 1, 0),
(3, 3, 1, -1, 1, 0),
(4, 4, 1, -1, 1, 0),
(5, 5, 1, -1, 1, 0),
(6, 6, 1, -1, 1, 0),
(7, 7, 1, -1, 1, 0),
(12, 12, 3, -1, 1, 0),
(13, 13, 3, -1, 1, 0),
(14, 14, 3, -1, 1, 0),
(15, 14, 3, -1, 1, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `first_name`, `last_name`, `username`, `password`, `joined`, `class_id`, `salt`) VALUES
(1, 'Samuel', 'Arseneault', 'SArseneault', '209175abc4eec87b14eeede2092908300930c6fb03f46eaf7284ec3f6c1608e8', '2015-03-21 16:48:17', 9, 'Ì@Œ}ª—–äY¾ãÇÐ³—Ã.O»ÑÆ|išJ€§Ê');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `name`, `username`, `password`, `salt`, `joined`, `group`) VALUES
(1, 'Samuel Arseneault', 'Sam', '76b4e6153ce434eb0f93f9aaaf5031d30fb0dd870d91a59742e9c99f7500337d', '½âv>_1å@ûî­ŸÏøŸ òMÉ×¬Ü#˜S‰®ð4', '2015-03-20 05:34:48', 0),
(2, 'Test Teacher', 'Test', '81183069c879c1633fa86ebbb0e2d9c4af41fed71a3a83e4445c33c2bc33ee4c', 'ë5´W²,“÷?írŸÌbwjò^9I9±Td"¯¨n”', '2015-03-20 05:40:23', 0);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_session`
--

CREATE TABLE IF NOT EXISTS `teacher_session` (
`id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `hash` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `level`
--
ALTER TABLE `level`
MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `level_progress`
--
ALTER TABLE `level_progress`
MODIFY `levelprog_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `question_progress`
--
ALTER TABLE `question_progress`
MODIFY `questionprog_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `teacher_session`
--
ALTER TABLE `teacher_session`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
