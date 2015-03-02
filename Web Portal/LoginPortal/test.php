<?php
	
	require_once 'core/init.php';
	
	//Grabbing Variables from the link
	$username = $_GET["userName"];
	$password = $_GET["password"];

	//Creating a user object and calling the login function
	$user = new User();
	$login = $user->login($username, $password);
	
	//If the login was successful return 1			
	if($login) {
		echo "1";
		return 1;
	} else {
		echo "0";
		return 0;
	}

?>