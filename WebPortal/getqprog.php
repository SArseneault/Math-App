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

		//Grab the question prog data
		$questionProgData = $db->get('question_progress', array('question_id', '=', $question['question_id']));
		//$questionProgData = $db->query('SELECT * FROM question_progress WHERE question_id = ? AND attempts > 0', array($question['question_id']));
		if($questionProgData->count())
		{
			$questionProgData = $questionProgData->first();
			$questionProgData = get_object_vars($questionProgData);
		

			if( ($questionProgData['attempts'] > 0) && ($questionProgData['answer'] != -1) )
			{
				//Pushing the level name and time onto the array
				$json[$i]["operand1"] = $question['operand1'];
				$json[$i]["operator"] = $question['operator'];
				$json[$i]["operand2"] = $question['operand2'];
				$json[$i]["studentAnswer"] = $questionProgData['answer'];
				$json[$i]["attempts"] = $questionProgData['attempts'];
				$i++;
			}
		}
	}

	//Printing the encoded json dictionary
	echo json_encode($json);


?>

