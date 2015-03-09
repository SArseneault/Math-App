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
        <li><a href="viewClass.php">Class</a></li>
        <li class="active"><a href="addLevel.php">Add Level</a></li>
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

<!-- Table used to display levels -->
<div class ="container">
  <div class = "table-responsive">
    <table class = "table">
      <thread>
        <tr>
          <th>Level Number</th>
          <th>Practice Questions</th>
          <th>Test Questions</th>
          <th>Students on level</th>
        </tr>
      </thred>
      <tbody>
        <tr>
          <td>Level 1</td>
          <td>5</td>
          <td>15</td>
          <td>2<td>
        </tr>
        <tr>
          <td>Level 2</td>
          <td>6</td>
          <td>10</td>
          <td>4</td>
        </tr>
        <tr>
          <td>Level 3</td>
          <td>7</td>
          <td>9</td>
          <td>1</td>
        </tr>
      </tbody>
  </table>
</div>
</div>


<div class ="container">
  <div class="row">
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#createLevelModal">Create Level</a>
    </div>
    <div class ="col-md-2">
      <a href="#" class="btn btn-default" data-toggle="modal" data-target="#addQuestionModal">Add Question</a>
    </div>
  </div>
</div>

<!--modal for create level -->
<div class="modal fade" id="createLevelModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Create Level</h4>
      </div>
      <div class="modal-body">

        <!--forms for input -->
        <form>
          <div class ="form-group">
            <label for "labelForLevelName">Level Name</lable>
              <input type ="text" class"form-control" id ="labelForLevelName" placeholder="Level Name">
          </div>

          <div class ="form-group">
            <label for "labelForLevelDescription">Description</lable>
              <input type ="text" class"form-control" id ="labelForLevelName" placeholder="Description">
          </div>

          <div class ="form-group">
            <label for "labelForLevelTime">Level Time</lable>
              <input type ="text" class"form-control" id ="labelForLevelTime" placeholder="Level Time">
          </div>

        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Submit Level</button>
      </div>
    </div>
  </div>
</div>

<!--modal for add question -->
<div class="modal fade" id="addQuestionModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Question</h4>
      </div>
      <div class="modal-body">

        <!--forms for input -->
        <form>
          <div class ="form-group">
            <label for "labelForQuestionName">Question Name</lable>
              <input type ="text" class"form-control" id ="labelForQuestionName" placeholder="Question Name">
          </div>

          <div class ="form-group">
            <label for "labelForQuestionDescription">Description</lable>
              <input type ="text" class"form-control" id ="labelForQuestionDescription" placeholder="Question Name">
          </div>

          <!-- need to change input type -->
          <div class ="form-group">
            <label for "labelForQuestionFreq">Question Frequency</lable>
              <input type ="number" class"form-control" id ="labelForQuestionFreq" placeholder="Question Frequency">
          </div>

          <!--check box for practice/test question -->
          <div class ="form-group">
            <h4>Question Type</h4>
            <form role ="form">
              <label class ="radio-inline">
                <input type="radio" name="practiceRadio">Practice
              </label>
              <label class ="radio-inline">
                <input type="radio" name="testRadio">Test
              </label>
            </form>
          </div>


          <!-- need to fix input operation (-/+) size is all messed up -->
          <div class ="form-group">
            <label for "labelForQuestionEntry">Question</lable>
            <input type ="number" class"form-control" id ="labelOperatorOne" placeholder="Operator 1">
            <input type ="number" class"form-control" id ="labelOperatorTwo" placeholder="Operator 2">
            <select class ="form-control" id="operator">
              <option>+</option>
              <option>-</option>
            </select>
          </div>


          <div class ="form-group">
            <label for "labelForQuestionAnswer">Answer</lable>
              <input type ="number" class"form-control" id ="labelForQuestionAnswer" placeholder="Answer">
          </div>


        </form>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Submit Question</button>
      </div>
    </div>
  </div>
</div>




  </body>


</html>
