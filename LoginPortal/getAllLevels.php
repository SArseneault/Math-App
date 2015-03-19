<?php
	
	//Connecting to database
	require_once 'core/init.php';

	//Ensure we are outputting a text javascript page
	header('Content-type: text/javascript');

			
	//Creating a database object
	$db = DB::getInstance();
	

	//Grabbing Variables from the link
	$classID =  $_GET["classid"];

	//Creating a jason array
	$json = array();


	//Grabbing the level data
	$leveldata = $db->get('level', array('class_id', '=', $classID));

	//Grabbing std object from database object
	$leveldata = $leveldata->results();

	//Creating a loop counter variable
	$i = 1;
	//Looping through each level
	foreach($leveldata as $level)
	{

		//Converting the level std object into an array
		$level = get_object_vars($level);

		//Pushing the level name and time onto the array
		$json[$i]["levelName"] = $level['name'];
		$json[$i]["levelID"] = $level['level_id'];

		$i++;
		
	}


	
	//Printing the encoded json dictionary
	echo json_encode($json);


?>
