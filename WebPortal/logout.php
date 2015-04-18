<?php
	require_once 'core/init.php';

	$user = new User();
	  //Redirect the user if they are not logged in.
	  if(!$user->isLoggedIn()) {
	      Redirect::to("includes/errors/loginerror.php");
	  }
	  if(!Session::exists(Config::get('teachersession/session_name'))) {

	      Redirect::to("includes/errors/sessionexpired.php");

	  }

	$user->logout();

	Redirect::to('login.php');