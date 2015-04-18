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

	

	$sclass = new SClass();//Creating a class object

	//Calling the delete class
	$sclass->deleteClass( $_POST['classid'] );

	
	//Returning result to javascript
	echo 'This class has been successfully removed!';

?>