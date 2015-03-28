<?php 
  require_once 'core/init.php';
	

	$user = new User();//Picking current user details

	//Calling the remove all level function
	$user->removeAllLevels($_POST['classid']);

	
	//Returning result to javascript
	echo 'All levels have been removed';

?>