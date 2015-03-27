<?php 
  require_once 'core/init.php';
	

	$student = new Student();//Creating a student ovject

	//Calling the delete class
	$student->clearStudentProg($_POST['classid']);

	
	//Returning result to javascript
	echo 'This student level progress has successfully been cleared!';

?>