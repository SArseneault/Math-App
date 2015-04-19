<?php
	
	require_once 'core/init.php';
	

	//Grabbing Variables from the link
	$username = $_GET["userName"];
	$password = $_GET["password"];


	//Creating a student object and calling the login function
	$Student = new Student();
	$login = $Student->login($username, $password);
	
	//If the login was successful return 1			
	if($login) {
		echo "1";
		return 1;
	} else {
		echo "0";
		return 0;
	}


?>