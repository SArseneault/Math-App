<?php 
  require_once 'core/init.php';
	

	$user = new User();//Picking current user details

	//Calling the remove level function
	$user->removeLevel( $_POST['levelid'] );

	
	//Returning result to javascript
	echo 'Level has been removed';

?>