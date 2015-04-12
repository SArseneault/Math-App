<?php
	
	//Connecting to database
	require_once 'core/init.php';

	//Ensure we are outputting a text javascript page
	//header('Content-type: text/javascript');

			
	//Creating a database object
	$db = DB::getInstance();
	

	//Grabbing Variables from the link
	$studentID = $_POST["studentid"];
	$classID =  $_POST["classid"];
	
	//Creating a jason array
	$json = array();

	//Grabbing the level and level prog data
	$leveldata = $db->query("SELECT * FROM level WHERE class_id = {$classID}");
	//UNION SELECT * FROM level_progress WHERE studentid = {$studentID}");

	$leveldata = $leveldata->results();

	

	//Creating a loop counter variable
	$i = 0;

	foreach($leveldata as $level)
	{
		$level = get_object_vars($level);

		//Grab the level prog data
		$levelProgData = $db->query("SELECT * FROM level_progress WHERE level_id= {$level['level_id']} AND student_id = {$studentID}");

		//Only if the progress exists
		if($levelProgData->count())
		{

			$levelProgData = $levelProgData->first();
			$levelProgData = get_object_vars($levelProgData);

			//Converting time to show minutes only
			$str_time = $levelProgData['test_time'];
			$str_time = preg_replace("/^([\d]{1,2})\:([\d]{2})$/", "00:$1:$2", $str_time);
			sscanf($str_time, "%d:%d:%d", $hours, $minutes, $seconds);
			$time_minute = $hours * 60 + $minutes;

			//Pushing the level information onto the array
			$json[$i]["levelName"] = $level['name'];
			$json[$i]["testTime"] = $time_minute;
			$json[$i]["testAttempts"] = $levelProgData['test_attempts'];

			//Moving onto next json object
			$i++;

		}
	}

	//Printing the encoded json dictionary
	echo json_encode($json);


?>

