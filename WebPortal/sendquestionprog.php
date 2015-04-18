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

			
?>