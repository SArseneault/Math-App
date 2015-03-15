<?php 
  require_once 'core/init.php';

  $user = new User();//Picking current user details
  $studentOBJ = new Student(); //Creating a student object
  //Redirect the user if they are not logged in.
  if(!$user->isLoggedIn()) {
      Redirect::to("includes/errors/loginError.php");
  }

  //Creating and setting the classInfo and students variables
  if($user->classExist()){
    $classInfo = $user->getClass();
  
    $students = $studentOBJ->getStudents($classInfo['class_id']);
    $levels = $user->getLevels();

  } else {

    $classInfo = null;
    $levels = null;
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
          'max' => 30
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

            //Refresh the page to show the update
            header("Refresh:0");
        } catch(Execption $e) {
          die($e->getMessage());
          }

      } else {
          foreach($validation->errors() as $error) {
            echo $error, '<br>';
          }
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
          'required' => true,
          'min' => 2,
          'max' => 50
          ),
        'password' => array(
            'required' => true,
            'min' => 6
           ),
        'password_again' => array(
            'required' => true,
            'min' => 6,
            'matches' => 'password'
            )

        ));
      

      if($validation->passed()) {

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


            //Refresh the page to show the update
            header("Refresh:0");
        } catch(Execption $e) {
          die($e->getMessage());
          }

      } else {
          foreach($validation->errors() as $error) {
            echo $error, '<br>';
          }
        }
    }

  }

} ?>


<!DOCTYPE html>
<html>
<head>
  <!-- Connect Bootstrap css -->
  <meta name ="viewport" content="width=deivce-width, initial-scale=1.0">
  <link href="includes/css/bootstrap.min.css" rel="stylesheet">
  <Title> Grayling Math Racer</title>
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
      <a class="navbar-brand" href="index.html">Grayling Math Racer</a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li><a href="index.php">Home</a></li>
        <li class="active"><a href="viewClass.php">Class</a></li>
        <li><a href="addLevel.php">Add Level</a></li>
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
    <table class = "table">
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
                      <td><a data-toggle="modal" data-target="#editStudentModal" onclick="setStudentID('<?php print_r($student['student_id']); ?>')"><?php print_r($student['first_name']); print_r(" "); print_r($student['last_name']);?></a></td>
                      
                      <?php
                      $studentProg = $studentOBJ->getLevelProgress($student['student_id']);

                      if($studentProg){
                      foreach($studentProg as $currProg) {

                        $currProg = get_object_vars($currProg);
                       
                        ///If the progress has been completed then display the link
                        if($currProg['status'] == 1){ ?>
                          <td><a data-toggle="modal" data-target="#viewLevelModal" onclick="setLevelInfo()">Completed</a></td> 
                      <?php
                      //Else display not completed
                       } else { ?>
                          <td>Not Completed</td> 
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
    
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#createClassModal">Create Class</a>
    </div>
    <?php if($classInfo) { ?>
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#addStudentModal">Add Student</a>
    </div>
    <?php } ?>

  </div>
</div>

<!--modal for buttons -->


<!--modal for create Class -->
<div class="modal fade" id="createClassModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Create Class</h4>
      </div>
      <div class="modal-body">

        <!--forms for input -->
        <form action="" method="post">
          <div class ="form-group">
            <label for "labelForTeacherName">Teacher Name</label>
              <input type ="text" class"form-control" name="teacher_name" id ="labelForTeacherName" placeholder="Teacher Name">
          </div>
          <div class ="form-group">
            <label for "labelForClassName">Class Name</label>
              <input type ="text" class"form-control" name="class_name" id ="labelForClassName" placeholder="Class Name">
          </div>
          <div class ="form-group">
            <label for "labelForClassPassword">Class Password</label>
              <input type ="password" class"form-control" name="class_password" id ="labelForClassPassword" placeholder="Class Password">
          </div>
          <div class ="form-group">
            <label for "labelForConfirmClassPassword">Confirm Class Password</label>
              <input type ="password" class"form-control" name="class_password_again" id ="labelForConfirmClassPassword" placeholder="Confirm Password">
          </div>
        
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
<div class="modal fade" id="addStudentModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Student</h4>
      </div>
      <div class="modal-body">
       
          <div class ="form-group">
            <label for "labelForStudentName">First Name</label>
              <input type ="text" class"form-control" name="first_name" id ="labelForStudentName" placeholder="First Name">
          </div>
          <div class ="form-group">
            <label for "labelForStudentName">Last Name</label>
              <input type ="text" class"form-control" name="last_name" id ="labelForStudentName" placeholder="Last Name">
          </div>
          <div class ="form-group">
            <label for "labelForStudentUserName">Username</label>
              <input type ="text" class"form-control" name="username" id ="labelForStudentUserName" placeholder="Username">
          </div>
          <div class ="form-group">
            <label for "labelForStudentPassword">Password</label>
              <input type ="password" class"form-control" name="password" id ="labelForStudentPassword" placeholder="Password">
          </div>
          <div class ="form-group">
            <label for "labelForConfirmStudentPassword">Confirm Student Password</label>
              <input type ="password" class"form-control" name="password_again"id ="labelForConfirmStudentPassword" placeholder="Confirm Password">
          </div>
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
<div class="modal fade" id="editStudentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">

         
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Student Edit</h4>
      
        <h1 id="student_ID"></h1>

      </div>
        <div class="modal-footer">
        <button type="button" id="refreshpage" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" id="removeStudent"class="btn btn-danger" name="removeLevel">Remove student</button>
      </div>
    </div>
  </div>
</div>

<!--Script to grab level info for editstudentmodal-->
<script>

  //Variable to store the student's  id 
  var SID = 0;
  function setStudentID(studentID){
 
    SID = studentID;
    
  }


  $('#removeStudent').on('click', function (e) {
   
    $.post('removeStudent.php',{studentid:SID},
    function(data)
    {
      document.getElementById('student_ID').innerHTML=data;
    });
  })


  $('#refreshpage').on('click', function (e) {
    location.reload();
  })

</script>




<!--Model for editing a student-->
<div class="modal fade"  id="viewLevelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Level View</h4>
    
         
        <div id="graph"></div>


      </div>


        <div class="modal-footer">
        <button type="button" id="refreshpage" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>


    </div>
  </div>
</div>




  
<!--Script to grab level info for the viewlevelmodal-->
<script>


  function setLevelInfo(){
   // alert("Welcome");

 
  }


  $('#removeStudent').on('click', function (e) {
   
    $.post('removeStudent.php',{studentid:SID},
    function(data)
    {
      document.getElementById('student_ID').innerHTML=data;
    });
  })


  $('#refreshpage').on('click', function (e) {
    location.reload();
  })

</script>






















<!-- Bootstrap js plugins -->
<script src="https://code.jquery.com/jquery.js"></script>
<!-- include all compiled plugins -->
<script src="includes/js/bootstrap.min.js"></script>

</body>
</html>