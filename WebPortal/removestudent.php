<?php 
  require_once 'core/init.php';
	

	$student = new Student();//Picking current user details

	//Calling the remove student
	$student->removeStudent( $_POST['studentid'] );

	
	//Returning result to javascript
	echo 'This student has been successfully removed!';

?>