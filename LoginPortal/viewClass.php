<?php 
  require_once 'core/init.php';

  $user = new User();//Picking current user details

  //Redirect the user if they are not logged in.
  if(!$user->isLoggedIn()) {
      Redirect::to("includes/errors/loginError.php");
  }
?>


<!DOCTYPE html>
<html>
<head>
  <!-- Connect Bootstrap css -->
  <meta name ="viewport" content="width=deivce-width, initial-scale=1.0">
  <link href="includes/css/bootstrap.min.css" rel="stylesheet">
  <Title> Grayling Math Racer</title>
  </head>
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
<div class ="container">
  <h2> Class Name </h2>
  <h4> Teacher Name </h4>
  <div class = "table-responsive">
    <table class = "table">
      <thread>
        <tr>
          <th>Name</th>
          <th>Progress</th>
        </tr>
      </thred>
      <tbody>
        <tr>
          <td>Kelly</td>
          <td>5</td>
        </tr>
        <tr>
          <td>Sam</td>
          <td>6</td>
        </tr>
        <tr>
          <td>John</td>
          <td>10</td>
        </tr>
      </tbody>
  </table>
</div>
</div>


<!--buttons -->
<div class ="container">
  <div class="row">
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#createClassModal">Create Class</a>
    </div>
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#addStudentModal">Add Student</a>
    </div>
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
        <form>
          <div class ="form-group">
            <label for "labelForTeacherName">Teacher Name</label>
              <input type ="text" class"form-control" id ="labelForTeacherName" placeholder="Teacher Name">
          </div>
          <div class ="form-group">
            <label for "labelForClassName">Class Name</label>
              <input type ="text" class"form-control" id ="labelForClassName" placeholder="Class Name">
          </div>
          <div class ="form-group">
            <label for "labelForClassPassword">Class Password</label>
              <input type ="password" class"form-control" id ="labelForClassPassword" placeholder="Class Password">
          </div>
          <div class ="form-group">
            <label for "labelForConfirmClassPassword">Confirm Class Password</label>
              <input type ="password" class"form-control" id ="labelForConfirmClassPassword" placeholder="Confirm Password">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Submit</button>
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
        <form>
          <div class ="form-group">
            <label for "labelForStudentName">Student Name</lable>
              <input type ="text" class"form-control" id ="labelForStudentName" placeholder="Student Name">
          </div>
          <div class ="form-group">
            <label for "labelForStudentUserName">Student Username</lable>
              <input type ="text" class"form-control" id ="labelForStudentUserName" placeholder="Student Username">
          </div>
          <div class ="form-group">
            <label for "labelForStudentPassword">Student Password</lable>
              <input type ="password" class"form-control" id ="labelForStudentPassword" placeholder="Student Password">
          </div>
          <div class ="form-group">
            <label for "labelForConfirmStudentPassword">Confirm Student Password</lable>
              <input type ="password" class"form-control" id ="labelForConfirmStudentPassword" placeholder="Confirm Password">
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Submit</button>
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
