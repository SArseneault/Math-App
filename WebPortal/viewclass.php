<?php 
  require_once 'core/init.php';

  //Decides when to display the success messages
  if(Session::exists('success')) {
   
      

      //Displaying the flash message
      ?><div class="alert alert-success">
                  <a href="viewclass.php" class="close" data-dismiss="alert">&times;</a>
                  <strong><?php print_r(Session::get('success') );?></strong> 
        </div> <?php

        //Removing the flash instance
        Session::flash('success');

    } else if(Session::exists('fail')) {
   
      

      //Displaying the flash message
      ?><div class="alert alert-danger">
                  <a href="viewclass.php" class="close" data-dismiss="alert">&times;</a>
                  <strong><?php print_r(Session::get('fail') );?></strong> 
        </div> <?php

        //Removing the flash instance
        Session::flash('fail');

    }


  

  $user = new User();//Picking current user details
  $studentOBJ = new Student(); //Creating a student object
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
  
    $students = $studentOBJ->getStudents($classInfo['class_id']);
    $levels = $user->getLevels();

  } else {

    $classInfo = null;
    $levels = null;
    $students = null;
}
 

  if(Input::exists()) {
    if (isset($_POST['createClass'])) {
      if(Token::check(Input::get('token'))) {

      //Validate fields
      $validate = new Validate();

        
      $validation = $validate->check($_POST, array(
        'teacher_name' => array(
          'required' => true,
          'min' => 2,
          'max' => 30
          ),
        'class_name' => array(
          'required' => true,
          'min' => 2,
          'max' => 30,
          'unique' => 'class'
          ),
        'class_password' => array(
              'required' => true,
              'min' => 6
           ),
        'class_password_again' => array(
              'required' => true,
              'min' => 6,
              'matches' => 'class_password'
            )

        ));
      


      if($validation->passed()) {

        try {
           
            //Creating a new class and salt
            $sclass = new SClass();
            $salt = Hash::salt(32);

            //Inserting the new class into the database
            $sclass->create(array(
              'class_name' => Input::get('class_name'),
              'teacher_name' => Input::get('teacher_name'),
              'class_password' => Hash::make(Input::get('class_password'), $salt),
              'teacher_id' => $user->data()->id,
              'salt' => $salt
              ));

            //Setting the class info
            $classInfo = $user->getClass();

            //Updating the teacher's class ID

            Session::flash('success', 'You have succesfully created a class');


            //Refresh the page to show the update
            header("Refresh:0");
        } catch(Execption $e) {
          die($e->getMessage());
          }

      } else {
          
          $errorString = "</br>";
              foreach($validation->errors() as $error) {
                $errorString = $errorString . $error . "</br>";
               
              }


          ?> <div class="alert alert-danger">
                <a href="login.php" class="close" data-dismiss="alert">&times;</a>
                <strong>Error!</strong> <?php echo($errorString); ?>
              </div> <?php


        }
    }
  } elseif (isset($_POST['addStudent'])) {
      if(Token::check(Input::get('token'))) {

      //Validate fields
      $validate = new Validate();

      $validation = $validate->check($_POST, array(
        'first_name' => array(
          'required' => true,
          'min' => 2,
          'max' => 50
          ),
        'last_name' => array(
          'min' => 2,
          'max' => 50
          ),
        'username' => array(
          'min' => 2,
          'max' => 50,
          'required' => true
          ),
        'password' => array(
            'required' => true,
            'min' => 2
           ),
        'password_again' => array(
            'required' => true,
            'min' => 2,
            'matches' => 'password'
            )

        ));
      
      $failure = false;
      $errorString = "</br>";

      //Check to ensure the username doesn't already exist in the class
      if($studentOBJ->findByClassID($_POST['username'], $classInfo['class_id']))
      {
        $failure = true;
        $errorString = "</br>" . $_POST['username'] . " already exsits in this class </br>"; 
      
      }

      if( ($validation->passed()) and (!$failure) ) {

        try {

           //Creating a new salt 
            $salt = Hash::salt(32);
           
            //Inserting the new student into the database
            $studentOBJ->create(array(
              'first_name' => Input::get('first_name'),
              'last_name' => Input::get('last_name'),
              'username' => Input::get('username'),
              'password' => Hash::make(Input::get('password'), $salt),
              'class_id' => $classInfo['class_id'],
              'joined' => date('Y-m-d H:i:s'),
              'salt' => $salt
              ));


            Session::flash('success', 'You have succesfully created a student');

            //Refresh the page to show the update
            header("Refresh:0");

        } catch(Execption $e) {
          die($e->getMessage());
          }

      } else {
         

          
              foreach($validation->errors() as $error) {
                $errorString = $errorString . $error . "</br>";
               
              }


          ?> <div class="alert alert-danger">
                <a href="" class="close" data-dismiss="alert">&times;</a>
                <strong>Error!</strong> <?php echo($errorString); ?>
              </div> <?php



        }
    }

  } else if (isset($_POST['newpass'])) { //////////////////////////
    

    //Grabbing Variables from the link
    $studentID = $_POST["studentid"];
    $newPass = $_POST["newpass"];
    $confirmPass = $_POST['confirmpass'];


     //Validate fields
      $validate = new Validate();

      $validation = $validate->check($_POST, array(
            'newpass' => array(
              'required' => true,
              'min' => 2
              ),
             'confirmpass' => array(
              'required' => true,
              'min' => 2,
              'matches' => 'newpass'
              )
            ));


    if($validation->passed()) {

        try {
           
          //Creating a new salt 
          $salt = Hash::salt(32);

         //Updating the level with the new time
          $studentOBJ->updateStudent(array(
            'password' => Hash::make($newPass, $salt),
            'salt' => $salt
            ), $studentID);


          Session::flash('success', 'You have successfully updated the student\'s password!');

          //Refresh the page to show the update
          header("Refresh:0");

        } catch(Execption $e) {
          die($e->getMessage());
          }

   } else {
          

        foreach($validation->errors() as $error) {
          $errorString = $errorString . $error . "</br>";
           
        }

        Session::flash('fail',$errorString);
        header("Refresh:0");

      }

  
    } else if (isset($_POST['newusername'])) {//////////////////////////
    

    //Grabbing Variables from the link
    $studentID = $_POST["studentid"];
    $newUsername = $_POST["newusername"];



      //Validate fields
      $validate = new Validate();

      $validation = $validate->check($_POST, array(
        'newusername' => array(
          'min' => 2,
          'max' => 50,
          'required' => true
          )
        ));
      
      $failure = false;
      $errorString = "</br>";

      //Check to ensure the username doesn't already exist in the class
      if($studentOBJ->findByClassID($_POST['newusername'], $classInfo['class_id']))
      {
        $failure = true;
        $errorString = "</br>" . $_POST['newusername'] . " already exsits in this class </br>"; 
      
      }


      if( ($validation->passed()) and (!$failure) ) {

        try {
           
            //Updating the user with the new username
            $studentOBJ->updateStudent(array(
              'username' => $newUsername
              ), $studentID);

            Session::flash('success', 'You have successfully updated the student\'s username!');

          //Refresh the page to show the update
          header("Refresh:0");

        } catch(Execption $e) {
          die($e->getMessage());
          }

      } else {
          

              foreach($validation->errors() as $error) {
                $errorString = $errorString . $error . "</br>";
                 
              }

              Session::flash('fail',$errorString);
              header("Refresh:0");

        }



    }




} ?>


<!DOCTYPE html>
<html>
<head>
  <!-- Connect Bootstrap css -->
  <meta name ="viewport" content="width=deivce-width, initial-scale=1.0">
  <link href="includes/css/bootstrap.min.css" rel="stylesheet">
  <Title> Minute Math Racer</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
  <script src="https://rawgit.com/nnnick/Chart.js/master/Chart.min.js"></script>
 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="./Chart.Bar.js"></script>

     <link rel="stylesheet" href="styles/kendo.common.min.css" />
    <link rel="stylesheet" href="styles/kendo.default.min.css" />
    <link rel="stylesheet" href="styles/kendo.dataviz.min.css" />
    <link rel="stylesheet" href="styles/kendo.dataviz.default.min.css" />

    <script src="js/jquery.min.js"></script>
    <script src="js/kendo.all.min.js"></script>


 
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
      <a class="navbar-brand" href="index.php">Minute Math Racer</a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
<!--         <li><a href="index.php">Home</a></li>
 -->        <li class="active"><a href="viewclass.php">Class Editor</a></li>
        <li><a href="addlevel.php">Level Editor</a></li>
        <li><a href="importexport.php">Import/Export</a></li>
        <li><a href="help.php">Help</a></li>

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


<!--table -->
<?php 
// If the class exists then display the table and grab the info
if($user->classExist()){  ?>
 
<div class ="container">
  <h2> <?php print_r($classInfo['class_name']);?> </h2>
  <h4> <?php print_r($classInfo['teacher_name']);?>  </h4>
  <div class = "table-responsive">
    <table class="table table-striped">
      <thread>
        <?php if(!$students) { ?>
        <p></br>Please add students to view the table</p>
         <?php } else {?>
        <tr>
        <th>Name</th>
           <?php

          foreach($levels as $level){

            //Convert the std object to an array
            $level = get_object_vars($level); 
            ?>
         
          <th><?php print_r($level['name']); ?></th>
          
           <?php } ?>
          </tr>

        
      </thred>
      <tbody>

         <?php 
          $i = 0;
         

         foreach($students as $student){
                //Convert the std object to an array
                $student = get_object_vars($student);


                    ?>
                      <tr>
                      <td><a data-toggle="modal" data-target="#editStudentModal" onclick="setStudentID('<?php print_r($student['student_id']); ?>','<?php print_r($student['username']); ?>','<?php print_r($student['password']); ?>','<?php print_r($classInfo['class_id']); ?>')"><?php print_r($student['first_name']); print_r(" "); print_r($student['last_name']);?></a></td>
                      
                      <?php

                  
                      $studentProg = $studentOBJ->getLevelProgress($student['student_id']);

            
    

                      if($studentProg){
                        
                      foreach($studentProg as $currProg) {
                        $currProg = get_object_vars($currProg);
                      
                        ///If the progress has been completed then display the link
                        if( ($currProg['test_attempts'] > 0) or ($currProg['practice_attempts'] > 0) ){ 

                         

                            ?>
                          <td><a data-toggle="modal" data-target="#viewLevelModal" onclick="setLevelInfo('<?php print_r($currProg['test_time'])?>','<?php print_r($currProg['test_attempts'])?>','<?php print_r($currProg['practice_time'])?>','<?php print_r($currProg['practice_attempts'])?>','<?php print_r($classInfo['class_id']); ?>','<?php print_r($currProg['level_id']); ?>')">Attempted</a></td> 
                      <?php 
                      //Else display not completed
                       } else { ?>
                          <td>Not Attempted</td> 
                       <?php }//End else
                             }}//End loop?>

                      </tr>
                      <?php

        } $i=$i+1; } ?>

      
      </tbody>
  </table>
</div>
</div> 
<?php } ?>


<!--buttons -->
<div class ="container">
  <div class="row">
    <?php if(!$classInfo) { ?>
      <div class ="col-md-2">
        <a href="#" class="btn btn-default" data-toggle="modal" data-target="#createClassModal">Create Class</a>
      </div>
    <?php } ?>
    <?php if($classInfo) { ?>
      <div class ="col-md-2">
        <a href="#" class="btn btn-default" data-toggle="modal" data-target="#addStudentModal">Add Student</a>
      </div>
        <?php if($students) { ?>
          <div class ="col-md-2">
            <a href="#" class="btn btn-default" data-toggle="modal" onclick="setClassID('<?php print_r($classInfo['class_id']); ?>')" data-target="#clearStudentProgModal">Clear Student Progress</a>
          </div>
        <?php } ?>

      <div class ="col-md-2">
        <a href="#" class="btn btn-danger" data-toggle="modal" onclick="setClassID('<?php print_r($classInfo['class_id']); ?>')" data-target="#deleteClassModal">Delete Class</a>
      </div>
    <?php } ?>

  </div>
</div>

<!--modal for buttons -->


<!--modal for remove Class -->
<div class="modal fade" id="deleteClassModal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Delete Class</h4>
      </div>
      <div class="modal-body">
          <h3>Are you sure you want to delete this class?</h3>
          <br>
          <h1 id="class_ID"></h1>
          </div>
          <div class="modal-footer">
            <button type="button" onclick="refreshPage()" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="submit" id="deleteClass" class="btn btn-primary">Delete Class</button>
          </div>
        </div>
      
  </div>
</div>


<!--modal for clear student progress -->
<div class="modal fade" id="clearStudentProgModal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Clear Progress</h4>
      </div>
      <div class="modal-body">
          <h3>Are you sure you want clear the level progress for all of the students?</h3>
          <br>
          <h1 id="clearProgResults"></h1>
          </div>
          <div class="modal-footer">
            <button type="button" onclick="refreshPage()" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="submit" id="clearStudentProgress" class="btn btn-primary">Clear Progress</button>
          </div>
        </div>
      
  </div>
</div>




<!--modal for create Class -->
<div class="modal fade" id="createClassModal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Create Class</h4>
      </div>
      <div class="modal-body">

        <!--forms for input -->
        <form action="" method="post">

        <pre>
                  Teacher Name: <input type ="text" class"form-control" name="teacher_name" id ="labelForTeacherName" placeholder="Teacher Name">
        </br>
                    Class Name: <input type ="text" class"form-control" name="class_name" id ="labelForClassName" placeholder="Class Name">
        </br>
                Class Password: <input type ="password" class"form-control" name="class_password" id ="labelForClassPassword" placeholder="Class Password">
        </br>
        Confirm Class Password: <input type ="password" class"form-control" name="class_password_again" id ="labelForConfirmClassPassword" placeholder="Confirm Password">
        </br>

        </pre>
        
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="submit" name="createClass" class="btn btn-primary">Create</button>
            <input type="hidden" name="token" value="<?php echo Token::generate(); ?>">
          </div>
        </div>
      
  </div>
</div> 

<!--modal for add student -->
<div class="modal fade" id="addStudentModal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Student</h4>
      </div>
      <div class="modal-body">
       
        <pre>
                      First Name: <input type ="text" class"form-control" name="first_name" id ="labelForStudentName" placeholder="First Name">
          </br>
                       Last Name: <input type ="text" class"form-control" name="last_name" id ="labelForStudentName" placeholder="Last Name">
          </br>
                        Username: <input type ="text" class"form-control" name="username" id ="labelForStudentUserName" placeholder="Username">
          </br>
                        Password: <input type ="password" class"form-control" name="password" id ="labelForStudentPassword" placeholder="Password">
          </br>
        Confirm Student Password: <input type ="password" class"form-control" name="password_again"id ="labelForConfirmStudentPassword" placeholder="Confirm Password">
        </pre>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="submit" name="addStudent" class="btn btn-primary">Add Student</button>
    
      </div>
    </div>
  </form>
  </div>
</div>

<!--Model for editing a student-->
<div class="modal fade" id="editStudentModal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">

         
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Student Edit</h4>
        <pre>
        Student Username: <input type="text" id="student_username_ID" class"form-control input-sm"/>      <button type="submit" onclick="updateStudentUser();" class="btn-xs btn-info">Update Username</button>        
        </br>
        Student Password: <input type="text" id="student_password_ID" class"form-control input-sm"/> 
        </br>
        Confirm Password: <input type="text" id="confirm_student_password_ID" class"form-control input-sm"/>      <button type="submit" onclick="updateStudentPass();" class="btn-xs btn-info">Update Password</button>
        </br> </pre> 
      <script>
      function updateStudentUser()
      {

        newUsername = document.getElementById('student_username_ID').value;
        $.post('viewclass.php',{studentid:SID, newusername:newUsername},function(data){ 
          //document.getElementById('student_username_ID').value = data;
          
         location.reload();
   
        }); 

      }
      function updateStudentPass()
      {

        newPass = document.getElementById('student_password_ID').value;
        confirmPass = document.getElementById('confirm_student_password_ID').value;

        $.post('viewclass.php',{studentid:SID, newpass:newPass, confirmpass:confirmPass},function(data){ 
          //document.getElementById('student_password_ID').value = data;
          
         location.reload();
   
        }); 

      }
    </script>
      
        <h1 id="student_ID"></h1>

      </div>
      <div class="modal-body">

       <style>

#editStudentModal .modal-dialog
{
    width: 1500px; /* your width */
    
}


    .axis path,
    .axis line {
      fill: none;
      stroke: #000;
      shape-rendering: crispEdges;
    }

    .bar {
      fill: steelblue;
    }
   

    .x.axis path {
      display: none;
    }

    .bar text {
      fill: white;
    }
    /*add the format for the bar labels*/
    .label {
 
        font-family: sans-serif;
        font-size: 11px;
        font-weight: bold;
        fill: black;
      }

    </style>
    <div class = "table-responsive">
      <table class="table" id="ltable">
            <thead id="tblHead">
              <tr>
                <th><h4>Student Level Progres:<h4></th>
              </tr>
            </thead>
            <tbody>
              <tr>
              <td id="bar"> </td>
              <tf
              </tr>
            </tbody>
            
      </table>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script>

          
            /*var data = [
              {levelName:"Zero Rule",testTime:"60", testAttempts:"1"},
              {levelName:"1+1",testTime:"5", testAttempts:"7"},
              {levelName:"Level 3",testTime:"0", testAttempts:"3"},
              {levelName:"Level 4",testTime:"0", testAttempts:"9"},
            ];*/
          
      

    function createGraph() {

      
      //Setting the level data
      data = Larr; 


 
      var $window = $(window);
      var wWidth  = $window.width();
      var wHeight = $window.height();

      var margin = {top: 10, right: 0, bottom: 30, left: 60},
          width = (300 - margin.left - margin.right) + data.length*100,
          height = 300 - margin.top - margin.bottom;

      //var formatPercent = d3.format("1");

      var x = d3.scale.ordinal()
          .rangeRoundBands([0, width], .1);

      var y = d3.scale.linear()
          .range([height, 0]);

      var xAxis = d3.svg.axis()
          .scale(x)
          .orient("bottom");

      var yAxis = d3.svg.axis()
          .scale(y)
          .orient("left")
      //var data = [[1,1],[2,3],[3,2],[4,5],[5,4]];

      var svg = d3.select("#bar").append("svg")
          .attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
        .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
      
        x.domain(data.map(function(d) { return d.levelName; }));
        y.domain([0, d3.max(data, function(d) { return d.testTime; })]);

        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis);

        svg.append("g")
            .attr("class", "y axis")
            .call(yAxis)
            .append("text")
            .attr("transform","rotate(-90)")
            .attr("y", -45)
            .attr("dy", ".71em")
            .style("text-anchor", "end")
            .text("Time Spent on Level (in minutes)");

        svg.selectAll(".bar")
            .data(data)
            .enter().append("rect")
            .attr("class", "bar")
            .attr("x", function(d) { return x(d.levelName); })
            .attr("width", x.rangeBand())
            .attr("y", function(d) { return y(d.testTime); })
            .attr("height", function(d) { return height - y(d.testTime); });
        
        // This adds a label inside the bar graph in each bar that represent the value of it
        svg.selectAll(".label")
           .data(data)
           .enter().append("text")
           .text(function(d) {
           return "Attempts: "+d.testAttempts;
           })
           .attr("x", function(d) {var t=(d.levelName == "") ? "Unknown":d.levelName; return x(t)+x.rangeBand()/2;})
           .attr("y", function(d) {return y(d.testTime)-1;})
           .attr("text-anchor", "middle")
           .attr("class", "label");
    
      function type(d) {
        d.testTime = +d.testTime;
        return d;
      }
    }

    </script>



    
      </div>
        <div class="modal-footer">
        <button type="button" id="refreshpage" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" id="removeStudent"class="btn btn-danger" name="removeLevel">Remove student</button>
      </div>
    </div>
  </div>
</div>







<!--Script to grab level info for editlevelmodal-->
<script type="text/javascript" src="./jquery-1.4.2.js"></script>
<script type="text/javascript">

  var test_time = 0;
  var test_attempts = 0;
  var practice_attemps = 0;
  var practice_time = 0;
  //Variable to store level id info
  var LID = 0;
  var CID = 0;
  QArrLength = -1;
  var Qarr; 

  function setLevelInfo(TTime, TAttempts, PTime, PAttempts, classID, levelID){


    test_time = TTime;
    test_attempts = TAttempts;
    practice_attemps = PAttempts;
    practice_time = PTime;

    document.getElementById('test_time_ID').innerHTML = test_time;
    document.getElementById('test_attempts_ID').innerHTML = test_attempts;
    document.getElementById('practice_time_ID').innerHTML = practice_time;
    document.getElementById('practice_attempts_ID').innerHTML = practice_attemps;


    //document.getElementById('level_ID').innerHTML="Level "+levelID+" info:";
    CID = classID;
    LID = levelID;
    
    //questions = JSON.parse(questions);


 
    $.post('getqprog.php',{classid:CID, levelid:LID},function(data){ 
       
      Qarr = JSON.parse(data);

      QArrLength = Qarr.length;
      
      createTable();
       
    }); 


  }




  //Variable to store the student's  id 
  var SID = 0;
  var SUN = "";
  var SPW = "";

  //Varaible to store the level prog info
  LArrLength = -1;
  var Larr = [];

  function setStudentID(studentID, studentUsername, studentPassword, classID){
 
    //Storing the student information globally to the rest of javascript
    SID = studentID;
    SUN = studentUsername;
    SPW = studentPassword;


    //Displaying the student credentials in the edit student modal
    document.getElementById('student_username_ID').value = SUN;

    
    //Grabbing the
     $.post('getlprog.php',{studentid: SID, classid:classID},function(data){ 
       
      var parsed = JSON.parse(data);

      for(var x in parsed){
        Larr.push(parsed[x]);
      }

       LArrLength = Larr.length;
      
      //document.getElementById('student_password_ID').innerHTML = data;
      
      createGraph();
       
    });

  }

  var CID = -1;
  function setClassID(classID) {
    CID = classID;
  }
  $('#deleteClass').on('click', function (e) {
   
    $.post('deleteclass.php',{classid:CID},
    function(data)
    {
      document.getElementById('class_ID').innerHTML=data;
    });
  })


    $('#clearStudentProgress').on('click', function (e) {
   
    $.post('clearstudentprog.php',{classid:CID},
    function(data)
    {
      document.getElementById('clearProgResults').innerHTML=data;
    });
  })


  $('#removeStudent').on('click', function (e) {
   
    $.post('removestudent.php',{studentid:SID},
    function(data)
    {
      document.getElementById('student_ID').innerHTML=data;
    });
  })


  $('#refreshpage').on('click', function (e) {
    location.reload();
  })

   $('#refreshpage2').on('click', function (e) {
    location.reload();
  })

  function refreshPage() {
    location.reload();
  }

</script>




<!--Model for editing a student-->
<div class="modal fade"  id="viewLevelModal" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <button type="button" onclick="refreshPage()" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Level View</h4></br>
    
        Test Time: <span id="test_time_ID"></span></br>       
        Test Attempts: <span id="test_attempts_ID"></span></br>    
        Practice Time: <span id="practice_time_ID"></span></br>    
        Practice Attempts: <span id="practice_attempts_ID"></span></br>    

        </br>
        </br>
        </br>
        End Of Level Snapshot: </br>
        <table class="table table-striped" id="qtable">
            <thead id="tblHead">
              <tr>
                <th>Question</th>
                <th>Answer</th>
                <th>Student Answer</th>
                <!--<th>Attempts</th>-->
              </tr>
            </thead>



                      <script type="text/javascript">
                       
                      
                        function createTable() {


                     

                         //Linking to the table
                        var table = document.getElementById("qtable");

                        //Creating a new body and adding it to the table
                        var body = document.createElement("tbody");
                        table.appendChild(body);
        
                          //Display that the studnet got a 100%
                          if(QArrLength <= 0){
                            var newRow = document.createElement("tr");
                            newRow.align = "center";
                           //var t = document.createTextNode("This student got all the questions correct for this level.");       
                            //newRow.appendChild(t); 
                            body.appendChild(newRow);


                             //Question
                            var newColumn = document.createElement("TD");  
                            newRow.appendChild(newColumn);

                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode('This student got all the questions correct for this level');       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn);

                             var newColumn = document.createElement("TD"); 
                            newRow.appendChild(newColumn);

                          

                             var newColumn = document.createElement("TD"); 
                            newRow.appendChild(newColumn);


                          }


                          //Loop through each element of the array 
                          for (var i = 0; i < QArrLength; i++) {

                            //Create a new row
                            var newRow = document.createElement("tr");
                            newRow.align = "center";
                            body.appendChild(newRow);


                             //Question
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['operand1'] + Qarr[i]['operator'] + Qarr[i]['operand2']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn); 

                            //Answer
                            var O1 = parseInt(Qarr[i]['operand1']);
                            var O2 = parseInt(Qarr[i]['operand2']);
                            var answer;
                            if(Qarr[i]['operator'] == "+" )
                              answer = O1 + O2;
                            else if(Qarr[i]['operator'] == "-" )
                              answer = Q1 - Q2;
                            else if(Qarr[i]['operator'] == "*" )
                              answer = Q1 - Q2;
                            else if(Qarr[i]['operator'] == "/" )
                              answer = Q1 / Q2;

                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(answer);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn); 

                            //Student's Answer
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['studentAnswer']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn); 

                           /* //Attempts
                            var newColumn = document.createElement("TD"); 
                            var t = document.createTextNode(Qarr[i]['attempts']);       
                            newColumn.appendChild(t); 
                            newRow.appendChild(newColumn);  */

                          }
                          
                      }


                     
                      </script>




          </table>


      </div>


        <div class="modal-footer">
        <button type="button" onclick="refreshPage()" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>


    </div>
  </div>
</div>





<!-- Bootstrap js plugins -->
<script src="https://code.jquery.com/jquery.js"></script>
<!-- include all compiled plugins -->
<script src="includes/js/bootstrap.min.js"></script>

</body>
</html>