<?php

    ini_set('display_errors', 1);

	//Allow people to login
	session_start();

	//Global array
	$GLOBALS['config'] = array(
		'mysql' => array(
			'host' => 'localhost',
			'username' => 'root',
			'password' => '',
			'db' => 'mathappinfo'
		),
		'remember' => array(
			'cookie_name' => 'hash',
			'cookie_expiry' => 604800 //604800 1 week in seconds
		),
		'teachersession' => array(
			'session_name' => 'teacher',
			'token_name' => 'token'
		),
		'studentsession' => array(
			'session_name' => 'student',
			'token_name' => 'token'
		)
	);

	//Auto load parse in functions. spl = standard php lib
	//Only requiring classes as we need them
	spl_autoload_register(function($class) {
		require_once 'classes/' . $class . '.php';
	});

	
	require_once 'functions/sanitize.php';


	if(Cookie::exists(Config::get('remember/cookie_name')) && !Session::exists(Config::get('teachersession/session_name'))) {
		$hash = Cookie::get(Config::get('remember/cookie_name'));
		$hashCheck = DB::getInstance()->get('teacher_session', array('hash', '=', $hash));

		if($hashCheck->count()) {
			$user = new User($hashCheck->first()->teacher_id);
			$user->login();
		}




	if(Cookie::exists(Config::get('remember/cookie_name')) && !Session::exists(Config::get('studentsession/session_name'))) {
		$hash = Cookie::get(Config::get('remember/cookie_name'));
		$hashCheck = DB::getInstance()->get('student_session', array('hash', '=', $hash));

		if($hashCheck->count()) {
			$student = new User($hashCheck->first()->student_id);
			$student->login();
		}

	}

	}


