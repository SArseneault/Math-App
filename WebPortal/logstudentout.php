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

	//Creating a student object and calling the login function
	$Student = new Student();
	$Student->logout();



?>