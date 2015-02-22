<?php
	require_once 'core/init.php';

	//echo Config::get('mysql/host'); //127.0.0.1


	////////////////////////////////////////////    How to query from data base    ////////////////////////////////////////////

	/*$users = DB::getInstance()->query('SELECT username FROM teacher');
	$users = DB::getInstance()->get('users', array('username', '=', 'alex'));
	$users = DB::getInstance()->get('users', array('username', '>', '5'));
	if($users->count()){
		foreach($users as $user){
			echo $user->username;
		}
	}*/

	//b = new DB();
	/*DB::getInstance()->query('Select username FROM teachers WHERE username = "?' or username = "?", array(
		'alex',
		'billy',
		)*/

	//$user = DB::getInstance()->query( "SELECT username FROM teacher WHERE username = ?", array('alex') );
	//$user = DB::getInstance()->get('teacher', array('username', '=', 'alex'));
	
	/*
	//Grab all the users from the DB
	$user = DB::getInstance()->query( "SELECT * FROM teacher");

	if(!$user->count()) {
		echo '</br>No User';
	} else {
		//Looping through each user
		foreach($user->results() as $user) {
			echo $user->username, "</br>";
		}

		//Grabing just one user 
		echo $user->first()->username;
	}
	*/

	////////////////////////////////////////////    How to inset into data base    ////////////////////////////////////////////
	/*
	$userInsert = DB::getInstance()->insert('teacher', array(
		'username' => 'Dale',
		'password' => 'dPass',
		'salt' => 'salt'
	));

	if($userInsert) {
		//Success
	}
	*/

	////////////////////////////////////////////    How to update data base    ////////////////////////////////////////////
	$userInsert = DB::getInstance()->update('teacher', 21, array(
		'password' => 'newPass',
		'name' => 'Mike V'
	));

?>