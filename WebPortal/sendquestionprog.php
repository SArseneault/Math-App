<?php
	
	require_once 'core/init.php';
	
	//Setting db to an instance of the database singleton 
	$db = DB::getInstance();

	//Grabing the post array
	$handle = fopen("php://input", "rb");
	$http_raw_post_data = '';
	while (!feof($handle)) {
	    $http_raw_post_data .= fread($handle, 8192);
	}
	fclose($handle);

	//Converting the json string array to an array
	$questionProgData = json_decode($http_raw_post_data,true);

	$questionProgData = $questionProgData[0];
	//print_r($questionProgData);

	//Creating a fields array
	$fields = array();


 

	

	
	//Looping through each progress and inserting it into the database
	foreach($questionProgData as $questionProg)
	{

		//Grabbing the current question data
	    $Questiondata = $db->get('question_progress', array('question_id', '=', $questionProg['QuestionID']));
	    if($Questiondata->count()) {

	      $Questiondata = $Questiondata->first();
	      $Questiondata = get_object_vars($Questiondata);
	      
	    } else {
	      return 0;
	    }

	
		$fields['answer'] = $questionProg['User Answer'];
		$fields['attempts'] = $Questiondata['attempts'] + 1;
		//updating the question progress table with the passed info. If it works it echos 1, else it echos 0
		if($db->update('question_progress', $questionProg['QuestionID'], 'question_id', $fields)) 
			echo "1";
		else
			echo "0";
	}


/*
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

*/



			
?>