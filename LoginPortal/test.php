<?php
	
	require_once 'core/init.php';
	
	//Setting db to an instance of the database singleton 
	$db = DB::getInstance();


	$jsonString = file_get_contents('php://input');
	$jsonArray = json_decode($json_string, true);

	print_r($jsonArray);



?>