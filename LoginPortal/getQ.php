<?php
	
	//Connecting to database
	require_once 'core/init.php';

	//Ensure we are outputting a text javascript page
	//header('Content-type: text/javascript');

			
	//Creating a database object
	$db = DB::getInstance();
	

	//Grabbing Variables from the link
	$classID =  $_POST["classid"];
	$levelID = $_POST["levelid"];

	//Creating a jason array
	$json = array();



	//Grabbing the question data
	$questiondata = $db->query('SELECT * FROM question WHERE level_id = ? AND class_id = ?', array(
		$levelID,
		$classID
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
		$json[$i]["questionName"] = $question['name'];
		$json[$i]["description"] = $question['description'];
		$json[$i]["operand1"] = $question['operand1'];
		$json[$i]["operand2"] = $question['operand2'];
		$json[$i]["operator"] = $question['operator'];
		$json[$i]["frequency"] = $question['freq'];
		$json[$i]["questiontype"] = $question['question_type'];
		$i++;
	}

	//Printing the encoded json dictionary
	echo json_encode($json);


?>
