<?php
	
	require_once 'core/init.php';
	
	//Setting db to an instance of the database singleton 
	$db = DB::getInstance();


	//Grabbing Variables from the link
	$username = $_GET["username"];
	$classname =  $_GET["class"];
	$level = $_GET["level"];
	$status = $_GET["status"];
	$elapsed_time = $_GET["elapsed_time"];
	$attempts = $_GET["attempts"];



	//Grabbing the class data
	$classData = $db->get('class', array("class_name", '=', $classname));
	$classData = $classData->first();
	$classData = get_object_vars($classData);
	$classID = $classData['class_id']; //Setting the class id

	//Grabbing the student data
	$studentData = $db->query('SELECT * FROM student WHERE class_id = ? AND username = ?', array(
				$classID,
				$username
				));
	$studentData = $studentData->first();
	$studentData = get_object_vars($studentData);
	$studentID = $studentData['student_id']; //Setting the student id	
	
	//Grabbing the level data
	$levelData = $db->query('SELECT * FROM level WHERE class_id = ? AND name = ?', array(
				$classID,
				$level
				));

	$levelData = $levelData->first();
	$levelData = get_object_vars($levelData);
	$levelID = $levelData['level_id']; //Setting the level id

	//Grabbing the level progress data
	$levelProgData = $db->query('SELECT * FROM level_progress WHERE student_id = ? AND level_id = ?', array(
				$studentID,
				$levelID
				));
	$levelProgData = $levelProgData->first();
	$levelProgData = get_object_vars($levelProgData);
	$levelProgID = $levelProgData['levelprog_id']; //Setting the level progress id


	//Creating a fields array
	$fields = array(
		'status' =>  $status,
		'elapsed_time' => $elapsed_time,
		'attempts' => $attempts
		);


	//updating the level progress table with the passed info. If it works it echos 1, else it echos 0
	if($db->update('level_progress', $levelProgID, 'levelprog_id', $fields)) 
		echo "1";
	else
		echo "0";





			
?>