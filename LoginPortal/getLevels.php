<?php
	
	//Connecting to database
	require_once 'core/init.php';

	//Ensure we are outputting a text javascript page
	header('Content-type: text/javascript');

			
	//Creating a database object
	$db = DB::getInstance();
	

	//Grabbing Variables from the link
	$username = $_GET["username"];
	$studentID = $_GET["studentid"];
	$classID =  $_GET["classid"];

	//Creating a jason array
	$json = array();


	//Grabbing the level data
	$leveldata = $db->get('level', array('class_id', '=', $classID));

	//Grabbing std object from database object
	$leveldata = $leveldata->results();

	//Creating a loop counter variable
	$i = 1;
	$json[0]["username"] =  $username;
	//Looping through each level
	foreach($leveldata as $level)
	{

		//Converting the level std object into an array
		$level = get_object_vars($level);

		//Pushing the level name and time onto the array
		$json[$i]["levelName"] = $level['name'];
		$json[$i]["timeLimit"] = $level['time_limit'];

		//Grabbing the question data where the questions = the level id
		$questiondata = $db->get('question', array('level_id', '=', $level['level_id']));

		//Grabbing std object from database object
		$questiondata = $questiondata->results();

		//Creating variables to count practice and test
		$practiceCount = 0;
		$testCount = 0;

		//Looping through each question
		foreach($questiondata as $question)
		{
			//Converting the question std object into an array
			$question = get_object_vars($question);

			if($question['question_type'] == 0)
				$practiceCount++;
			elseif($question['question_type'] == 1)
				$testCount++;

		}

		$json[$i]["practicequestionCount"] = $practiceCount;
		$json[$i]["testquestionCount"] = $testCount;

		$i++;
		//print_r($questiondata);
	}

	//print_r($leveldata);

	
	//Printing the encoded json dictionary
	echo json_encode($json);


?>
