<?php
	
	require_once 'core/init.php';

	$studentOBJ = new Student(); //Creating a student object
	 //Redirect the user if they are not logged in.
	 if(!$studentOBJ->isLoggedIn()) {
	     Redirect::to("includes/errors/loginerror.php");
	     return -1;
	 }
	 if(!Session::exists(Config::get('studentsession/session_name'))) {

	     Redirect::to("includes/errors/sessionexpired.php");
	     return -1;

	 }
			

	//Setting db to an instance of the database singleton 
	$db = DB::getInstance();

	//Grabbing Variables from the link
	$studentID = $_GET["studentid"];
	$classID =  $_GET["classid"];
	$levelID = $_GET["level"];
	$status = $_GET["status"];
	$test_time = $_GET["test_time"];
	$practice_time = $_GET["practice_time"];
	$level_type = $_GET["level_type"];
	
	//Converting seconds to minutes
	if( ($test_time > 59) ) 
	{
		$test_time = ($test_time/60)*100;
	}

		//Converting seconds to minutes
	if( ($practice_time > 59) ) 
	{
		$practice_time = ($practice_time/60)*100;
	}

	
	//Grabbing the level progress data
	$levelProgData = $db->query('SELECT * FROM level_progress WHERE student_id = ? AND level_id = ?', array(
				$studentID,
				$levelID
				));
	
	$levelProgData = $levelProgData->first();
	$levelProgData = get_object_vars($levelProgData);
	$levelProgID = $levelProgData['levelprog_id']; //Setting the level progress id


	//Creating a fields array
	$fields = array();


	//Determine whether to increment the prac or the test attempt
	if($level_type === "0")
	{
		$fields["practice_attempts"] = $levelProgData['practice_attempts']+1;
		$fields['practice_time'] = $practice_time;
	}
	else if($level_type === "1")
	{
		$fields["test_attempts"] = $levelProgData['test_attempts']+1;
		$fields['test_time'] = $test_time;

		//Only up date the status if its at zero
		if($levelProgData['status'] == 0)
			$fields['status'] =  $status;
	}



	//updating the level progress table with the passed info. If it works it echos 1, else it echos 0
	if($db->update('level_progress', $levelProgID, 'levelprog_id', $fields)) 
		echo "1";
	else
		echo "0";




			
?>