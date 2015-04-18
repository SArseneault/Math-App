<?php 
  require_once 'core/init.php';
	

	$user = new User();//Picking current user details

	  //Redirect the user if they are not logged in.
	  if(!$user->isLoggedIn()) {
	      Redirect::to("includes/errors/loginerror.php");
	  }
	  if(!Session::exists(Config::get('teachersession/session_name'))) {

	      Redirect::to("includes/errors/sessionexpired.php");

	  }

	//Calling the remove level function
	$user->removeLevel( $_POST['levelid'] );

	
	//Returning result to javascript
	echo 'Level has been removed';

?>