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

	//Calling the remove all level function
	$user->removeAllLevels($_POST['classid']);

	
	//Returning result to javascript
	echo 'All levels have been removed';

?>