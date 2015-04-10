<?php 
  require_once 'core/init.php';

  $db = DB::getInstance();

  $user = new User();//Picking current user details
  $student = new Student(); //Creating a student object

  //Redirect the user if they are not logged in.
  if(!$user->isLoggedIn()) {
      Redirect::to("includes/errors/loginerror.php");
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

  //For importing
  if(isset($_POST['import1']))
  {
    if($classInfo){
      $name       = $_FILES['file']['name'];  
      $temp_name  = $_FILES['file']['tmp_name'];  
      if(isset($name)){
          if(!empty($name)){      
              $location = 'uploads/';      
              if(move_uploaded_file($temp_name, $location.$name)){


                  //echo 'uploaded';
              }
              $handle = fopen($location.$name, "r");

             //Creating an string to store all the error info
              $errorString = "</br>";
              $failure = false;

              //Uploading the level info
              while(($fileop = fgetcsv($handle,1000,",")) !== false)
              {
               
                 if($fileop[0] === "NEXT" AND $fileop[1] === "NEXT" AND $fileop[2] === "NEXT"){
                  break;
                 }

                //Variable to store failures
                 
      
                //Checking if the level count is 42 or below
                $levelCount = $db->query('SELECT * FROM level WHERE class_id = ?', array($classInfo['class_id']));
                if($levelCount->count() > 42){
                    $errorString = $errorString . $fileop[0] . " was NOT added. There can't be more than 42 levels<br>";
                    $failure = true;
                  }


                //Checking if the level name exists in the database already with the same class
                $nameCheck = $db->query('SELECT * FROM level WHERE name = ?  AND class_id = ?', array(
                        $fileop[0],
                        $classInfo['class_id']
                      ));
                
                if($nameCheck->count()) {
                     $errorString = $errorString . $fileop[0] . " already exsits in the class <br>";
                   

                    $failure = true;
                } 

              

                if(!$failure){

                  //Inserting the new levelinto the database
                  $user->addLevel(array( 
                    'name' => $fileop[0],
                    'description' => $fileop[1],
                    'time_limit' => $fileop[2],
                    'class_id' => $classInfo['class_id']
                    ));
                }

            }




              //Uploading question info
              while(($fileop = fgetcsv($handle,1000,",")) !== false)
              {

               //Grabbing level info which the question is linked to
                $levelInfo = $db->query('SELECT * FROM level WHERE name = ? AND description = ? AND class_id = ?', array(
                  $fileop[0],
                  $fileop[1],
                  $classInfo['class_id']
                  ));
                $levelInfo = $levelInfo->first();
                $levelInfo = get_object_vars($levelInfo);

                //Setting the level id
                $levelID = $levelInfo['level_id']; 

    
              //Inserting the new levelinto the database
              $user->addQuestion(array(
                'name' => $fileop[2],
                'description' => $fileop[3],
                'operand1' => $fileop[4],
                'operand2' => $fileop[5],
                'operator' => $fileop[6],
                'question_type' => $fileop[7],
                'freq' => $fileop[8],
                'level_id' => $levelID,
                'class_id' => $classInfo['class_id']
                ));


             


              }
               if($failure == true)
              {
                 ?> <div class="alert alert-warning">
                        <a href="login.php" class="close" data-dismiss="alert">&times;</a>
                        <strong>Warning!</strong> <?php print_r($errorString);?>
                    </div> <?php
              }
              ?> <div class="alert alert-success">
                <a href="login.php" class="close" data-dismiss="alert">&times;</a>
                <strong>Successfully uploaded level and question information</strong> 
              </div> <?php
          }       
      }  else {
          ?><div class="alert alert-danger">
                <a href="login.php" class="close" data-dismiss="alert">&times;</a>
                <strong>Error!</strong> Please upload file.
          </div> <?php
      }
    } else {
       ?><div class="alert alert-danger">
                <a href="login.php" class="close" data-dismiss="alert">&times;</a>
                <strong>Error!</strong> Please create a class before attempting to upload level and question information.
          </div> <?php
    }
  }


  //For exporting
  if(isset($_POST['export1']))
  {


    //Grabbing Variables from the link
    $classID =  $classInfo['class_id'];
     
    //Creating file with unique name
    $filename = 'uploads/exportInfo.csv';

    //Opening the file
    $fp = fopen($filename, "w");

    //Query database for level data
    $leveldata = $db->get('level', array('class_id', '=', $classID));
    $leveldata = $leveldata->results();

    //Query database for question data
    $questiondata = $db->get('question', array('class_id', '=', $classID));
    $questiondata = $questiondata->results();

    if($leveldata){

        //Looping through each level
        foreach($leveldata as $level){

              //Convert the std object to an array
              $level = get_object_vars($level);

              //Storing level info
              $row = $level['name'] . ",";
              $row = $row . $level['description'] . ",";
              $row = $row . $level['time_limit'];
             
              fputs($fp,$row);
              fputs($fp,"\n");   
        }

          //Creating divider
        $row = "NEXT,NEXT,NEXT";
        fputs($fp,$row);
        fputs($fp,"\n");

        //Looping through each level
        foreach($questiondata as $question){

              //Convert the std object to an array
              $question = get_object_vars($question);

              //Grab the level info where the level id of the question
              $levelInfo = $db->get('level', array('level_id', '=', $question['level_id']));
              $levelInfo = $levelInfo->first();
              $levelInfo = get_object_vars($levelInfo);
          
        
              //Storingthe level info for the question
              $row = $levelInfo['name'] . ",";
              $row = $row . $levelInfo['description'] . ",";

              //Storing question info
              $row = $row . $question['name'] . ",";
              $row = $row . $question['description'] . ",";
              $row = $row . $question['operand1'] . ",";
              $row = $row . $question['operand2'] . ",";
              $row = $row . $question['operator'] . ",";
              $row = $row . $question['question_type'] . ",";
              $row = $row . $question['freq'];
             
              fputs($fp,$row);
              fputs($fp,"\n");   
        }

        //Downloading the file
        if (file_exists($filename)) {
          header('Content-Description: File Transfer');
          header('Content-Type: application/octet-stream');
          header('Content-Disposition: attachment; filename='.basename($filename));
          header('Expires: 0');
          header('Cache-Control: must-revalidate');
          header('Pragma: public');
          header('Content-Length: ' . filesize($filename));
          readfile($filename);
        exit;
}

    } else {

        ?><div class="alert alert-danger">
              <a href="login.php" class="close" data-dismiss="alert">&times;</a>
              <strong>Error!</strong> Please add levels and questions to export.
          </div> <?php
    }
    
    fclose($fp);
}




  ?>


<!DOCTYPE html>
<html>
<head>
  <!-- Connect Bootstrap css -->
  <meta name ="viewport" content="width=deivce-width, initial-scale=1.0">
  <link href="includes/css/bootstrap.min.css" rel="stylesheet">
  <Title> Grayling Math Racer</title>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
  <script src="https://rawgit.com/nnnick/Chart.js/master/Chart.min.js"></script>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="./Chart.Bar.js"></script>
  </head>



  <!-- Bootstrap js plugins -->
  <script src="https://code.jquery.com/jquery.js"></script>
  <!-- include all compiled plugins -->
  <script src="includes/js/bootstrap.min.js"></script>
</head>
  <body>

  
<!-- Navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="index.php">Grayling Math Racer</a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
       <!-- <li><a href="index.php">Home</a></li> -->
        <li><a href="viewclass.php">Class Editor</a></li>
        <li><a href="addlevel.php">Level Editor</a></li>
        <li class="active"><a href="importexport.php">Import/Export</a></li>
      <!--  <li><a href="help.php">Help</a></li> -->

      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="account.php">Account</a></li>
        <li><a href="logout.php">Log Out</a></li>
         <?php  if($user->isLoggedIn()) {?>
        <li><a><?php echo escape($user->data()->name); ?>!</a></li>
        <?php
        }?>
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</div>


 <form method="post" action="importexport.php" enctype="multipart/form-data">
  <div class ="col-md-2" align="center">
    <input type="submit" class="btn btn-info" name="export1" value="Export">
  </div>
</form>

  <form method="post" action="importexport.php" enctype="multipart/form-data">
    <div class ="col-md-2" align="center">
      <input type="submit" class="btn btn-warning" name="import1" value="import">
      <input type="file" name="file"/>
     
    </div>
  </form>



















</head>
</body>