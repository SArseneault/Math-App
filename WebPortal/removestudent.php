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

	$student = new Student();//Picking current user details

	//Calling the remove student
	$student->removeStudent( $_POST['studentid'] );

	
	//Returning result to javascript
	echo 'This student has been successfully removed!';

?>