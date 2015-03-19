<?php 
  require_once 'core/init.php';
	

	$user = new User();//Picking current user details

	//Calling the remove question function
	$user->removeQuestion( $_POST['questionid'] );

	
	//Returning result to javascript
	echo 'Question has been removed';

?>