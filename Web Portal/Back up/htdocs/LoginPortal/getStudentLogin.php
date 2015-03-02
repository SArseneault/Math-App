<?php
	
	//Connecting to database
	require_once 'core/init.php';

	//Ensure we are outputting a text javascript page
	header('Content-type: text/javascript');


	//Creating a jason array
	$json = array(
		''=> ''
	);

			
	//Creating a database object
	$db = DB::getInstance();
	
	$username = "Sam";
	//Find user by its id
	
	$field = (is_numeric($username)) ? 'id' : 'username';
	$data = $db->get('teacher', array($field, '=', $username));
	if($data->count()) {
		//$this->_data = $data->first();

		//pushing user and password to the json array
		array_push($json, $username, );
		
		echo "</br>They Exist";
	}
	


	//Printing the encoded jason dictionary
	echo json_encode($json);