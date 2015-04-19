<?php
	require_once 'core/init.php';

	$token = $_GET["token"];
	if(Token::check(Input::get('token'))) {
		echo "1";
	} else {
		//Sends a new token to the iOS Application
		echo (studentToken::generate());
	}

?>