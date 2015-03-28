<?php 
  require_once 'core/init.php';



  $user = new User();//Picking current user details
  $studentOBJ = new Student(); //Creating a student object
  //Redirect the user if they are not logged in.
  if(!$user->isLoggedIn()) {
      Redirect::to("includes/errors/loginerror.php");
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
      <a class="navbar-brand" href="index.php">Grayling Math Racer</a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li><a href="index.php">Home</a></li>
        <li class="active"><a href="viewclass.php">Class Editor</a></li>
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
                        if( ($currProg['test_attempts'] > 0) or ($currProg['practice_attempts'] > 0) ){ ?>
                          <td><a data-toggle="modal" data-target="#viewLevelModal" onclick="setLevelInfo('<?php print_r($currProg['test_time'])?>','<?php print_r($currProg['test_attempts'])?>','<?php print_r($currProg['practice_time'])?>','<?php print_r($currProg['practice_attempts'])?>')">Attempted</a></td> 
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
<div class="modal fade" id="deleteClassModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
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
<div class="modal fade" id="clearStudentProgModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
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
<div class="modal fade"  id="viewLevelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Level View</h4></br>
    
         
        Test Time: <span id="test_time_ID"></span></br>       
        Test Attempts: <span id="test_attempts_ID"></span></br>    
        Practice Time: <span id="practice_time_ID"></span></br>    
        Practice Attempts: <span id="practice_attempts_ID"></span></br>    



      </div>


        <div class="modal-footer">
        <button type="button" id="refreshpage" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>


    </div>
  </div>
</div>




  
<!--Script to grab level info for the viewlevelmodal-->
<script>

  var test_time = 0;
  var test_attempts = 0;
  var practice_attemps = 0;
  var practice_time = 0;
  function setLevelInfo(TTime, TAttempts, PTime, PAttempts){


    test_time = TTime;
    test_attempts = TAttempts;
    practice_attemps = PAttempts;
    practice_time = PTime;

    document.getElementById('test_time_ID').innerHTML = test_time;
    document.getElementById('test_attempts_ID').innerHTML = test_attempts;
    document.getElementById('practice_time_ID').innerHTML = practice_time;
    document.getElementById('practice_attempts_ID').innerHTML = practice_attemps;

  }


</script>






















<!-- Bootstrap js plugins -->
<script src="https://code.jquery.com/jquery.js"></script>
<!-- include all compiled plugins -->
<script src="includes/js/bootstrap.min.js"></script>

</body>
</html>