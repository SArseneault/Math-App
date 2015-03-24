<?php
	
	require_once 'core/init.php';
	
	//Setting db to an instance of the database singleton 
	$db = DB::getInstance();


	//Grabbing Variables from the link
	$studentID = $_GET["studentid"];
	$classID =  $_GET["classid"];
	$level = $_GET["level"];
	$status = $_GET["status"];
	$elapsed_time = $_GET["elapsed_time"];
	$level_type = $_GET["level_type"];
	


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
		'status' =>  $status
		);


	//Determine whether to increment the prac or the test attempt
	if($level_type === "0")
		$fields["practice_attempts"] = $levelProgData['practice_attempts']+1;
	else if($level_type === "1")
	{
		$fields["test_attempts"] = $levelProgData['test_attempts']+1;
		$fields['elapsed_time'] = $elapsed_time;
	}



	//updating the level progress table with the passed info. If it works it echos 1, else it echos 0
	if($db->update('level_progress', $levelProgID, 'levelprog_id', $fields)) 
		echo "1";
	else
		echo "0";




			
?>