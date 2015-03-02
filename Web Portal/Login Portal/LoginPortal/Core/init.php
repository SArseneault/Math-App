<?php

	//Allow people to login
	session_start();

	//Global array
	$GLOBALS['config'] = array(
		'mysql' => array(
			'host' => '127.0.0.1',
			'username' => 'root',
			'password' => '',
			'db' => 'mathappinfo'
		),
		'remember' => array(
			'cookie_name' => 'hash',
			'cookie_expiry' => 604800 //604800 == months in seconds
		),
		'session' => array(
			'session_name' => 'user',
			'token_name' => 'token'
		)
	);

	//Auto load parse in functions. spl = standard php lib
	//Only requiring classes as we need them
	spl_autoload_register(function($class) {
		require_once 'classes/' . $class . '.php';
	});

	
	require_once 'functions/sanitize.php';
?>