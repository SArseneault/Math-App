<?php 
  require_once 'core/init.php';
	

	$sclass = new SClass();//Picking current user details

	//Calling the delete class
	$sclass->deleteClass( $_POST['classid'] );

	
	//Returning result to javascript
	echo 'This class has been successfully removed!';

?>