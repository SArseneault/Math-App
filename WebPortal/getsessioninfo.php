<?php
	
	//Connecting to database
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
			

	//Ensure we are outputting a text javascript page
	header('Content-type: text/javascript');

			
	//Creating a database object
	$db = DB::getInstance();
	

	//Grabbing Variables from the link
	$username = $_GET["username"];
	$classname =  $_GET["classname"];


	//Grabbing the class data
	$classData = $db->get('class', array("class_name", '=', $classname));
	$classData = $classData->first();
	$classData = get_object_vars($classData);
	$classID = $classData['class_id']; //Setting the class id
	
	//Grabbing the student data
	$studentData = $db->query('SELECT * FROM student WHERE class_id = ? AND username = ?', array(
								$classID,
								$username
							  ));
	$studentData = $studentData->first();
	$studentData = get_object_vars($studentData);
	$studentID = $studentData['student_id']; //Setting the student id	


	//Creating a json array
	$json = array();

	//Storing the class id and student name
	$json[0]["class_id"] = $classID;
	$json[1]["student_id"] = $studentID;
	$json[2]["studentName"] = $studentData['first_name'] . " ". $studentData['last_name'];

	//Printing the encoded json dictionary
	echo json_encode($json);

?>
