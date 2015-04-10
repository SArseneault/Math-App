<?php
	
	require_once 'core/init.php';
	
	//Grabbing Variables from the link
	$classname = $_GET["userName"];
	$password = $_GET["password"];


	//Creating a class object and calling the login function
	$sclass = new SClass();
	$login = $sclass->login($classname, $password);
	
	//If the login was successful return 1			
	if($login) {
		echo "1";
		//return 1;
	} else {
		echo "0";
		//return 0;
	}

?>