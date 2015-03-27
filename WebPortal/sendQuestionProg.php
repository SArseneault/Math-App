<?php
	
	require_once 'core/init.php';
	
	//Setting db to an instance of the database singleton 
	$db = DB::getInstance();


	//Grabbing Variables from the link
	$studentID = $_GET["studentid"];
	$classID =  $_GET["classid"];
	$level = $_GET["level"];
	$question = $_GET["question"];

	$answer = $_GET["answer"];
	$attempts = $_GET["attempts"];
	


	//Grabbing the level data
	$levelData = $db->query('SELECT * FROM level WHERE class_id = ? AND name = ?', array(
				$classID,
				$level
				));

	$levelData = $levelData->first();
	$levelData = get_object_vars($levelData);
	$levelID = $levelData['level_id']; //Setting the level id

	//Grabbing the question data
	$questionData = $db->query('SELECT * FROM question WHERE class_id = ? AND level_id = ? AND name = ?', array(
				$classID,
				$levelID,
				$question
				));
	$questionData = $questionData->first();
	$questionData = get_object_vars($questionData);
	$questionID = $questionData['question_id']; //Setting the question id

	//Grabbing the question progress data
	$questionProgData = $db->query('SELECT * FROM question_progress WHERE student_id = ? AND level_id = ? AND question_id = ?', array(
				$studentID,
				$levelID,
				$questionID
				));
	$questionProgData = $questionProgData->first();
	$questionProgData = get_object_vars($questionProgData);
	$questionProgID = $questionProgData['questionprog_id']; //Setting the question progress id


	//Creating a fields array
	$fields = array(
		'answer' =>  $answer,
		'attempts' => $attempts
		);


	//updating the question progress table with the passed info. If it works it echos 1, else it echos 0
	if($db->update('question_progress', $questionProgID, 'questionprog_id', $fields)) 
		echo "1";
	else
		echo "0";





			
?>