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

	

	$student = new Student();//Creating a student ovject

	//Calling the delete class
	$student->clearStudentProg($_POST['classid']);

	
	//Returning result to javascript
	echo 'This student level progress has successfully been cleared!';

?>