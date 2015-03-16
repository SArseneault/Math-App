<?php
	
	//Connecting to database
	require_once 'core/init.php';

	//Ensure we are outputting a text javascript page
	header('Content-type: text/javascript');


	//Creating a jason array
	$json = array();

			
	//Creating a database object
	$db = DB::getInstance();
	
	$username = "LRabe";
	//Find user by its id
	
	$field = (is_numeric($username)) ? 'id' : 'username';
	$data = $db->get('student', array($field, '=', $username));


	if($data->count()) {
		//$this->_data = $data->first();

		//pushing user and password to the json array
		array_push($json, $username );
		
	
	}
	


	//Printing the encoded json dictionary
	//echo json_encode($json);


?>
{
    "kmark21":[
               {
               "levelName":"Level1",
               "timelimit": "5",
               "practicequestionCount":"15",
               "testquestionCount":"20"
               },
               {
               "levelName":"Level2",
               "timelimit": "5",
               "practicequestionCount":"15",
               "testquestionCount":"20"
               
               }
               
     ]
}