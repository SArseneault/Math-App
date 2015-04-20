<?php 
  
  //Including needed files
  require_once 'core/init.php';

  $user = new User();//Picking current user details
  $student = new Student(); //Creating a student object
  $db = DB::getInstance();

  //Redirect the user if they are not logged in.
  if(!$user->isLoggedIn()) {
      Redirect::to("includes/errors/loginerror.php");
  }
  if(!Session::exists(Config::get('teachersession/session_name'))) {

      Redirect::to("includes/errors/sessionexpired.php");

  }


  //Creating and setting the classInfo and students variables
  if($user->classExist()){
    $classInfo = $user->getClass();
    $students = $student->getStudents($classInfo['class_id']);

    $levels = $user->getLevels();

  } else {
    $classInfo = null;
    $levels = null;
    
  }

  //For default defaults
  $name = 'defaults/defaultinfo.csv'; 

  $handle = fopen($name, "r");

  //Uploading the level info
  while(($fileop = fgetcsv($handle,1000,",")) !== false)
  {
   
	     //Skip over headers
       if($fileop[0] === "Level Name:" AND $fileop[1] === "Question Name:" AND $fileop[2] === "Operand1:"){
        break;
       } else if($fileop[0] === "Level Name:" AND $fileop[1] === "Time Limit:"){
        continue;
       }

	  //Variable to store failures
	   $failure = false;

	  //Checking if the level count is 42 or below
	  $levelCount = $db->query('SELECT * FROM level WHERE class_id = ?', array($classInfo['class_id']));
	  if($levelCount->count() > 42){
	     print_r($fileop[0] . " was NOT added. There can't be more than 42 levels<br>");
	      $failure = true;
	    }


	  //Checking if the level name exists in the database already with the same class
	  $nameCheck = $db->query('SELECT * FROM level WHERE name = ?  AND class_id = ?', array(
	          $fileop[0],
	          $classInfo['class_id']
	        ));
	  if($nameCheck->count()) {
	       print_r($fileop[0] . " already exsits in the class <br>");
	      $failure = true;
	  } 



	  if(!$failure){

   
	    //Inserting the new levelinto the database
	    $user->addLevel(array( 
	      'name' => $fileop[0],
	      'time_limit' => $fileop[1],
	      'class_id' => $classInfo['class_id']
	      ));


	  }

  }


  //Uploading question info
  while(($fileop = fgetcsv($handle,1000,",")) !== false)
  {

   //Grabbing level info which the question is linked to
    $levelInfo = $db->query('SELECT * FROM level WHERE name = ? AND class_id = ?', array(
      $fileop[0],
      $classInfo['class_id']
      ));
    $levelInfo = $levelInfo->first();
    $levelInfo = get_object_vars($levelInfo);

    //Setting the level id
    $levelID = $levelInfo['level_id']; 


   //Inserting the new levelinto the database
    $user->addQuestion(array(
      'name' => $fileop[1],
      'operand1' => $fileop[2],
      'operator' => $fileop[3],
      'operand2' => $fileop[4],
      'question_type' => $fileop[5],
      'freq' => $fileop[6],
      'level_id' => $levelID,
      'class_id' => $classInfo['class_id']
      ));


  }
  echo "Successfully uploaded level and question information"     

  
  ?>