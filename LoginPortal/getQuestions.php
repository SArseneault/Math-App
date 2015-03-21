<?php
	
	//Connecting to database
	require_once 'core/init.php';

	//Ensure we are outputting a text javascript page
	//header('Content-type: text/javascript');

			
	//Creating a database object
	$db = DB::getInstance();
	

	//Grabbing Variables from the link
	$classID =  $_GET["classid"];
	$level = $_GET["level"];
	$questiontype = $_GET["questiontype"];

	//Creating a jason array
	$json = array();


	//Grab the level data
	$leveldata = $db->query('SELECT * FROM level WHERE name = ? AND class_id = ?', array(
							$level,
							$classID
						));
	$leveldata = $leveldata->first();
	$leveldata = get_object_vars($leveldata);
	$levelID = $leveldata['level_id']; //Setting the level id	
	

	//Grabbing the question data
	$questiondata = $db->query('SELECT * FROM question WHERE level_id = ? AND class_id = ? AND question_type = ?', array(
								$levelID,
								$classID,
								$questiontype
							));

	$questiondata = $questiondata->results();
	//Creating a loop counter variable
	$i = 0;

	//Looping through each level
	foreach($questiondata as $question)
	{

		//Converting the level std object into an array
		$question = get_object_vars($question);

		//Pushing the level name and time onto the array
		$json[$i]["questionID"] = $question['question_id'];
		$json[$i]["operand1"] = $question['operand1'];
		$json[$i]["operand2"] = $question['operand2'];
		$json[$i]["operator"] = $question['operator'];
		$json[$i]["frequency"] = $question['freq'];

		$i++;
	}

	//Printing the encoded json dictionary
	echo json_encode($json);


?>
